function init()

    title = "PONG"
    posx = 10
    posy = 200

    enemyx = screenwidth-10
    enemyy= 200

    paddle_width = 10
    paddle_height = 50

    player_rect = make_rectangle(posx,posy,paddle_width,paddle_height)
    enemy_rect = make_rectangle(enemyx,enemyy,paddle_width,paddle_height)

    line_point1 = make_point(screenwidth/2,0)
    line_point2 = make_point(screenwidth/2,screenheight)
  
    move_speed = 8

    ball_x = screenwidth/2
    ball_y = screenheight/2
    ball_radius = 10
    ball = make_circle(ball_x,ball_y, ball_radius)
    start_speed = 4
    ball_speedx =  start_speed
    ball_speedy =  start_speed


    left_score = 0
    right_score = 0

    
    add_sound("beep", "examples/ressources/beep.wav")
   -- file_inf = file_info("dummy")
   -- print(time_to_hms_24(file_inf["access time"]))

end

function collision()

    if check_collision_circle_rec(ball,player_rect) or check_collision_circle_rec(ball,enemy_rect) then
       
        play_sfx(0)
        local addspeed = math.random()
        ball_speedx = -1*(ball_speedx +addspeed)
    end
end

function reset_ball()

    ball_speedx =  start_speed
    local rand = math.random(0,1)

    if rand == 0 then
        ball_speedx = -1*ball_speedx
    end
   
    ball.x = screenwidth/2
    ball.y = screenheight/2
end

function update()

    collision()

    if key_down(key.UP) then
        player_rect.y = player_rect.y - move_speed
    end
    if key_down(key.DOWN) then
        player_rect.y = player_rect.y + move_speed
    end

    if key_down(key.W) then
        enemy_rect.y = enemy_rect.y - move_speed
    end
     if key_down(key.S) then
        enemy_rect.y = enemy_rect.y + move_speed
    end

   

    if enemy_rect.y < 0 then
        enemy_rect.y = 0
    end

    player_rect.y = clamp(player_rect.y, 0, screenheight - paddle_height)
    
    
    
    if enemy_rect.y  > screenheight - paddle_height  then
        enemy_rect.y = screenheight - paddle_height
    end

    
    ball.x = ball.x + ball_speedx
    ball.y = ball.y + ball_speedy

    if ball.x > screenwidth or ball.x < 0 then
        if ball.x > screenwidth then
            left_score = left_score + 1
        else
            right_score = right_score +1
        end
        play_sfx(6)
        reset_ball()
    end

    if ball.y > screenheight or ball.y <0 then
        ball_speedy = ping_pong(ball_speedy)
    end
   
    
end 

function draw()
     clear_background(color.BLACK)
     draw_rectangle(player_rect,color.GREEN)
     draw_rectangle(enemy_rect, color.GREEN)
     draw_line(line_point1,line_point2, color.GREEN)
     draw_circle(ball, color.WHITE)
     draw_text(tostring(left_score),100,20,25,color.WHITE)
     draw_text(tostring(right_score),500,20,25,color.WHITE)
end