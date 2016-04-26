void setupGUI(){
  color activeColor = color(0, 130, 164);
  cp5 = new ControlP5(this);
  //controlP5.setAutoDraw(false);
  cp5.setColorActive(activeColor);
  cp5.setColorBackground(color(170));
  cp5.setColorForeground(color(50));
  cp5.setColorLabel(color(50));
  cp5.setColorValue(color(255));

  ControlGroup ctrl = cp5.addGroup("menu", 15, 25, 35);
  ctrl.activateEvent(true);
  ctrl.setColorLabel(color(255));
  ctrl.close();
  
  int left = 0;
  int top = 5;
  int ypos = 0;
  
  cp5.addSlider("numCircles")
    .setPosition(left,top+ypos)
    .setSize(200,10)
    .setRange(minCircles,maxCircles)
    .setValue(numCircles)
    .setGroup("menu")
  ;
  ypos+=25;
  cp5.addToggle("showCircles")
    .setPosition(left,top+ypos)
    .setSize(10,10)
    .setValue(showCircles)
    .setLabel("Show Circles")
    .setGroup("menu")
  ;
  ypos+=35;
  cp5.addSlider("numLines")
    .setPosition(left,top+ypos)
    .setSize(200,10)
    .setRange(minLines,maxLines)
    .setValue(numLines)
    .setGroup("menu")
  ;
  ypos+=25;
  cp5.addToggle("showLines")
    .setPosition(left,top+ypos)
    .setSize(10,10)
    .setValue(showLines)
    .setLabel("Show Lines")
    .setGroup("menu")
  ;
  ypos+=35;
  cp5.addSlider("numVectors")
    .setPosition(left,top+ypos)
    .setSize(200,10)
    .setRange(minVectors,maxVectors)
    .setValue(numVectors)
    .setGroup("menu")
  ;
  ypos+=25;
  cp5.addToggle("showVectors")
    .setPosition(left,top+ypos)
    .setSize(10,10)
    .setValue(showVectors)
    .setLabel("Show Vectors")
    .setGroup("menu")
  ;
  ypos+=35;
  cp5.addSlider("seperation")
    .setPosition(left,top+ypos)
    .setSize(200,10)
    .setRange(minSep,maxSep)
    .setValue(1.5)
    .setGroup("menu")
  ;
}

void controlEvent(ControlEvent theControlEvent) {
  //if(theControlEvent == crtl.)
    guiEvent = true;
}

void updateArrays(){
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
