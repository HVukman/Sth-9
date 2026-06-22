package sth9

import "core:fmt"

import luajit "luajit"
import luaL_luajit "luajit/luaL"


import rl "vendor:raylib"
import "base:runtime"
import "core:os"
import "core:strings"
import "core:sys/windows"


SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450
STANDARD_TITLE :: "STH-9 GAME"

window_title : cstring
    
// set global variables
set_globals :: proc (L : ^luaL_luajit.State) {

    // set palette for dither
    luajit.pushinteger(L^,0)
    luajit.setglobal(L^,"palette")

    // set sprite width height
    // 256/8 = 32 as in pico 8
    luajit.pushinteger(L^,32)
    luajit.setglobal(L^,"sprite_width")
    luajit.pushinteger(L^,32)
    luajit.setglobal(L^,"sprite_height")

    // set blank color
    luajit.pushinteger(L^,23)
    luajit.setglobal(L^,"palt")


}


 
// set window title and resolution
set_window_title_res :: proc (L : ^luaL_luajit.State) {

     // open window is here
    // now push screenwidth and height
    luajit.getglobal(L^,"screenwidth")
    width:= luaL_luajit.checkinteger(L^,-1)
    luajit.setglobal(L^,"screenwidth")

    luajit.getglobal(L^,"screenheight")
    height := luaL_luajit.checkinteger(L^,-1)
    luajit.setglobal(L^,"screenheight")

    luajit.getglobal(L^, "title")
    type := luajit.type(L^, -1)

     if type!= luajit.TSTRING{
        window_title = STANDARD_TITLE
    }else{
        window_title = luajit.tostring(L^, -1)
    }

    if i32(width)<=0 {
        width_= SCREEN_WIDTH
    }else{
        width_ = i32(width)
    }
    if i32(height)<=0 {
        height_= SCREEN_HEIGHT
    }else{
        height_ = i32(height)
    }
}

main_loop :: proc (L:^luaL_luajit.State)  {

  
    context = runtime.default_context()
	
    
    set_window_title_res(L)

    rl.InitWindow(width_, height_, window_title)

    // cannot be changed afterwards then
    // create texture map

    for key, value in image_map {
	    textures[key] = rl.LoadTextureFromImage(image_map[key])
    }

      // Set bilinear scale filter for better font scaling
	rl.SetTextureFilter(font1.texture, .BILINEAR)
    
	
	//--------------------------------------------------------------------------------------
   
	// Main game loop
	for !rl.WindowShouldClose() { 		// Detect window close button or ESC key
		
        // update music streams

        for i,v in music_map{
            rl.UpdateMusicStream(v)
        }

        //----------------------------------------------------------------------------------
       // Update main loop
                //----------------------------------------------------------------------------------
        luajit.getglobal(L^,cstring("update"))
        resultupdate  := luajit.pcall(L^, 0, 0, 0)
        if resultupdate !=0 {   
            err_msg = luajit.tostring(L^, -1)
            luajit.pop(L^, 1) // Pop the error message
         }
         
        rl.BeginDrawing()
            if err_msg == ""{
                
                
                
                // Draw
                //----------------------------------------------------------------------------------
                
                stack_top := luajit.gettop(L^)
                defer luajit.settop(L^, stack_top)
                luajit.getglobal(L^,cstring("draw"))
                result := luajit.pcall(L^, 0, 0, 0)
                if result!=0 {   
                    err_msg = luajit.tostring(L^, -1)
                //    fmt.println("Something is wrong with draw? Error:", err_msg, "Code:", result)
                    luajit.pop(L^, 1) // Pop the error message
                    //break
                }

           
            } else {
                rl.ClearBackground(rl.BLUE)
                rl.DrawText(err_msg, 10, 10, 18, rl.WHITE)
            }
           
            
		rl.EndDrawing()
		//----------------------------------------------------------------------------------
           
        // Reload
        // if pressed F11
        if rl.IsKeyPressed(rl.KeyboardKey.F11){
                if debug{
                rl.ClearBackground(rl.BLACK)
                err_msg = ""
                
                // set variables
                set_globals(L)
                set_window_title_res(L)
                rl.SetWindowSize(width_,height_)
                rl.SetWindowTitle(window_title)
                if (luaL_luajit.loadfile(L^, prog_)) != luaL_luajit.ERRFILE{  
                
                // call the chunk on stack
                if luajit.pcall(L^, 0, 0, 0) != 0 {
                    err_msg = luajit.tostring(L^, -1)
                    luajit.pop(L^, 1)
                    
                    }
                }

                // call init from file
            
                luajit.getglobal(L^,cstring("init"))
                if luajit.isfunction(L^, -1) {
                    if luajit.pcall(L^, 0, 0, 0) != 0 {
                        
                        fmt.println(" No init found in file :", luajit.tostring(L^, -1))
                        err_msg = luajit.tostring(L^, -1)
                        luajit.pop(L^, 1)
                    }
                }
                // call update from file
                luajit.getglobal(L^,cstring("update"))
                if luajit.isfunction(L^, -1) {
                    if luajit.pcall(L^, 0, 0, 0) != 0 {
                        err_msg = luajit.tostring(L^, 1)
                        luajit.pop(L^, 1)
                        fmt.println(" No init found in file :", luajit.tostring(L^, -1))
                       // return
                    }
                }
                // draw is called anyway
        }
    }
    }
// De-Initialization
	//--------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------
     
    rl.CloseWindow() // Close window and OpenGL context
    
    luajit.pop(L^, 1) 

}


l_clearbackground :: proc "c"(L:luaL_luajit.State) -> i32 {
      new_col := COLOR_ARRAY
      col_:= luajit.tointeger(L, -1)
      rl.ClearBackground(new_col[col_])
      return 0;  /* number of results */
    }





// run the program
run :: proc(L: ^luaL_luajit.State, file_: cstring = "main.lua")
{

    
      // load the file
   
        if (luaL_luajit.loadfile(L^, file_))!= luaL_luajit.ERRFILE{  
        // call the chunk on stack
          if luajit.pcall(L^, 0, 0, 0) != 0 {
               fmt.println(" File %s coulnd not be loaded :", file_)
                err_msg = luajit.tostring(L^, 1)
                luajit.pop(L^, 1)
            }
        }

        // call init from file
    
        luajit.getglobal(L^,cstring("init"))
        if luajit.isfunction(L^, -1) {
            if luajit.pcall(L^, 0, 0, 0) != 0 {
                err_msg = luajit.tostring(L^, 1)
                luajit.pop(L^, 1)
                fmt.println(" No init found in file :", luajit.tostring(L^, -1))
                
            }
        }
           
    // call main 
    main_loop(L)

}

// where else to put?
prog_ : cstring
width_:i32
height_:i32
debug : bool

// add font to draw
// https://www.dafont.com/better-vcr.font?a=on&e=on&l[]=10
font1 : rl.Font

// for file dropped

filepath: cstring
err_msg : cstring

main :: proc() {

    
    debug = false
   when ODIN_OS == .Windows {
        windows.SetConsoleOutputCP(windows.CODEPAGE.UTF8)
    }
    
    all_text :cstring= "いろはにほへとちりぬるを\nわかよたれそつねならむ\nうゐのおくやまけふこえて\nあさきゆめみしゑひもせすüöäßÜÄÖПривітсвіте"

    //run_test_command()
    rl.InitAudioDevice()
    defer rl.CloseAudioDevice()

    init_sfx()   

    // cap texture map
    reserve(&image_map,IMAGES)
    reserve(&music_map,MUSICS)
    reserve(&textures,IMAGES)
    
    // for font
    
    codepoint_count: i32
	codepoints   := rl.LoadCodepoints(all_text, &codepoint_count)
	deduplicated := codepoints_remove_duplicates(codepoints[:codepoint_count])
	rl.UnloadCodepoints(codepoints)

    
    // https://github.com/odin-lang/examples/blob/master/raylib/ports/text/text_codepoints_loading.odin
     
    font1 = rl.LoadFontEx("resources/DotGothic16-Regular.ttf", 20, raw_data(deduplicated), i32(len(deduplicated)))
    
    // Free codepoints, atlas has already been generated
	delete(deduplicated)

    // if nothing else is set
	rl.SetTargetFPS(60) 				// 

   

    L := luaL_luajit.newstate(); // Create a new Lua state
    defer luajit.close(L); // Clean up later
    
    if L == nil {
        fmt.println("Failed to create Lua state");
        return;
    }
    

    // register functions
    register(&L)

    // set variables
    set_globals(&L)
    set_window_title_res(&L)
    
     // run the program with arguments


    if len(os.args)>1{
        
        for i:=1;i<len(os.args);i+=1{
            fmt.println(" arg ", os.args[i])
            if os.is_file(os.args[i])
            {
                fmt.println("is file")
                prog_=strings.clone_to_cstring(os.args[i])
                check_ext : string = strings.clone_from_cstring(prog_)
            }else if os.args[i] == "-debug" {
                debug = true
            }
            
        }
        
    }
    
    if prog_!=""{
        fmt.println("starting ", prog_)
        run(&L,prog_)
    }else{
        run(&L)
    }
    
  
    for _,v in sound_map{
        rl.UnloadSound(v)
    }

   /* for v in sfx_sounds{
        rl.UnloadSound(v)
    }
 */
    for _,v in music_map{
        rl.UnloadMusicStream(v)
    }

    for _,v in image_map{
        rl.UnloadImage(v)
    }
    //delete(sfx_sounds)
    delete(image_map)
    delete(music_map)
    delete(textures)
    

    rl.UnloadFont(font1)
    
}

