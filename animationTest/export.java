import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileNotFoundException;


public class export{
  public static String exportShapes(float[][][][] shapes,int[][][] allRgbs){
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
  return total;
  }

//   public static shapeShell importer(String fileName){
//     File fileR = new File(fileName);
//     try{

//       Scanner scan = new Scanner(fileR);
//       ArrayList<String> shapesString = new ArrayList<String>();
//       while(scan.hasNextLine()){
//         shapesString.add(scan.nextLine());
//       }
//       scan.close();

//       float[][][][] shapes = new float[shapesString.size()][][][];
//       int[][][] colors = new int[shapesString.size()][][];
//       System.out.println(shapesString.size());
//       for (String string : shapesString) {

//         System.out.println(string);
//       }


//       return new shapeShell(shapes,colors);


//     }  
//     catch(Exception e){
//       System.err.println(e);
//     }  
    
//     return new shapeShell();
// }

// public static void main(String[] args) {
  // importer("/assetPipeline/test.txt");
// }
}