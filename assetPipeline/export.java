
public class export{
  public static void exportShapes(float[][][][] shapes,int[][] colors, String fileName){
    String total = "";
    for(float[][][] shape:shapes){
      for(float[][] side:shape){
        for(float[] vert:side){
          for(float xyz:vert){
            total+=xyz+",";
          }
          total+="v";
        }
        total+= "si";
      }
      total+="sh";
  }
  System.out.println(total);
  }
}