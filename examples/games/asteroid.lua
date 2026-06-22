--- asteroids
--- port of: https://berbasoft.com/simplegametutorials/love/asteroids/
--- 

-- return default asteroids and keep it seperate
local function default_asteroids()
    return {
    {
        x = arena_width / 2 - 200,
        y = arena_height - 200,
    }
    }
end

-- resets game
local function reset()
    
    state = game_states.PLAY
    wait_time = 0
    --reset on failure/win
    angle = 0
    ship_speedx = 0
    ship_speedy = 0

    ship.x = screenwidth/2
    ship.y = screenheight/2

       -- asteroid table
    
    asteroids = default_asteroids()
    for _, asteroid in ipairs(asteroids) do
        asteroid.angle = math.random() * (2 * math.pi)
        asteroid.stage = #asteroidStages
    end

    bullets = {}

end

-- start here
function init()

    game_states = { PLAY =1, LOOSE =2,WIN=3}
    
    state = game_states.PLAY
    wait_time = 0
    -- constants
    ship_radius = 30
    small_radius = 8
    bullet_radius  = 4
    bulletTimerLimit = 0.5
    deaccelarete = 0.2
    arena_width = screenwidth
    arena_height = screenheight
    init_asteroids = default_asteroids

    --- bullet timer
    bulletTimer = bulletTimerLimit

    -- ship and small circle
    ship = make_circle(screenwidth/2,screenheight/2,ship_radius)
    circ2 = make_circle(screenwidth/2,screenheight/2,small_radius)
    
    
    angle = 0
    ship_speedx = 0
    ship_speedy = 0


     -- asteroid table
    asteroids = default_asteroids()

    asteroidStages = {
        {
            speed = 120,
            radius = 15,
        },
        {
            speed = 70,
            radius = 30,
        },
        {
            speed = 50,
            radius = 50,
        },
        {
            speed = 20,
            radius = 80,
        }
    }

    for _, asteroid in ipairs(asteroids) do
        asteroid.angle = math.random() * (2 * math.pi)
        asteroid.stage = #asteroidStages
    end

    bullets = {}
end

function update()

    -- switch states
    if state==game_states.PLAY then

        -- if empty win
        if #asteroids == 0 then
            state = game_states.WIN
        end

        local shipdistance = 20

        bulletTimer = bulletTimer + get_frame_time()


        if key_down(key.RIGHT) then
            angle = angle + 10*get_frame_time()
        end
        if key_down(key.LEFT) then
            angle = angle - 10*get_frame_time()
        end

        if key_down(key.UP) then
            local shipspeed = 100
            ship_speedx = ship_speedx + math.cos(angle)* shipspeed*get_frame_time()
            ship_speedy = ship_speedy + math.sin(angle)* shipspeed*get_frame_time()
        
        end


        ship.x = (ship.x + ship_speedx*get_frame_time())%arena_width
        ship.y = (ship.y + ship_speedy*get_frame_time())%arena_height

        circ2.x = ship.x + math.cos(angle)*shipdistance
        circ2.y = ship.y + math.sin(angle)*shipdistance

        angle = angle % (2*math.pi)

        -- make bullets
        if key_down(key.S) then
            if bulletTimer >= bulletTimerLimit then
                bulletTimer = 0
                
                    table.insert(bullets, {
                        x = ship.x + math.cos(angle) * ship_radius,
                        y = ship.y + math.sin(angle) * ship_radius,
                        angle = angle,
                        timeLeft = 4,
                    })
                end
        end

        -- move asteroids 

        for _, asteroid in ipairs(asteroids) do
        --  local asteroidSpeed = 20
            asteroid.x = (asteroid.x + math.cos(asteroid.angle)
                * asteroidStages[asteroid.stage].speed *  get_frame_time()) % arena_width
            asteroid.y = (asteroid.y + math.sin(asteroid.angle)
                * asteroidStages[asteroid.stage].speed*  get_frame_time()) % arena_height
        end

        -- check collision asteroid and ship 
        for _, asteroid in ipairs(asteroids) do
            local asteroid_circ = make_circle(asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius)
            local collision_ = check_collision_circles(ship,asteroid_circ)
            
            if collision_ then
                state = game_states.LOOSE
                --print("collision!")
            end
        end


        -- shoot bullets
        for bulletIndex = #bullets, 1, -1 do
            local bullet = bullets[bulletIndex]

            bullet.timeLeft = bullet.timeLeft - get_frame_time()

            if bullet.timeLeft <= 0 then
                table.remove(bullets, bulletIndex)
            else
                local bulletSpeed = 500
                bullet.x = (bullet.x + math.cos(bullet.angle) * bulletSpeed * get_frame_time())
                % arena_width
                bullet.y = (bullet.y + math.sin(bullet.angle) * bulletSpeed * get_frame_time())
                % arena_height
        
            end

            for asteroidIndex = #asteroids, 1, -1 do
                local asteroid = asteroids[asteroidIndex]
                local asteroid_circle = make_circle(asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius)
                
                local coll_bullet_asteroid = check_collision_circles(
                    asteroid_circle,make_circle(bullet.x,bullet.y,bullet_radius)
                )
                
                if coll_bullet_asteroid then
                    table.remove(bullets, bulletIndex)
                    -- make smaller asteroids if bigger
                    if asteroid.stage > 1 then
                            local angle1 = math.random() * (2 * math.pi)
                            local angle2 = (angle1 - math.pi) % (2 * math.pi)

                            table.insert(asteroids, {
                                x = asteroid.x,
                                y = asteroid.y,
                                angle = angle1,
                                stage = asteroid.stage - 1,
                            })
                            table.insert(asteroids, {
                                x = asteroid.x,
                                y = asteroid.y,
                                angle = angle2,
                                stage = asteroid.stage - 1,
                            })
                        end

                    table.remove(asteroids, asteroidIndex)
                    break
                end
            end
        end
    elseif state==game_states.WIN or state==game_states.LOOSE then
        wait_time = wait_time+1
        if wait_time > 30 then
            reset()
        end
    
    end

end

function draw()
    
    clear_background(color.BLACK)
   
    if state==game_states.PLAY then 
         -- draw copies to wrap around
     for y = -1, 1 do
        for x = -1, 1 do
            
            -- draw ship and circle
            local ship_copy = make_circle(ship.x + (x*screenwidth),
                ship.y + (y*screenheight),30)
            draw_circle(ship_copy,color.BLUE)
            
            local circ_copy = make_circle(circ2.x + (x*screenwidth),
                circ2.y + (y*screenheight),8)
            draw_circle(circ_copy,color.SKYBLUE)

            -- draw bullets 
            for _, bullet in ipairs(bullets) do
               
                 local bullet_circle = make_circle(bullet.x,bullet.y,bullet_radius)
                 draw_circle(bullet_circle,color.GREEN)
            end

            -- draw asteroids
            for _, asteroid in ipairs(asteroids) do
                local asteroid_circle = make_circle(asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius)
                draw_circle(asteroid_circle,color.YELLOW)
            end

            
        end
    end
    elseif state==game_states.WIN then
        draw_text("winner",screenwidth/2,screenheight/2,30, color.GREEN)
    elseif state==game_states.LOOSE then
        draw_text("looser",screenwidth/2,screenheight/2,30, color.GREEN)
       
    end
   

end