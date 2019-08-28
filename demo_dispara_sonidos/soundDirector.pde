class SoundDirector {

  OscP5 oscP5;
  NetAddress myRemoteLocation;

  SoundDirector(PApplet parent, int port_out, int port_in) {
    oscP5 = new OscP5(parent, port_in);
    myRemoteLocation = new NetAddress("127.0.0.1", port_out);
  }


  void sendTest() {
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(123); /* add an int to the osc message */
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }

  void playSound(int id) {
    OscMessage myMessage = new OscMessage("/play");
    myMessage.add(id); 
    oscP5.send(myMessage, myRemoteLocation);
  }

  void playSound(int id, float amp) {
    OscMessage myMessage = new OscMessage("/play");
    myMessage.add(id); 
    myMessage.add(amp);
    oscP5.send(myMessage, myRemoteLocation);
  }

  void pauseSound(int id) {
    OscMessage myMessage = new OscMessage("/pause");
    myMessage.add(id); 
    oscP5.send(myMessage, myRemoteLocation);
  }

  void stopSound(int id) {
    OscMessage myMessage = new OscMessage("/stop");
    myMessage.add(id); 
    oscP5.send(myMessage, myRemoteLocation);
  }

  void loopSound(int id) {
    OscMessage myMessage = new OscMessage("/loop");
    myMessage.add(id); 
    oscP5.send(myMessage, myRemoteLocation);
  }

  void loopSound(int id, float amp) {
    OscMessage myMessage = new OscMessage("/loop");
    myMessage.add(id); 
    myMessage.add(amp);
    oscP5.send(myMessage, myRemoteLocation);

  }
  
  void setAmp(int id, float amp){
    OscMessage myMessage = new OscMessage("/amp");
    myMessage.add(id); 
    myMessage.add(amp);
    oscP5.send(myMessage, myRemoteLocation);
  }
  
  void silence(){
    OscMessage myMessage = new OscMessage("/silence");
    oscP5.send(myMessage, myRemoteLocation);
  }
}
