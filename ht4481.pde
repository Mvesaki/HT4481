import ddf.minim.*;

Minim m;
AudioPlayer tlacitko;
AudioPlayer konec;

int stisknuto;

PImage photo;
int pocet=3;
int[] znak = {
  115, 113, 114
};
int[] xx = {
  395, 618, 840
};
int[] yy = {
  100, 100, 100
};   
boolean byloOK[];

void setup() {
  byloOK = new boolean[pocet];
  nulujkontrolu();
  size(1500, 855);
  noStroke();
  background(0);
  photo = loadImage("ht4481.png");
  image(photo, 0, 0);
  kontrola();
  m = new Minim(this);
  tlacitko = m.loadFile("beep-02.wav");
  konec = m.loadFile("beep-01a.wav");
}

void draw() { 
  // keep draw() here to continue looping while waiting for keys
}


void keyPressed() {

  for (int i = 0; i < pocet; i = i+1) {
    
    if (keyCode == znak[i]) {
      fill(255, 255, 0);
      arc(xx[i], yy[i], 80, 80, 0, 2*PI, OPEN);
      stisknuto = i;
      byloOK[i]=true;
      tlacitko.loop(0);
    }
  }
}

void keyReleased() {
 
  fill(0, 255, 0);
  arc(xx[stisknuto], yy[stisknuto], 80, 80, 0, 2*PI, OPEN);
  kontrola();
 
}
void mouseClicked() {
  image(photo, 0, 0);
  nulujkontrolu();
  kontrola();
}

void nulujkontrolu() {
  for (int i = 0; i < pocet; i = i+1) {
    //  println (i);
    byloOK[i]= false;
  }
}
void kontrola() {
  fill(255, 0, 0);
  rect(60, 800, 50, 50);
  boolean OK= true;
  for (int i = 0; i < pocet; i = i+1) {
    OK=OK && byloOK[i];
  }
  if (OK) {
    fill(0, 255, 0);
    rect(60, 800, 50, 50);
    konec.loop(0);
  }
}

