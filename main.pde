


//libraries
import processing.serial.*;
Serial port;

//minim
import ddf.minim.*;

Minim minim;
AudioPlayer player;

//gui

import controlP5.*;

ControlP5 cp5;

boolean guiEvent = false;


//objects
Circle circles[];
Line lines[];
Flock flock;

color[] palette = {color(131,184,217),color(196,209,217),color(96,135,160),color(127,136,141),color(81,87,90)};

//variables
int numCircles = 3;
int minCircles = 1;
int maxCircles = 10;
int circleRadiusMin = 50;
int circleRadiusMax = 100;
int numLines = 2;
int minLines = 1;
int maxLines = 5;
int numVectors = 150;
int minVectors = 50;
int maxVectors = 250;
float seperation = 1.5;
float minSep = .5;
float maxSep = 10;
boolean showCircles = false;
boolean showLines = false;
boolean showVectors = false;


void setup(){
  size(1200,800);
  smooth();
  background(palette[3]);
  port = new Serial(this, Serial.list()[2],9600);
  setupGUI();
  setupMinim();
  
  circles = new Circle[numCircles];
  lines = new Line[numLines];
  flock = new Flock();
  
  
  for(int i = 0; i < circles.length; i++){
    circles[i] = new Circle(random(width),random(height),random(circleRadiusMin,circleRadiusMax));
  }
  for(int i = 0; i < lines.length; i++){
    float a = random(width);
    float b = random(height);
    float c = random(width);
    float d = random(height);
    lines[i] = new Line(a,b,c,d,int(random(3)));
  }
  for (int i = 0; i < numVectors; i++) {
    flock.addVector(new Vector(width/2,height/2));
  }
}

void draw(){
  if(guiEvent){
    background(palette[3]);
    updateArrays();
    guiEvent=false;
  }
  if(showCircles)
    background(palette[3]);
  
  play();
  flock.run(seperation, showVectors);
  checkIntersections();
  checkport();
}

void play(){
  for(int i = 0; i < lines.length; i++){
    lines[i].display();
  }
  for(int i = 0; i < circles.length; i++){
    circles[i].run();
    circles[i].display();
  }
}

void checkIntersections(){
  
  // circle line
  for(int i = 0; i < lines.length; i++){
    for(int j = 0; j < circles.length; j++){
      if(lines[i].lineIntersection(lines[i].lx1,lines[i].ly1,lines[i].lx2,lines[i].ly2,circles[j].cx,circles[j].cy,circles[j].lastcx,circles[j].lastcy) && !circles[j].graceperiod){
        circles[j].xspeed*=-random(.1,2.1);
        circles[j].yspeed*=-random(.1,2.1);
        circles[j].graceperiod = true;
      }
    }
  }
  
  // circle circle
  for(int i = 0; i < circles.length; i++){
    for(int j = 0; j < circles.length; j++){
      if(i != j){
        if(dist(circles[i].cx,circles[i].cy,circles[j].cx,circles[j].cy) < (circles[i].rad + circles[j].rad)){
          pushMatrix();
          stroke(palette[2]);
          line(circles[i].curveP1x,circles[i].curveP1y,circles[j].curveP2x,circles[j].curveP2y);
          line(circles[i].curveP2x,circles[i].curveP2y,circles[j].curveP1x,circles[j].curveP1y);
          popMatrix();
        }
      }
    }
  }
  
  // circle vector
  ArrayList<Vector> vectorCheck = flock.check();
  for(int i = 0; i < circles.length; i++){
    for(Vector v : vectorCheck){
      if(dist(circles[i].cx,circles[i].cy,v.location.x,v.location.y) < circles[i].rad){
        pushMatrix();
        stroke(palette[0]);
        line(circles[i].cx,circles[i].cy,v.location.x,v.location.y);
        popMatrix();
      }
    }
  }
}
