int state = 0; 
String result=""; 
PFont myFont;

void mainpage(User current_user) {
  surface.setSize(1200, 800);
  myFont = createFont("Ink Free", 20);
  textFont(myFont); 
  background(40, 40, 40);

  //upper bar
  fill(50, 50, 50);
  noStroke();
  quad(0, 0, 1200, 0, 1200, 40, 0, 40);

  //cross
  fill(255, 114, 86);
  stroke(255, 114, 86);


  //change
  fill(255, 215, 0);
  stroke(255, 215, 0);
  ellipse(40, 20, 10, 10);

  //big
  fill(173, 255, 47);
  stroke(173, 255, 47);
  ellipse(60, 20, 10, 10);

  //left bar
  fill(20, 25, 35);
  noStroke();
  quad(0, 40, 250, 40, 250, 730, 0, 730);

  //lower bar
  fill(20, 25, 35);
  noStroke();
  quad(0, 800, 1200, 800, 1200, 730, 0, 730);

  //account
  PImage face = loadImage("face.png");
  image(face, 20, 65, 40, 40);
  fill(255);
  text(current_user.userName, 70, 90);
  //search bar
  fill(255);
  text ("SEARCH", 25, 155);
  fill(255, 255, 255);
  noStroke();
  rect(20, 160, 210, 20, 12, 12, 12, 12);
  switch (state) {
  case 0:
    fill(0); 
    text (result, 25, 177); 
    break;

  case 1:

    break;
  }

  //Songs
  fill(255);
  text ("SONGS", 25, 225);
  PImage Play = loadImage("Play.png");
  PImage Sound = loadImage("sound.png");
  image(Play, 210, 240, 15, 15);
  image(Play, 210, 270, 15, 15);
  image(Play, 210, 300, 15, 15);
  image(Play, 210, 330, 15, 15);

  //playlists
  fill(20, 25, 35);
  noStroke();
  quad(0, 400, 250, 400, 250, 500, 0, 500);
  fill(255);
  text ("PLAYLISTS", 25, 425);
  PImage Group = loadImage("Group 2.png");
  image(Group, 25, 440, 100, 40);
  PImage ic_add = loadImage("ic_add.png");
  image(ic_add, 200, 410, 15, 15);
  PImage soundicon = loadImage("sound.png");
  image(soundicon, 520, 759, 15, 15);

  //setting
  PhotoButton settingin;
  settingin=new PhotoButton(170, 75, "Settings-2.png");
  if (click&&settingin.ButtonPressed()) {
    pages=3;
    click=false;
  }
  //close

  PhotoButton close;
  close=new PhotoButton(210, 75, "Take_off.png");
  if (click&&close.ButtonPressed()) {
    pages=0;
    video.start();
    cnt_face=0;
    click=false;
  }

  PhotoButton vmdclose;
  vmdclose=new PhotoButton(14, 14, "close2.png");
  if (click&&vmdclose.ButtonPressed()) {
    pages=0;
    video.start();
    cnt_face=0;
    click=false;
  }


  //song list
  ArrayList<TextButton>songButtons=new ArrayList<TextButton>();
  for (int i=0; i<numofSongs; i++) {
    TextButton songButton = new TextButton(20, 235+30*i, 180, 20, #AAAAAA, 12, "Arial", songs.get(i).songname);
    songButtons.add(songButton);
  }
  for (int i=0; i<numofSongs; i++) {
    if (click&&songButtons.get(i).ButtonPressed()) {
      songs.get(inplayingsong.get(inplayingsong.size()-1)).end();
      songs.get(i).begin();
      inplayingsong.add(i);
      presongstep=2;
      click=false;
      break;
    }
  }

  PhotoButton beginpause;
  Boolean play = false;
  for (int i=0; i<numofSongs; i++) {
    if (songs.get(i).ifplay()) {
      play=true;
    }
  }

  if (play) {
    beginpause=new PhotoButton(365, 755, "Pause.png");
  } else {
    beginpause=new PhotoButton(365, 755, "BigPlay.png");
  }

  if (click&&beginpause.ButtonPressed()) {
    playplasebottum=songs.get(inplayingsong.get(inplayingsong.size()-1)).playpause();
    click=false;
  }
  //nextprevious
  PhotoButton nextsong;
  nextsong=new PhotoButton(420, 762, "Next-2.png");
  if (click&&nextsong.ButtonPressed()&&circletype!=2) {
    presongstep=2;
    songs.get(inplayingsong.get(inplayingsong.size()-1)).end();
    songs.get((inplayingsong.get((inplayingsong.size()-1))+1)%4).begin();
    inplayingsong.add((inplayingsong.get(inplayingsong.size()-1)+1)%4);
    click=false;
  } else if (click&&nextsong.ButtonPressed()&&circletype==2) {
    presongstep=2;
    inplayingsong.add(ceil(random(3)));
    songs.get(inplayingsong.get(inplayingsong.size()-2)).end();
    songs.get(inplayingsong.get(inplayingsong.size()-1)).begin();
    click=false;
  }

  PhotoButton presong;
  presong=new PhotoButton(325, 762, "Next.png");
  if (click&&presong.ButtonPressed()) {
    if ((inplayingsong.size()-presongstep)>=0) {
      songs.get(inplayingsong.get(inplayingsong.size()-1)).end();
      songs.get(inplayingsong.get(inplayingsong.size()-presongstep)).begin();
      inplayingsong.add(inplayingsong.get(inplayingsong.size()-presongstep));
      presongstep=presongstep+2;
    }
    click=false;
  }


  //restart
  PhotoButton restart;
  restart=new PhotoButton(460, 761, "replay1.png");

  if (click&&restart.ButtonPressed()) {
    presongstep=2;
    for (int i=0; i<numofSongs; i++) {
      songs.get(inplayingsong.get(inplayingsong.size()-1)).end();
      songs.get(inplayingsong.get(inplayingsong.size()-1)).begin();
    }
    click=false;
  }
  //changeruntype
  PhotoButton changeruntype;
  changeruntype=new PhotoButton(280, 761, changeruntypephotoname);
  if (click&&changeruntype.ButtonPressed()) {
    if (circletype==0) {
      circletype=1;
      changeruntypephotoname="order1.png";
    } else if (circletype==1) {
      circletype=2;
      changeruntypephotoname="Shuffle.png";
    } else if (circletype==2) {
      circletype=0;
      changeruntypephotoname="round1.png";
    }

    click=false;
  }

  textSize(12);
  fill(0, 0, 0);
  //change song,iluustrate songname in playing


  ScrollBar progress;
  progress=new ScrollBar(680, 765, 500, 1, 0, 100);

  ScrollBar volumn;
  volumn=new ScrollBar(550, 765, 100, 1, 0, 100);

  fill(20, 25, 35);
  stroke(20, 25, 35);
  quad(210, 200, 240, 200, 240, 380, 210, 380);

  for (int i=0; i<numofSongs; i++) {
    if (inplayingsong.get(inplayingsong.size()-1)==i) {
      for (int j=0; j<numofSongs; j++) {
        if (j==i) {
          image(Sound, 210, 240+j*30, 15, 15);
        } else {
          image(Play, 210, 240+j*30, 15, 15);
        }
      }
      volumn.barValue = volumn.update(abs(1-songs.get(i).getVolume()/float(-80)));
      progress.barValue =progress.update(songs.get(i).getposition()/songs.get(i).getlength());
      if (progress.rollOver() && mousePressed) {
        songs.get(i).setposition(progress.barValue);
        click=false;
      }
      text(songs.get(i).songname.substring(0, songs.get(i).songname.length() - 4), 20, 770);
      if (songs.get(i).ifwillcloseSoon())
      {
        finishSignal=1;
      }
      if (songs.get(i).ifwillclose()) {
        finishButton fbtn1=new finishButton(centrex-100, centrey-70, 200, 50, "Continue");
        finishButton fbtn2=new finishButton(centrex-100, centrey+20, 200, 50, "Replace");
        fbtn1.display();
        fbtn2.display();
        if (click&&fbtn1.ButtonPressed())
        {
          continueFlag=true;
        } else if (click&&fbtn2.ButtonPressed())
        {
          continueFlag=true;
          songs = allSongList.get(0);
          if (flag!=4) {
            songs = allSongList.get(flag-1);
          }
        }
        if (continueFlag==true)
        {
          presongstep=2;
          if (circletype==0) {
            songs.get(i).end();
            songs.get(i).begin();
          }
          if (circletype==1) {
            songs.get(inplayingsong.get(inplayingsong.size()-1)).end();
            songs.get((i+1)%numofSongs).begin();
            inplayingsong.add((i+1)%numofSongs);
          }
          if (circletype==2) {
            inplayingsong.add(ceil(random(3))); 
            songs.get(inplayingsong.get(inplayingsong.size()-2)).end();
            songs.get(inplayingsong.get(inplayingsong.size()-1)).begin();
          }
          continueFlag=false;
        } else
        {
          songs.get(inplayingsong.get(inplayingsong.size()-1)).pause();
        }
      }
      break;
    }
  }

  if (volumn.rollOver() && mousePressed) {
    for (int i=0; i<numofSongs; i++) {
      songs.get(i).setVolume((1-volumn.barValue)*-80);
    }
    click=false;
  }
  drawEmotions();
  for (int i=0; i<numofSongs; i++) {
    if (songs.get(i).ifplay()) {
      if (!songs.get(i).ifwillcloseSoon()&&flag==4)
      {
        setParticleStatus(1);
      }
      if (songs.get(i).ifwillcloseSoon()||flag!=4)
        setParticleStatus(0);
      visualization(songs.get(i));
    }
  }
}

void drawEmotions() {
  if (flag==2)
  {
    image(happy, posx, posy);
  }
  if (flag==4)
  {
    image(surprise, posx, posy);
  }
  if (flag==3)
  {
    image(sad, posx, posy);
  }
  if (flag==1) {
    image(normal, posx, posy);
  }
}

void keyPressed() {
  if (key==ENTER||key==RETURN) { 
    state++;
  } else if (key==BACKSPACE) {
    if (result.length()>0)
      result = result.substring(0, result.length()-1);
  } else {
    if (key==' ')
      result = result + key;
    else {
      int ascii_num=int(key);
      if ((ascii_num>=97&&ascii_num<=122)||(ascii_num>=65&&ascii_num<=90))
        result =result+key;
    }
  }
}
