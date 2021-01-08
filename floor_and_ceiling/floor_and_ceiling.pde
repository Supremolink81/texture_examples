import java.awt.Robot;
//ArrayList<Ripple>myRipples;
float eyeX,eyeY,eyeZ,focusX,focusY,focusZ,upX,upY,upZ;
boolean w,a,s,d,shift;
float leftRightAngle,upDownAngle,sprint;
Robot rbt;

void setup(){
  noCursor();
  size(displayWidth,displayHeight,P3D);
  leftRightAngle=0;
  upDownAngle=0;
  //myRipples=new ArrayList<Ripple>();
  eyeX=width/2;
  eyeY=height/2;
  eyeZ=height/2;
  try{
    rbt=new Robot();
  }catch(Exception e){
    e.printStackTrace();
  }
  upX=0;
  upY=1;
  upZ=0;
  //for(int i=0;i<10000;i++){
  //  myRipples.add(new Ripple());
  //}
}
void draw(){
  background(0);
  drawAxis();
  drawInterface();
  sprint=10;
  camera(eyeX,eyeY,eyeZ,focusX,focusY,focusZ,upX,upY,upZ);
  drawSurface(-20000,20000,100,height);
  drawSurface(-20000,20000,100,0);
  moveCam();
  //for(int i=0;i<10000;i++){
  //  Ripple r=myRipples.get(i);
  //  r.act();
  //  r.show();
  //}
}
void drawAxis(){
  stroke(255,0,0);
  strokeWeight(3);
  line(0,0,0,1000,0,0);
  line(0,0,0,0,1000,0);
  line(0,0,0,0,0,1000);
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
  for(int i=start;i<end;i+=dist){
    line(i,Height,start,i,Height,end);
    line(start,Height,i,end,Height,i);
  }
}
void moveCam(){
  if(shift)sprint=30;
  else sprint=10;
  if(w){
    eyeX+=cos(leftRightAngle)*sprint;
    eyeZ+=sin(leftRightAngle)*sprint;
  }
  if(a){
    eyeX+=cos(leftRightAngle-PI/2)*sprint;
    eyeZ+=sin(leftRightAngle-PI/2)*sprint;
  } 
  if(s){
    eyeX-=cos(leftRightAngle)*sprint;
    eyeZ-=sin(leftRightAngle)*sprint;
  }
  if(d){
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
