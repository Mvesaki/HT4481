import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ht4481 extends PApplet {



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
int meritko;

public void setup() {
  meritko = 75;
  table = loadTable("data-ht4481.csv", "header");
  pocet = table.getRowCount();
  byloOK = new boolean[pocet];
  nulujkontrolu();
  size(1125, 641);
  noStroke();
  background(0);
  photo = loadImage("ht4481.png");
  image(photo, 0, 0);
  photo.resize(width,height);
  image(photo, 0, 0);
  kontrola();
  m = new Minim(this);
  tlacitko = m.loadFile("beep-02.wav");
  konec = m.loadFile("beep-01a.wav");

}

public void draw() { 
  // keep draw() here to continue looping while waiting for keys
}


public void keyPressed() {
  stisknuto = str(keyCode);
   if(key==27)
      key=0;
  print (stisknuto);
  print(":");
  try{
  TableRow result = table.findRow(stisknuto, "kod");  
  xx = PApplet.parseInt(result.getString("x")); 
  yy = PApplet.parseInt(result.getString("y"));
      fill(255, 255, 0);
      arc(xx*meritko/100, yy*meritko/100, 80*meritko/100, 80*meritko/100, 0, 2*PI, OPEN);
      index=PApplet.parseInt(result.getString("id"));
      println (index);
      byloOK[index]=true;
      tlacitko.loop(0);
    
  }catch(Exception e){}
}

public void keyReleased() {
  if(byloOK[index]){
  fill(0, 255, 0);
  arc(xx*meritko/100, yy*meritko/100, 80*meritko/100, 80*meritko/100, 0, 2*PI, OPEN);
  kontrola();
  }
}
public void mouseClicked() {
  image(photo, 0, 0);
  nulujkontrolu();
  kontrola();
}

public void nulujkontrolu() {
  for (int i = 0; i < pocet; i = i+1) {
    //  println (i);
    byloOK[i]= false;
  }
}
public void kontrola() {
  fill(255, 0, 0);
  rect(60*meritko/100, 800*meritko/100, 50*meritko/100, 50*meritko/100);
  boolean OK= true;
  for (int i = 0; i < pocet; i = i+1) {
    OK=OK && byloOK[i];
  }
  if (OK) {
    fill(0, 255, 0);
    rect(60*meritko/100, 800*meritko/100, 50*meritko/100, 50*meritko/100);
    konec.loop(0);
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ht4481" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
