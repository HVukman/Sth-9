package sth9
import rl "vendor:raylib"
import luajit "luajit"
import luajit_luaL "luajit/luaL"


BLACK_WHITE :: 4
BLACk_WHITE_PALETTE :: [BLACK_WHITE] rl.Color{rl.BLACK,rl.WHITE,rl.RAYWHITE , rl.BLANK}

// https://www.color-hex.com/color-palette/45299
GB_COLORS :: 5
GB_COLOR_ARRAY :: [GB_COLORS]rl.Color { rl.Color{155,188,15,255},rl.Color{139,172,15,255},
        rl.Color{48,98,48,255}, rl.Color{15,56,15,255} , rl.BLANK }

// standard colors
COLORS :: 30
COLOR_ARRAY :: [COLORS]rl.Color{
    rl.WHITE,rl.BLACK, 
    rl.GREEN,rl.LIGHTGRAY,
    rl.GRAY,rl.DARKGRAY,
    rl.YELLOW, rl.GOLD,
    rl.ORANGE, rl.PINK,
    rl.RED,rl.MAROON,
    rl.GREEN,rl.LIME,
    rl.DARKGREEN,rl.SKYBLUE,
    rl.BLUE,rl.DARKBLUE,
    rl.PURPLE,
    rl.VIOLET,rl.DARKPURPLE,
    rl.BEIGE,rl.DARKBROWN,
    rl.BLANK,rl.MAGENTA,
    rl.RAYWHITE,
    // 4 gameboy colors 
    rl.Color{155,188,15,255},
    rl.Color{139,172,15,255},
    rl.Color{48,98,48,255},
     rl.Color{15,56,15,255}
}

    
color_enum :: enum{
    COLOR_STANDARD = 0,
    COLOR_BLACK_WHITE = 1,
    COLOR_GB = 2,
}

make_colors :: proc(L: ^luajit.State) {

    
    // set color table
   
    luajit.createtable(L^,0,30)
    luajit.pushinteger(L^,0)
    luajit.setfield(L^,-2,"WHITE")
    luajit.pushinteger(L^,1)
    luajit.setfield(L^,-2,"BLACK")
    luajit.pushinteger(L^,2)
    luajit.setfield(L^,-2,"GREEN")
    luajit.pushinteger(L^,3)
    luajit.setfield(L^,-2,"LIGHTGRAY")
    luajit.pushinteger(L^,4)
    luajit.setfield(L^,-2,"GRAY")
    luajit.pushinteger(L^,5)
    luajit.setfield(L^,-2,"DARKGRAY")
    luajit.pushinteger(L^,6)
    luajit.setfield(L^,-2,"YELLOW")
    luajit.pushinteger(L^,7)
    luajit.setfield(L^,-2,"GOLD")
    luajit.pushinteger(L^,8)
    luajit.setfield(L^,-2,"ORANGE")
    luajit.pushinteger(L^,9)
    luajit.setfield(L^,-2,"PINK")
    luajit.pushinteger(L^,10)
    luajit.setfield(L^,-2,"RED")
    luajit.pushinteger(L^,11)
    luajit.setfield(L^,-2,"MAROON")
    luajit.pushinteger(L^,12)
    luajit.setfield(L^,-2,"LIME")
    luajit.pushinteger(L^,13)
    luajit.setfield(L^,-2,"DARKGREEN")
    luajit.pushinteger(L^,15)
    luajit.setfield(L^,-2,"SKYBLUE")
    luajit.pushinteger(L^,16)
    luajit.setfield(L^,-2,"BLUE")
    luajit.pushinteger(L^,17)
    luajit.setfield(L^,-2,"DARKBLUE")
    luajit.pushinteger(L^,18)
    luajit.setfield(L^,-2,"PURPLE")
    luajit.pushinteger(L^,19)
    luajit.setfield(L^,-2,"VIOLET")
    luajit.pushinteger(L^,20)
    luajit.setfield(L^,-2,"DARKPURPLE")
    luajit.pushinteger(L^,21)
    luajit.setfield(L^,-2,"BEIGE")
    luajit.pushinteger(L^,22)
    luajit.setfield(L^,-2,"DARKBROWN")
    luajit.pushinteger(L^,23)
    luajit.setfield(L^,-2,"BLANK")
    luajit.pushinteger(L^,24)
    luajit.setfield(L^,-2,"MAGENTA")
    luajit.pushinteger(L^,25)
    luajit.setfield(L^,-2,"RAYWHITE")
    luajit.pushinteger(L^,26)
    luajit.setfield(L^,-2,"GB_COLOR1")
    luajit.pushinteger(L^,27)
    luajit.setfield(L^,-2,"GB_COLOR2")
     luajit.pushinteger(L^,28)
    luajit.setfield(L^,-2,"GB_COLOR3")
     luajit.pushinteger(L^,29)
    luajit.setfield(L^,-2,"GB_COLOR4")
    luajit.setglobal(L^,"color")

    // set palette
    luajit.createtable(L^,0,3)
    luajit.pushinteger(L^,0)
    luajit.setfield(L^,-2,"Standard")
    luajit.pushinteger(L^,1)
    luajit.setfield(L^,-2,"GAME_BOY")
    luajit.pushinteger(L^,2)
    luajit.setfield(L^,-2,"BLACK_WHITE")
    luajit.setglobal(L^,"color_palettes")
}