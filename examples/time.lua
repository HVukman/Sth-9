--- using time
function init()
    title = "TIME"
    weekday = weekday()
    month = month_now()
    time_ = time_now_string()
    today_str = today_string()
    screenwidth = 400
    screenheight = 400
    check = 0
    absolute_time = time_now()
end

function update()
   
    check = check + 1
    -- assuming frame time is 60
    if check%60 == 0 then
         time_ = time_now_string()
    end
end

function draw()
    clear_background(color.BLACK)
    draw_text(time_ , 20,30,26, color.YELLOW) 
    draw_text(today_str ,20,55,26, color.YELLOW)   
    draw_text(weekday .. " ".. month , 20,80,26, color.YELLOW)    
    draw_text("absoulte time at init " .. tostring(absolute_time), 20,110,18, color.YELLOW)    
end