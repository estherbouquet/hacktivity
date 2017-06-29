class Player {

  int margin = 1000;

  PVector p=new PVector();
  PVector v=new PVector();

  Particules smoke;

  float vMax=10; // valeur init : 14
  float accel=0.5; // valeur init : 1
  float friction=0.99;
  float bound=0.5;
  float security=0.1;
  float camX=0;
  float camY=0;
  float gravity=0.15;
  float energie=100;

  //--------------------------------------------------------
  //CONSTRUCTEUR
  //--------------------------------------------------------
  Player(float px, float py) {
    this.p = new PVector(px, py);
    smoke = new Particules();
  }

  void startCam() {
    // camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
    camera(
      width/2.0+int(camX), 
      height/2.0+int(camY), 
      (height/2.0) / tan(PI*30.0 / 180.0), 
      width/2.0+int(camX), 
      height/2.0+int(camY), 
      0, 
      0, 1, 0
      );
  }

  //--------------------------------------------------------
  //DRAW
  //--------------------------------------------------------
  void draw() {

    float co = map(v.mag(), 0, vMax, 0.01, 0.1);
    min(co, 0.01);
    max(co, 0.1);

    camX-=( camX - (p.x-width/2) )*co;
    camY-=( camY - (p.y-height/2) )*co;

    //-------------------------------------
    p.add(v);
    v.mult(friction);


    v.y+=gravity;
    if (v.mag()>vMax)v.limit(vMax);

    if (down && energie>0)v.y+=accel;
    if (up && energie>0)v.y-=accel;
    if (right && energie>0)v.x+=accel;
    if (left && energie>0)v.x-=accel;

    if (energie<0)energie=0;

    if (up || down || left || right) {
      if (energie>0)smoke.add(p.x, p.y);
      // energie--;
    }
    // On définit la couleur de l'ellipse
    smoke.draw();

    fill(45, 44, 50, 250);
    noStroke();
    ellipse(p.x, p.y, 30, 30);

    //teleport the player to the other bound of world
    float delta_cam_x= p.x - camX;
    float delta_cam_y= p.y - camY;
    if (p.x>width_world+margin) {//bord droit
      p.x=-margin; //On envoie le joueur tout à gauche
      camX=-margin - delta_cam_x; //On déplace la camera en gardant le même decalage entre le centre de la camera et la position du joueur
      for (int i=0; i<this.smoke.tab.size(); i++) {//On translate le vecteur position de toutes les particules de fumée 
        this.smoke.tab.get(i).p.sub(width_world+2*margin, 0);
      }
    }
    if (p.x <-margin) {//bord gauche
      p.x=width_world+margin;
      camX=width_world+margin - delta_cam_x;
      for (int i=0; i<this.smoke.tab.size(); i++) {
        this.smoke.tab.get(i).p.add(width_world+2*margin, 0);
      }
    }
    if (p.y > height_world+margin) {//bord bas
      p.y=-margin;
      camY=-margin - delta_cam_y;
      for (int i=0; i<this.smoke.tab.size(); i++) {
        this.smoke.tab.get(i).p.sub(0, height_world+2*margin);
      }
    }
    if (p.y < -margin) {//bord haut
      p.y=height_world+margin;
      camY=height_world+margin - delta_cam_y;
      for (int i=0; i<this.smoke.tab.size(); i++) {
        this.smoke.tab.get(i).p.add(0, p.y+margin);
      }
    }

    //println("p.x =" +p.x + "p.y="+p.y);
    //println("v.x =" +v.x + "v.y="+v.y);
  }

  float [] space={20, 20};
  float [] space2={5, 5};

  void draw2() {
    // ellipse autour de l'ellipse principale
    /* noFill();
     stroke(0,100);
     strokeWeight(0.6);    
     ellipse(p.x, p.y, 120, 120); */
    // lignes qui rattachent au centre de la fenêtre  
    /* dashline(p.x, p.y,width/2,height/2,space);
     stroke(255,0,0,100);
     dashline(p.x, p.y,width/2,height,space2);
     stroke(0,0,255,150);
     dashline(p.x, p.y,2000,height,space2); */
  }

  void drawPost() {
    // contours pour la ligne du bas + ligne directrice au milieu de l'ellipse
    stroke(0);
    // ligne directrice au milieu de l'ellipse 
    //line(p.x, p.y, p.x+v.x*5, p.y+v.y*5);
  }

  void collide(ArrayList<Bloc> t) {
    //Pas beacoup mieux qu'avant mais on n'a plus qu'une seule boucle
    for (int i=0; i<t.size(); i++) {
      if (t.get(i).inside(p.x, p.y+10)) {//dessus
        v.y*=-bound;
        v.mult(0.85);
        energie++;
        while (t.get(i).inside(p.x, p.y+10)) {
          p.y-=security;
        }
      }
      if (t.get(i).inside(p.x, p.y-10)) {//dessous 
        v.y*=-bound;
        while (t.get(i).inside(p.x, p.y-10)) {
          p.y+=security;
        }
      }
      if (t.get(i).inside(p.x+10, p.y)) {
        v.x*=-bound;
        while (t.get(i).inside(p.x+10, p.y)) {//gauche
          p.x-=security;
        }
      }
      if (t.get(i).inside(p.x-10, p.y)) {
        v.x*=-bound;
        while (t.get(i).inside(p.x-10, p.y)) {//droite
          p.x+=security;
        }
      }
    }
  }

  
    
    
  }

  /*
  void collide(ArrayList<Bloc> t) {//Trop de parcours
   
   for (int i=0; i<t.size(); i++) {
   if (t.get(i).inside(p.x, p.y+10)) {
   v.y*=-bound;
   v.mult(0.85);
   energie++;
   }
   while (t.get(i).inside(p.x, p.y+10)) {
   p.y-=security;
   }
   }
   
   for (int i=0; i<t.size(); i++) {
   if (t.get(i).inside(p.x, p.y-10)) {  
   v.y*=-bound;
   }
   while (t.get(i).inside(p.x, p.y-10)) {
   p.y+=security;
   }
   }
   
   for (int i=0; i<t.size(); i++) {
   if (t.get(i).inside(p.x+10, p.y)) {
   v.x*=-bound;
   }
   while (t.get(i).inside(p.x+10, p.y)) {
   p.x-=security;
   }
   }
   
   for (int i=0; i<t.size(); i++) {
   if (t.get(i).inside(p.x-10, p.y)) {
   v.x*=-bound;
   }
   while (t.get(i).inside(p.x-10, p.y)) {
   p.x+=security;
   }
   }
   
   //-----------------------------------------------
   }*/
}