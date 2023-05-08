class Myosin extends MeshRenderer {
  private PShape shape;

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Myosin() {
    super();
  }

  // Constructor for myosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
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
    renderMeshShape(shape, getPosition());
  }

  public void displayMyosinHead() {
    renderMeshShape(shape, getPosition());
  }
}
