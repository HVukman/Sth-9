-- draw wider texture
function init()
    screenwidth = 128
    screenheight= 90
    -- change width of sprites (default is 32)
    sprite_width = 64
    -- change heigts with sprite_height = .. (default is also 32 ; 32*32 is one sprite)
    palette= 0
    load_image("example","examples/resources/sheet_example.png")
end

function update()

end

function draw()
    clear_background(color.RAYWHITE)
    draw_sprite( "example", 0 ,60,14)
end