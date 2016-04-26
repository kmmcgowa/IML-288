class Line extends Behavior{
  
  float lx1,ly1,lx2,ly2;
  
  boolean bounce = false;
  boolean speedUP = false;
  boolean randEffect = false;
  
  Line(float _x1, float _y1, float _x2, float _y2, int effect) {
    lx1 = _x1;
    ly1 = _y1;
    lx2 = _x2;
    ly2 = _y2;
    if(effect == 0) bounce = true;
    else if (effect == 1) speedUP = true;
    else randEffect = true;
  }
  
  void display(){
    if(showLines){
      pushMatrix();
      stroke(palette[4]);
      line(lx1,ly1,lx2,ly2);
      popMatrix();
    }
  }
  
}
