
import oscP5.*;
import netP5.*;
  
int OSC_OUT_PORT;
int OSC_IN_PORT;

SoundDirector director;

void setup() {
  size(400,400);
  frameRate(25);
  OSC_OUT_PORT = 12222;
  OSC_IN_PORT = 12000;
  
  director = new SoundDirector(this, OSC_OUT_PORT, OSC_IN_PORT);
 

}


void draw() {
  background(0);  
  

  
}

void keyPressed(){
director.playSound(0,random(0,1));
}

void mousePressed(){
director.pauseSound(0);

}
