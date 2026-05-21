public class shape {
  float[][][] sides;
  color[] colors;
  
  public shape(float[][][] verts,color[] colors){
    sides = verts;
    //colors are sorted front,back,top,right,bottom,left(clockwise from top)
    this.colors = colors;
  }

  public void drawSides(){
    int colorIndex = 0;
    for(float[][] side:sides){
      if(side.length != 0){
        fill(colors[colorIndex]);
        beginShape();
        for(float[] vert:side){
          vertex(vert[0],vert[1],vert[2]);
        }
        endShape(CLOSE);
      }
      colorIndex++;
    }
  }

  public void connectRect(){
      for(int i = 0; i<sides[0].length;i++){
        line(sides[0][i][0],sides[0][i][1],sides[0][i][2],sides[1][i][0],sides[1][i][1],sides[1][i][2]);
      }
  }

    public void sidesRect(){
      int colorIndex = 2;
      for(int i = 0; i<sides[0].length;i++){
        fill(colors[colorIndex]);
        beginShape();
        vertex(sides[0][i][0],sides[0][i][1],sides[0][i][2]);
        vertex(sides[1][i][0],sides[1][i][1],sides[1][i][2]);
        if(i == sides[0].length-1){
        vertex(sides[1][0][0],sides[1][0][1],sides[1][0][2]);
        vertex(sides[0][0][0],sides[0][0][1],sides[0][0][2]);
        i = sides[0].length;
        } else {
        vertex(sides[1][i+1][0],sides[1][i+1][1],sides[1][i+1][2]);
        vertex(sides[0][i+1][0],sides[0][i+1][1],sides[0][i+1][2]);
        }
        colorIndex++;
        
        


        endShape(CLOSE);
      }
  }

  public void connectPyr(){
    if(sides[0].length == 1){
      for(int i = 0; i<sides[1].length;i++){
        line(sides[0][0][0],sides[0][0][1],sides[0][0][2],sides[1][i][0],sides[1][i][1],sides[1][i][2]);
      }
    } else {
      for(int i = 0; i<sides[0].length;i++){
        line(sides[1][0][0],sides[1][0][1],sides[1][0][2],sides[0][i][0],sides[0][i][1],sides[0][i][2]);
      }
    }
  }

    public void sidesPyr(){
    if(sides[0].length == 1){
      colorIndex = 1;
      for(int i = 0; i < sides[1].length; i++){
        fill(colors[colorIndex]);
        colorIndex++;
        beginShape();
        vertex(sides[0][0][0],sides[0][0][1],sides[0][0][2]);
        vertex(sides[1][i][0],sides[1][i][1],sides[1][i][2]);
        if(i == sides[1].length-1){
          vertex(sides[1][0][0],sides[1][0][1],sides[1][0][2]);
          i = sides[1].length;
        }else{
          vertex(sides[1][i+1][0],sides[1][i+1][1],sides[1][i+1][2]);
        }
        endShape(CLOSE);
      }
    } else {
      for(int i = 0; i < sides[0].length; i++){
        fill(color(0,255,0));
        beginShape();
        vertex(sides[1][0][0],sides[1][0][1],sides[1][0][2]);
        vertex(sides[0][i][0],sides[0][i][1],sides[0][i][2]);
        if(i == sides[0].length-1){
          vertex(sides[0][0][0],sides[0][0][1],sides[0][0][2]);
          i = sides[0].length;
        }else{
          vertex(sides[0][i+1][0],sides[0][i+1][1],sides[0][i+1][2]);
        }
        endShape(CLOSE);
      }
    }
  }

  public void combine(){
    if(sides.length >= 2){
      if(sides[0].length == sides[1].length){
        sidesRect();
      } else {
        sidesPyr();
      }
    }
  }


  
}
