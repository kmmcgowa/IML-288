class Vector extends Behavior {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;

  float lastx;
  float lasty;
  
  color currentCol = color(palette[1]);

  Vector(float x, float y) {
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    location = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
    lastx = location.x;
    lasty = location.y;
  }
  void run(ArrayList<Vector> vectors, float sep, boolean show) {
    flock(vectors, sep);
    update();
    borders();
    if(show){
      render(); // shows vectors 
    }
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  void flock(ArrayList<Vector> vectors, float sep) {
    PVector seper = separate(vectors);   // Separation
    PVector ali = align(vectors);      // Alignment
    PVector coh = cohesion(vectors);   // Cohesion
    seper.mult(sep);
    ali.mult(1.0);
    coh.mult(1.0);
    applyForce(seper);
    applyForce(ali);
    applyForce(coh);
  }
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    lastx = location.x;
    lasty = location.y;
    location.add(velocity);
    acceleration.mult(0);
  }
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.setMag(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }
  void render() {
    float theta = velocity.heading() + radians(90);
    pushMatrix();
    fill(currentCol, 100);
    stroke(255);
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
  PVector separate (ArrayList<Vector> vectors) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Vector other : vectors) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }
    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
  PVector align (ArrayList<Vector> vectors) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Vector other : vectors) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }
  PVector cohesion (ArrayList<Vector> vectors) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Vector other : vectors) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } 
    else {
      return new PVector(0, 0);
    }
  }
} // END VECTOR CLASS --------------------------------------------------------------

class Flock extends Behavior{
  ArrayList<Vector> vectors;

  Flock() {
    vectors = new ArrayList<Vector>();
  }

  void run(float sep, boolean show) {
    for (Vector v : vectors) {
      v.run(vectors, sep, show);
    }
  }

  void addVector(Vector v) {
    vectors.add(v);
  }
  
  ArrayList check(){
    return vectors;
  }
}
