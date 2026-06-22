-- shows how pictures are dithered with different palettes
function init()

    sprite_width = 500
    sprite_height = 375
    palette = 2 -- black and white; 0 standard,1 black and white, 2 gameboy
    load_image("frog","examples/resources/frog.jpg")
end

function update()

end

function draw()
    clear_background(color.BLACK)
    draw_sprite( "frog", 0 ,0,0)
end