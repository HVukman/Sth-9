--- wave equation
function boundary()
 -- boundary conditions
    for k=1,100 do
        sol[1][k]= 1
    end
    for l=1,100 do
        sol[100][l]= 1
    end

    for m=1,100 do
        sol[m][1]= 1
    end

    for n=1,100 do
        sol[100][n]= 1
    end
end

function init()

    screenwidth = 600
    screenheight = 600
    t =0.1
    h = 3
    sol = {}

    -- insert null everywhere
    for i=1,100 do
        table.insert(sol,{})
        for j=1,100 do
            table.insert(sol[i],0)
        end
    end

    boundary()

    startx = 10
    starty = 10
    radius = h
    alpha = 17.3
end

function update()
    boundary()
    factor = (t*alpha/h)^2
     for i=2,99 do
        
        for j=2,99 do
            if sol[i][j]>2 then
                sol[i][j]=2
            else
                sol[i][j] = factor*( sol[i-1][j] + sol[i+1][j]+sol[i][j-1]+ sol[i][j+1]-4*sol[i][j]  ) + 2*sol[i][j] - sol[i][j]
           end
        end

    end

    print(sol[34][99])
end

function draw()

    clear_background(color.BLACK)
    local x = startx
    local y = starty
    local col_ = color.BLACK
    for i=1,100 do
        
        for j=1,100 do

            if sol[i][j]<= 0 then
                col_ = color.SKYBLUE
            elseif sol[i][j]> 0.01 and sol[i][j]<0.1 then
                col_ = color.PURPLE
            elseif sol[i][j]> 0.1 and sol[i][j]<0.6 then
                col_ = color.VIOLET
            elseif sol[i][j]> 0.6 and sol[i][j]<0.9 then
                col_ = color.MAGENTA
            elseif sol[i][j]> 0.9 and sol[i][j]<1 then
                col_= color.GREEN
            elseif sol[i][j]> 1 and sol[i][j]< 2 then
                col_ = color.PINK
            elseif sol[i][j]> 2  then
                col_ = color.RED
            end
            local circ = make_circle(x,y,radius)
            draw_circle(circ,col_)
            x= x+h
        end
        x= startx
        y= y + h
    end
end