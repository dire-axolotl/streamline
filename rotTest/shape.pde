public class shape {
  float[][][] sides;
  
  public shape(float[][][] verts){
    sides = verts;
  }

  public void drawSides(){
    for(float[][] side:sides){
      if(side.length != 0){
        fill(color(255,0,0));
        beginShape();
        for(float[] vert:side){
          print(vert[0]);
          vertex(vert[0],vert[1],vert[2]);
        }
        endShape(CLOSE);
      }
    }
  }

  public void connectRect(){
      for(int i = 0; i<sides[0].length;i++){
        line(sides[0][i][0],sides[0][i][1],sides[0][i][2],sides[1][i][0],sides[1][i][1],sides[1][i][2]);
      }
  }

    public void sidesRect(){
      for(int i = 0; i<sides[0].length;i++){
        fill(color(0,255,0));
        beginShape();
        vertex(sides[0][i][0],sides[0][i][1],sides[0][i][2]);
       vertex(sides[0][i][0],sides[0][i][1],sides[0][i][2]


        endShape(CLOSE);
      }
  }

  public void connectPyr(){
    if(sides[0].length == 1){
      for(int i = 0; i<sides[1].length;i++){
        line(sides[0][0][0],sides[0][0][1],sides[0][0][2],sides[1][i][0],sides[1][i][1],sides[1][i][2]);
      }
    } else {
      print("hi");
      for(int i = 0; i<sides[0].length;i++){
        line(sides[1][0][0],sides[1][0][1],sides[1][0][2],sides[0][i][0],sides[0][i][1],sides[0][i][2]);
      }
    }
  }

  public void combine(){
    if(sides.length >= 2){
      if(sides[0].length == sides[1].length){
        connectRect();
      } else {
        connectPyr();
      }
    }
  }


  
}
