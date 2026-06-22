-- testing fennel inclusion
function init()
    
    local fennel = require("examples/resources/fennel")
    table.insert(package.searchers, fennel.searcher)
    game = fennel.dofile("examples/main.fnl")
    
end

function update()
    
end

function draw()
    clear_background(color.BLACK)
    game.draw_hello()
   
end