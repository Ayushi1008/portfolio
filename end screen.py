import turtle

win = turtle.Screen()
point = turtle.Turtle()
win.title("HERE ENDS THE PROJECT")

win.bgcolor('black')

point.speed(10)


# creating eye

def eye(col, rad):
    point.pendown()
    point.fillcolor(col)
    point.begin_fill()
    point.circle(rad)
    point.end_fill()
    point.penup()


# draw face
point.fillcolor('yellow')
point.begin_fill()

point.circle(100)
point.end_fill()
point.penup()

# draw eyes
point.goto(-40, 120)
eye('white', 15)
point.goto(-37, 125)
eye('black', 5)
point.goto(40, 120)
eye('white', 15)
point.goto(40, 125)
eye('black', 5)

# nose
point.goto(0, 75)
eye('black', 8)

# mouth
point.goto(-40, 85)
point.pendown()

point.right(90)

point.circle(40, 180)
point.penup()

# tongue
point.goto(-10, 45)
point.pendown()
point.right(180)
point.fillcolor('red')
point.begin_fill()
point.circle(10, 180)
point.end_fill()
point.penup()

point.hideturtle()
point.setposition(150, -100)
point.color('lavender')
point.write("THANK YOU FOR PLAYING THE GAME!", move=False, align='right', font=('Comic Sans', 20, 'normal'))


turtle.done()
