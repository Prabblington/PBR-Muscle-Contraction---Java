# PBR Muscle Contraction - Java
 Physically Based Rendering (PBR) of muscle contraction Dissertation project

Description:

This project was an attempt at using PBR to simulate the Sliding Filament Theory in a computed 
environment such as Processing 4.2 . This IDE allowed me to use absolute precision when creating 
object meshes and generating points relative to a focused position. Geometric functions were coded
themselves and an implementation of Perlin Noise using Processing's own "noise()" function has been
used to show that it would be possible to render objects with more realism if given more time for
the project to show a more advanced implementation of PBR. 

Objects present:

Actin filament = The pink and blue helical structures which move along the x-axis.
Myosin thick filament = The cylinder underneath the actin filament
Myosin heads (Myosin globules) = Spherical objects which have Perlin noise applied which move towards
				 the actin filament.
Tropomyosin = Green bezier curve with darker green globes attached to them which spin and move along 
	      the x-axis.

* Coded using Processing 4.2 Java

Pre-requisites:
- Processing 4.2
- Java JDK 

To run:

1. Download code in ZIP or pull from gitHub here if public: https://github.com/Prabblington/PBR-Muscle-Contraction---Java/tree/main
2. Extract ZIP contents
3. Open /Source/Main and select "main.pde" - This will open the project in Processing
4. Run with Play button in Processing

How to use:

- There is camera controls when running
	* MOUSE1 (Left click) = Pan around
	* MOUSE2 (Right click) = Rotate camera at target
	* MOUSEUP/MOUSEDOWN (Scroll wheel) = Inverted controls, zooms in and out
