
String fileName;
shapeCon shapes;
shapeCon ani;
int timeIndex = 0;
int frames = 0;
int[] timeData;

//testing tools remove later
float alpha = 0;
float theta = 0;
float oldTheta;
float oldAlpha;
float initialX;
float initialY;
int run;


void setup(){
  size(1000,1000,P3D);

  // box(100,100,0);
  fileName = "awsome.txt";
  //remember timeData should be same length as pages or longer
  timeData = new int[]{1,1,1,1};

  ani =  advancedImporter(fileName,timeData);
  

  
}

void draw(){
  // translate(200,200);
  background(255);
  translate(width/2,height/2);
  rotateX((float) Math.toRadians(alpha));
  rotateY((float) Math.toRadians(theta));
  // fill()
  // box(10,10,10);
  // newSphere(100,new float[]{200,200,0},255,0,0);
  ani.drawShapes();
  if(frames - frameRate < 0){
    timeIndex++;
    frames = 0;
    if(timeIndex == timeData.length){
      timeIndex = 0;
    }
    ani.reset();
    print("reset");
  }
  ani.interpolate(timeIndex);
  frames++;
}

void mouseClicked(){
  initialX = mouseX + 0f;
  initialY = mouseY + 0f;
}

void mouseDragged(){
  //testing tools remove later
  theta = (mouseX - initialX )/4 + oldTheta; 
  alpha = -(mouseY - initialY)/4 + oldAlpha; 
}

void mouseReleased(){
  //testing tools remove later
  oldAlpha = alpha;
  oldTheta = theta;
}

void newSphere(int siz,float[] pos,int r, int g, int b){
  pushMatrix();
  fill(color(r,g,b));
  translate(pos[0],pos[1],pos[2]);
  sphere(siz);
  popMatrix();
}