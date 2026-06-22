-- draw linear spline
-- draw point on spline in last segment

function init()
    linep1 = make_point( 100,10)
    linep2 = make_point( 200,110)
    linep3 = make_point( 310,100)
	linep4 = make_point( 510,310)
	linep5 = make_point( 610,410)
	t=0.0 -- at start of segment until 1.0
    points = {linep1,linep2,linep3,linep4,linep5}
	draw_point = get_spline_point_linear(linep4,linep5,t)
    circ = make_circle(draw_point.x,draw_point.y, 5)
	speed = 0.01
end

function update()

	t = t + speed
	
	if t>=1 then
		speed= -0.01
	elseif t<=0 then
		speed= 0.01
	end
	draw_point = get_spline_point_linear(linep4,linep5,t)
	circ = make_circle(draw_point.x,draw_point.y, 5)
end

function draw()

    clear_background(color.BLACK)
    draw_circle(circ, color.RED)
    draw_linear_spline(points,5,2.0,color.YELLOW)
end