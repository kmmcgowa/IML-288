class Circle extends Behavior{
  
  float cx, cy, diam, rad, curveP1x, curveP1y, curveP2x, curveP2y, ang;
  int xspeed;
  int yspeed;
  float lastcx;
  float lastcy;
  boolean graceperiod = false;
  int gracecount = 0;
  
  Circle(float _x, float _y, float _diam){
    cx = _x;
    cy = _y;
    diam = _diam;
    rad = diam/2;
    ang = 0;
    curveP1x = cx + rad*cos(radians(ang));
    curveP1y = cy + rad*sin(radians(ang));
    curveP2x = cx - rad*cos(radians(ang));
    curveP2y = cy - rad*sin(radians(ang));
    xspeed = int(random(3,5));
    yspeed = int(random(3,5));
    lastcx = cx;
    lastcy = cy;
  }
 
  void run(){
    lastcx = cx;
    lastcy = cy;
    cx += xspeed;
    cy += yspeed;
    if(cx > width || cx < 0)
      xspeed*=-1;
    if(cy > height || cy < 0)
      yspeed*=-1;
    ang++;
    ang = ang%360;
    curveP1x = cx + cos(radians(ang))*rad;
    curveP1y = cy + sin(radians(ang))*rad;
    curveP2x = cx - cos(radians(ang))*rad;
    curveP2y = cy - sin(radians(ang))*rad;
    if(graceperiod && gracecount < 10)
      gracecount++;
    else {
      gracecount = 0;
      graceperiod = false;
    }
    
  }
  
  void display(){
    if(showCircles){
      pushMatrix();
      noFill();
      stroke(palette[4]);
      ellipse(cx,cy,diam,diam);
      ellipse(cx,cy,1,1);
      popMatrix();
      pushMatrix();
      fill(255);
      stroke(palette[4]);
      ellipse(curveP1x,curveP1y,10,10);
      ellipse(curveP2x,curveP2y,10,10);
      popMatrix();
    }
  }
  
}
