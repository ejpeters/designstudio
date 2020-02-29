import org.openkinect.processing.*;

Kinect2 kinect2;

float minThresh = 500;
float maxThresh = 1700;
PImage img, forest, desert;

ArrayList<PImage> images = new ArrayList<PImage>();

void setup() {
  size(512, 424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  forest = loadImage("forest.jpg");
  desert = loadImage("desert.jpg");
}

void draw() {

  background(0);

  img.loadPixels();

  //if (images.size() > 10) {
  //  images.remove(0);
  //}
  

  int[] depth = kinect2.getRawDepth();
  
  //forest.mask(desert);

  for (int x = 0; x < kinect2.depthWidth; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      if (d > minThresh && d < maxThresh) {
        img.pixels[offset] = color(200);
        //forest.mask(desert);
        //forest.pixels[offset].mask(desert.pixels[offset]);
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }

  for (int i = 0; i < images.size(); i++){
    
  }
  
  img.updatePixels();
  images.add(img);
  
  if (images.size() > 10) {
    images.remove(0);
  }
  
  PImage part = images.get(0);
  //image(part, 0, 0);
  
  image(forest, 0, 0);
  desert.mask(part);
  image(desert, 0, 0);
  
}

class Image {
  PImage kinectPos;

  Image(PImage thePos) {
    kinectPos = thePos;
  }
}
