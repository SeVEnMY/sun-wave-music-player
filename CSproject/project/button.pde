  class UseAccountButton {
  int x, y; //position
  float w, h; //buttonsize
  color c1, c2, c3; //color, mouse over color, button clicked color

  //Constructor
  UseAccountButton(int aX, int aY, float aw, float ah, color aC1, color aC2, color aC3) {
    x=aX;
    y=aY;
    w=aw;
    h=ah;

    c1=aC1;
    c2=aC2;
    c3=aC3;
     display(c1);
  }


  //draw button
  void display(color C) {

  }

  //if mouse is over button
  boolean rollOver() {
    if (mouseX>x && mouseX<x+w && mouseY>y&&mouseY<y+h) {
      display(c2); //set color to mouse over color
      return true;
    } else {
      display(c1); //set color to normal color
      return false;
    }
  }
  boolean ButtonPressed() {
     display(c3); 
    if (rollOver()&&mousePressed) {

      return true;
    } else {
      return false;
    }
  }
}

class RectButton {
  int x, y; //position
  float w, h; //buttonsize
  color c1, c2, c3; //color, mouse over color, button clicked color

  //Constructor
  RectButton(int aX, int aY, float aw, float ah, color aC1, color aC2, color aC3) {
    x=aX;
    y=aY;
    w=aw;
    h=ah;

    c1=aC1;
    c2=aC2;
    c3=aC3;
    display(c1);
  }


  //draw button
  void display(color C) {
    stroke(#3F6699);
    fill(C);
    rect(x, y, w, h);
  }

  //if mouse is over button
  boolean rollOver() {
    if (mouseX>x && mouseX<x+w && mouseY>y&&mouseY<y+h) {
      display(c2); //set color to mouse over color
      return true;
    } else {
      display(c1); //set color to normal color
      return false;
    }
  }
  boolean ButtonPressed() {
    display(c3); 
    if (rollOver()&&mousePressed) {

      return true;
    } else {
      return false;
    }
  }
}



class PhotoButton {
  int x, y; //position

  String photoname;
  PImage img;
  //Constructor
  PhotoButton(int aX, int aY, String aphotoname) {
    x=aX;
    y=aY;

    photoname=aphotoname;

    PImage aimg = loadImage(photoname);
    img=aimg;
    display();
  }


  //draw button
  void display( ) {
    image(img, x, y);
  }

  //if mouse is over button
  boolean rollOver() {
    if (mouseX>x && mouseX<x+img.width && mouseY>y&&mouseY<y+img.height) {
      display( )   ;
      return true;
    } else {
      display( );
      return false;
    }
  }
  boolean ButtonPressed() {
    display( );
    if (rollOver()&&mousePressed) {
      return true;
    } else {

      return false;
    }
  }
}





class TextButton {
  int X;
  int Y;
  int widthback;
  int heightback;
  color textcolor;
  color backgroundcolor;
  int textsize;
  String texttype;
  String textcontent;
  PFont f;  

  //Constructor
  TextButton(int aX, int aY, int awidthback, int aheightback, color atextcolor, int atextsize, String atexttype, String atextcontent) {
    X=aX;
    Y=aY;
    widthback=awidthback;
    heightback=aheightback;
    textcolor=atextcolor;
    backgroundcolor=color(20, 25, 35);
    textsize=atextsize;
    texttype=atexttype;
    textcontent=atextcontent.substring(0, atextcontent.length() - 4);
    display();
  }


  //draw button
  void display( ) {

    fill(backgroundcolor);
    rect(X, Y, widthback, heightback);
    f = createFont(texttype, textsize, true);
    textFont(f, textsize);
    fill(textcolor);
    text(textcontent, X+10, Y+15);
  }

  //if mouse is over button
  boolean rollOver() {

    if (mouseX>X && mouseX<X+widthback && mouseY>Y&&mouseY<Y+heightback) {

      return true;
    } else {

      return false;
    }
  }
  boolean ButtonPressed() {
    display( );
    if (rollOver()&&mousePressed) {

      return true;
    } else {

      return false;
    }
  }
}
class finishButton
{
  float x;
  float y;
  float w;
  float h;
  String text;
  color backgroundC;
  color textC;
  float marginTop;
  float marginLeft;
  finishButton(float _x,float _y,float _w,float _h,String text)
  {
     this.x=_x;this.y=_y;this.w=_w;this.h=_h;this.text=text;
     marginLeft=_w/2-60;
     marginTop=_h/2+10;
  }
  void display()
  {
    fill(#dd0a37);
    rect(x,y,w,h,h/2);
    fill(#ffffff);
    textSize(32);
    text(text,x+marginLeft,y+marginTop);
  }
  boolean rollOver() {

    if (mouseX>x && mouseX<x+w && mouseY>y&&mouseY<y+h) {

      return true;
    } else {

      return false;
    }
  }
  boolean ButtonPressed() {
    display( );
    if (rollOver()&&mousePressed) {
      return true;
    } else {

      return false;
    }
  }
}
