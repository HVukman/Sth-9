-- shows how pictures are dithered
function init()

    sprite_width = 500
    sprite_height = 375
    palette= 0
    load_image("frog","examples/resources/frog.jpg")
end

function update()

end

function draw()
    clear_background(color.BLACK)
    draw_sprite( "frog", 0 ,0,0)
end