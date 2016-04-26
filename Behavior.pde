class Behavior {
  
  Behavior(){
  }
  
  boolean lineIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
    boolean intersect = false;
    float a1 = y2 - y1;
    float b1 = x1 - x2;
    float c1 = a1*x1 + b1*y1;
    float a2 = y4 - y3;
    float b2 = x3 - x4;
    float c2 = a2*x3 + b2*y3;
    float det = a1*b2 - a2*b1;
    if(det == 0){
      return intersect;
    }
    else {
      float x = (b2*c1 - b1*c2)/det;
      float y = (a1*c2 - a2*c1)/det;
      if(x > min(x1, x2) && x < max(x1, x2) &&
         x > min(x3, x4) && x < max(x3, x4) &&
         y > min(y1, y2) && y < max(y1, y2) &&
         y > min(y3, y4) && y < max(y3, y4)){
        intersect = true;
      }
    }
    return intersect;
  }
  
}
