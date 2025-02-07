# Minecraft Computer Craft Programs

This is where I store my Minecraft CC programs, take a look at your own leisure, currently have 2 programs, a tunneling program and strip mining program for CC:Tweaked Turtles, usage is described below.

## Usage

To use my turtle programs, you need a turtle. Normal or Advanced will work. The tunneling and strip mining programs will need a diamond pickaxe attached to the turtle to convert it into a mining turtle. Search up mining turtle in JEI in game in order to see how to do it. Once that is set up, place the turtle 2 blocks higher than the ground, basically at head height with the player model. Make sure to fuel the turtle by placing coal in the first slot and then following these commands in order:

```
lua
turtle.refuel()
exit
```

Once the turtle has been fueled, open any one of my programs on this github and view the raw file. Copy the link of the raw file and then use the following command

```
wget https://link-to-raw-file
```

Then, just type the name of the file in the turtle and you should be good to go

## Usage of Programs

### Tunneling

This one is super easy, just specify how deep you want to tunnel and it will create a 3x3 tunnel that deep, placing a torch every 8 blocks. Make sure you put torches in the first slot before starting the program.

### Strip mining

This will strip mine 1x3 mineshafts. You need to specify how many mineshafts youwant to mine, how deep those mineshafts to go and whether you want new mineshafts to go begin to the left or right. Torches will be placed every 8 blocks so make sure the turtle has torches in slot 1.
