class Track {

  float x;
  float y;
  float w;
  float h;
  boolean playing;
  SoundFile sound;
  float[] wave;
  int wave_size;
  PFont font_small;
  PFont font_large;
  int id;
  String filename;
  float slider_x;
  float slider_y;
  float slider_w;
  float slider_h;
  boolean slider_pressed;
  float vol;

  float x_play;
  float y_play;
  float x_pause;
  float y_pause;
  float x_stop;
  float y_stop;
  float button_side;
  boolean play_pressed;
  boolean pause_pressed;
  boolean stop_pressed;
  int play_opacity;
  int pause_opacity;
  int stop_opacity;

  int fire_time;
  int current_time;
  int prev_time;

  float current_play_time;


  Track(PApplet parent, String path, String filename_, int id_, float vol_, float x_, float y_) {
    x = x_;
    y = y_;
    filename = filename_;
    sound = new SoundFile(parent, path + filename);
    wave_size = 100;
    w = 200;
    h = 50;
    wave = new float[wave_size];
    makeWave();
    playing = false;
    id = id_;

    slider_x = x + 145;
    slider_y = y + 5;
    slider_w = 10;
    slider_h = h - 10;
    vol = vol_;
    slider_pressed = false;

    button_side = 15;
    x_play = x + 160;
    y_play = y + 7;

    x_pause = x + 180;
    y_pause = y + 7;

    x_stop = x + 160;
    y_stop = y + 27;

    play_opacity = 0;
    pause_opacity = 0;
    stop_opacity = 0;

    current_play_time = 0;
  }

  void render() {
    pushMatrix();  
    pushStyle();
    stroke(255, 0, 94); 
    noFill();
    pushMatrix();  
    translate(x, y);
    rect(0, 0, w, h);
    fill(255, 0, 94);
    rect(0, 0, 35, h);
    fill(0);
    noStroke();
    if (font_large != null)
      textFont(font_large);
    textAlign(CENTER, CENTER);
    text(id, 35/2, h/2);
    stroke(255, 0, 94); 

    pushMatrix(); 
    translate(40, 15);
    rect(0, 0, wave_size, 30);
    popMatrix();


    pushMatrix();

    if (playing)
      stroke(0, 255, 210, 200);
    else
      stroke(255, 0, 94);
    translate(40, 30);
    for (int i = 0; i < wave.length; i++) {
      float l = wave[i];
      l = constrain(l, 0, 30);
      line(i, -l/2, i, l/2);
    }
    float x_playhead = map(current_play_time, 0, sound.duration(), 0, wave.length);
    stroke(255, 128, 0);
    line(x_playhead, -15, x_playhead, 15);
    if (font_small != null)
      textFont(font_small);
    textAlign(LEFT);
    fill(0);
    pushMatrix();
    translate(3,12);
    text(nfc(sound.duration(), 1), 1,1);
    fill(255, 128, 0);
    text(nfc(sound.duration(), 1), 0, 0);
    popMatrix();

    popMatrix();

    pushMatrix();
    // translate(x, y);
    fill(255, 0, 94);
    if (font_small != null)
      textFont(font_small);
    textAlign(LEFT);
    text(filename, 40, 11);
    popMatrix();

    popMatrix();

    pushMatrix();
    translate(slider_x, slider_y);
    noFill();
    stroke(255, 0, 94);
    fill(255, 0, 94);
    float h_vol = map(vol, 0, 1, 0, slider_h);
    rect(0, slider_h, slider_w, -h_vol);
    noFill();
    rect(0, 0, slider_w, slider_h);
    popMatrix();

    noStroke();

    pushMatrix();
    translate(x_play, y_play);
    fill(255, 0, 94);
    rect(0, 0, button_side, button_side);
    fill(255, play_opacity);
    rect(0, 0, button_side, button_side);
    fill(0);
    triangle(3, 2, 13, 7.5, 3, 13);
    popMatrix();

    pushMatrix();
    translate(x_pause, y_pause);
    fill(255, 0, 94);
    rect(0, 0, button_side, button_side);
    fill(255, pause_opacity);
    rect(0, 0, button_side, button_side);
    fill(0);
    rect(3, 2, 4, 10);
    rect(9, 2, 4, 10);
    popMatrix();

    pushMatrix();
    translate(x_stop, y_stop);
    fill(255, 0, 94);
    rect(0, 0, button_side, button_side);
    fill(255, stop_opacity);
    rect(0, 0, button_side, button_side);
    fill(0);
    rect(3, 3, 9, 9);
    popMatrix();

    popMatrix();


    popStyle();
  }

  void update() {

    playing = sound.isPlaying();

    if (!playing) {
      prev_time = millis();
    }
    current_time = millis();

    float delta_time = current_time - prev_time;


    current_play_time += delta_time/1000.0;

    if (current_play_time > sound.duration())
      current_play_time = 0;

    if (slider_pressed) {
      float y = constrain(mouseY, slider_y, slider_y + slider_h);
      vol = map(y, slider_y, slider_y + slider_h, 1, 0);
    }

    stop_opacity -=10;
    stop_opacity = constrain(stop_opacity, 0, 255);
    play_opacity -=10;
    play_opacity = constrain(play_opacity, 0, 255);
    pause_opacity -=10;
    pause_opacity = constrain(pause_opacity, 0, 255);

    sound.amp(vol);

    if (playing) {
      prev_time = millis();
    }
  }

  boolean isPlaying() {
    return sound.isPlaying();
  }

  void playSound() {
    if (!sound.isPlaying())
      sound.play();
  }

  void pauseSound() {
    if (sound.isPlaying())
      sound.pause();
  }

  void stopSound() {
    // println("stop");
    current_play_time = 0;
    sound.stop();
    // sound.stop();
    // sound.
    // println(sound.position());
  }

  void loopSound() {
    sound.loop();
  }
  
  void setVolume(float vol_){
    vol_ = constrain(vol_, 0, 1);
    vol = vol_;
    sound.amp(vol);
  
  }

  void checkMousePressed() {
    if (mouseX > slider_x && mouseX < slider_x + slider_w && mouseY > slider_y && mouseY < slider_y + slider_h) {
      slider_pressed = true;
    }
  }

  void checkMouseClick() {
    if (mouseX > x_play && mouseX < x_play + button_side && mouseY > y_play && mouseY < y_play + button_side) {
      playSound();
      play_opacity = 255;
    }

    if (mouseX > x_pause && mouseX < x_pause + button_side && mouseY > y_pause && mouseY < y_pause + button_side) {
      pauseSound();
      pause_opacity = 255;
    }

    if (mouseX > x_stop && mouseX < x_stop + button_side && mouseY > y_stop && mouseY < y_stop + button_side) {
      stopSound();
      stop_opacity = 255;
    }
  }

  void releaseMouse() {
    slider_pressed = false;
  }

  void setFonts(PFont s, PFont l) {
    font_small = s;
    font_large = l;
  }

  void makeWave() {
    int rate = floor((sound.frames()/wave.length));
    float add = 0;


    float[] sampleContent = new float[sound.frames()];
    sound.read(sampleContent);
    for (int i = 0; i < sampleContent.length; i++) {
      float f = abs(sampleContent[i]) * 200;

      add += f;
      if (i%rate==0) {
        float avg = add/rate;
        add = 0;
        int index = floor((i-1)/rate);
        if (index<wave.length)
          wave[index] = abs(avg);
      }
    }
  }
}
