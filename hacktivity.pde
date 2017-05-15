Parser parser;
Player p;
Pluie pluie;
Fire fires;

PImage old;

PImage neige;
PImage part;

PGraphics hudA;

void setup() {
  fullScreen(P3D);
  frameRate(60);
  old = loadImage("back.png");
  part = loadImage("particuleOP.png");
  neige = loadImage("neige.png");

  smooth(2);

  parser = new Parser(loadShape("levelTINY.svg"));
  p = new Player(width/2-200, height/2-200);
  pluie = new Pluie();
  fires = new Fire();

  initSound();
  hudA = createGraphics(width, height, P2D);
  hudA.noSmooth();
  hudA.beginDraw();
  hudA.clear();
  hudA.endDraw();
}

float ang=0;


void draw() {
  background(255);
  p.startCam();
  runSound();
  pushMatrix();
  translate(width/2, height, -400);
// Cercle visible au lancement
  fill(0, 70);
  noStroke();
  ellipse(0, 0, width*1.3, width*1.3);
// rectangle qui tourne 
  //rectMode(CENTER);
  //rotate(ang);
  //ang+=0.01;
  //fill(0, 200);
  //rect(0, 0, width*1.3, 30);
  popMatrix();
  rectMode(CORNER);

  //shape(p,0,0);    
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
  
  
  camera();
  imageMode(CORNER);
  image(old, 0, 0, width, height);

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

// carré du haut 
  fill(0);
  rect(10, 10, 60, 80);
  
  fill(255);
  text(frameRate, 12, 20);
  text(pluie.pluie.size(), 12, 40);
  text(parser.count, 12, 60);
  
// barre en bas
  fill(255, 40);
  noStroke();
  rect(20, height-40, map(p.energie, 0, 100, 0, 200), 20);
}