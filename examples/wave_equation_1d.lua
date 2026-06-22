--- solution of the wave equation in 1d
--- randomly chosen parameters
function init()
    screenwidth = 300
    screenheight = 30
    lefty = 2
    righty = 0
    n = 150
    length = 1
    h = length/n
    c=0.3
    t=0.01
    cfl = c*(t/h)
    sol= {}
    sol[1]=lefty
    sol[n] = righty
    for i=2,(n-1) do
        sol[i] = 0
    end
    
end

function update()
    sol[1] = lefty
    local alpha = c*(t/h)

    local past = {}
    for i=1,n do
        past[i] = sol[i]
    end
    
    for i=2,(n-1) do
        sol[i] = 2*(1-(alpha*alpha)) + (alpha*alpha)*(sol[i+1]+ sol[i-1]) - past[i]
    end
    sol[n] = lefty
end

function draw()

    clear_background(color.BLACK)
    local x = 10
    local y = screenheight/2
    radius = 2
    if cfl<=1 then
        for _,v in ipairs(sol) do
        local circ = make_circle(x,v+y,color.GREEN)
        draw_circle(circ,col_)
        x = x+ (h*200)
    end     
    end
   

end