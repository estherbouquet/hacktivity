class Particules {

  ArrayList<Part> tab;

  Particules() {
    tab = new ArrayList<Part>();
  }

  void add(float x, float y) {  
    for (int i=0; i<3; i++) {
      Part p=new Part(x, y);
      tab.add(p);
    }
  }

  void draw() {
    for (int i=0; i<tab.size(); i++) {
      tab.get(i).draw();
      if (tab.get(i).life<0)tab.remove(tab.get(i));
    }
  }
}


class Part {
  float life=100;
  PVector p;
  PVector wind;
  float t=30;

  Part(float x, float y) {
    p = new PVector(x, y);
    wind = new PVector(random(-0.5, 0.5), random(-2, -0.5));
  }

  void draw() {
    fill(0, life);
    //noFill();
    noStroke();
    //ellipse(p.x,p.y,t,t);

    imageMode(CENTER);
    tint(255, life);
    image(part, p.x, p.y, t, t);

    p.add(wind);
    life--;
    t+=2;
  }
}