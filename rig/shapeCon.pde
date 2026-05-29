public class shapeCon{
  shape[] curPage;
  shape[][] pages;
  int[] timeData;
  float[][][][][] deltaData;

  public shapeCon(shape[][] pages,int[] timeData){
    float[][][][][] unsetDeltaData = new float[pages.length-1][][][][];
    this.curPage = pages[0];
    this.pages = pages;
    this.timeData = timeData;
    for(int pageI= 0; pageI<timeData.length; pageI++){
      for(int shapeI=0; shapeI<pages[pageI].length;shapeI++){
        unsetDeltaData[pageI][shapeI] = pages[pageI][shapeI].shapeDelta(pages[pageI][shapeI+1]);
      }
    }
    deltaData = unsetDeltaData;
  }

  public void interpolate(int timeIndex){
    for(int shI = 0; shI<curPage.length; shI++){
      for(int siI = 0; siI < 2; siI++){
        for(int verI = 0; verI<curPage[shI].sides[siI].length; verI++){
          for(int xyz = 0; xyz<3;xyz++){
            curPage[shI].sides[siI][verI][xyz] += deltaData[timeIndex][siI][shI][verI][xyz]/timeData[timeIndex];
          }
        }
      }
    }
  }
}