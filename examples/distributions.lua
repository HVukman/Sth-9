--- test distributions

function init()
    state = 0
    results = { }

    
    -- normal(mean, standard deviation)
    for i=1,100 do
        table.insert(results,normal(1,0.5) )
    end
   
    results_pareto = { }

    -- pareto(alpha, beta)
    for i=1,100 do
        table.insert(results_pareto,pareto(2,0.2) )
    end

    for i,v in ipairs(results_pareto) do
        io.write((v * screenwidth/2)/100.0, " ")
    end

    results_gamma = { }
    for i=1,100 do
        table.insert(results_gamma,gamma_dist(1,0.4) )
    end

   

end

function update()
    if key_pressed(key.RIGHT) then
        state = (state+1)%3
    end
end

function draw()

    clear_background(color.BLACK)
    if state==0 then 
    
    for _,v in ipairs(results) do
        local res = make_circle(v*(screenwidth/2),screenheight/2,10)
        draw_circle(res,color.YELLOW)
      
    end
        draw_text("Normal distribution around Screenwidth/2", 10,10, 20, color.YELLOW)
    
    elseif state==1 then
         for _,v in ipairs(results) do
            local res = make_circle((v * screenwidth/2)/100.0,screenheight/2,5)
            draw_circle(res,color.YELLOW)
            draw_text("Pareto distribution ", 10,10, 20, color.YELLOW)
        end
   
    elseif state==2 then
         for _,v in ipairs(results_gamma) do
            local res = make_circle((v * screenwidth/2),screenheight/2,5)
            draw_circle(res,color.YELLOW)
            draw_text("Gamma distribution ", 10,10, 20, color.YELLOW)
       
    end
    end
end

