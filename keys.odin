package sth9
import rl "vendor:raylib"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "base:runtime"
import "core:strings"
import "core:unicode/utf8"

make_gamepad :: proc(L: ^luaL_luajit.State) {
    
    // gamepad
    luajit.createtable(L^,0,17)
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_FACE_UP))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_FACE_UP")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_FACE_DOWN))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_FACE_DOWN")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_FACE_RIGHT))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_FACE_RIGHT")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_FACE_LEFT))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_FACE_LEFT")

    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_FACE_UP))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_FACE_UP")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_FACE_DOWN))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_FACE_DOWN")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_FACE_RIGHT))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_FACE_RIGHT")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_FACE_LEFT))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_FACE_LEFT")

    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_TRIGGER_1))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_TRIGGER_1")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_TRIGGER_2))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_TRIGGER_2")
     luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_TRIGGER_1))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_TRIGGER_1")
     luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_TRIGGER_2))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_TRIGGER_2")

    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.MIDDLE_LEFT))
    luajit.setfield(L^,-2,"GAMEPAD_MIDDLE_LEFT")
     luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.MIDDLE))
    luajit.setfield(L^,-2,"GAMEPAD_MIDDLE")
     luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.MIDDLE_RIGHT))
    luajit.setfield(L^,-2,"GAMEPAD_MIDDLE_RIGHT")


    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.LEFT_THUMB))
    luajit.setfield(L^,-2,"GAMEPAD_LEFT_THUMB")
    luajit.pushinteger(L^, luajit.Integer(rl.GamepadButton.RIGHT_THUMB))
    luajit.setfield(L^,-2,"GAMEPAD_RIGHT_THUMB")

    luajit.setglobal(L^,"gamepad")

}
make_keys :: proc(L: ^luaL_luajit.State) {


    luajit.createtable(L^,0,39)

    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.UP))
    luajit.setfield(L^,-2,"UP")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.DOWN))
    luajit.setfield(L^,-2,"DOWN")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.LEFT))
    luajit.setfield(L^,-2,"LEFT")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.RIGHT))
    luajit.setfield(L^,-2,"RIGHT")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.SPACE))
    luajit.setfield(L^,-2,"SPACE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.ESCAPE))
    luajit.setfield(L^,-2,"ESCAPE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.X))
    luajit.setfield(L^,-2,"X")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.W))
    luajit.setfield(L^,-2,"W")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.A))
    luajit.setfield(L^,-2,"A")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.S))
    luajit.setfield(L^,-2,"S")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.R))
    luajit.setfield(L^,-2,"R")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.H))
    luajit.setfield(L^,-2,"H")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.D))
    luajit.setfield(L^,-2,"D")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.Y))
    luajit.setfield(L^,-2,"Y")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.Z))
    luajit.setfield(L^,-2,"Z")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.P))
    luajit.setfield(L^,-2,"P")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.ENTER))
    luajit.setfield(L^,-2,"ENTER")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.LEFT_SHIFT))
    luajit.setfield(L^,-2,"SHIFT")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.LEFT_CONTROL))
    luajit.setfield(L^,-2,"L_CONTROL")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.RIGHT_CONTROL))
    luajit.setfield(L^,-2,"R_CONTROL")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.F1))
    luajit.setfield(L^,-2,"F1")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.ONE))
    luajit.setfield(L^,-2,"ONE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.TWO))
    luajit.setfield(L^,-2,"TWO")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.THREE))
    luajit.setfield(L^,-2,"THREE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.FOUR))
    luajit.setfield(L^,-2,"FOUR")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.FIVE))
    luajit.setfield(L^,-2,"FIVE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.SIX))
    luajit.setfield(L^,-2,"SIX")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.SEVEN))
    luajit.setfield(L^,-2,"SEVEN")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.EIGHT))
    luajit.setfield(L^,-2,"EIGHT")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.NINE))
    luajit.setfield(L^,-2,"NINE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.ZERO))
    luajit.setfield(L^,-2,"ZERO")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.DELETE))
    luajit.setfield(L^,-2,"DELETE")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.ENTER))
    luajit.setfield(L^,-2,"ENTER")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.INSERT))
    luajit.setfield(L^,-2,"INSERT")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.PAGE_UP))
    luajit.setfield(L^,-2,"PAGE_UP")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.PAGE_DOWN))
    luajit.setfield(L^,-2,"PAGE_DOWN")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.END))
    luajit.setfield(L^,-2,"END")
    luajit.pushinteger(L^,luajit.Integer(rl.KeyboardKey.NUM_LOCK))
    luajit.setfield(L^,-2,"NUM_LOCK")

    // mouse 
    luajit.pushinteger(L^,luajit.Integer(rl.MouseButton.LEFT))
    luajit.setfield(L^,-2,"MOUSE_LEFT")
    luajit.pushinteger(L^,luajit.Integer(rl.MouseButton.RIGHT))
    luajit.setfield(L^,-2,"MOUSE_RIGHT")
    luajit.pushinteger(L^,luajit.Integer(rl.MouseButton.MIDDLE))
    luajit.setfield(L^,-2,"MOUSE_MIDDLE")
    luajit.pushinteger(L^,luajit.Integer(rl.MouseButton.SIDE))
    luajit.setfield(L^,-2,"MOUSE_SIDE")
     luajit.pushinteger(L^,luajit.Integer(rl.MouseButton.EXTRA))
    luajit.setfield(L^,-2,"MOUSE_EXTRA")
   

   
    luajit.setglobal(L^,"key")
}


// get char pressed
l_get_charpressed :: proc "c" (L: luaL_luajit.State) -> i32 {

    context = runtime.default_context()
    char_ := rl.GetCharPressed()
    dummy: [1]rune
    dummy[0] = char_
    new_string:= utf8.runes_to_string(dummy[:])
    newstr: cstring = strings.clone_to_cstring(new_string)
    return 1
}
// keydown
l_keydown :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    
    // Check if the key is currently being held down
    is_down := rl.IsKeyDown(rl.KeyboardKey(key_))
    luajit.pushboolean(L, i32(is_down))
    return 1
}
// keypressed
l_keypressed :: proc "c" (L: luaL_luajit.State) -> i32 {
    key_ := luajit.tointeger(L, -1)
    // Check if the key is currently being held down
    is_pressed:= rl.IsKeyPressed(rl.KeyboardKey(key_))
    luajit.pushboolean(L, i32(is_pressed))
    return 1
}
