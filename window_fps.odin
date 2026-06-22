package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import rl "vendor:raylib"
import "base:runtime"
import "core:c"



// set window position
l_set_window_pos :: proc "c" (L: luaL_luajit.State) -> i32 {
    x:= i32(luaL_luajit.checknumber(L,1))
    y:= i32(luaL_luajit.checknumber(L,1))
    rl.SetWindowPosition(x,y)
    return 0
}


l_restore_window :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.RestoreWindow()
    return 0
}


l_close_window :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.CloseWindow()
    return 0
}

l_set_target_fps :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    new_fps := i32(luaL_luajit.checknumber(L,-1))
    rl.SetTargetFPS(c.int(new_fps))
    return 0
}

l_get_fps :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    fps_:=rl.GetFPS()
    luajit.pushinteger(L,luajit.Integer(fps_))
    return 1
}

l_get_frame_time :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    frame_time:=rl.GetFrameTime()
    luajit.pushnumber(L, luajit.Number(frame_time))
    return 1
}

l_maximize_window :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    rl.MaximizeWindow()
    return 0
}

l_minimize_window :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    rl.MinimizeWindow()
    return 0
}

l_toggle_fullscreen :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    rl.ToggleFullscreen()
    return 0
}

l_toggle_borderless :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    rl.ToggleBorderlessWindowed()
    return 0
}


l_take_screenshot :: proc "c" (L: luaL_luajit.State) -> i32 {
    str_:= luaL_luajit.checkstring(L,-1)
    rl.TakeScreenshot(str_)
    return 0
}

// is window fullscreen
l_is_window_fullscreen :: proc "c" (L: luaL_luajit.State) -> i32 {
    res := rl.IsWindowFullscreen()
    luajit.pushboolean(L,i32(res))
    return 1
}

// is window minimized
l_is_window_minimzed :: proc "c" (L: luaL_luajit.State) -> i32 {
    res := rl.IsWindowMinimized()
    luajit.pushboolean(L,i32(res))
    return 1
}

// is window maximized
l_is_window_maximized :: proc "c" (L: luaL_luajit.State) -> i32 {
    res := rl.IsWindowMaximized()
    luajit.pushboolean(L,i32(res))
    return 1
}

// window should close
l_window_should_close :: proc "c" (L: luaL_luajit.State) -> i32 {
    res := rl.WindowShouldClose()
    luajit.pushboolean(L,i32(res))
    return 1
}
