--- Shows how to implement a camera
function init()

    title= "2D Camera"
    
    screenwidth = 800
    screenheight = 450

    -- add a camera to the scene
    cam_ = init_camera()

    rectx = 400
    recty = 280

    -- set target, offset , zoom and rotation
    cam_.target.x =  rectx + 20
    cam_.target.y =  recty + 20
    cam_.offset.x =  20
    cam_.offset.y =  20

    cam_.zoom = 1.0
    cam_.rotation = 0.0

    rect = make_rectangle( rectx, recty,200,150)
    -- add the other buildings
    max_buildings = 100
    local spacing = 10
    buildings = {}
    colors_buildings = {}
    
    keyset = {}
    for k in pairs(color) do
        table.insert(keyset, k)
    end

    for i=1,max_buildings do
        
        local width_ = math.random(100,1000)
        local height_ = math.random(100,800)
        table.insert(buildings, make_rectangle(-6000+spacing,screenheight-130-height_,width_,height_))
        spacing = spacing + width_
        table.insert(colors_buildings, color[keyset[math.random(#keyset)]])
    end

    speed = 6

    
    bigrect = make_rectangle( -6000, 320, 13000, 8000)

end

function update()

    if (key_down(key.RIGHT))
    then
        rect.x = rect.x + speed
    end
    if (key_down(key.LEFT))
    then
        rect.x = rect.x - speed
    end

    -- clamp rotation
    if (key_down(key.R))
    then
        cam_.rotation = cam_.rotation - 1 
    end
    
    if (key_down(key.S))
    then
         cam_.rotation = cam_.rotation + 1 
    end

    if cam_.rotation > 40 then cam_.rotation = 40 end
    if cam_.rotation < -40 then cam_.rotation = -40 end

    cam_.target.x =  rect.x
    cam_.target.y =  rect.y + 20

    cam_.zoom = math.exp(math.log(cam_.zoom) + (get_wheel_movement().y*0.1))

    if key_pressed(key.SPACE) then
        cam_.zoom = 1.0
        cam_.rotation = 0.0
    end
   
end

function draw()
     
    clear_background(color.RAYWHITE)

    -- draw the targets for the camera until end_mode_2D 
    begin_mode_2D(cam_)

    draw_rectangle(bigrect, color.DARKGRAY)
    for i,v in ipairs(buildings) do
        draw_rectangle(v, colors_buildings[i])
    end

    draw_rectangle(rect,color.RED)

    end_mode_2D()

    draw_text("Free 2D camera controls:", 20, 220, 18, color.BLACK);
    draw_text("- Right/Left to move player", 40, 240, 18, color.BLACK);
    draw_text("- Mouse Wheel to Zoom in-out", 40, 260, 18, color.BLACK);
    draw_text("- R / S to Rotate", 40, 280, 18, color.BLACK);
    draw_text("- Space to reset Zoom and Rotation", 40, 300, 18, color.BLACK);
    
    
end