boolean up=false;
boolean down=false;
boolean left=false;
boolean right=false;
boolean fire=false;

void keyPressed() {
  println(keyCode);
  if (keyCode==38)up=true;
  if (keyCode==40)down=true;
  if (keyCode==37)left=true;
  if (keyCode==39)right=true;
  if (keyCode == 81)fire=true;
 
}

void keyReleased() {
  if (keyCode==38)up=false;
  if (keyCode==40)down=false;
  if (keyCode==37)left=false;
  if (keyCode==39)right=false;
  if (keyCode == 81)fire=false;
}