class Pluie {
  ArrayList<Goutte> pluie;
  //int accurate=10;
  
  Pluie() {
    pluie = new ArrayList<Goutte>();
  }

  void gen(float x, float y) {
      pluie.add(new Goutte(x, y));
  }

  void draw() {
    for (int i=0; i<pluie.size(); i++) {
      pluie.get(i).draw();
      if(pluie.get(i).life<0)pluie.remove(pluie.get(i));
    }
  }
}


class Goutte {
  PVector p;
  PVector v;
  float life=250;
  float vLife=0.5;

  Goutte(float x, float y) {
    p = new PVector(x, y);
    v=new PVector(random(0.2, 0.4), random(1.5, 2));
  }

  void draw() {
    fill(0, life);
    noStroke();
    
    tint(255,0,0,life);
    imageMode(CENTER);
    image(neige,p.x,p.y,6,6);
    //ellipse(p.x, p.y, 3, 3);
    life-=vLife;
    p.add(v);
  }
}