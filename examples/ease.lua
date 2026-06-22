-- easing example
function init()
    rectx = 10
    recty = 200
    rect = make_rectangle( rectx, recty,200,150)
    frame_counter =0
    time  = 600

    target_rec = 200
    target_ball = screenwidth/2
    ball_x = -10
    ball_y = 100
    ball_radius = 10
    ball = make_circle(ball_x,ball_y, ball_radius)

    texty = -50
    target_texty = 400
    cool_text = " WOW EASING "

end

function update()

    frame_counter = frame_counter + 1

    if frame_counter >= time then
         frame_counter = 0
    end
    -- ease untile time is reached
    rect.x = ease_elastic_in(frame_counter,10,target_rec,time)
    ball.x = ease_elastic_out(frame_counter,-10,target_ball,time)
    texty =  ease_elastic_in(frame_counter,-50,target_texty,time)

    if  frame_counter >= time then
         frame_counter = 0
         
    end 

end

function draw()

    clear_background(color.RAYWHITE)
    draw_rectangle(rect,color.BLACK)
    draw_circle(ball, color.GREEN)
    draw_text(cool_text, 600, texty , 25, color.RED)

end