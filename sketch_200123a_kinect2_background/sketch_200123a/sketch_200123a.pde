import org.openkinect.processing.*;

Kinect2 kinect2;
float minThresh = 600;
float maxThresh = 800;
PImage img;
PImage path;


void setup() {
  size(512, 424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  path = loadImage("teamtree-4593618_640.png");
  path.resize(512, 424);
}

void draw() {
  background(0);
  
  img.loadPixels();
  path.loadPixels();
  
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, height, 0, 4500);
  
  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
    
  pushMatrix();
  for(int x = 0; x < kinect2.depthWidth; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      if (d > minThresh && d < maxThresh) {
        //img.pixels[offset] = color(255, 20, 20);
        
        //sumX += x;
        //sumY += y;
        //totalPixels++;
      } else {
        // Draw the pixels from the image we imported
        
        img.pixels[offset] = path.pixels[offset];
        //img.pixels[offset] = color(0);
      }
    }
  }
  

  
  img.updatePixels();
  image(img, 0, 0);
  popMatrix();
  
  pushMatrix();
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(255, 255, 20);
  ellipse(avgX, avgY, 64, 64);
  //append(particles, avgX);
  //append(particles, avgY);
  popMatrix();
  
  
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);

}
