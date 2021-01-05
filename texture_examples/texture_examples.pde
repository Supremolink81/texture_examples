float rotx,roty;
PImage diamond,dirt,grassTop,grassSide;
boolean w,a,s,d;

void setup(){
  size(800,800,P3D);
  diamond=loadImage("diamond.png");
  dirt=loadImage("dirt.png");
  grassTop=loadImage("grass_top.png");
  grassSide=loadImage("grass_side.png");
  textureMode(NORMAL);
}

void draw(){
  background(0);
  texturedCube(width/2,height/2,0,diamond,100);
  texturedCube(100,height/2,0,dirt,100);
  texturedCube(width/2,100,0,grassTop,dirt,grassSide,100);
  texturedCube(100,100,0,grassTop,100);
}
void texturedCube(float x,float y,float z,PImage texture,float size){
  pushMatrix();
  beginShape(QUADS);
  translate(x,y,z);
  scale(size);
  noStroke();
  rotateX(rotx);
  rotateY(roty);
  texture(texture);
  //top
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,0,1,1,1);
  vertex(0,0,1,0,1);
  //bottom
  vertex(0,1,0,0,0);
  vertex(1,1,0,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  //right
  vertex(0,0,0,0,0);
  vertex(0,0,1,1,0);
  vertex(0,1,1,1,1);
  vertex(0,1,0,0,1);
  //left
  vertex(1,0,0,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(1,1,0,0,1);
  //front
  vertex(0,0,1,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  //back
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,1,0,1,1);
  vertex(0,1,0,0,1);
  endShape();
  popMatrix();
}
void texturedCube(float x,float y,float z,PImage top,PImage bottom,PImage side,float size){
  pushMatrix();
  translate(x,y,z);
  scale(size);
  noStroke();
  rotateX(rotx);
  rotateY(roty);
  //top
  beginShape(QUADS);
  texture(top);
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,0,1,1,1);
  vertex(0,0,1,0,1);
  endShape();
  //bottom
  beginShape(QUADS);
  texture(bottom);
  vertex(0,1,0,0,0);
  vertex(1,1,0,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  endShape();
  //right
  beginShape(QUADS);
  texture(side);
  vertex(0,0,0,0,0);
  vertex(0,0,1,1,0);
  vertex(0,1,1,1,1);
  vertex(0,1,0,0,1);
  //left
  vertex(1,0,0,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(1,1,0,0,1);
  //front
  vertex(0,0,1,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  //back
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,1,0,1,1);
  vertex(0,1,0,0,1);
  endShape();
  popMatrix();
}
void mouseDragged(){
  rotx+=(pmouseY-mouseY)*0.01;
  roty+=(pmouseX-mouseX)*-0.01;
}
