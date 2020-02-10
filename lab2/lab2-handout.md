CPU Lab
===

## Overview of this lab

Before starting this lab, you are supposed to be equipped with the following:

- The same environment as assembly lab
- Basic C++ programming language
- Basic MIPS assembly

After this lab, you will understand following:

- Better understanding about emulating, especially SPIM, a MIPS emulator
- Better understanding about 5-stage pipelining CPU model

During this lab, you are suggested to refer to the following materials:

- MIPS32 ISA Quick Reference

    https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00565-2B-MIPS32-QRC-01.01.pdf

    More documents: https://www.mips.com/products/architectures/mips32-2/

- syscalls defined by SPIM

    http://students.cs.tamu.edu/tanzir/csce350/reference/syscalls.html

## Background Story

Young emperor Qin Shi Huang just woke up from a nightmare. Three Suns will go into a straight line, leading his people to the devastation. The only way to resolve, is to accurately calculate the orbit of those stars. At the same time, von Neumann and Wang Miao visit, with their powerful design called 5-stage CPU...

## Provided infrastructure

Inside this repository, we provide following files:

<font face="Consolas">|-lab2</font>

<font face="Consolas">    |-lab2-handout.pdf --- This document</font>

<font face="Consolas">|-spim-timingmodel/CPU --- spim-t code directory</font>

<font face="Consolas">    |-timingmodel.h --- Basic definition of Timing Event and Timing Component</font>

<font face="Consolas">    |-timing_core.h --- CPU top design definition</font>

<font face="Consolas">    |-timing_{fetcher, decoder, executor, lsu, register, rob}.h/cpp --- specific processor component</font>

<font face="Consolas">    |-scheduler.h/cpp --- global scheduler</font>

<font face="Consolas">    |-next_pc_gen.h/cpp --- A component for pc generation</font>

## Task Instructions

Figure 1 introduces the 5 stages in their in-order processor design.

[Blank]

According to their design, the emperor has trained five troops, in charge of instruction fetching, decoding, executing, memory and regfile accessing. But soon they realize a practical problem: soldiers are too far away to receive neighboring signal, thus a global clock is impossible to be implemented at all. After careful thought, Wang comes up an idea: a global scheduler, instead of global clock should be set and operated by emperor, to guide all events in the order of their timestamp. Therefore a complete instruction can be organized as five timing events, correspondingly going through each stage (timing component).

Before simulating stars, the emperor wants to test this machine with an image processing MIPS assembly that he dreamed. The emperor hopes the functionality (output) would be the same with lab1 and timing statistics to be at least close. The emperor commands his army in the language of C++.

We have provided a naive processor framework which can only execute `addiu`, `jal`, `lw` and `syscall` instructions. You should:

- Finish all related instruction types from your lab1 program. (Both C version and MIPS version are acceptable)
- Handle Read-After-Write data dependency correctly.
- Complete a design document (save it for thousands of your offsprings).

### Suggestions from Wang Miao

0. All function-related code is written in `run.cpp` in spim. What you only need is to split them into stages. Just copy those reusable code (or macro) at ease.

1. Classify your instruction in decoding stage. Generally MIPS has three instruction categories: R-type, I-type and J-type. But they can be divided into more subtypes. A proper classification can greatly simplify your `switch...case...` logic in the rest stages.

2. There are several ways for handling RAW dependencies:

- Use a bool array as 'spinlocks' to regfile. Stall any event in decoding stage that tries to read a locked register.
- Or, think global scheduler as a priority queue which picks the **earliest unstalled events** and passes to its receiver. Stall determination shoud be carefully considered.

3. One delayed branch is required in this lab (Why?). You may need to insert `nop` after each jump instruction in your lab1 code.

4. Implement instruction one by one. To improve developing efficiency, we conduct regfile checking after each instruction commits. Spim-t would stop at first difference register write. Spim can also generate gold register traces via `../spim-timingmodel/spim/spim -lab2-gen -delayed_branches file lab1.S`. Only comparison and syscall uses spim regfile (which I have completed). **You must not use any value directly from spim regfile `R[]`.**

5. Do not try to change files with `DO NOT MODIFY` header! They are reserved for TA and will be overwritten automatically.

### Finish writing your design document

- Design document

    No specific format required, but you should demonstrate how your program works, in a clear way

- Record performance of your algorithm

    Lab1 cycle count (pipelined core without bypassing):
    Lab2 cycle count:
    Average stall ratio = average(executeCycles/(endCycle-startCycle)):

- Answer following questions:

    - ALU is just a bunch of combinational logic. Why does it need one cycle?
    - Is the emperor able to implement a out-of-order processor using this design?

Good luck, your Majesty!

## Grading policy

Plagiarism is **strictly** forbidden in this lab. Peer discussion is **not** suggested. Contact TA if you are in trouble.

### Functionality

TA emulates your program to generate an output pixel file. Then TA compares it with a pre-processed gold standard (your lab1 work). More matches mean higher correctness score. Note that we will use different image pairs for grading!

### Timing

Lower $abs(lab1-cycle-count - lab2-cycle-count)$ means higher score.

Overall grade is based on such two items.
