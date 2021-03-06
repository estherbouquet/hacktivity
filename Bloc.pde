class Bloc{
  float x=0;
  float y=0;
  float w=0; 
  float h=0;

  Bloc(float _x,float _y,float _w,float _h){  
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }

  void draw(){
    
    if(p.camX+width>x && p.camX<x+w && p.camY+height>y && p.camY<y+h){
      fill(45,44,50);
      noStroke();
      rect(x,y,w,h,5);
    }
  }
  
  boolean inside(float px,float py){
    if(px>x && px<x+w && py>y && py<y+h){
      return true;
    } else{
      return false;
    }
  }
  
  //need this one to be sure that md won't overlay bloc
  boolean inside(float mdx, float mdy, float mdw, float mdh){
    if(mdx+mdw >= this.x && mdx <this.x+this.w && mdy+mdh > this.y && mdy < this.y + this.h){
      return true;
    } else{
      return false;
    }
  }

}