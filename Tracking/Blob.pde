class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }

  void add(float x, float y) {
    
    minx = min(minx,x);
    miny = min(miny,y);
    maxx = max(maxx,x);
    maxy = max(maxy,y);
  }
  
   float size(){
      return (maxx - minx) * (maxy - miny);
  }
  
  void show(){
  /*stroke(0);
  fill(255);
  strokeWeight(2);
  rectMode(CORNERS);
  rect(minx,miny,maxx,maxy);
  */

  ps.addParticle(maxx, maxy);
  ps.run();
  
  }

  boolean isNear(float x, float y) {
    float cx = (minx +maxx) / 2;
    float cy = (miny +maxy) / 2;

    float d = distSq(cx, cy, x, y);
    if ( d < distTreshold*distTreshold ) {
      return true;
    } else {
      return false;
    }
  }
  
}
