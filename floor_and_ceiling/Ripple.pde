//class Ripple {
//  float x,z,speed,size,a;
//  Ripple(){
//    x=random(-20000,20000);
//    z=random(-20000,20000);
//    size=random(0, 200);
//    speed=2;
//  }
//  void act() {
//    size+=speed;
//    if(size>200){
//      x=random(-20000,20000);
//      z=random(-20000,20000);
//      size=0;
//    }
//  }
//  void show(){
//    pushMatrix();
//    translate(x,height,z);
//    a=map(size,0,200,255,0);
//    noFill();
//    stroke(255,a);
//    ellipse(0,0,size,size/2);
//    popMatrix();
//  }
//}
