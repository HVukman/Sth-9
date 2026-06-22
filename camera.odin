package sth9
import rl "vendor:raylib"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:fmt"
import "base:runtime"

cam_: rl.Camera2D
two_d_mode : bool

l_end_mode_2D :: proc "c" (L: luaL_luajit.State) -> i32 {

    rl.EndMode2D()
    return 0
}


l_begin_mode_2D :: proc "c" (L:luaL_luajit.State) -> i32 {

    context = runtime.default_context()
   // fmt.println("type ", luajit.Type(L,-1))
    if luajit.istable(L,-1){

            luajit.getfield(L, -1, "zoom")  // Push zoom onto stack
            zoom := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -1, "rotation") // Push rotation onto stack
            rotation := f32(luaL_luajit.checknumber(L, -1))
           luajit.pop(L, 1)

            x_target : f32
            y_target : f32
            x_offset : f32
            y_offset : f32

            luajit.getfield(L, -1, "target")

            if luajit.istable(L,-1){
                
                luajit.getfield(L, -1, "x")  // Push x onto stack
                x_target = f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
               luajit.pop(L, 1)  
            
                luajit.getfield(L, -1, "y") // Push y onto stack
                y_target = f32(luaL_luajit.checknumber(L, -1))

               luajit.pop(L, 1)
               luajit.pop(L, 1)

            }else{
                luaL_luajit.error(L, `no camera table on stack ("target" is missing")`)
               luajit.pop(L, 1)
                return 0
            }

            luajit.getfield(L, -1, "offset")
            target_offset := luajit.istable(L,-1)
            if target_offset{
                
                    luajit.getfield(L, -1, "x")  // Push x onto stack
                    x_offset = f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
                   luajit.pop(L, 1)  
                
                    luajit.getfield(L, -1, "y") // Push y onto stack
                    y_offset = f32(luaL_luajit.checknumber(L, -1))
                   luajit.pop(L, 1)

                    
                    offset:= rl.Vector2{x_offset,y_offset}
                    target:= rl.Vector2{x_target,y_target}
                    cam_.rotation= rotation
                    cam_.zoom = zoom
                    cam_.offset = offset
                    cam_.target = target
              
                    
                    rl.BeginMode2D(cam_)
                   luajit.pop(L, 1)
                    return 0

                }else{
                    luaL_luajit.error(L, `no camera table on stack ("offset" is missing)`)
                   luajit.pop(L, 1)
                    return 0
                }

    }else{
        luaL_luajit.error(L, "No proper table on stack for camera")
       luajit.pop(L, 1)
        return 0
    }

    return 0
}


l_init_camera:: proc "c" (L: luaL_luajit.State)-> i32 {

    

    luajit.createtable(L,0,4)

    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"zoom")

    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"rotation")

    luajit.createtable(L,0,2)
    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"x")
    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"y")
    luajit.setfield(L,-2,"target")

    luajit.createtable(L,0,2)
    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"x")
    luajit.pushnumber(L,0.0)
    luajit.setfield(L,-2,"y")
    luajit.setfield(L,-2,"offset")

    //return table with keys "zoom","rotation","target","offset"

    return 1
}