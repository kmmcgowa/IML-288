void setupMinim(){
  minim = new Minim(this);
  player = minim.loadFile("main.mp3");
  player.play();
}
