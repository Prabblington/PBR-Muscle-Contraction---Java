class Myosin extends ShapeRenderer {
  private ArrayList<PVector> vertex;
  //private ArrayList<PVector> myosinHeads;
  
  // ------------------------------ GETTERS AND SETTERS ------------------------------
  
  public ArrayList<PVector> getVertexList()  {
   return vertex; 
  }  
  public void setVertexList(ArrayList<PVector> v)  {
   this.vertex = v; 
  }
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Myosin() {
    super();
    vertex = new ArrayList<PVector>();
    //myosinHeads = new ArrayList<PVector>();
  }
  
  public void displayThickFilament()  {
    this.renderCustomVertex(vertex);
  }
  
  
}
