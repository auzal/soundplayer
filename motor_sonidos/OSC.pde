import netP5.*;
import oscP5.*;

int OSC_PORT = 12222;

void startOSC() {
  oscP5 = new OscP5(this, OSC_PORT);
}

void oscEvent(OscMessage theOscMessage) {
  signal_alpha = 255;
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  String addrPattern = theOscMessage.addrPattern();
  if (addrPattern.equals("/play")) {
    int id = theOscMessage.get(0).intValue(); 
    Track t = findTrackById(id);
    if (t!=null) {
      if (theOscMessage.checkTypetag("i")) {
        t.playSound();
      } else if (theOscMessage.checkTypetag("if")) {
        float amp = theOscMessage.get(1).floatValue(); 
        t.setVolume(amp);
        t.playSound();
      }
    } else {
      println("TRYING TO ACCESS A NON EXISTANT SOUND!!!!!");
    }
  } else if (addrPattern.equals("/loop")) {
    int id = theOscMessage.get(0).intValue(); 
    Track t = findTrackById(id);
    if (t!=null) {
      if (theOscMessage.checkTypetag("i")) {
        t.loopSound();
      } else if (theOscMessage.checkTypetag("if")) {
        float amp = theOscMessage.get(1).floatValue(); 
        t.setVolume(amp);
        t.loopSound();
      }
    } else {
      println("TRYING TO ACCESS A NON EXISTANT SOUND!!!!!");
    }
  } else if (addrPattern.equals("/pause")) {
    int id = theOscMessage.get(0).intValue(); 
    Track t = findTrackById(id);
    if (t!=null) {
      if (theOscMessage.checkTypetag("i")) {
        t.pauseSound();
      }
    } else {
      println("TRYING TO ACCESS A NON EXISTANT SOUND!!!!!");
    }
  }else if (addrPattern.equals("/stop")) {
    int id = theOscMessage.get(0).intValue(); 
    Track t = findTrackById(id);
    if (t!=null) {
      if (theOscMessage.checkTypetag("i")) {
        t.stopSound();
      }
    } else {
      println("TRYING TO ACCESS A NON EXISTANT SOUND!!!!!");
    }
  }else if (addrPattern.equals("/amp")) {
    int id = theOscMessage.get(0).intValue(); 
    Track t = findTrackById(id);
    if (t!=null) {
      if (theOscMessage.checkTypetag("if")) {
        float amp = theOscMessage.get(1).floatValue(); 
        t.setVolume(amp);
      }
    } else {
      println("TRYING TO ACCESS A NON EXISTANT SOUND!!!!!");
    }
  } else if (addrPattern.equals("/silence")) {
   silence();
  } 
}
