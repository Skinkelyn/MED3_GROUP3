class Particle {

  PVector loc, dir, vel;
  float speed;
  int d=1; // direction change
  color col;

  Particle(PVector _loc, PVector _dir, float _speed) {
    loc = _loc;
    dir = _dir;
    speed = _speed;
  }

  void run() {
    move();
    checkEdges();
    update();
  }

  void move() {
    float angle=noise(loc.x/noiseScale, loc.y/noiseScale, frameCount/noiseScale)*TWO_PI*noiseStrength;
    dir.x = cos(angle+lerpX/360);
    dir.y = sin(angle+lerpY/360);
    vel = dir.get();
    vel.mult(speed*d);
    loc.add(vel);
  }

  void checkEdges() {
    //float distance = dist(width/2, height/2, loc.x, loc.y);
    //if (distance>150) {
    if (loc.x<0 || loc.x>width || loc.y<0 || loc.y>height) {    
      loc.x = random(width*1.2);
      loc.y = random(height);
    }
  }

  void update() {
    fill(200, 244, 0);
    ellipse(loc.x, loc.y, loc.z, loc.z);
  }
}
