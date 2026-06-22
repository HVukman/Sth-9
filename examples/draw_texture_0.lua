function init()
    screenwidth = 128
    screenheight= 90
    palette= 2
    load_image("example","examples/resources/sheet_example.png")
end

function update()

end

function draw()
    clear_background(color.RAYWHITE)
    -- draw sprite 1 at x,y -- a t will be seen
    draw_sprite( "example", 1 ,60,14)
end