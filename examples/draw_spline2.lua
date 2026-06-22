-- draw basic spline and catmull spline
-- draw point on spline in last segment

function init()
    linep1 = make_point( 100,10)
    linep2 = make_point( 200,110)
    linep3 = make_point( 310,100)
	linep4 = make_point( 510,310)
	linep5 = make_point( 610,410)
    linep6 = make_point( 620,430)
	t=0.0 -- at start of segment until 1.0
    points = {linep1,linep2,linep3,linep4,linep5,linep6}

	draw_point = get_spline_point_basis(linep1,linep2,linep3,linep4,t)
    circ = make_circle(draw_point.x,draw_point.y, 5)

    draw_point_cat = get_spline_point_catmull(linep2,linep3,linep4,linep5,t)
    circ_cat = make_circle(draw_point.x,draw_point.y, 5)

	speed = 0.01
end

function update()

	t = t + speed
	
	if t>=1 then
		speed= -0.01
	elseif t<=0 then
		speed= 0.01
	end
	draw_point = get_spline_point_basis(linep1,linep2,linep3,linep4,t)
	circ = make_circle(draw_point.x,draw_point.y, 5)

    draw_point_cat = get_spline_point_catmull(linep2,linep3,linep4,linep5,t)
    circ_cat = make_circle(draw_point_cat.x,draw_point_cat.y, 5)
end

function draw()

    clear_background(color.BLACK)
    draw_circle(circ, color.RED)
    draw_circle(circ_cat, color.GREEN)
    draw_text("Basis Spline", 10,10,15, color.YELLOW)
    draw_basis_spline(points,5,2.0,color.YELLOW)
    draw_text("Catmull Rom Spline", 10,30,15, color.GREEN)
    draw_catmull_rom_spline(points,5,2.0,color.GREEN)
end