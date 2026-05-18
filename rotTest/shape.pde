public class shape {
  float[][][] sides;
  
  public shape(float[][][] verts){
    sides = sides;
  }

  public void drawSides(){
    for(float[][] side:sides){
      if(side.length != 0){
        beginShape();
        for(float[] vert:side){
          vertex(vert[0],vert[1]);
        }
        endShape();
      }
    }
  }

  
}
