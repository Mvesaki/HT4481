import ddf.minim.*;

Minim m;
AudioPlayer tlacitko;
AudioPlayer konec;

int stisknuto;

PImage photo;
int pocet=4;

String dataText[];
String celyText[];
String klavesa[];
int znak[];
int xx[];
int yy[];

/*int[] znak = {
  112, 113, 114, 115
};
int[] xx = {
  395, 618, 840, 1062
};
int[] yy = {
  100, 100, 100, 100
};*/   
boolean byloOK[];

void nactiTextDoHodnot(String nazevSouboru){
dataText = loadStrings(nazevSouboru);
klavesa = new String[celyText.length];
znak = new int[celyText.length];
xx = new int[celyText.length];
yy = new int[celyText.length];
for(int i = 0 ; i < celyText.length ; i++){
String radek = dataText[i];
String[] hodnoty = splitTokens(radek,", ");
//klavesa[i] = parseString(hodnoty[0]);
znak[i] = parseInt(hodnoty[1]);
xx[i] = parseInt(hodnoty[2]);
yy[i] = parseInt(hodnoty[3]);
println(znak[i]);
}
}
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
  nactiTextDoHodnot("data-ht4481.csv");
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
  if(byloOK[stisknuto]){
  fill(0, 255, 0);
  arc(xx[stisknuto], yy[stisknuto], 80, 80, 0, 2*PI, OPEN);
  kontrola();
  }
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

