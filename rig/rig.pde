import java.util.ArrayList;

ArrayList<shape[]> pages;
//page I determines the cureent page
int pageI;
//page I determines the shape being moved
int shapeI;
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
  pageI = 0;
  pages = new ArrayList<shape[]>();
  shape n = new shape();
  shapes = n.importer("test.txt");
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
  
  int i = 0;
  for(shape s:pages.get(pageI)){
    if(shapeI == i){
      stroke(255);
    } else {
      stroke(0);
    }
    s.drawSides();
    s.combine();
    i++;
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
  }else if(keyCode == 'W') {
    moveShape(0,100);
  }else if(keyCode == 'A') {
    moveShape(100,0);
  }else if(keyCode == 'S') {
    moveShape(0,-100);
  }else if(keyCode == 'D') {
    moveShape(-100,0);
  }
}

void moveShape(float xM,float yM){
  float[] xyz = new float[]{xM,yM,0};
  xyz = matrix.combinedRot(xyz,-alpha,-theta);
  pages.get(pageI)[shapeI].shapeAdd(xyz);
}