package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import rl "vendor:raylib"
import "base:runtime"

 // see : https://blog.febucci.com/2018/08/easing-functions/

// easing functions from raylib 

l_ease_expo_in_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseExpoInOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}



l_ease_expo_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseExpoOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_expo_in :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseExpoIn(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}


l_ease_linear_in_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseLinearInOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}


l_ease_linear_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseLinearOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_linear_in :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseLinearIn(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}


l_ease_elastic_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseElasticOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_elastic_in :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseElasticIn(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_bounce_in :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseBounceIn(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_bounce_out :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseBounceOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1

}

l_ease_sine_in :: proc  "c" (L: luaL_luajit.State) -> i32 {
  
    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseSineIn(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L,luajit.Number(res))
    return 1
}

l_ease_sine_out :: proc  "c" (L: luaL_luajit.State) -> i32 {
    context = runtime.default_context()
    counter:=luaL_luajit.checknumber(L,-4)
    start:=luaL_luajit.checknumber(L,-3)
    target :=luaL_luajit.checknumber(L,-2)
    duration :=luaL_luajit.checknumber(L,-1)

    res := rl.EaseSineOut(f32(counter),f32(start),f32(target),f32(duration))
    luajit.pushnumber(L, luajit.Number( res))
    return 1
}
