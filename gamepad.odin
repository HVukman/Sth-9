package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import rl "vendor:raylib"
import "core:c"


// compare button up of gamepad i
l_is_gamepad_button_released:: proc "c" (L:luaL_luajit.State) -> i32 {
   
    input := i32(luaL_luajit.checkinteger(L,2))
    gamepad := i32(luaL_luajit.checkinteger(L,1))
    res_ := rl.IsGamepadButtonReleased(gamepad,rl.GamepadButton(input))
    luajit.pushboolean(L,i32(res_))
    return 1
}

// compare button up of gamepad i
l_is_gamepad_button_up:: proc "c" (L:luaL_luajit.State) -> i32 {
   
    input := i32(luaL_luajit.checkinteger(L,2))
    gamepad := i32(luaL_luajit.checkinteger(L,1))
    res_ := rl.IsGamepadButtonUp(gamepad,rl.GamepadButton(input))
    luajit.pushboolean(L,i32(res_))
    return 1
}

// compare button down of gamepad i
l_is_gamepad_button_down:: proc "c" (L:luaL_luajit.State) -> i32 {
   
    input := i32(luaL_luajit.checkinteger(L,2))
    gamepad := i32(luaL_luajit.checkinteger(L,1))
    inp_:= i32(rl.GetGamepadButtonPressed())
    res_ := rl.IsGamepadButtonDown(gamepad,rl.GamepadButton(input))
    luajit.pushboolean(L,i32(res_))
    return 1
}

// compare button pressed of gamepad i
l_is_gamepad_button_pressed :: proc "c" (L:luaL_luajit.State) -> i32 {
   
   
    button := c.int(luaL_luajit.checkinteger(L,2))
    gamepad := i32(luaL_luajit.checkinteger(L,1))  
    res_ := rl.IsGamepadButtonPressed(gamepad,rl.GamepadButton(button))
    luajit.pushboolean(L,i32(res_))
    return 1
}

// get the button pressed of any gamepad 
l_get_gamepad_button_pressed :: proc "c" (L:luaL_luajit.State) -> i32 {
   
    luajit.pushinteger(L, luajit.Integer(rl.GetGamepadButtonPressed()))
    return 1
}

// get internal name of gamepad
l_get_gamepad_name :: proc "c" (L:luaL_luajit.State) -> i32 {
    inp:=i32(luaL_luajit.checkinteger(L,-1))
    res:= rl.GetGamepadName(inp)
    luajit.pushstring(L,res)
    return 1
}

// is any gamepad available
l_is_gamepad_available :: proc "c" (L:luaL_luajit.State) -> i32 {

    inp:=luaL_luajit.checkinteger(L,-1)
    res:= rl.IsGamepadAvailable(i32(inp))
    luajit.pushboolean(L, i32(res))
    return 1
}


// get axis left strick x of gamepad (integer)
l_get_gamepad_axis_right_y :: proc "c" (L: luaL_luajit.State) -> i32  {

    gamepad := luaL_luajit.checkinteger(L,-1)
    axis_y := rl.GetGamepadAxisMovement(i32(gamepad), rl.GamepadAxis.RIGHT_Y)
    luajit.pushnumber(L, luajit.Number(axis_y))
    return 1
}

// get axis left strick x of gamepad (integer)
l_get_gamepad_axis_right_x :: proc "c" (L: luaL_luajit.State) -> i32  {

    gamepad := luaL_luajit.checkinteger(L,-1)
    axis_x := rl.GetGamepadAxisMovement(i32(gamepad), rl.GamepadAxis.RIGHT_X)
    luajit.pushnumber(L, luajit.Number(axis_x))
    return 1
}
// get axis left strick x of gamepad "c" (integer)
l_get_gamepad_axis_left_y :: proc "c" (L: luaL_luajit.State) -> i32  {

    gamepad := luaL_luajit.checkinteger(L,-1)
    axis_y := rl.GetGamepadAxisMovement(i32(gamepad), rl.GamepadAxis.LEFT_Y)
   luajit.pushnumber(L, luajit.Number(axis_y))
    return 1
}

// get axis left strick x of gamepad (integer)
l_get_gamepad_axis_left_x :: proc "c" (L: luaL_luajit.State) -> i32  {

    gamepad := luaL_luajit.checkinteger(L,-1)
    axis_x := rl.GetGamepadAxisMovement(i32(gamepad), rl.GamepadAxis.LEFT_X)
    luajit.pushnumber(L, luajit.Number(axis_x))
    return 1
}
