class Fire{
  ArrayList<Bullet> bullets;
  
  Fire(){
    bullets = new ArrayList<Bullet>();
  }

  void gen(PVector _p,PVector _v){
    bullets.add(new Bullet(_p,_v));
  }

  void draw(){
    for(int i=0;i<bullets.size();i++){
      bullets.get(i).draw();
      if(bullets.get(i).life<0)bullets.remove(bullets.get(i));
    }    
  }
  
}


class Bullet{
  PVector p;
  PVector v;
  float life=20;
  
  Bullet(PVector _p,PVector _v){
    this.p = new PVector(_p.x,_p.y);
    this.v = new PVector(_v.x,_v.y);
  }

  void draw(){
    p.add(v);
    stroke(0);
    strokeWeight(0.8);
    //rect(p.x,p.y,10,10);
    line(p.x,p.y,p.x-v.x,p.y-v.y);
    life--;
  }

}