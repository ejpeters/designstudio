import processing.sound.*;

SoundFile file;
String audioName = "wind-grass.mp3";
String path;

void setup() {
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
}


void draw() {

}
