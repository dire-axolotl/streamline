import java.util.ArrayList;

float globalAlpha;
float globalTheta;
float oldTheta;
float oldAlpha;
float theta;
float alpha;
float initialX;
float initialY;
int run;
float z;
ArrayList<float[]> verticies;

void setup(){
  size(1000,1000,P3D);
  z = 10;
  verticies = new ArrayList<float[]>();
  
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

void draw(){
  background(255);
  textSize(100);
  fill(0);
  text("Xrot:"+alpha +" Yrot:"+theta, 110,110);
  newSphere(10,new float[]{mouseX,mouseY,z},125,255,125);

  pushMatrix();
  translate(width/2,height/2);
  rotateX((float) Math.toRadians(alpha));
  rotateY((float) Math.toRadians(theta));
  for(int i=0; i<verticies.size(); i++){
    newSphere(10,verticies.get(i),0,0,0);
  }
  popMatrix();
  // pushMatrix();
  // translate(200,200);
  // rotateX((float) Math.toRadians(alpha));
  // rotateY((float) Math.toRadians(theta));
  // translate(100,0);
  // fill(100,100);
  // box(100f,100f,100f);
  // popMatrix();
  // pushMatrix();
  // globalAlpha+=.5;
  // globalTheta+=.5;
  // translate(mouseX,mouseY);
  
  // rotateX((float) Math.toRadians(alpha));
  // rotateY((float) Math.toRadians(theta));
  // // rotateY((float) Math.toRadians(-theta));
  // // rotateX((float) Math.toRadians(-alpha));
  // // rotateY((float) Math.toRadians(-theta));
  // // rotateX((float) Math.toRadians(-alpha));
  // float[] pos = new float[]{0,0,100};
  // newSphere(10,pos,255,0,125);
  // float[] xRotated = matrix.vectorRot3dX(pos,globalAlpha);
  // // matrix.vectorPrint(xRotated);
  // newSphere(10,xRotated,125,255,0);
  // float[] yRotated = matrix.vectorRot3dY(pos,globalTheta);
  // matrix.vectorPrint(yRotated);
  // newSphere(10,yRotated,0,125,255);
  // float[] combined = matrix.vectorRot3dY(xRotated,globalTheta);
  // matrix.vectorPrint(combined);
  // newSphere(10,combined,255,255,255);
  // float[] unchangedY = matrix.vectorRot3dX(pos,-alpha);
  // float[] unchanged = matrix.vectorRot3dY(unchangedY,-theta);
  // System.out.println("unchaged");
  // matrix.vectorPrint(unchanged);
  // System.out.println("unchaged");

  // newSphere(10,unchanged,255,255,0);

  // popMatrix();

  

}

//float[] curMousePos = new float[]{mouseX,mouseY, z};
//float[] realPos = matrix.combinedRot(curMousePos,alpha,theta);

void newSphere(int siz,float[] pos,int r, int g, int b){
  pushMatrix();
  fill(color(r,g,b));
  translate(pos[0],pos[1],pos[2]);
  sphere(siz);
  popMatrix();
}

void keyPressed(){
  if(keyCode == 'V'){

    float[] curMousePos = new float[]{mouseX-width/2,mouseY-height/2, z};
    float[] realPos = matrix.combinedRot(curMousePos,-alpha,-theta);
    verticies.add(realPos);
  }
}