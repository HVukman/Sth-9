-- draw texture with different background color
function init()
    screenwidth = 128
    screenheight= 90
    palette= 2
    palt = color.BLACK
    load_image("example","examples/resources/sheet_example2.png")
end

function update()

end

function draw()
    clear_background(color.RAYWHITE)
    draw_sprite( "example", 0 ,60,14)
end