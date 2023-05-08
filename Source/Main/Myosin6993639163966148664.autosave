class Myosin extends MeshRenderer {
  private ArrayList<PVector> vertex;
  private PVector location;
  private float filamentHeight;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // vertexList for myosin heads
  public ArrayList<PVector> getVertexList() {
    return vertex;
  }
  public void setVertexList(ArrayList<PVector> ver) {
    this.vertex = ver;
  }

  // Myosin thick filament height properties
  public float getHeight() {
    return this.filamentHeight;
  }
  public void setHeight(float newHeight) {
    this.filamentHeight = newHeight;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Myosin() {
    super();
  }

  // Constructor for myosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super();
    this.location = new PVector(initLocation.x, initLocation.y, initLocation.z);
    this.setNumPoints(initNumPoints);
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
    //this.renderMeshCylinder(this.location, this.getNumPoints(), this.filamentHeight);
    this.renderMeshCapsule(this.location, 10, 100);
  }

  public void displayMyosinHead() {
    this.renderMeshGlobe(this.location, true);
  }
}
