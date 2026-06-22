--- 
function init()
    title= "Input Keys"
    speed = 5.0
    -- make circle
    radius = 30
    circ = make_circle(300,200,radius)

end

function update()

     

     
        if (key_down(key.UP))
        then
            circ.y = circ.y - speed
        end
        if (key_down(key.DOWN))
        then
            circ.y = circ.y + speed
        end
        
        if (key_down(key.RIGHT))
        then
            circ.x = circ.x + speed
        end
        if (key_down(key.LEFT))
        then
            circ.x = circ.x - speed
        end

        if circ.y < radius then
            circ.y = radius
        end

        if circ.y + radius > screenheight then
            circ.y = screenheight - radius
        end

        if circ.x - radius < 0 then 
            circ.x = radius
        end
        if circ.x + radius > screenwidth then
            circ.x = screenwidth - radius
        end
             
        
end

function draw()
     
    clear_background(color.RAYWHITE)
    draw_text("move the ball with arrow keys", 10, 10, 20, color.DARKGRAY)
    draw_circle(circ,color.RED)
    
    
end