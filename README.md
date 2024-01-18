# The Impossible Puzzle

Welcome to **The Impossible Puzzle**, an intriguing gaming experience designed to challenge your patiente ;). Don't spoil the surprise by reading too much ahead – first give the game the chance to make its first impression on you.

### Play Instructions

To fully appreciate the surprise and challenges that **The Impossible Puzzle** offers, we recommend playing the game first without reading the detailed description below. Immerse yourself in the experience, and once you've given it your best shot, return to this section for insights into the game's design and development.

## Description

### Idea behind the game

**The Impossible Puzzle** is designed to be an engaging and progressive challenging game. It begins with seemingly straightforward levels. As the player advances however, the game gets harder. The challenge is, that with each level the game incorporates simulations of various color blindness conditions.

### How?
The game itself is a normal sliding puzzle we know from childhood. The small square puzzle, where you have to order the numbers 1-15 where the missing 16 gives you the opportunity to slide the other numbers into place.
As the level progress you get images/colour-hues you have to order. 
For the algorithm to simulate the color blindness i have used the filters from the open-source code [daltonlens.org](https://daltonlens.org/opensource-cvd-simulation).
### Results

The game progresses through levels of increasing difficulty, introducing players to different color blindness simulations such as Protanopia, Deuteranopia, and Tritanopia. The ultimate challenge lies in the impossible level, where the puzzle becomes a black-and-white enigma, pushing players to their limits.

### Issues/Problems

Initially i wanted to create the algorithm to adjust the colours of the images accordingly to the selected colourblindness. But i realized quickly, that there isnt just some simple formula i could use for the rgb, colours as I have seen on this essay [Computerized simulation of color appearance for dichromats](http://vision.psychol.cam.ac.uk/jdmollon/papers/Dichromatsimulation.pdf) 
So i figured, until I fully understand the maths behind this, my time for this project will be up already. And because of the importance of the colour-blindness awarness that would be the biggest part of creating this inclusive gaming experience, 
i have decided to look for a simpler solution to use the algorithm. 

#### Linkes & Codes used 
- Color blindness filter [daltonlens.org](https://daltonlens.org/opensource-cvd-simulation)
- The algorithm in detail [Computerized simulation of color appearance for dichromats](http://vision.psychol.cam.ac.uk/jdmollon/papers/Dichromatsimulation.pdf)

- [GitHub Repo](https://github.com/HavaFuga/TheImpossiblePuzzle)