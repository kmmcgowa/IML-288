void setupMinim(){
  minim = new Minim(this);
  
  // change song path here
  
  player = minim.loadFile("main.mp3");
  
  
  player.play();
}
