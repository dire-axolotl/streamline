import java.lang.Math;


public class matrix {

  //[ x, y, z] [x]
  //[ x, y, z] [y]
  //[ x, y, z] [z]
  float[][] matrix;
  
  public matrix(float[][] mat){
    this.matrix = mat;
  }

  public void print(){
    for(float[] vertex: matrix){
      for(float f:vertex){
        System.out.print(f + " ");
      }
      System.out.println();
    }
  }

  public static void vectorPrint(float[] vector){
    System.out.print("[");
      for(float f:vector){
        System.out.print(f + ", ");
      }
      System.out.print("]");
    }

  public float[] matrixMult(float[] vector){
    float[] newVec = new float[vector.length];
    for(int row = 0; row < matrix.length; row++){
      for(int col = 0; col < matrix[row].length; col++){
        // System.out.println(matrix[col][row] + " m");
        // System.out.println(vector[row] + " v");
        newVec[col] += matrix[col][row]*vector[row];
      }
    }
    return newVec;
  }

  public static float[] vectorRot3dX(float[] vector, float alpha){
    alpha = (float) Math.toRadians(alpha);
    
    matrix rot = new matrix(new float[][]{{1,0,0},{0, (float) Math.cos(alpha),(float) -Math.sin(alpha)},{0,(float) Math.sin(alpha),(float) Math.cos(alpha)}});
    return rot.matrixMult(vector);
  }

  public static float[] vectorRot3dY(float[] vector, float theta){
    theta = (float) Math.toRadians(theta);
    
    matrix rot = new matrix(new float[][]{{(float) Math.cos(theta),0,(float) Math.sin(theta)},{0,1,0},{(float) -Math.sin(theta),0,(float) Math.cos(theta)}});
    return rot.matrixMult(vector);
  }

  public static float[] combinedRot(float[] vector,float alpha, float theta){
    return vectorRot3dY(vectorRot3dX(vector, alpha),theta);
  }

  public static void main(String[] args) {
    float[] vector = new float[]{1,1,1};
    vectorPrint(vectorRot3dX(vector, -90));
  }

  
}