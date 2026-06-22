-- draw many bnuuys on screen 
function init()
    title = "BNUUY"
   
    bnuuy_pos = {}
    for i=1,100000 do
        table.insert(bnuuy_pos, {math.random(0,screenwidth), math.random(0,screenheight)})
    end
    palette= 0
    load_image("bnuuy","examples/resources/bnuuy.png")
    speed = 0.1
end

function update()

    for i=1,#bnuuy_pos do
         bnuuy_pos[i][1] = bnuuy_pos[i][1] + math.random()*math.random(-1,1)
         bnuuy_pos[i][2] = bnuuy_pos[i][2] + math.random()*math.random(-1,1)
    end
   
end

function draw()
    clear_background(color.RAYWHITE)

    for i,v in ipairs(bnuuy_pos) do
        draw_sprite( "bnuuy", 1 ,v[1],v[2])
    end

    draw_text(string.format("FPS: %i",get_fps()),20,0,25, color.YELLOW )
end
