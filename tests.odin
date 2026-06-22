package sth9
import "core:testing"
import rl "vendor:raylib"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:fmt"
import "core:os"
import "core:sys/windows"
import "core:strings"

@(test)
my_test :: proc(t: ^testing.T) {
    when ODIN_OS == .Windows {
        windows.SetConsoleOutputCP(windows.CODEPAGE.UTF8)
    }
    

    //run_test_command()
    rl.InitAudioDevice()
    defer rl.CloseAudioDevice()

    init_sfx()   

    // cap texture map
    reserve(&image_map,IMAGES)
    reserve(&music_map,MUSICS)
    reserve(&textures,IMAGES)
    
    // for font
    all_text :cstring= "いろはにほへと　ちりぬるを\nわかよたれそ　つねならむ\nうゐのおくやま　けふこえて\nあさきゆめみし　ゑひもせす"
    codepoint_count: i32
	codepoints   := rl.LoadCodepoints(all_text, &codepoint_count)
	deduplicated := codepoints_remove_duplicates(codepoints[:codepoint_count])
	rl.UnloadCodepoints(codepoints)

    // https://github.com/odin-lang/examples/blob/master/raylib/ports/text/text_codepoints_loading.odin
     
    font1 = rl.LoadFontEx("resources/BetterVCR.ttf", 20, raw_data(deduplicated), i32(len(deduplicated)))
    // Free codepoints, atlas has already been generated
	delete(deduplicated)

	
    
    L := luaL_luajit.newstate(); // Create a new Lua state
    defer luajit.close(L); // Clean up later
    
    if L == nil {
        fmt.println("Failed to create Lua state");
        return;
    }
    

    // register functions
    register(&L)

    // set palette for dither
    luajit.pushinteger(L,0)
    luajit.setglobal(L,"palette")

    // set sprite width height
    // 256/8 = 32 as in pico 8
    luajit.pushinteger(L,32)
    luajit.setglobal(L,"sprite_width")
    luajit.pushinteger(L,32)
    luajit.setglobal(L,"sprite_height")

  
    // set blank color
    luajit.pushinteger(L,23)
    luajit.setglobal(L,"palt")

    // run the program with arguments



    if len(os.args)>1{
        
        for i:=1;i<len(os.args);i+=1{
            fmt.println(" arg ", os.args[i])
            if os.is_file(os.args[i])
            {
                fmt.println("is file")
                prog_=strings.clone_to_cstring(os.args[i])
                check_ext : string = strings.clone_from_cstring(prog_)
               
                
            }
        }
        
    }
    
    prog_:cstring = "examples\\draw_spline.lua"
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

