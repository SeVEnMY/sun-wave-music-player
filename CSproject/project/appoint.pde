

import gab.opencv.*;
import processing.video.*;
import java.awt.*;






void appoint() {

  surface.setSize(480, 640);

  stroke(#3F6699);
  fill(#3F6699);
  rect(0, 0, 480, 640);
  PImage background;
  background=loadImage("456.png");
  image(background, 0, 0);
  for (int i=0; i<numofSongs; i++) {
    songs.get(i).end();
  }
  //use account bottom
  UseAccountButton useaccount;
  useaccount = new UseAccountButton(floor(100), floor(480), 280, 80, color(67, 221, 230), color(27, 181, 190), color(7, 161, 170));

  if (click&&useaccount.ButtonPressed()) {
    pages=1;
    video.stop();
    click=false;
  }

  //use account bottom

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  if (video.available() == true)
    video.read();
  image(video, 80, 210);
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();

  if (faces.length>0) {
    cnt_face+=1;
    if (cnt_face==100)
    {
      pages=2;
      click=false;
      video.stop();
      cnt_face=0;
    }
  }
}
