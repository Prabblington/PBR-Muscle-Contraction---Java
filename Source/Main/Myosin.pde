class Myosin extends MeshRenderer {
  private ArrayList<PVector> vertex;
  //private ArrayList<PVector> myosinHeads;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  public ArrayList<PVector> getVertexList() {
    return vertex;
  }
  public void setVertexList(ArrayList<PVector> ver) {
    this.vertex = ver;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor 
  public Myosin() {
    super();
  }
  
  // Constructor for myosin heads
  public Myosin(ArrayList<PVector> v) {
    super();
    vertex = new ArrayList<PVector>(v);
    //myosinHeads = new ArrayList<PVector>();
  }

  // Constructor for myosin thick filament
  public Myosin(float[] d) {
    super();
    vertex = new ArrayList<PVector>();

    // Myosin filament vertex arrayList
    vertex.add(new PVector( -d[0], -d[1], -d[2] )); // -1, -2, -3
    vertex.add(new PVector( d[2], -d[1], -d[2] ));  // 3, -2, -3
    vertex.add(new PVector( d[2], d[2], -d[2] ));   // 2, 2, -2
    vertex.add(new PVector( -d[0], d[2], -d[2] ));  // -1, -3, -3

    vertex.add(new PVector( -d[0], -d[1], d[2] ));  // -1, -2, 3
    vertex.add(new PVector( d[2], -d[1], d[2] ));   // 3, -2, -3
    vertex.add(new PVector( d[2], d[2], d[2] ));    // 3, 3, 3
    vertex.add(new PVector( -d[0], d[2], d[2] ));   // -1, 3, 3
  }

  public void displayThickFilament() {
    this.renderQuadShape(vertex);
  }
  
  public void displayMyosinHead()  {
    this.renderMeshGlobe();
  }
}
