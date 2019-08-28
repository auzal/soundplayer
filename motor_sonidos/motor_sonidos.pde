import processing.sound.*;

ArrayList <Track> tracks;

OscP5 oscP5;

PFont f_small;
PFont f_large;



int signal_alpha = 0;

void setup() {
  size(640, 600);
  tracks = new ArrayList();
  loadConfig();
  startOSC();
}

void draw() {
  final String sketch = getClass().getName() + " || @ " + nfc(frameRate, 1) + " fps";
  surface.setTitle(sketch);
  background(0);
  for (int i = 0; i < tracks.size(); i++) {
    tracks.get(i).render();
    tracks.get(i).update();
  }

  pushStyle();
  textFont(f_large);
  fill(255, 0, 94);
  textAlign(RIGHT, TOP);
  textLeading(23);
  text("MOTOR DE SONIDO\nA M N E S I A", 280, 5);
  stroke(255, 0, 94);
  strokeWeight(2);
  line(300, 7, 300, 50);
  textFont(f_small);
  textAlign(LEFT, TOP);
  text(tracks.size() + " SONIDOS CARGADOS", 320, 8);

  text("RECIBIEND EN PUERTO: " + OSC_PORT, 320, 20 );
  text("OSC ACTIVO", 320, 32 );
  fill( 0, 255, 210, signal_alpha);
  noStroke();
  ellipse(385, 37, 6, 6);

  popStyle();

  signal_alpha -= 15;
  signal_alpha = constrain(signal_alpha, 0, 255);
}

void keyPressed() {
  if(key == DELETE || key == BACKSPACE ){
    silence();
  }
}

void mousePressed() {
  for (int i = 0; i < tracks.size(); i++) {
    tracks.get(i).checkMousePressed();
  }

  for (int i = 0; i < tracks.size(); i++) {
    tracks.get(i).checkMouseClick();
  }
}

void mouseReleased() {
  for (int i = 0; i < tracks.size(); i++) {
    tracks.get(i).releaseMouse();
  }
}

void mouseClicked() {
}


void loadConfig() {
  f_small = loadFont("quick10.vlw");
  f_large = loadFont("Source30.vlw");
  String path = "data/amnesia/";

  XML xml;
  try {
    xml = loadXML(path + "config.xml");
  }
  catch(Exception e) {
    xml = null;
  }

  float x = 10;
  float y = 60;

  float h = 50;
  float w = 200;
  float margin = 10;

  if (xml!=null) {
    XML [] tracks_data = xml.getChildren("track");
    for (int i = 0; i < tracks_data.length; i++) {
      int id = tracks_data[i].getInt("id");
      float vol = tracks_data[i].getFloat("vol");
      String file = tracks_data[i].getString("file");

      Track t = new Track(this, path, file, id, vol, x, y);
      t.setFonts(f_small, f_large);
      tracks.add(t);
      y += h + margin;
      if ((i+1)%9==0) {

        y = 60;
        x+= w+margin;
      }
    }
  }
}

Track findTrackById(int id) {
  Track result = null;

  for (int i = 0; i < tracks.size(); i++) {
    if (id == tracks.get(i).id) {
      result =  tracks.get(i);
      break;
    }
  }
  return result;
}

void silence(){
  for(int i = 0 ; i < tracks.size() ; i++){
    tracks.get(i).stopSound();
  }
}
