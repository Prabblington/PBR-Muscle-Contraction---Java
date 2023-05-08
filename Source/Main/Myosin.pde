class Myosin extends MeshRenderer {
  private PVector location;
  private float filamentHeight;
  private PShape shape;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

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

  public void generateThickFilamentShape() {
    this.shape = this.generateMeshCylinder(this.getNumPoints(), this.filamentHeight);
    shape.rotateY(HALF_PI);
  }

  public void generateMyosinHeadShape() {
    this.shape = this.renderMeshGlobe(true);
    shape.rotateY(HALF_PI);
  }

  public void displayThickFilament() {
    this.renderMeshShape(shape, this.location);
  }

  public void displayMyosinHead() {
    this.renderMeshShape(shape, this.location);
  }
}
