import turtle

window = turtle.Screen()
pointer = turtle.Turtle()
window.title(" WELCOME SCREEN ")
# giving  colour to screen
window.bgcolor('#25383C')
# setting width and height of screen45
window.setup(width=700, height=800)

pointer.speed(10)
pointer.hideturtle()

colors = ['#B38481', '#A2AD9C', '#FFEFD5', '#F75D59']

pointer.goto(20, 30)
for i in range(300):
    # iterating colors
    for c in colors:
        pointer.color(c)
        pointer.forward(i)
        pointer.left(91)
        turtle.tracer(15)

# tracer used to switch between animations like turn on or off
# used to accelerate drawing complex ones s

pointer.color("#FBD5AB")
pointer.setposition(155, 350)
pointer.write("WELCOME TO THE TURTLE RACE PROJECT", move=True, align='right', font=('Comic Sans', 25, 'normal'))


turtle.done()
