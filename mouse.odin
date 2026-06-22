package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import rl "vendor:raylib"
import "base:runtime"
import " core:unicode/utf8"
import "core:strings"


l_get_mouse_x :: proc "c" (L:luaL_luajit.State) -> i32 {

    mouse_x := rl.GetMouseX()
    luajit.pushinteger(L,luajit.Integer(mouse_x))
    return 1
}

l_get_mouse_y :: proc "c" (L:luaL_luajit.State) -> i32 {

    mouse_y := rl.GetMouseY()
    luajit.pushinteger(L,luajit.Integer(mouse_y))
    return 1
}

l_get_wheel_movement :: proc "c" (L:luaL_luajit.State) -> i32 {

    mouse_y := rl.GetMouseWheelMoveV()

    luajit.createtable(L,0,2)

    luajit.pushnumber(L,luajit.Number(mouse_y.x))
    luajit.setfield(L,-2,"x")
    luajit.pushnumber(L,luajit.Number(mouse_y.y))
    luajit.setfield(L,-2,"y")

    
    return 1
}

// mouse button pressed
l_mouse_pressed :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    // Check if the key is currently being held down
    is_pressed:= rl.IsMouseButtonPressed(rl.MouseButton(key_))
    luajit.pushboolean(L, i32(is_pressed))
    return 1
}

// mouse button down
l_mouse_down :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    // Check if the key is currently being held down
    is_pressed:= rl.IsMouseButtonDown(rl.MouseButton(key_))
    luajit.pushboolean(L, i32(is_pressed))
    return 1
}

// mouse button released
l_mouse_released :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    // Check if the key is currently being held down
    is_pressed:= rl.IsMouseButtonReleased(rl.MouseButton(key_))
    luajit.pushboolean(L, i32(is_pressed))
    return 1
}



// mouse not pressed
l_mouse_up :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    // Check if the key is currently being held down
    is_pressed:= rl.IsMouseButtonUp(rl.MouseButton(key_))
    luajit.pushboolean(L, i32(is_pressed))
    return 1
}

// show cursor
l_show_cursor :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.ShowCursor()
    return 0
}
// hide cursor
l_hide_cursor :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.HideCursor()
    return 0
}



// is cursor hidden 
l_cursor_hidden :: proc "c" (L: luaL_luajit.State) -> i32 {
    cursor_hidden_bool := rl.IsCursorHidden()
    luajit.pushboolean(L, i32(cursor_hidden_bool))
    return 1
}

// enable cursor
l_enable_cursor :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.EnableCursor()
    return 0
}

// disable cursor
l_disable_cursor :: proc "c" (L: luaL_luajit.State) -> i32 {
    rl.DisableCursor()
    return 0
}

// is cursor on screen 
l_cursor_on_screen :: proc "c" (L: luaL_luajit.State) -> i32 {
    cursor_onscreen_bool := rl.IsCursorOnScreen()
    luajit.pushboolean(L, i32(cursor_onscreen_bool))
    return 1
}


l_mouse_crosshair :: proc "c" (L : luaL_luajit.State) -> i32 {
    rl.SetMouseCursor(rl.MouseCursor.CROSSHAIR)
    return 0
}

l_mouse_default :: proc "c" (L : luaL_luajit.State) -> i32 {
    rl.SetMouseCursor(rl.MouseCursor.DEFAULT)
    return 0
}

l_mouse_ibeam :: proc "c" (L : luaL_luajit.State) -> i32 {
    rl.SetMouseCursor(rl.MouseCursor.IBEAM)
    return 0
}

l_mouse_notallowed :: proc "c" (L : luaL_luajit.State) -> i32 {
    rl.SetMouseCursor(rl.MouseCursor.NOT_ALLOWED)
    return 0
}

