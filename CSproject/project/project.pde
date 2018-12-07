import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import javax.swing.*;
import controlP5.*;

ControlP5 cp5;
Capture video;
OpenCV opencv;

boolean playplasebottum=true;
boolean continueFlag;
boolean click=true;
int pages=0;
ArrayList<Song> tempSongs;
ArrayList<ArrayList<Song>> allSongList = new ArrayList<ArrayList<Song>>();
int numofSongs = 4;
ArrayList<String> namesofSongs =new ArrayList<String>();
ArrayList<Song> songs = new ArrayList<Song>();

String changeruntypephotoname="round1.png";
ArrayList<Integer> inplayingsong = new ArrayList<Integer>();
int circletype=0;
int presongstep=2;
boolean enterMain;
int cnt_face;
User user=new User("skrskr", "dan@gmail.com", "123456");
// 0 appoint// 1 signin //2 mainpage// 3 setting//

AudioInput in;
void setup() {
  surface.setResizable(true);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  timer=new TimedEventGenerator(this);
  timer.setIntervalMs(1000);
  font = createFont("Helvetica", 64);
  posx=33;
  posy=530;
  happy = loadImage("happy.png");
  sad = loadImage("sad.png");
  surprise = loadImage("surprise.png");
  normal=loadImage("normal.png");
  flag=4;
  enterMain=false;

  background(0);
  noStroke();
  smooth();
  inplayingsong.add(1);
  //define songs
  //normal
  namesofSongs.add("Everglow.mp3");
  namesofSongs.add("Yellow.mp3");
  namesofSongs.add("Just the Way You Are.mp3");
  namesofSongs.add("Paradise.mp3");

  //happy
  namesofSongs.add("Adventure Of A Lifetime.mp3");
  namesofSongs.add("Love You Like the Movies.mp3");
  namesofSongs.add("Charlie Brown.mp3");
  namesofSongs.add("Viva la Vida.mp3");
  int indexofName = 0;

  //sad
  namesofSongs.add("The Scientist.mp3");
  namesofSongs.add("See You Again.mp3");
  namesofSongs.add("Talking to the Moon.mp3");
  namesofSongs.add("Gravity.mp3");

  for (int i =0; i<3; i++) {
    tempSongs = new ArrayList<Song>();
    for (int j =0; j< numofSongs; j++) {
      Song s = new Song(namesofSongs.get(indexofName), this);
      indexofName++;
      tempSongs.add(s);
    }
    allSongList.add(tempSongs);
  }

  songs = allSongList.get(0);

  surface.setSize(1080, 640);
  video = new Capture(this, 320, 240);
  opencv = new OpenCV(this, 320, 240);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  //signin email
  cp5=new ControlP5(this);
  cp5.addTextfield(" ")
    .setPosition(80, 222)
    .setSize(330, 50)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(false)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  //signin password
  cp5.addTextfield("  ")
    .setPosition(80, 342)
    .setSize(330, 50)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(true)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  //setting username
  cp5.addTextfield("   ")
    .setPosition(140, 230)
    .setSize(330, 40)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(false)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  //setting email
  cp5.addTextfield("    ")
    .setPosition(140, 470)
    .setSize(330, 40)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(false)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  //setting oldpw
  cp5.addTextfield("     ")
    .setPosition(590, 230)
    .setSize(330, 40)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(true)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  //setting newpw
  cp5.addTextfield("      ")
    .setPosition(590, 470)
    .setSize(330, 40)
    .setColorBackground(color(255, 255, 255))
    .setColor(0)
    .setPasswordMode(true)
    .setLabelVisible(false)
    .setFont(createFont("BellMTItalic-50.vlw", 40))
    .setVisible(false)
    ;
  cnt_face=0;
}


void draw() {



  if (pages==0) {
    textFieldini();
    appoint();
  }
  if (pages==1) {  
    enterMain=false;  
    signin();
  }


  if (pages==2) {  
    textFieldini();
    if (enterMain==false)
    {
      allSongList.get(0).get(1).popThisSong();
      enterMain=true;
      continueFlag=false;
    }
    mainpage(user);
  }

  if (pages==3) {  
    textFieldini();
    setting();
  }
}


void mouseReleased() {
  click=true;
}
void textFieldini() {
  if (pages!=1) {
    cp5.get(Textfield.class, " ").setVisible(false);
    cp5.get(Textfield.class, "  ").setVisible(false);
  }
  if (pages!=3) {
    cp5.get(Textfield.class, "   ").setVisible(false);
    cp5.get(Textfield.class, "    ").setVisible(false);
    cp5.get(Textfield.class, "     ").setVisible(false);
    cp5.get(Textfield.class, "      ").setVisible(false);
  }
}
