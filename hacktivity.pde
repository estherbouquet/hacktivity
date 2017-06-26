import static javax.swing.JOptionPane.*;

Parser parser;
Player p;
Pluie pluie;
Fire fires;

PImage old;

PImage neige;
PImage part;

PGraphics hudA;
int start_time= millis();

int alpha=240;

int width_world=0;
int height_world=0;


void setup() {
  fullScreen(P3D);
  frameRate(60);
  old = loadImage("back.png");
  part = loadImage("particuleOP.png");
  neige = loadImage("neige.png");
  
  noCursor();
  

  smooth(2);
  pluie = new Pluie();
  parser = new Parser(loadShape("levelTINY_test.svg"));
  p = new Player(width/2-200, height/2-200);

  fires = new Fire();

//  initSound();
  hudA = createGraphics(width, height, P2D);
  hudA.noSmooth();
  hudA.beginDraw();
  hudA.clear();
  hudA.endDraw();

  initMetaData();
}

float ang=0;


void draw() {
  background(255);

  imageMode(CORNER);
  tint(255, alpha);
  image(old, 0, 0, width, height);

  p.startCam();
  //runSound();

  pushMatrix();
  translate(width/2, height, -400);
  // Cercle visible au lancement
  fill(45,44,50, 70);
  noStroke();
  ellipse(0, 0, width*1.3, width*1.3);
  popMatrix();
  rectMode(CORNER);

  p.draw();
  parser.draw();

  for (int i=0; i<5; i++) pluie.gen(p.p.x+random(-width, width), p.p.y-random(height/2));
  pluie.draw();

  p.collide(parser.tabBloc);

  PVector dir = p.v.copy().normalize().mult(10);
  dir.rotate(random(-0.05, 0.05));
  if (fire)fires.gen(p.p.copy(), dir);
  fires.draw();

  p.draw2();
  p.drawPost();
  fires.draw();

  drawMetaData();

  camera();



  p.startCam();

  // ligne pour connaître position caméra au départ ?  
  //strokeWeight(0.8);
  //stroke(0);
  //line(0, 0, 1000, 300);
  camera();

  hudA.beginDraw();
  //hudA.clear();
  hudA.noFill();
  hudA.stroke(0);
  hudA.strokeWeight(0.4);

  //hudA.ellipse(-p.camX+p.p.x+p.v.x,-p.camY+p.p.y+p.v.y,60,60);
  hudA.endDraw();

  image(hudA, 0, 0);


  /*r
  // carré du haut 
   fill(0);
   rect(10, 10, 60, 80);
   
   fill(255);
   text(frameRate, 12, 20);
   text(pluie.pluie.size(), 12, 40);
   text(parser.count, 12, 60);
   */

  // barre en bas
  fill(255, 40);
  noStroke();
  //rect(20, height-40, map(p.energie, 60, 100, 0, 200), 20);
  
  int elapsed_time = int((millis()-start_time)/1000);
  rect(20, height-40, map(elapsed_time, 0, 6000, 0, width-20), 20);
  if (elapsed_time >= 6000) {//AU bout de 60 secondes, on demande au joueur s'il veut poursuivre sa partie
    int confirmResult = showConfirmDialog(null, "Temps écoulé, souhaitez-vous continuer à jouer ?", 
      "Temps écoulé !", ERROR_MESSAGE);
    if (confirmResult==YES_OPTION) {
      start_time=millis();
    } else {
      showMessageDialog(null, printTabScore(),"Score", PLAIN_MESSAGE); 
    }
    
  }
  
   
}

String printTabScore(){
    String s = "Carrés: "+tabScore[0];
    s+="\nÉtoiles: "+tabScore[1];
    s+="\nPolygone: "+tabScore[2];
    s+="\nCercle: "+tabScore[3];
    s+="\nTriangle: "+tabScore[4];
    return s;
}
    
