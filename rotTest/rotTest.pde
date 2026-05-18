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
int sideAVertNum;
float[][] sideA;
int sideBVertNum;
float[][] sideB;
boolean mode;
boolean completedSide;
ArrayList<shape> shapes;
color sideACol;
color sideBCol;

void setup(){
  size(1000,1000,P3D);
  z = 10;
  verticies = new ArrayList<float[]>();
  sideAVertNum = 4;
  sideA = new float[4][];
  sideBVertNum = 4;
  sideB = new float[4][];
  mode = true;
  completedSide = true;
  sideACol = color(0,255,0);
  sideBCol = color(255,0,0);

  shapes = new ArrayList<shape>();
  
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
  //rotation text
  textSize(100);
  fill(0);
  text("Xrot:"+theta +" Yrot:"+alpha, 220,100);

  //shape maker text
  textSize(50);
  fill(sideACol);
  text("sideA:"+sideAVertNum, 45,65);
  fill(sideBCol);
  text("sideB:"+sideBVertNum, 45,110);
  newSphere(10,new float[]{mouseX,mouseY,z},125,255,125);

  pushMatrix();
  translate(width/2,height/2);
  rotateX((float) Math.toRadians(alpha));
  rotateY((float) Math.toRadians(theta));
  for(int i=0; i<verticies.size(); i++){
    newSphere(10,verticies.get(i),0,0,0);
  }
  noFill();
  for(int tri =0;tri<verticies.size()-2;tri++){
  beginShape();
  for(int i=0; i<3; i++){
    vertex(verticies.get(i+tri)[0],verticies.get(i+tri)[1],verticies.get(i+tri)[2]);
  }
  endShape(CLOSE);
  }
    for(shape s:shapes){
    s.drawSides();
    s.combine();
  }
  popMatrix();


  

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
  print(z);
  if(keyCode == 'V'){

    float[] curMousePos = new float[]{mouseX-width/2,mouseY-height/2, z};
    float[] realPos = matrix.combinedRot(curMousePos,-alpha,-theta);
    verticies.add(realPos);
    boolean ran = false;
    if(mode){
      if(verticies.size() >= sideAVertNum){
        for(int i =sideAVertNum-1; i>=0; i--){
          println("i:" + i + " " + verticies);
          sideA[i] = verticies.remove(i);
        }
        ran = true;
        completedSide = !completedSide;
        modeSwap();
      }
    } else {
      if(verticies.size() >= sideBVertNum){
        for(int i =sideBVertNum-1; i>=0 ; i--){
          sideB[i] = verticies.remove(i);
        }
        ran = true;
        completedSide = !completedSide;
        modeSwap();
      }
    }
    if(completedSide && ran){
      shapes.add(new shape(new float[][][]{sideA,sideB}));
      sideA = new float[sideAVertNum][];
      sideB = new float[sideBVertNum][];
    }
    
  } else if(keyCode == 'F'){
    //forward and reverse;
    if(z == -10){
      z *=-1;
    }else if(z < -10){
      z/=2;
    } else {
      z*=2;
    }
  } else if(keyCode == 'R'){
    if(z == 10){
      z *=-1;
    }else if(z > 10){
      z/=2;
    } else {
      z*=2;
    }
  }else if(keyCode == 'Y'){
    theta = 0;
    oldTheta = 0;
  }else if(keyCode == 'X'){
    alpha = 0;
    oldAlpha = 0;
  } else if(keyCode == 'A'){
    modeSwap();
  } else if(keyCode == '1' || keyCode == '2' || keyCode == '3' || keyCode == '4'||keyCode == '5'||keyCode == '5'||keyCode == '6'||keyCode == '7'||keyCode == '8'||keyCode == '9'){
    if(mode){
      sideAVertNum = (int) keyCode - 48;
      sideA = new float[(int) keyCode - 48][];
    } else {
      sideBVertNum = (int) keyCode - 48;
      sideB = new float[(int) keyCode - 48][];
    }
  }


}

void modeSwap(){
  mode = !mode;
  color temp = sideACol;
  sideACol = sideBCol;
  sideBCol = temp;
}