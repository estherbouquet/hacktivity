import processing.sound.*;

PinkNoise noise;

void initSound() {
  noise = new PinkNoise(this);
  noise.play();
  noise.amp(map(p.p.mag(),0,p.vMax,0.01,0.1));
}

void runSound(){
  //noise.amp(map(p.v.mag(),0,p.vMax,0.01,0.1));
  //println(map(p.v.mag(),0,p.vMax,0.01,0.1));
}