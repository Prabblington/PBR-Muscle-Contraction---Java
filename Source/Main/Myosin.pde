class Myosin extends MeshRenderer {
  private PVector location;
  //private float filamentHeight;
  private PShape shape;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  //// Myosin thick filament height properties
  //public float getHeight() {
  //  return this.filamentHeight;
  //}
  //public void setHeight(float newHeight) {
  //  this.filamentHeight = newHeight;
  //}

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Myosin() {
    super();
  }

  // Constructor for myosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super();
    this.location = new PVector(initLocation.x, initLocation.y, initLocation.z);
    setNumPoints(initNumPoints);
  }

  public void generateThickFilamentShape() {
    shape = generateMeshCylinder(getNumPoints(), getHeight());
    shape.rotateY(HALF_PI);
  }

  public void generateMyosinHeadShape() {
    shape = this.renderMeshGlobe(true, false);
    shape.rotateY(HALF_PI);
  }

  public void displayThickFilament() {
    renderMeshShape(shape, location);
  }

  public void displayMyosinHead() {
    renderMeshShape(shape, location);
  }
}
