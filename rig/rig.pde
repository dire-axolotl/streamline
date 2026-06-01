import java.util.ArrayList;

ArrayList<shape[]> pages;
//page I determines the cureent page
int pageI;
//page I determines the shape being moved
int shapeI;
float[] moveMatrix;
int test = 0;
shape[] shapes;
PrintWriter fileWrite;
String fileName = "rollerAniAtk.txt";
boolean spaceMode;
boolean vertexMode;
boolean rotMode;
float deltaX = 0;
float deltaY= 0;
float oldTheta;
float oldAlpha;
float theta;
float alpha;
float oldShapeTheta;
float oldShapeAlpha;
float shapeTheta;
float shapeAlpha;
float oldShapeZShift;
float shapeZShift;

float xShift;
float yShift;


float oldZShift;
float zShift;
float initialX;
float initialY;
float z;
int run;
void setup(){
  size(1000,1000,P3D);
  spaceMode = true;
  moveMatrix = new float[] {0,0,0};
  fileWrite = createWriter(fileName);
  rotMode = true;
  pageI = 0;
  pages = new ArrayList<shape[]>();
  shape n = new shape();
  shapes = n.importer("rollerPallet.txt");
  pages.add(shapes);
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
  translate(xShift,yShift,0);
  
  int i = 0;
  for(shape s:pages.get(pageI)){
    pushMatrix();
    if(shapeI == i){
      stroke(255);
      // print(moveMatrix[0]);
      if(rotMode){
        rotateX((float) Math.toRadians(shapeAlpha));
        rotateY((float) Math.toRadians(shapeTheta));
        rotateZ((float) Math.toRadians(shapeZShift));
      } else {
        translate(moveMatrix[0],moveMatrix[1],moveMatrix[2]);
      }
    } else {
      stroke(0);
    }
    s.drawSides();
    s.combine();
    i++;
    popMatrix();
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
  if(spaceMode){
    theta = (mouseX - initialX )/4 + oldTheta; 
    alpha = -(mouseY - initialY)/4 + oldAlpha; 
  } else {
    if(rotMode){
      shapeTheta = (mouseX - initialX )/4 + oldShapeTheta; 
      shapeAlpha = -(mouseY - initialY)/4 + oldShapeAlpha; 
    } else {
      deltaX = (mouseX - initialX);
      deltaY = (mouseY - initialY);
      print(initialX);
      moveMatrix = new float[]{deltaX,deltaY,0};
      moveMatrix = matrix.combinedRot(moveMatrix,-alpha,-theta);
    }
  }
  run++;
  // println(moveMatrix[0]);
}

void mouseReleased(){
  print("hi");
  run = 0;

  if(rotMode){
    pages.get(pageI)[shapeI].shapeRot(shapeAlpha,shapeTheta);
  } else {
    pages.get(pageI)[shapeI].shapeAddReal(moveMatrix,1);
  }
  moveMatrix = new float[]{0,0,0};
  oldTheta= theta;
  oldAlpha= alpha;
  oldShapeAlpha= 0;
  oldShapeTheta= 0;
  shapeAlpha= 0;
  shapeTheta= 0;
}

void keyPressed(){
  //new Page
  if(keyCode == 'N'){
    shape[] copyList = new shape[pages.get(pageI).length];
    for(int i = 0; i< pages.get(pageI).length; i++){
      copyList[i] = new shape(pages.get(pageI)[i]);
    }
    pages.add(copyList);
  } else if(keyCode == UP) {
    if(pageI<pages.size()-1){
      pageI++;
    }
  }else if(keyCode == '.') {
    for(shape[] s:pages){
      exportShape(s);
    }
    fileWrite.flush();
    fileWrite.close();
    exit();
  } else if(keyCode == DOWN) {
    if(pageI>0){
      pageI--;
    }
  }else if(keyCode == LEFT) {
    if(shapeI<pages.get(pageI).length-1){
      shapeI++;
    }
  } else if(keyCode == RIGHT) {
    if(shapeI>0){
      shapeI--;
    }
  }else if(keyCode == 'X') {
    theta = 0;
    oldTheta = 0;
  }else if(keyCode == 'Y') {
    alpha = 0;
    oldAlpha = 0;
  }else if(keyCode == 'T') {
    spaceMode = !spaceMode;
  }else if(keyCode == 'I') {
    pages.remove(pageI);
  }else if(keyCode == 'R'){
    rotMode = !rotMode;
  }else if(keyCode == 'Q') {
    zShift-=10;
  }else if(keyCode == 'E') {
    zShift+=10;
  }else if(keyCode == 'W') {
    yShift-=20;
  }else if(keyCode == 'A') {
    xShift-=20;
  }else if(keyCode == 'S') {
    yShift+=20;
  }else if(keyCode == 'D') {
    xShift+=20;
  }else if(keyCode == 'M') {
    spaceMode = !spaceMode;
  }
}

void moveShape(float xM,float yM){
  float[] xyz = new float[]{xM,yM,0};
  xyz = matrix.combinedRot(xyz,-alpha,-theta);
  pages.get(pageI)[shapeI].shapeAdd(xyz,1);
}


void exportShape(shape[] shapes){
  float[][][][] floatForm= new float[shapes.length][][][];
    int[][][] colorRgb = new int[shapes.length][][];
    int i = 0;
    for(shape s:shapes){
      floatForm[i] = s.sides;
      colorRgb[i] =  s.colorToRGBInt();
      i++;
    }

    String total = export.exportShapes(floatForm,colorRgb);
    total += "PAGE\n";
    fileWrite.print(total);
    // fileWrite.flush();
}