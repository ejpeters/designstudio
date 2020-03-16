import org.openkinect.processing.*;
Kinect2 kinect2;
PImage img, trail, erosion;
PGraphics largerImage;

float minThresh = 500;
float maxThresh = 2000;

boolean isFullScreen = false;

void settings() {
  if (isFullScreen) {
    fullScreen();
  } else {
    size(1280, 800, P3D);
  }
}

void setup() {
  background(255, 0, 0);
  noStroke();
  
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  largerImage = createGraphics(1280, 800, P3D);
}

void draw() {
  img.loadPixels();
  
  int[] depth = kinect2.getRawDepth();
  
  int skip = 1;
  
  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      if (d > minThresh && d < maxThresh) {
        img.pixels[offset] = color(200);
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }
  
  img.updatePixels();
  
  // draw kinect image to the screen
  //image(img, 0, 0);
  
  // upscale kinect image to img
  largerImage.beginDraw();
  // use add blend mode to add white pixels on top of existing upscaled image
  largerImage.blendMode(ADD);
  largerImage.image(img, 0, 0, largerImage.width, largerImage.height);
  // reset blend mode and draw kinect data on top to fade out
  largerImage.blendMode(BLEND);
  largerImage.fill(0, 0, 0, 10);
  largerImage.noStroke();
    largerImage.rect(0, 0, largerImage.width, largerImage.height);
  // close PGraphics
  largerImage.endDraw();
  
  // draw upscaled image to screen
  scale(-1.0, 1.0);
  image(largerImage, -largerImage.width, 0);
  
  
  
}
