class Song {
  String songname;
  PApplet p;
  Minim minim;
  AudioPlayer player;
  //Constructor
  Song(String asongname, PApplet p) {
    minim = new Minim(p);
    player = minim.loadFile(dataPath(asongname));
    player.setGain(-20);
    minim.stop();
    songname=asongname;
  }


  // function
  void play() {
    player.play();
  }
  void pause()
  {
    player.pause();
  }
  void setStream() {
    in = minim.getLineIn();
  }
  void popThisSong()
  {
    player = minim.loadFile(dataPath(songname));
    player.setGain(-40);
    setStream();
    player.rewind();
    initialization();
  }
  void begin() {
    player = minim.loadFile(dataPath(songname));
    player.setGain(-40);
    setStream();
    player.rewind();
    initialization();
    player.play();
  }
  boolean playpause() {
    if (player.isPlaying()) {
      player.pause();
      return true;
    } else {
      player.play();
      return false;
    }
  }

  void end() {
    //player.close();
    player.pause();
    minim.stop();
  }

  float getposition() {

    return player.position();
  }

  float getlength() {

    return player.length();
  }
  boolean ifplay() {

    if (player.isPlaying())return true;
    else return false;
  }

  boolean ifwillcloseSoon() {
    if (abs(float(player.position())/float(player.length()))>=0.91) {
      return true;
    } else
      return false;
  }

  boolean ifwillclose() {
    if (player.isPlaying()==true||(player.isPlaying()==false&&abs(float(player.position())/float(player.length()))>=0.93)) {
      if (abs(float(player.position())/float(player.length()))>=0.93) {

        return true;
      } else
        //text(str(player.position()), 702, 700);
        //text(str(player.length()), 702, 710);
        return false;
    } else
      return false;
  }

  void setposition(float x) {

    player.cue(int(player.length()*x));
  }


  float getVolume() {

    return  player.getGain();
  }
  void setVolume(float x) {
    player.setGain(x);
  }
}
