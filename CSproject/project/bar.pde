class ScrollBar { //<>// //<>// //<>// //<>// //<>//

  float x, y, w, h; //position and size of bar
  float barLoc, barValue, barMin, barMax; 
  //position of scrollbar, the ratio of scrollbar position, min value, max value

  //Constructor
  ScrollBar(float tmpX, float tmpY, float tmpW, float tmpH, float tmpMin, float tmpMax) {
    x = tmpX;
    y = tmpY;
    w = tmpW;
    h = tmpH;

    barMin = tmpMin;
    barMax = tmpMax;
  }

  //draw bar
  void display() {
    noStroke();
    rectMode(CORNER);
    fill(67, 221, 230);
    rect(x, y, barLoc-x, h); //left portion of bar
    fill(220);
    rect(barLoc, y, w-barLoc+x, h); //right portion of bar
    fill(255);
    //scrollbar
    rect(barLoc-width/200, y+h/2-3*h, width/100, 6*h);
    ellipse(barLoc-width/200, y+h/2, 6*h, 6*h);
    ellipse(barLoc+width/200, y+h/2, 6*h, 6*h);
  }

  //if mouse is over bar
  boolean rollOver() {
    if (mouseX > x && mouseX < x+w && mouseY > y-2*h && mouseY < y+4*h) {
      return true;
    } else {
      return false;
    }
  }

  //if bar pressed change the scrollbar position
  float update(float ratio) {
    if (rollOver() && mousePressed) {
      barLoc = mouseX;
      barValue = map(barLoc, x, x+w, barMin, barMax)/(barMax-barMin);
    } else {
      barLoc = map(ratio, 0, 1, x, x+w);
    }
    display();
    return barValue;
  }
}
