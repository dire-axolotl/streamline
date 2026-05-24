public class shapeShell{
  float[][][][] verts;
  int[][][] colors;
  public shapeShell(float[][][][] verts, int[][][] colors){
    this.verts = verts;
    this.colors = colors;
  }

  public shapeShell(){
    this.verts = null;
    this.colors = null;
  }
}