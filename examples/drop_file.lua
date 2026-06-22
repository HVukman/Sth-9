--- drop file on window
function init()
    info = ""
    drop = false
    info_drop = nil
    access_time =nil
    full_path = nil
    modification_time =nil
    creation_time = nil
    size = 0
end

function update()
    if is_file_dropped() then
        drop = true
        -- time is saved as absolute nanoseconds and has to be converted
        -- get the info in table info_drop (name,size, full_path,access_time,modification_time,creation_time)
        info_drop = get_info_dropped_file()
        size = info_drop.size
        full_path = info_drop.fullpath
        access_time = to_string_dd_mm_yyyy( info_drop.access_time)
        modification_time = to_string_dd_mm_yyyy( info_drop.modification_time)
        creation_time = to_string_dd_mm_yyyy( info_drop.creation_time)
    end
end

function draw()
    clear_background(color.BLACK)
    if drop then 
        draw_text("File dropped ".. full_path,20,100,16,color.YELLOW) 
        draw_text("Name " .. info_drop.name,20,120,20,color.YELLOW)
        draw_text("Size " .. tostring(info_drop.size) .. " Bytes",20,140,20,color.YELLOW) 
        draw_text("Access Time " .. access_time,20,160,20,color.YELLOW)
        draw_text("Modification_Time " .. modification_time,20,180,20,color.YELLOW)
        draw_text("Creation Time " .. creation_time,20,200,20,color.YELLOW)
        else draw_text("Drop file here",20,100,20,color.YELLOW) 
    end
end