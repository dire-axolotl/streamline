public class shape {
  float[][][] sides;
  color[] colors;
  
  public shape(float[][][] verts,color[] colors){
    sides = verts;
    //colors are sorted front,back,top,right,bottom,left(clockwise from top)
    this.colors = colors;
  }

  public shape(){
    //empty constructor for psuedo static methods
  }
  public shape(shape s){
    float[][][] fullshape = new float[s.sides.length][][];
    for(int si = 0; si<s.sides.length; si++){
      float[][] newSides = new float[s.sides[si].length][3];
      for(int v = 0; v<s.sides[si].length;v++){
        for(int xyz = 0; xyz<s.sides[si][v].length;xyz++){
          newSides[v][xyz] =  s.sides[si][v][xyz];
        }
      }
      fullshape[si] = newSides;
      
    }
    this.sides = fullshape;
    this.colors = s.colors.clone();
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
      int colorIndex = 1;
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

  public void shapeRot(float alpha,float theta){
    for(int siI = 0; siI<this.sides.length;siI++){
      for(int vertI = 0; vertI<this.sides[siI].length;vertI++){
        sides[siI][vertI] = matrix.combinedRot(sides[siI][vertI],alpha,theta);
      }
    }
    
  }

  public int[][] colorToRGBInt(){
    int[][] rgbs = new int[colors.length][3];
    int i = 0;
    for(color col:colors){
      rgbs[i] = new int[]{(int) red(col),(int) green(col),(int) blue(col)};
      i++;
    }  
    return rgbs;
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
  // can't be staic because pde doesn't ball like that
  public shape[] importer(String fileName){
    try{
      ArrayList<String> strings = new ArrayList<String>();
      BufferedReader read = createReader(fileName);
      String currentLine = "";
      while(currentLine != null){
        currentLine = read.readLine();
        if(currentLine != null){
           strings.add(currentLine);
        }
      }
      shape[] shapes = new shape[strings.size()];
      int shapesI = 0;
      for(int shapeLineIndex = 0; shapeLineIndex < strings.size();shapeLineIndex++){
        
        String[] lineList = strings.get(shapeLineIndex).split("MCSPLIT");
        // print(lineList[1]);
        String[] sides = lineList[0].split("si");
        String[] colorsList = lineList[1].split("C");
        
        float[][][] sidesPost = new float[sides.length][][];

        int sidesI = 0;
        for(String s:sides){
          String[] verts = s.split("v");
          float[][] vertsPost = new float[verts.length][];
          int vertI = 0;
          for(String coords:verts){
            String[] xyz = coords.split(",");
            float[] xyzPost = new float[3];
            int xyzI = 0;
            for(String axis:xyz){
              xyzPost[xyzI] = Float.parseFloat(axis) + 0f;
              xyzI++;
            }
            vertsPost[vertI] = xyzPost;
            vertI++;
          }
          sidesPost[sidesI] = vertsPost;
          sidesI++;
     
        }
        

        color[] colors = new color[13];
        int colorI = 0;
        for(String col:colorsList){
          String[] rgb =col.split(",");
          colors[colorI] = color(Integer.parseInt(rgb[0]),Integer.parseInt(rgb[1]),Integer.parseInt(rgb[2]));

          colorI++;
          
        }

        shapes[shapesI] = new shape(sidesPost,colors);
        shapesI++;
      }



      return shapes;
    }
    catch(Exception e){
      
      print(e);
    }
    return new shape[]{new shape()};
    
    
  }

  void shapeAdd(float[] xyz, int scale){
    for(int si =0; si< sides.length;si++){
      for(int ver = 0; ver<sides[si].length;ver++){
        sides[si][ver][0] -= xyz[0]/scale;
        sides[si][ver][1] -= xyz[1]/scale;
        sides[si][ver][2] -= xyz[2]/scale;
      }
    }
  }

    void shapeAddReal(float[] xyz, int scale){
    for(int si =0; si< sides.length;si++){
      for(int ver = 0; ver<sides[si].length;ver++){
        sides[si][ver][0] += xyz[0]/scale;
        sides[si][ver][1] += xyz[1]/scale;
        sides[si][ver][2] += xyz[2]/scale;
      }
    }
  }


  float[][][] shapeDelta(shape s){
    float[][][] delta = new float[sides.length][][];
    for(int si = 0; si<sides.length; si++){
      float[][] sideList = new float[sides[si].length][];
      for(int vert = 0; vert<sides[si].length; vert++){
        float[] vertList = new  float[3];
        for(int xyz = 0; xyz<sides[si][vert].length; xyz++){
          vertList[xyz] = sides[si][vert][xyz] - s.sides[si][vert][xyz];
        }
        sideList[vert] = vertList;
      }
      delta[si] = sideList;
    }
    return delta;
  }
  
}
