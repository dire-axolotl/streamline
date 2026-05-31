import java.util.ArrayList;

String fileName;
PrintWriter fileWrite;
float globalAlpha;
float globalTheta;
float oldTheta;
float oldAlpha;
float theta;
float alpha;
float oldZShift;
float zShift;
float initialX;
float initialY;
int run;
float z;
ArrayList<float[]> verticies;
int sideAVertNum;
float[][] sideA;
int sideBVertNum;
float[][] sideB;
ArrayList<color[]> colorMatrix;
color[] newColors;
boolean mode;
boolean completedSide;
ArrayList<shape> shapes;
int newColorIndex = 0;
int colorIndex = 0;
color sideACol;
color sideBCol;
color currentColor;
boolean palletOn;
int b = 0;


void setup(){
  fileWrite = createWriter("rollerPallet.txt");
  palletOn = false;
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
  zShift = 0;
  oldZShift = zShift;
  colorMatrix = new ArrayList<color[]>();
  colorMatrix.add(new color[11]);
  newColors = colorMatrix.get(0);
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
  if(palletOn){

  } else {
  background(255);
  //rotation text
  textSize(100);
  fill(0);
  text("Xrot:"+theta +" Yrot:"+alpha, 220,100);
  textSize(20);
  text("z:"+zShift, 800,170);

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
  rotateZ((float) Math.toRadians(zShift));
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
    boolean ran = false;
    if(mode){
      if(verticies.size() >= sideAVertNum){
        for(int i =sideAVertNum-1; i>=0; i--){
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
      // = new color[]{color(0),color(0),color(0),color(0),color(0),color(0)}
      shapes.add(new shape(new float[][][]{sideA,sideB},colorMatrix.get(colorIndex)));
      print(sideAVertNum);
      print(sideBVertNum);
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
  } else if(keyCode == 'Z'){
    zShift = 0;
    oldZShift = 0;
  }else if(keyCode == 'Q'){
    zShift += 10;
  }else if(keyCode == 'E'){
    zShift -= 10;
  }else if(keyCode == 'A'){
    if(completedSide){
      modeSwap();
    }
  }else if(keyCode == 'H'){
    float[][][][] floatForm= new float[shapes.size()][][][];
    int[][][] colorRgb = new int[shapes.size()][][];
    int i = 0;
    for(shape s:shapes){
      floatForm[i] = s.sides;
      colorRgb[i] =  s.colorToRGBInt();
      i++;
    }

    String total = export.exportShapes(floatForm,colorRgb);
    fileWrite.print(total);
    fileWrite.flush();
    fileWrite.close();
    exit();
    // export();
  } else if(keyCode == 'P'){
    //open pallet
    // int[][] rgb = new int[allColors.length][3];
    palletOn = !palletOn;
    drawPallet(b);
  
  }else if(keyCode == 'T'){
    print(colorMatrix.size());
    if(colorIndex < colorMatrix.size()-1){
      colorIndex++;
      drawPallet(b);
    }
  }else if(keyCode == 'G'){
    if(colorIndex != 0){
      colorIndex--;
      drawPallet(b);
    }
  }else if(keyCode == 'U'){
    newColors = new color[11];
    colorMatrix.add(newColors);
    colorIndex++;
    newColorIndex = 0;
    drawPallet(b);
  }else if(keyCode == 'I'){
    if(newColorIndex != 0){
      newColorIndex--;
    }
    newColors[newColorIndex] = color(255,255,255);

    drawPallet(b);
  }else if(keyCode == 'O'){
    if(newColorIndex != 10){
    if(mouseX > 0 && mouseX < 510 && mouseY > 0 && mouseY < 510){
      currentColor = color(mouseX/2,mouseY/2,b);
      newColors[newColorIndex] = currentColor;
      colorMatrix.set(colorIndex,newColors);
      drawPallet(b);
      newColorIndex++;
    }
  } 
  }else if(keyCode == 'K'){
    if(b<255){
      b+=25;
    }
    drawPallet(b);
  }else if(keyCode == 'L'){
    if(b > 0){
    b -= 25;
    }
    drawPallet(b);
  }  else if(keyCode == '1' || keyCode == '2' || keyCode == '3' || keyCode == '4'||keyCode == '5'||keyCode == '5'||keyCode == '6'||keyCode == '7'||keyCode == '8'||keyCode == '9'){
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

void drawPallet(int b){
  for(int r = 0; r<255; r++){
    for(int g = 0; g<255; g++){
      fill(color(r,g,b));
      rect(r*2,g*2,2,2);
    }
  }
  for(int i =0; i<colorMatrix.get(colorIndex).length; i++){
      // print(colorIndex);
      fill(colorMatrix.get(colorIndex)[i]);
      rect(800,75*i,75,75);
  }
}