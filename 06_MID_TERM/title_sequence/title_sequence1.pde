//Algoritmo creato durante il corso SEI 2014 @ UnirSM
//Disegna gocce di sangue, le più grandi colano  

import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;
int blurCount=0;

colatura[]  myColatura = new colatura [100];
int nColatura=0;

void setup () {
  size(1050, 430); 
  background(0);
  frameRate(25);
}

void draw () {
  //Variabili delle goccie di sangue (Blood variables)
  float pesoBig = random(20)+15;
  float xBig = random(-10, 10);
  float yBig = random(-10, 10);
  float pesoSmall = random(10)+5;
  float xSmall = random(-30, 30);  
  float ySmall = random(-30, 30); 
  float pesoSmallest = random(5)+5;
  float xSmallest =random(-40, 40);
  float ySmallest =random(-40,40);
  //BRUSH 1
    if (key == '1') { 
    pesoBig = random(8)+5;  
    xBig = random(-5, 5);
    yBig = random(-5, 5);
    pesoSmall = random(3)+1;
    xSmall = random(-10, 10); 
    ySmall = random(-6, 6);
    pesoSmallest = random(2);
    xSmallest =random(-15, 15);
    ySmallest =random(-15, 15);
 }
  //BRUSH 2
  if (key == '2') {
    pesoBig= random(20)+5;  
    xBig = random(-5, 5);
    yBig = random(-5, 5);
    pesoSmall = random(10)+1;
    xSmall = random(-25, 25); 
    ySmall = random(-25, 25);
    pesoSmallest = random(5)+1;
    xSmallest =random(-35, 35);
    ySmallest =random(-35, 35);
  }
  //BRUSH 3
  if (key == '3') {
    pesoBig+=10;  
    xBig = random(-10, 10);
    yBig = random(-10, 10);
    pesoSmall = random(10)+5;
    xSmall = random(-30, 30); 
    ySmall = random(-30, 30);
    pesoSmallest = random(5)+5;
    xSmallest =random(-40, 40);
    ySmallest =random(-40, 40);
  }

// BLUR ALL BRUSHES
 if (key == '4') {
   filter(BLUR,1);
 }  

  if (mousePressed) { 
   
    //BIG SPLAT RED

    stroke(150, 0, 0);
    strokeWeight(pesoBig);
    
    point(mouseX+xBig, mouseY+yBig);
    //mappa colatura(map dripping value)
    if (frameCount%5 == 0) {
      myColatura[nColatura] = new colatura(mouseX+xBig, mouseY+yBig, pesoBig/3);
      nColatura++;
      if (nColatura >= myColatura.length) nColatura = 0;
    }

    //SMALL SPLAT

    stroke(150, 0, 0);
    strokeWeight(pesoSmall);
    point(mouseX+xSmall, mouseY+ySmall);

    //SMALLEST SPLAT

    stroke(150, 0, 0);
    strokeWeight(pesoSmallest);
    point(mouseX+xSmallest, mouseY+ySmallest);
  }

  //Attiva colatura (drip activator)
  for (int k=0; k<= nColatura; k++) {
    if (myColatura[k] != null) {
      myColatura[k].scendi();
    }
  }
  //salva frame (Save frame for animation)
  if (key =='s' || key =='S') {
    saveFrame("Animation03/anim-####.tga");
    println(frameCount);
  }
} 

void keyReleased() {

  // ------ pdf export ------
  // press 'r' to start pdf recording and 'e' to stop it
  // ONLY by pressing 'e' the pdf is saved to disk!

  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, "####.pdf");
      println("recording started");
      recordPDF = true;
    }
  }
  else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
    }
  }
  //cancella disegno (delete draw)
  if (key == 'd' || key == 'D') background(0);
}


class colatura {
  //GLOBAL VARIABLES
  float x=0;
  float y=0;
  float w=0; // larghezza del punto, strokeweight
  float d=0; // valore di colatura, dripping
  float l=0; // lunghezza della colatura, dripping lenght
  float b=1; // rallenta la colatura, dripping decelerate 
  float f=255; // riempimento alpha, fill
  

  //CONSTRUCTOR
  colatura (float _x, float _y, float _w) {
    x=_x;
    y=_y;
    w=_w;
    l=int(random(100,600));
  }


  //FUNCTIONS
  void scendi () { 
    if (d <= l) {
      b*=0.99;
      d+=b;
      f-=1;
      w*=0.995;
      stroke(150,0,0,f);
      strokeWeight(w);
      //scendi in maniera non omogenea su asse X (random dripping on X axis)
      point(x+(random(-1, 1)), y+d);
      }
     
  }
}
