import java.awt.Robot;

float rotx,roty;
boolean w,a,s,d,shift;
float eyeX,eyeY,eyeZ,focusX,focusY,focusZ,upX,upY,upZ;
PImage mossyStone,woodPlank;
float leftRightAngle,upDownAngle,sprint;
int gridSize;
color black=#000000;
color white=#FFFFFF;
color dullblue=#7092BE;
PImage map;
Robot rbt;

void setup(){
  noCursor();
  pointLight(255,255,255,eyeX,eyeY,eyeZ);
  size(displayWidth,displayHeight,P3D);
  leftRightAngle=0;
  upDownAngle=0;
  eyeX=width/2;
  eyeY=9*height/10;
  eyeZ=height/2;
  gridSize=100;
  map=loadImage("map.png");
  try{
    rbt=new Robot();
  }catch(Exception e){
    e.printStackTrace();
  }
  upX=0;
  upY=1;
  upZ=0;
  mossyStone=loadImage("Mossy_Stone_Bricks.png");
  woodPlank=loadImage("Oak_Planks.png");
  textureMode(NORMAL);
}

void draw(){
  background(0);
  camera(eyeX,eyeY,eyeZ,focusX,focusY,focusZ,upX,upY,upZ);
  moveCam();
  drawSurface(-2000,2000,100,height);
  drawSurface(-2000,2000,100,height-gridSize*4);
  drawMap(5);
  drawInterface();
}
void mouseDragged(){
  rotx+=(pmouseY-mouseY)*0.01;
  roty+=(pmouseX-mouseX)*-0.01;
}
boolean canMoveForward(){
  float fwdX,fwdY,fwdZ;
  int mapX,mapY;
  fwdX=eyeX+cos(leftRightAngle)*150;
  fwdY=eyeY;
  fwdZ=eyeZ+sin(leftRightAngle)*150;
  mapX=int(fwdX+2000)/gridSize;
  mapY=int(fwdZ+2000)/gridSize;
  if(map.get(mapX,mapY)==white)return true;
  return false;
}
boolean canMoveBackward(){
  float fwdX,fwdY,fwdZ;
  int mapX,mapY;
  fwdX=eyeX-cos(leftRightAngle)*150;
  fwdY=eyeY;
  fwdZ=eyeZ-sin(leftRightAngle)*150;
  mapX=int(fwdX+2000)/gridSize;
  mapY=int(fwdZ+2000)/gridSize;
  if(map.get(mapX,mapY)==white)return true;
  return false;
}
boolean canMoveLeft(){
  float fwdX,fwdY,fwdZ;
  int mapX,mapY;
  fwdX=eyeX+cos(leftRightAngle+degrees(-HALF_PI))*150;
  fwdY=eyeY;
  fwdZ=eyeZ+sin(leftRightAngle+degrees(-HALF_PI))*150;
  mapX=int(fwdX+2000)/gridSize;
  mapY=int(fwdZ+2000)/gridSize;
  if(map.get(mapX,mapY)==white)return true;
  return false;
}
boolean canMoveRight(){
  float fwdX,fwdY,fwdZ;
  int mapX,mapY;
  fwdX=eyeX+cos(leftRightAngle+degrees(HALF_PI))*150;
  fwdY=eyeY;
  fwdZ=eyeZ+sin(leftRightAngle+degrees(HALF_PI))*150;
  mapX=int(fwdX+2000)/gridSize;
  mapY=int(fwdZ+2000)/gridSize;
  if(map.get(mapX,mapY)==white)return true;
  return false;
}
void drawMap(int count){
  for(int x=0;x<map.width;x++){
    for(int y=0;y<map.height;y++){
      color c=map.get(x,y);
      if(c==dullblue)for(int i=1;i<=count;i++)texturedCube(x*gridSize-2000,height-gridSize*i,y*gridSize-2000,mossyStone,gridSize);
    }
  }
}
void keyPressed(){
  if(key=='w'||key=='W')w=true;
  if(key=='a'||key=='A')a=true;
  if(key=='s'||key=='S')s=true;
  if(key=='d'||key=='D')d=true;
  if(keyCode==SHIFT)shift=true;
}
void keyReleased(){
  if(key=='w'||key=='W')w=false;
  if(key=='a'||key=='A')a=false;
  if(key=='s'||key=='S')s=false;
  if(key=='d'||key=='D')d=false;
  if(keyCode==SHIFT)shift=false;
}
void drawSurface(int start,int end,int dist,int Height){
  stroke(255);
  strokeWeight(0.5);
  for(int i=start;i<end;i+=dist)for(int j=start;j<end;j+=dist)texturedCube(i,Height,j,woodPlank,dist);
}
void drawInterface(){
  pushMatrix();
  translate(focusX,focusY,focusZ);
  rotateY(cos(leftRightAngle));
  stroke(255,0,0);
  strokeWeight(5);
  line(-10,0,10,0);
  line(0,-10,0,10);
  popMatrix();
}
void moveCam(){
  if(shift)sprint=30;
  else sprint=10;
  if(w&&canMoveForward()){
    eyeX+=cos(leftRightAngle)*sprint;
    eyeZ+=sin(leftRightAngle)*sprint;
  }
  if(a&&canMoveLeft()){
    eyeX+=cos(leftRightAngle-PI/2)*sprint;
    eyeZ+=sin(leftRightAngle-PI/2)*sprint;
  } 
  if(s&&canMoveBackward()){
    eyeX-=cos(leftRightAngle)*sprint;
    eyeZ-=sin(leftRightAngle)*sprint;
  }
  if(d&&canMoveRight()){
    eyeX+=cos(leftRightAngle+PI/2)*sprint;
    eyeZ+=sin(leftRightAngle+PI/2)*sprint;
  }
  focusX=eyeX+cos(leftRightAngle)*300;
  focusY=eyeY+tan(upDownAngle)*300;
  focusZ=eyeZ+sin(leftRightAngle)*300;
  leftRightAngle+=(mouseX-pmouseX)*0.01;
  upDownAngle+=(mouseY-pmouseY)*0.01;
  if(upDownAngle>PI/2.5)upDownAngle=PI/2.5;
  if(upDownAngle<-PI/2.5)upDownAngle=-PI/2.5;
  if(mouseX>width-2)rbt.mouseMove(3,mouseY);
  if(mouseX<2)rbt.mouseMove(width-3,mouseY);
}
