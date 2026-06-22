--- you should see and empty black window
--  this is how the script should look like at its basic
function init()
    title = "Bouncing Ball"
    p1 = make_point(12,13)
    radius = 19
    circ = make_circle(300,30,radius)
    use_gravity = true
    gravity = 0.2
    ball_speed = {}
    ball_speed.x = 5.0
    ball_speed.y = 4.0
end

function update()
     --[[ 
            ballPosition.x += ballSpeed.x;
            ballPosition.y += ballSpeed.y;

            if (useGravity) ballSpeed.y += gravity;

            // Check walls collision for bouncing
            if ((ballPosition.x >= (GetScreenWidth() - ballRadius)) || (ballPosition.x <= ballRadius)) ballSpeed.x *= -1.0f;
            if ((ballPosition.y >= (GetScreenHeight() - ballRadius)) || (ballPosition.y <= ballRadius)) ballSpeed.y *= -0.95f;
     ]]
     circ.x = circ.x + ball_speed.x
     circ.y = circ.y + ball_speed.y

     if use_gravity then
        circ.y = circ.y + gravity
     end

     if circ.x >= (screenwidth - radius) or circ.x <= radius then
        ball_speed.x = -1.0*ball_speed.x
     end
     if circ.y >= (screenheight- radius) or circ.y <= radius then
        ball_speed.y = -0.95*ball_speed.y
     end

     if key_pressed(key.SPACE) then
        if use_gravity then
            use_gravity = false
        else 
            use_gravity = true
        end
    end
end

function draw()
    clear_background(color.BLACK)
    draw_circle(circ,color.GOLD)
    draw_text("Press Space to toggle gravity", 20,400,16, color.YELLOW)
    if use_gravity then
        draw_text("Gravity ON", 20,420,16, color.YELLOW)
    end
end