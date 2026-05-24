shape[] shapes;
float oldTheta;
float oldAlpha;
float theta;
float alpha;
float oldZShift;
float zShift;
float initialX;
float initialY;
float z;
int run;
void setup(){
  size(1000,1000,P3D);
  shape n = new shape();
  shapes = n.importer("test.txt");
  zShift = 0;
  oldZShift = zShift;
}


void newSphere(int siz,float[] pos,int r, int g, int b){
  pushMatrix();
  fill(color(r,g,b));
  translate(pos[0],pos[1],pos[2]);
  sphere(siz);
  popMatrix();
  z = 10;
}



void draw(){
  background(255);
  //rotation text
  textSize(100);
  fill(0);
  text("Xrot:"+theta +" Yrot:"+alpha, 220,100);
  textSize(20);
  text("z:"+zShift, 800,170);
  newSphere(10,new float[]{mouseX,mouseY,z},125,255,125);

  pushMatrix();
  translate(width/2,height/2);
  rotateX((float) Math.toRadians(alpha));
  rotateY((float) Math.toRadians(theta));
  rotateZ((float) Math.toRadians(zShift));
  
    for(shape s:shapes){
    print(s);
    s.drawSides();
    s.combine();
  }
  popMatrix();
}



  


void mouseDragged(){
  if(run == 0){
    initialX = mouseX + 0f;
    initialY = mouseY + 0f;
  }
  // print(initialX + " init");
  // print(mouseX + " mouse");
  // print(oldTheta + " theta");
  theta = (mouseX - initialX )/4 + oldTheta; 
  alpha = -(mouseY - initialY)/4 + oldAlpha; 
  run++;
}

void mouseReleased(){
  run = 0;
  oldTheta= theta;
  oldAlpha= alpha;
}