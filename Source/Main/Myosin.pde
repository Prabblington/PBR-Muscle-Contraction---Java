class Myosin extends ShapeRenderer {
  private ArrayList<PVector> vertex;
  //private ArrayList<PVector> myosinHeads;
  
  // ------------------------------ GETTERS AND SETTERS ------------------------------
  
  public ArrayList<PVector> getVertexList()  {
   return vertex; 
  }  
  public void setVertexList(ArrayList<PVector> ver)  {
   this.vertex = ver; 
  }
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Myosin(ArrayList<PVector> v) {
    super();
    vertex = new ArrayList<PVector>(v);
    //myosinHeads = new ArrayList<PVector>();
  }
  
  public void displayThickFilament()  {
    this.renderCustomVertex(vertex);
  }
  
  
}
