<br />
<p align="center">
  <p align="center" font-size: large>
    <b>Exploring the basics of C </b>
    <br />
    <br />
    <br />
  </p>
</p>

<!-- TABLE OF CONTENTS -->

<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#structure-of-the-repository">Structure of the Repository</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT -->

## About The Project

This project was created as part of the "Polyglottal Week" of the Code Chrysalis Advanced Software Engineering Program.

The goal I set myself for this week was to explore the basics of C and apply them to a real-world example (Raspberry PI GIPO control).
Because of the specificity of this projects, there is really not much to say in this readme - I do not recommend to use this code, and instead explore yourselves!
The repo itself is only a small portion of what went into this project - the main task was to research the underlying principles of programming that I wanted to understand better.

These are:

- Compilers
- Memory Allocation
- Garbage Collection
- RaspberryPi GIPO control

Additionally, this helped me understand the "quality of life" improvements that modern programming languages include.

<!-- STRUCTURE -->

## Structure of the Repository

The repo is structured as follows:

1. CompilerBreakdown:

Contains Examples of mainProgram.c as it is going through the main steps of the compiling process.

- Preprocess
- Compiler
- Assembly
- Linker

These steps were shown in a short presentation to give an overview of how a compiler works.

2. earlyExplorations:

Contains the following exploratory scripts:

- HelloPi: The simplest Hello World example, as you might expect
- HexDump: An attempt to print out the content of stored memory to the console.
- PrintByte: Print out a byte to the console
- testName: A very simple additon script

3. MainProgram:

The main code of this repo, incorporating the above scripts to achieve the following overall functionality:

- RaspberryPi controls:
  - Controlling an LED on the RaspberryPI GPIO Breadboard
  - Controlling an LCD screen on the RaspberryPI GPIO Breadboard
  - Displaying the core temperature of the RaspberryPI

- Exploration of Memory handling:
  - Displaying different values in bytes and bits
  - Printing out the content of stored memory



<!-- CONTACT -->

## Contact

Chris Ackermann
<br />
Github: [https://github.com/Chris-Ack](https://github.com/Chris-Ack)
<br />
LinkedIn: [https://www.linkedin.com/in/chris-ackermann/](https://www.linkedin.com/in/chris-ackermann/)
