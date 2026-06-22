package sth9 

import rl "vendor:raylib"
import "core:math"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:os"
import "base:runtime"
import "core:strings"

// texture map
IMAGES :: 16
image_map : map[string]rl.Image
textures : map[string]rl.Texture

/*
lua_load_texture :: proc(L: ^luaL_luajit.State) -> libc.int {
    filename := luaL_luajit.checkstring(L, 1)
    tex := rl.LoadTexture(filename)
    ud := cast(^rl.Texture2D)luaL_luajit.newuserdata(L, size_of(rl.Texture2D))
    ud^ = tex
    return 1
}
*/
l_draw_sprite_pro :: proc "c"(L: luaL_luajit.State) -> i32 {

    // draw_sprite_pro( name_image, sprite_int, x,y , rot , scale)
    context = runtime.default_context()

    key:=luaL_luajit.checkstring(L,-6)
    //image_, ok := image_map[strings.clone_from_cstring(key)]
    text_,ok2 := textures[strings.clone_from_cstring(key)]
    

    if ok2{

        xpos := f32(luaL_luajit.checknumber(L,-4))
        ypos := f32(luaL_luajit.checknumber(L,-3))
        rot := f32(luaL_luajit.checknumber(L,-2))
        scale := f32(luaL_luajit.checknumber(L,-1))
        sprite_int := i32(luaL_luajit.checknumber(L,-5))
        
      
        // put width and height on stack
        luajit.getglobal(L,"sprite_width")
        width:= i32(luaL_luajit.checknumber(L,-1))

        luajit.getglobal(L,"sprite_height")
        height:= i32(luaL_luajit.checknumber(L,-1))

        //  standard: (0*32)%256
        texture_x := (sprite_int*width)%(width*height)
        // standard: ((7*32)//256)*32
        texture_y := ((sprite_int*height)/(width*height))*height
        source_rect := rl.Rectangle{f32(texture_x), f32(texture_y), f32(width), f32(height)}
        destin_rect:= rl.Rectangle{xpos, ypos , f32(width)*scale, f32(height)*scale}
        origin := rl.Vector2{0, 0}

       // rl.DrawTextureRec(text_, source_rect, {xpos, ypos}, rl.WHITE)
        rl.DrawTexturePro(text_,source_rect, destin_rect, origin, rot, rl.WHITE)

    }else{
        luaL_luajit.error(L, "%s image not found " , key)
    } 
        
    return 0
}

l_draw_sprite :: proc "c"(L: luaL_luajit.State) -> i32 {

    // rl.DrawTexture(texture, rl.GetScreenWidth()/2 - texture.width/2, rl.GetScreenHeight()/2 - texture.height/2, rl.WHITE)
    // draw_sprite( name_image, sprite_int, x , y)
    context = runtime.default_context()

    key:=luaL_luajit.checkstring(L,-4)
    //image_, ok := image_map[strings.clone_from_cstring(key)]
    text_,ok2 := textures[strings.clone_from_cstring(key)]
    

    if ok2{

        xpos := f32(luaL_luajit.checknumber(L,-2))
        ypos := f32(luaL_luajit.checknumber(L,-1))

        sprite_int := i32(luaL_luajit.checknumber(L,-3))
      
      
        // put width and height on stack
        luajit.getglobal(L,"sprite_width")
        width:= i32(luaL_luajit.checknumber(L,-1))

        luajit.getglobal(L,"sprite_height")
        height:= i32(luaL_luajit.checknumber(L,-1))

        //  standard: (0*32)%256
        texture_x := (sprite_int*width)%(width*height)
        // standard: ((7*32)//256)*32
        texture_y := ((sprite_int*height)/(width*height))*height

        rl.DrawTextureRec(text_, {f32(texture_x), f32(texture_y), f32(width), f32(height)}, {xpos, ypos}, rl.WHITE)
    

    }else{
        luaL_luajit.error(L, "%s image not found " , key)
    } 
        
    return 0
}

// helper to calculate distance between colors
difference_color :: proc(c1,c2: rl.Color) -> i32 {

    dr := i32(c1.r) - i32(c2.r)
    dg := i32(c1.g) - i32(c2.g)
    db := i32(c1.b) - i32(c2.b)


    dist_ := dr*dr + dg*dg + db*db
    return dist_
}

// dither texture
find_closest_palette_color :: proc (old_: rl.Color, L: luaL_luajit.State, palette: []rl.Color) -> rl.Color{

    
    palette_len_ := len(palette)
    closest_index := 0
    for i:=0;i<palette_len_;i+=1{

        if difference_color(palette[i],old_) < difference_color(palette[closest_index],old_){
            closest_index = i
        }
    }

  
    return palette[closest_index]
}

dithered :: proc (image : rl.Image, L: luaL_luajit.State) -> rl.Image{


    // slicing constants

    col_array := COLOR_ARRAY
    bw_palette := BLACk_WHITE_PALETTE
    gb_palette := GB_COLOR_ARRAY

    newcol: rl.Color
    

    luajit.getglobal(L,"palette")
    palette_int:= i32(luaL_luajit.checkinteger(L,-1))
    palette : []rl.Color

    switch palette_int{
        case i32(color_enum.COLOR_STANDARD):
            palette = col_array[:]
        case i32(color_enum.COLOR_BLACK_WHITE):
            palette = bw_palette[:]
        case i32(color_enum.COLOR_GB):
            palette = gb_palette[:]
        case :
            palette = col_array[:]
    }

   
    imagecolors := rl.LoadImageColors(image)
    new_image := rl.GenImageColor(image.width, image.height, rl.BLACK)

    // transparent color
    luajit.getglobal(L,"palt")
    blank_ := int(luaL_luajit.checkinteger(L,-1))
    blank_color := col_array[blank_]

    for i:=0;i<int(image.height);i+=1{
       
        for j:=0;j<int(image.width);j+=1{
           
            // Calculate index (row-major order)
            index := i * int(image.width) + j
            
            old_color := imagecolors[index] 

            new_col: rl.Color

    
            if old_color == blank_color{
                new_col = rl.BLANK
            }else{
                new_col = find_closest_palette_color(old_color, L , palette)
            }

            imagecolors[index] = new_col 
            if (new_col != rl.BLANK){
            
            quant_error := old_color - new_col
            err_r := f32(old_color.r) - f32(new_col.r)
            err_g := f32(old_color.g) - f32(new_col.g)
            err_b := f32(old_color.b) - f32(new_col.b)

            // right pixel (7/16)
            if j+1<int(image.width){
                weight :f32= 7.0/16.0
                newindex := i * int(image.width) + (j+1)
                
                r := f32(imagecolors[newindex].r)
                r += err_r * weight 
                r = math.clamp(r, 0, 255)
                imagecolors[newindex].r = u8(r)

                g := f32(imagecolors[newindex].g)
                g += err_g * weight 
                g = math.clamp(g, 0, 255)
                imagecolors[newindex].g = u8(g)

                b := f32(imagecolors[newindex].b)
                b += err_b * weight 
                b = math.clamp(b, 0, 255)
                imagecolors[newindex].b = u8(b)
            }
            // bottom right (1/16)
            if i+1<int(image.height) && j+1<int(image.width){
                
                weight :f32= 1.0/16.0
                newindex := (i+1) * int(image.width) + (j+1)
                r := f32(imagecolors[newindex].r)
                r += err_r * weight 
                r = math.clamp(r, 0, 255)
                imagecolors[newindex].r = u8(r)

                g := f32(imagecolors[newindex].g)
                g += err_g * weight 
                g = math.clamp(g, 0, 255)
                imagecolors[newindex].g = u8(g)

                b := f32(imagecolors[newindex].b)
                b += err_b * weight 
                b = math.clamp(b, 0, 255)
                imagecolors[newindex].b = u8(b)
            }
            // bottom (5/16)
             if i+1<int(image.height){
                weight :f32= 5.0/16.0
                newindex := (i+1) * int(image.width) + (j)
                r := f32(imagecolors[newindex].r)
                r += err_r * weight 
                r = math.clamp(r, 0, 255)
                imagecolors[newindex].r = u8(r)

                g := f32(imagecolors[newindex].g)
                g += err_g * weight 
                g = math.clamp(g, 0, 255)
                imagecolors[newindex].g = u8(g)

                b := f32(imagecolors[newindex].b)
                b += err_b * weight 
                b = math.clamp(b, 0, 255)
                imagecolors[newindex].b = u8(b)
            }
            // bottom left (3/16)
            if i+1 < int(image.height) && j-1 > 0{
                weight :f32= 3.0/16.0
                newindex := (i+1) * int(image.width) + (j-1)
               
                r := f32(imagecolors[newindex].r)
                r += err_r * weight 
                r = math.clamp(r, 0, 255)
                imagecolors[newindex].r = u8(r)

                g := f32(imagecolors[newindex].g)
                g += err_g * weight 
                g = math.clamp(g, 0, 255)
                imagecolors[newindex].g = u8(g)

                b := f32(imagecolors[newindex].b)
                b += err_b * weight 
                b = math.clamp(b, 0, 255)
                imagecolors[newindex].b = u8(b)
            }

            }
           
    }
    }

    for i := 0; i < int(new_image.height); i += 1 {
       // fmt.println("i write new", i)
        for j := 0; j < int(new_image.width); j += 1 
        {
            index := i * int(new_image.width) + j
            rl.ImageDrawPixel(&new_image, i32(j), i32(i), imagecolors[index])
        }
    }


	return new_image
}

l_load_image :: proc "c" (L: luaL_luajit.State) -> i32 {

    context = runtime.default_context()

    file_:=luaL_luajit.checkstring(L,-1)
    check,err_:=strings.clone_from_cstring(file_)
    name_:=luaL_luajit.checkstring(L,-2)
    if os.is_file(check){
        
        abs,_ := os.get_absolute_path(check,runtime.default_allocator())
 
	    image := rl.LoadImage(file_)
        // dither image then draw
        image = dithered(image,L)
        // set image map
        image_map[strings.clone_from_cstring(name_)]=image
        // after window init!!
    

        }
        else{
           luaL_luajit.error(L, "%s was not found ", file_)
            return 0
        }
          
    return 0
}
