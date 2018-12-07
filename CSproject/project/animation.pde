import ddf.minim.*;
class Mover {
  PVector location;         
  PVector velocity;         
  PVector acceleration;
  float mass;                 
  float G;
  int r, g, b, a;
  color c;
  Mover(float m_, float x_, float y_) {
    location = new PVector(x_, y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = m_;
    G = 1;
  }
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 1;
    G = 1;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    acceleration.mult(0);
  }
  PVector getLocation()
  {
    return location;
  }
  void display() {
    noStroke();
    fill(c);
    ellipse(location.x, location.y, mass*16, mass*16); 
    //translate(location.x,location.y,0);
    //sphere(mass*16);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }

  boolean isInside(Liquid l) {
    if (location.x > l.x && location.x < l.x+l.w && location.y > l.y && location.y < l.y+l.h) {
      return true;
    } else {
      return false;
    }
  }
  void setV(float vx, float vy)
  {
    velocity.x=0;
    velocity.y=0;
  }
  void setColor(int emotionValue)
  {

    if (emotionValue==1)
      c=color(random(255), random(255), random(255), 150);
    else if (emotionValue==2)
      c=color(random(220, 255), 158, 194, random(100, 255));
    else if (emotionValue==3)
    {
      float newcolor=random(100, 255);
      c=color(0, newcolor, newcolor, 150);
    }
  }
  void drag(Liquid l, float scale) {
    float speed = velocity.mag();
    float dragMagnitude = 0.5*l.c * speed *speed;

    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();

    drag.mult(dragMagnitude);
    applyForce(drag);
  }
  //F = (G * m1 * m2)/(distance * distance);  
  PVector disAttract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5, 10);
    force.mult(-1);
    force.normalize();

    float strength = (G * mass * m.mass)/(distance * distance);
    force.mult(strength);
    return force;
  }
  //
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5, 10);
    force.normalize();

    float strength = (G * mass * mass)/(distance * distance);
    force.mult(strength);
    return force;
  }
}

class Liquid {
  float x, y, w, h;    
  float c;              
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  void display() {
    noStroke();
    fill(187, 255, 255);
    rect(x, y, w, h);
  }
  void setSize(float x_, float y_, float w_, float h_)
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
}

class Attractor {
  float mass;
  PVector location;
  float G;
  int dir;
  Attractor() {
    location = new PVector(width/2, 0);
    mass = 20;
    G = 1;
    dir=1;
  }
  Attractor(float m_, float x_, float y_) {
    location = new PVector(x_, y_);
    mass = m_;
    G = 1.5;
    dir=1;
  }
  void update() {
    location.x = mouseX;
    location.y = mouseY;
  }
  void display() {
    stroke(0);
    fill(175, 0);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5, 25);
    force.normalize();
    float strength = (G*mass*m.mass)/(distance*distance);
    force.mult(strength);
    return force.mult(dir);
  }
  void setDir(int i)
  {
    dir=i;
  }
  PVector disAttract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5, 5);
    force.normalize();
    force.mult(-1);
    float strength = (G*mass*m.mass)/(distance*distance);
    force.mult(strength);
    return force;
  }
}


int screenWidth;
int screenHeight;
int mode;
int num=300;
int centrex;
int centrey;
int radius;
int marginal;
int convergeRadius;
int baseX, baseY;
int finishSignal;
Mover[] movers = new Mover[num];
Attractor a;
float theta[] = new float[num];//original angle of each point.
float mtheta[] = new float[num];//translate angle to math value.
Liquid liquid;
int lx0, ly0, lw0, lh0;
int lx1, ly1, lw1, lh1;
int lx2, ly2, lw2, lh2;
int lx3, ly3, lw3, lh3;
int emotionValue;
int particleStatus;
void initialization() {
  baseX=250;
  baseY=40;
  screenWidth=950;
  screenHeight=690;
  centrex=baseX+screenWidth/2;
  centrey=baseY+screenHeight/2;
  //print(centrey,centrex);
  radius=300;
  marginal=100;
  convergeRadius=25;
  mode=0;
  lx0=100;
  ly0=-30;
  lw0=750;
  lh0=750;
  lx1=175;
  ly1=45;
  lw1=600;
  lh1=600;
  lx2=275;
  ly2=145;
  lw2=400;
  lh2=400;
  lx3=375;
  ly3=245;
  lw3=200;
  lh3=200;
  emotionValue=1;
  finishSignal=0;
  particleStatus=0;
  liquid = new Liquid(baseX+lx2, baseY+ly2, lw2, lh2, 0.07); 
  for (int i = 0; i < movers.length; i++) {
    theta[i] = round(random(360));
    mtheta[i] = theta[i]/180*PI;
    //movers[i] = new Mover(random(1, 2), random(width), random(height));
    movers[i] = new Mover(1, cos(mtheta[i])*radius+centrex, sin(mtheta[i])*radius+centrey);
    movers[i].setColor(emotionValue);
    //movers[i] = new Mover(1, 450,450);
  }
  a = new Attractor(60, centrex, centrey);
}
void visualization(Song curSong) {
  //a.display();
  int alloutside=0;
  int allinsquare=0;
  //float fac=random(0,1);
  //liquid.display();
  for (int i = 0; i < movers.length; i++) {
    PVector f = a.attract(movers[i]);
    PVector curLocation=movers[i].getLocation();
    if (!movers[i].isInside(liquid)) {
      movers[i].drag(liquid, 100);
      //if(curLocation.x<marginal||curLocation.y<marginal||curLocation.x>=screenWidth-marginal||curLocation.y>=screenHeight-marginal)
      alloutside++;
    }
    f=f.mult(5);
    movers[i].applyForce(f); 
    movers[i].update();
    if (mode==1)
    {
      if (curLocation.x<=centrex+40&&curLocation.y<=centrey+40&&curLocation.x>=centrex-40&&curLocation.y>=centrey-40)
      {
        if (curLocation.x<=centrex+convergeRadius&&curLocation.y<=centrey+convergeRadius&&curLocation.x>=centrex-convergeRadius&&curLocation.y>=centrey-convergeRadius)
          allinsquare++;
        movers[i].setV(0, 0);
      }
    }
    movers[i].display();
  }
  if (alloutside==num&&mode==0&&finishSignal==0)
  {
    int curEmotionValue = emotionValue;
    if (flag != 4) {
      curEmotionValue=flag;
    }
    if (emotionValue!=curEmotionValue)
      emotionValue=curEmotionValue;
    for (int i = 0; i < movers.length; i++) {
      movers[i].setColor(emotionValue);
    }
    mode=1;
    a.setDir(1);
  }
  if (allinsquare>=num-1&&mode==1&&particleStatus==0)
  {
    mode=0;
    a.setDir(-1);
    float test= (1000 * in.mix.get(0) + 100);
    //println(test);
    //float test=random(0,1);
    float rx=random(-50, 50);
    float ry=random(-50, 50);
    float rw=random(-50, 50);
    float rh=random(-50, 50);
    if (test<97)
      liquid.setSize(baseX+lx3+rx, baseY+ly3+ry, lw3+rw, lh3+rh);
    else if (test<100)
      liquid.setSize(baseX+lx2+rx, baseY+ly2+ry, lw2+rw, lh2+rh);
    else if (test<103)
      liquid.setSize(baseX+lx1+rx, baseY+ly1+ry, lw1+rw, lh1+rh);
    else
      liquid.setSize(baseX+lx0+rx, baseY+ly0+ry, lw0+rw, lh0+rh);
  }
}
void setParticleStatus(int status)
{
  particleStatus=status;
}
void changeParticleStatus()
{
  if (particleStatus==0)
    particleStatus=1;
  else 
  particleStatus=0;
}
