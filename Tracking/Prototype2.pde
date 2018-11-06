import processing.video.*;

Capture video;

ArrayList<Firework> fireworks;
PVector gravity = new PVector(0,0.2);

// color trackColor; 
float threshold = 50;
float distTreshold = 10;

// Capturing the previous image of live video
PImage prev;

// 
float motionX = 0;
float motionY = 0; 

// 
float lerpX = 0; 
float lerpY = 0; 

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(cameras);
  
  fireworks = new ArrayList<Firework>();
  

  // 'this' bc this sketch needs the frames
  video = new Capture(this, cameras[4]);
  video.start();

  // Saving the previous image from the live video
  prev = createImage(640, 480, RGB);
}

// Triggered bt the camera itself, every time there is a new frame
void captureEvent(Capture video) {
  // Copy the image to previous image. Copy whole video unto whole video
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  // Read video
  video.read();
}

void draw() {
  // load pixels from video and previous image
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);

  float avgX = 0; 
  float avgY = 0;

  int count = 0;

   loadPixels();

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);


      // Finding the distance between the colors
      float d = distSq(r1, g1, b1, r2, g2, b2);

      if (d > threshold*threshold) {

        avgX += x; 
        avgY += y;
        count++;

        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();


// ANIMATION, that follows the average X & Y 
  if (count > 0) {
    motionX = avgX/count;
    motionY = avgY/count; 

// lerp is used to ssmooth out a value
    lerpX = lerp(lerpX, motionX, 0.15);
    lerpY = lerp(lerpY, motionY, 0.15);

// This is the thing, that follows the motion
    fill(255, 0, 0);
    strokeWeight(4.0);
    stroke(0, 255, 0);
    ellipse(lerpX, lerpY, 30, 30);
    
//     fireworks.add(new Firework());
    
  fill(51, 50);
  noStroke();
  rect(lerpX,lerpY,40,40);
  //background(255, 20);

  
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
}
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
