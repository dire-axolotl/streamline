public class shapeCon{
  shape[] curPage;
  shape[][] pages;
  int[] timeData;
  float[][][][][] deltaData;

  public shapeCon(shape[][] pages,int[] timeData){
    float[][][][][] unsetDeltaData = new float[pages.length-1][pages[0].length][2][][];
    println("start");
    shape[] copyOfPage = new shape[pages[0].length];
    int i =0;
    for(shape s:pages[0]){
      copyOfPage[i] = new shape(s);
      i++;
    }
    this.curPage = copyOfPage;
    // println("b");
    this.pages = pages;
    this.timeData = timeData;
    // print(pages.length + " pages");
    // print(pages[0].length + " shapes");
    for(int pageI= 0; pageI<pages.length-1; pageI++){
      print(pageI + " pageI");
      for(int shapeI=0; shapeI<pages[pageI].length;shapeI++){
        println("c");
        unsetDeltaData[pageI][shapeI] = pages[pageI][shapeI].shapeDelta(pages[pageI+1][shapeI]);
        println("u did it i guess");
      }
      // print("here?");
    }
    
    deltaData = unsetDeltaData;
  }

  public shapeCon(){

  }

  public void drawShapes(){
    
    for(shape s:curPage){
      // println(s.sides[0][0][2]);
      // fill(0);
      s.drawSides();
      s.combine();
    }
  }

  public void reset(){
    shape[] copyOfPage = new shape[pages[0].length];
    int i =0;
    for(shape s:pages[0]){
      copyOfPage[i] = new shape(s);
      i++;
    }
    curPage = copyOfPage;
  }

  public void interpolate(int timeIndex){
    for(int shI = 0; shI<curPage.length; shI++){
      for(int siI = 0; siI < 2; siI++){
        for(int verI = 0; verI<curPage[shI].sides[siI].length; verI++){
          // println(deltaData[timeIndex][siI][shI].length + " deltaMax");
          // println(curPage[shI].sides[siI].length + " curpMax");
          for(int xyz = 0; xyz<3;xyz++){
            // println(xyz + " xyz");
            // println(siI + " siI");
            // println(shI + " shI");
            // println(verI + " verI");
            
            curPage[shI].sides[siI][verI][xyz] += deltaData[timeIndex][shI][siI][verI][xyz]/timeData[timeIndex]/frameRate;
            // println(" hi");
          }
        }
      }
    }
    // println("we've been here");
  }
}

public shapeCon advancedImporter(String fileName, int[] timeDataP){
    try{
      ArrayList<String> strings = new ArrayList<String>();
      BufferedReader read = createReader(fileName);
      String currentLine = "";
      int pagesNum = 0;
      while(currentLine != null){
        currentLine = read.readLine();
        if(currentLine != null){
          if(currentLine.equals("PAGE")){
            pagesNum++;
          } else {
            strings.add(currentLine);
          }
        }
        
      }
      
      shape[][] pages = new shape[pagesNum][];
      int pageI = 0;
      int shapeI = 0;
      shape[] shapes = new shape[strings.size()/pagesNum];
      for(int lineI = 0; lineI < strings.size();lineI++){
        // print("a");
        // println(lineI + " lineI");
        // println(pageI + " pageI");
        // println(shapeI + " shapeI");
        // println(pagesNum + " pagesNum");
        if(shapeI == strings.size()/pagesNum){
          shapeI= 0;
          // println(shapes);
          pages[pageI] = shapes;
          shapes = new shape[strings.size()/pagesNum];
          pageI++;
        }

        // print("b");
        String[] lineList = strings.get(lineI).split("MCSPLIT");
        String[] sides = lineList[0].split("si");
        String[] colorsList = lineList[1].split("C");
        // print("c");
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
        // print("d");
        

        color[] colors = new color[13];
        int colorI = 0;
        for(String col:colorsList){
          String[] rgb =col.split(",");
          colors[colorI] = color(Integer.parseInt(rgb[0]),Integer.parseInt(rgb[1]),Integer.parseInt(rgb[2]));

          colorI++;
          
        }
        // println("g");
        shapes[shapeI] = new shape(sidesPost,colors);
        shapeI++;
        // println("e");

      }
      pages[pageI] = shapes;
      // print("x");
      //test pages
      for(int pageII = 0; pageII < pages.length;pageII++){
        for(int shapeII = 0; shapeII < pages[pageII].length;shapeII++){
          println(pageII + " page");
          println(shapeII + " shape");
          println(pages[pageII][shapeII] + " link");
        }
      }

      return new shapeCon(pages ,timeDataP);

    }
    catch(Exception e){
      
      print(e);
      return new shapeCon();
    }
    
    
  }