import oscP5.*;
OscP5 oscP5;
import org.multiply.processing.TimedEventGenerator;
private TimedEventGenerator timer;



int found;
float smileThreshold = 16;
float surpriseThreshold=5.0;
float sadThreshold= 7;
float mouthWidth, previousMouthWidth;
float eyebrowLeft, eyebrowRight, previousEyeBrowLeft, previousEyeBrowRight;
float mouthHeight, previousMouthHeight;
float eyeLeft, eyeRight;

PImage sad;
PImage happy;
PImage surprise;
PImage normal;

int flag;
PFont font;
int posx;
int posy;
public void found(int i) {
  found = i;
}

public void mouthWidthReceived(float w) {
  mouthWidth = w;
}
public void eyebrowLeftReceived(float f) {
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  eyebrowRight = f;
}
public void mouthHeightReceived(float f)
{
  mouthHeight=f;
}
public void eyeLeftReceived(float f) {
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  eyeRight = f;
}
// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
  }
}
void onTimerEvent() {
  if (mouthWidth>smileThreshold) {
    flag=2;
  } else if (mouthHeight>surpriseThreshold)
  {
    flag=4;
  } else if (eyebrowLeft<sadThreshold && eyebrowRight<sadThreshold)
  {
    flag=3;
  } else
  {
    flag=1;
  }

  previousMouthWidth=mouthWidth;
  previousEyeBrowLeft=eyebrowLeft;
  previousEyeBrowRight=eyebrowRight;
  previousMouthHeight=mouthHeight;
}
