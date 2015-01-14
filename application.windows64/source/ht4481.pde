import ddf.minim.*;

Minim m;
AudioPlayer tlacitko;
AudioPlayer konec;

String stisknuto;
PImage photo;
boolean byloOK[];
Table table;
int pocet;
int index;
int xx;
int yy;
void setup() {
  
  table = loadTable("data-ht4481.csv", "header");
  pocet = table.getRowCount();
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
  stisknuto = str(keyCode);
  print (stisknuto);
  print(":");
  try{
  TableRow result = table.findRow(stisknuto, "kod");  
  xx = int(result.getString("x")); 
  yy = int(result.getString("y"));
      fill(255, 255, 0);
      arc(xx, yy, 80, 80, 0, 2*PI, OPEN);
      index=int(result.getString("id"));
      
      println (index);
      byloOK[index]=true;
      tlacitko.loop(0);
    
  }catch(Exception e){}
}

void keyReleased() {
  if(byloOK[index]){
  fill(0, 255, 0);
  arc(xx, yy, 80, 80, 0, 2*PI, OPEN);
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

