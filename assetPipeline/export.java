
public class export{
  public static void exportShapes(float[][][][] shapes,int[][][] allRgbs){
    String total = "";
    int shapeN = 0;
    for(float[][][] shape:shapes){
      int siN=0;
      for(float[][] side:shape){
        int vN=1;

        int cN = 0;
        for(float[] vert:side){
          int xyzN = 0;
          for(float xyz:vert){
            total+=xyz;
            if(xyzN != 2){
              total+=",";
            }
            xyzN++;
          }
          if(vN != side.length){
            total+="v";
            vN++;
          }
        }
        System.out.println(siN + "si");
        if(siN != 1){
          total+= "si";
          siN++;
        }
      }
      total+="MCSPLIT";
      for(int i =0; i<allRgbs[shapeN].length; i++){
        total+=allRgbs[shapeN][i][0] + "," +allRgbs[shapeN][i][1] + "," +allRgbs[shapeN][i][2];
        if(i != allRgbs[shapeN].length-1){
          total+= "C";
        }
      }
      total += "\n";
    shapeN++;
  }
  System.out.println(total);
  }
}