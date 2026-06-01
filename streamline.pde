
float alpha = 0;
float theta = 0;
float oldTheta;
float oldAlpha;
String stoneAniFileName = "attackAniStone.txt";
float[] timeDataStone = new float[]{1,1,1,1,1};
String rollerAniWalkingFileName = "rollerAniWalking.txt";
float[] timeDataRoller = new float[]{1,1,1,1,1,1,1};
String dogAniWalkingFileName = "dogAniWalking.txt";
float[] timeDataDogWalk = new float[]{1,1};
String dogAniAttackingFileName = "dogAniAttack.txt";
float[] timeDataDogAtk = new float[]{1,1,1};
String rollerAniAtkFileName = "rollerAniAtk.txt";
float[] timeDataRollerAtk = new float[]{1,1,.5};

shapeCon stoneAni;
shapeCon rollerWalkAni;
shapeCon dogWalkAni;
shapeCon dogAtkAni;
shapeCon rollerAtkAni;
int run = 0;
int[] frames = new int[] {0,0,0,0,0};
int[] timeIndex = new int[] {0,0,0,0,0};
float[][] timeData;
boolean[] aniOn = {false,true,true,false,false};
float[][] aniXyz;
shapeCon[] cons;
float[] dogDelta = new float[]{0,0,0};
float[] charachterDelta = new float[]{0,0,0};
float dogCooldown = 10;
boolean dogCanAttack = false;
int playerHealth = 3;
int dogHealth = 5;
int charachterCooldown = 3;
boolean playerCanAttack = true;
float initialX;
float initialY;



void setup(){
  size(1000,1000,P3D);

  stoneAni = advancedImporter(stoneAniFileName,timeDataStone);
  rollerWalkAni = advancedImporter(rollerAniWalkingFileName,timeDataRoller);
  dogWalkAni = advancedImporter(dogAniWalkingFileName,timeDataDogWalk);
  dogAtkAni = advancedImporter(dogAniAttackingFileName,timeDataDogAtk);
  rollerAtkAni = advancedImporter(rollerAniAtkFileName,timeDataRollerAtk);
  timeData = new float[][]{timeDataStone,timeDataRoller,timeDataDogWalk,timeDataDogAtk,timeDataRollerAtk};
  cons = new shapeCon[]{stoneAni,rollerWalkAni,dogWalkAni,dogAtkAni,rollerAtkAni};
  //charachter is number 1
  aniXyz = new float[5][3];
  
}

void draw(){
  if(playerHealth == 0){
    aniOn[1] = false;
  } else if(dogHealth == 0){
    aniOn[2] = false;
    aniOn[3] = false;
  }
  // println("a");
  background(255);
  rotateX((float) Math.toRadians(alpha));
  rotateY((float) Math.toRadians(theta));
  translate(width/2,height/2);
  
  // println("b");
  for(int i = 0; i<timeIndex.length;i++){
    if(aniOn[i]){
      if(frameRate/4*timeData[i][timeIndex[i]] - frames[i] < 0){
        timeIndex[i]++;
        frames[i] = 0;
        if(timeIndex[i]== timeData[i].length){
          timeIndex[i] = 0;
          cons[i].reset();
          if(i == 1){
            charachterCooldown--;
            if(charachterCooldown == 0){
              playerCanAttack = true;
            }
          } else if(i == 3 && dogCanAttack){
            aniOn[3] = false;
            aniOn[2] = true;
            aniOn[0] = true;
            dogCanAttack =false;
          } else if(i == 0){
            print("hi");
            aniOn[0]= false;
            float delta = 0;
            delta += abs(aniXyz[0][0] - aniXyz[1][0]);
            delta += abs(aniXyz[0][2] - aniXyz[1][2]);
            println(delta + " delta");
            if(delta<300){
              playerHealth--;
              background(color(255,0,0));
            }
          } else if(i == 4){
            charachterCooldown = 3;
            aniOn[1] = true;
            aniOn[4] = false;
            float delta = 0;
            delta += abs(aniXyz[1][0] - aniXyz[2][0]);
            delta += abs(aniXyz[1][2] - aniXyz[2][2]);
            println(delta+  "delta");
            if(delta<300){
              dogHealth--;
              background(color(0,255,0));
            }
          }
        }
        if(i == 2){
          dogCooldown--;
          if(dogCooldown == 0){
            dogCooldown = 10;
            dogCanAttack = true;
          }
        }

      }
      //charachter
      if(i == 1){
        for(int n = 0; n<3;n++){
          aniXyz[1][n]+=charachterDelta[n];
          aniXyz[4][n]+=charachterDelta[n];
        }
      } else if(i >= 2){
        for(int n = 0; n<3;n++){
          aniXyz[2][n]+=dogDelta[n];
        }
        if(dogCanAttack){
          dogAttack();
          // println("b");
        }
      }
      pushMatrix();
      frames[i]++;
      translate(aniXyz[i][0],aniXyz[i][1],aniXyz[i][2]);
      // println("c");
      cons[i].drawShapes();
      cons[i].interpolate(timeIndex[i]);
      popMatrix();
      
    }
  
  if(dogDelta[0] > 100 || dogDelta[0] < -100){
    dogDelta[0]=0;
  } else if(aniXyz[2][0]-aniXyz[1][0]+50<0){
    dogDelta[0] += 2;
  } else if(aniXyz[2][0]+aniXyz[1][0]-50>0) {
    dogDelta[0] -= 2;
  }

  if(dogDelta[2] > 100 || dogDelta[2] < -100){
    dogDelta[2]=0;
  } else if(aniXyz[2][2]-aniXyz[1][2]+50<0){
    dogDelta[2] += 2;
  } else if(aniXyz[2][2]+aniXyz[1][2]-50>0) {
    dogDelta[2] -= 2;
  }
  // ani.interpolate(timeIndex);

  }
}

void keyPressed(){
  if(keyCode == 'W') {
    if(charachterDelta[2] > 0){
      charachterDelta[2] = 0;
    }
    charachterDelta[2] -= 10;
  } else if(keyCode == 'S') {
    if(charachterDelta[2] < 0){
      charachterDelta[2] = 0;
    }
    charachterDelta[2] -= -10;
  }else if(keyCode == 'A') {
    if(charachterDelta[0] > 0){
      charachterDelta[0] = 0;
    }
    charachterDelta[0] += -10;
  }else if(keyCode == 'D') {
    if(charachterDelta[0] < 0){
      charachterDelta[0] = 0;
    }
    charachterDelta[0] += +10;
  }
}

void dogAttack(){
  // print("a");
  float[] hold = new float[]{aniXyz[2][0],aniXyz[2][1],aniXyz[2][2]};
  aniXyz[0] = hold;
  // print("b");
  float deltaX = aniXyz[0][0]-aniXyz[1][0];
  float deltaZ = aniXyz[0][2]-aniXyz[1][2];
  float sloap = deltaZ/deltaX;
  float invSloap = deltaX/deltaZ;
  if(deltaX < 50 && deltaX > -50){
    aniXyz[0][0] += deltaX;
  }else {
    aniXyz[0][0] += invSloap*50;
  }
  if(deltaZ < 50 && deltaZ > -50){
    aniXyz[0][2] += deltaZ;
  }else {
    aniXyz[0][2] += sloap*50;
  }

  aniOn[2] = false;
  aniOn[3] = true;
  // print("c");
}

void mouseClicked(){
  if(playerCanAttack){
    playerCanAttack = false;
    aniOn[1] = false;
    aniOn[4] = true;
  }
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