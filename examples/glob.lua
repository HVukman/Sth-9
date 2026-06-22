--- should show all *.odin files in the previous folder
--- sorted by size

function compare_size(x,y)

    return x.size > y.size
end

function init()
    globbed = glob("*.odin")
    files_size = {}

    for i,v in ipairs(globbed) do
        local dummy = {}
        dummy["name"] = v
        dummy["size"] = file_size(v)    
        table.insert(files_size,dummy)
    end

    table.sort(files_size, compare_size)
end

function update()

end

function draw()
    clear_background(color.BLACK)
    y=30
    size= 17
    draw_text("files with *.odin pattern",10,10,size,color.WHITE)

    for i,v in ipairs(globbed) do
        draw_text(v,30,y,size,color.WHITE)
        y=y+size
    end

    y=30
   
    draw_text("files sorted by size",300,10,size,color.WHITE)

    for i,v in ipairs(files_size) do
        draw_text(v.name .. " " .. tostring(v.size),300,y,size,color.WHITE)
        y=y+size
    end
end