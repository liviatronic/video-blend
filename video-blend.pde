import processing.video.*;
import com.hamoid.*;

PImage target;
PImage mask;
Movie mov1;
Movie mov2;
VideoExport videoExport;

void setup() {
  size(640, 480, P2D);
  frameRate(10);
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();

  mov1 = new Movie(this, "facecam1-short-480.mp4");
  mov1.play();

  mov2 = new Movie(this, "catcam-short-480.mp4");
  mov2.play();
}

void draw() {
  float ratio = mouseX / (float) width;
  mov1.jump(ratio * mov1.duration()); 
  mov1.read();
  
  float ratio2 = mouseY / (float) height;
  mov2.jump(ratio2 * mov2.duration()); 
  mov2.read();
  
  target = mov1.get();
  mask = mov2.get();
  image(target, 0, 0, width, height);
  

  target.blend(mask, 0, 0, width, height, 0, 0, width, height, DARKEST);
  
  videoExport.saveFrame();
}
  
  void movieEvent(Movie movie) {
  movie.read();
}
  
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
