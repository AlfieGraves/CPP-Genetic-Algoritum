import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

int numCircles = 10;
int generation = 0;
int maxGens = 1000;
int popSize = 500;
float mutationRate = 0.015f;
int tournamentSize = 5;
float selectionPressure = 0.4f;
boolean computed = false;

Bunch orderedCircles;
Population population;
PFont f;
int startTime;
boolean timingStarted = false; 
float elapsedTimeInSeconds = 0;

int w = 800;
int h = 600;
int cx = w / 2;
int cy = h / 2;

void setup() {
  size(800, 600);
  f = createFont("Arial", 16, true);

  int[] R1={10,12,15,20,21,30,30,30,50,40}; 
  int[] R2={10,40,25,15,18};
  int[] R3={10,34,10,55,30,14,70,14};
  int[] R4={5,50,50,50,50,50,50};
  int[] R5={10,34,10,55,30,14,70,14,50,16,23,76,34,10,12,15,16,11,48,20};
  
  int[] selectedRadii = R1;
  
  numCircles = selectedRadii.length;
  orderedCircles = new Bunch(selectedRadii);

  population = new Population(popSize, maxGens, mutationRate);
  startTime = millis();
}

void draw() {
  if (!computed) {
    background(255);
    orderedCircles.draw();
    fill(0);
    textFont(f, 16);
    text("ORDER-BASED PLACEMENT", 50, 20);
    text("Bounding circle radius: " + orderedCircles.computeBoundary(), 50, 50);
    computed = true;
  }

  if (!population.finished) {
    if (!timingStarted) {
      startTime = millis(); // Start timing
      timingStarted = true;
    }
    population.evolve(generation);
    Individual best = population.getBest();
    background(255);
    textFont(f, 16);
    fill(0);
    text("Generation: " + generation, 50, 20);
    text("Best placement bounding radius: " + best.length, 50, 50);
    text("Placement order: " + Arrays.toString(best.genome), 50, 75);  // Display the order of circles
    orderedCircles.placeCircles(best.genome);
    orderedCircles.draw();
    generation++;
  } else {
    if (timingStarted) {
      float elapsedTimeMillis = millis() - startTime;
      elapsedTimeInSeconds = elapsedTimeMillis / 1000.0;
      timingStarted = false;
    }
    fill(0);
    text("Time taken: " + nf(elapsedTimeInSeconds, 0, 2) + " seconds", 50, 110);
    }
}
