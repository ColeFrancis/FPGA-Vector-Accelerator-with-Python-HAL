# Engineering Design Steps

## Define the Problem

What do we want to make?

We want to design an architecture capable of accelerating common vector operations, and a HAL that allows the acceleratore to be interfaced in Python.

## Do Background Research

What has already been done in this space we can adapt or build upon?

## Specify Requirements

How will we know our project is a success?

The accelerator will at least implement the following instructions:
* Vector-vector addition
* Sclar-vector multiplication
* Vector dot product
* Matrix-vector multiplication
* Vector Relu operation

The accelerator will be entirely implemented on our Basys3 FPGA.

Use UART as the communication protocol.

We will build a driver to interface with Python.
  

## Brainstorm various solutions

For each aspect of desing (hardware architecture, software design .etc) 

## Devop solution

Pick the best solution and develop it

## Test Solution

Make sure our solution meets all specified requirements

## Improve and Iterate Solution

If solution does not meet requirements, fix it

## Comunicate results

Create final documentation
