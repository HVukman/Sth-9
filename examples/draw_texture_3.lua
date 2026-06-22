function init()
    screenwidth = 200
    screenheight= 200
    palette= 2
    load_image("example","examples/resources/sheet_example.png")
end

function update()

end

function draw()
    clear_background(color.RAYWHITE)
    -- draw with rotation 15 degrees, scale 2.0
    draw_sprite_pro( "example", 0 ,screenwidth/2,screenheight/2,15, 2.0)
end