class Myosin extends MeshRenderer {
  private PShape shape;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  public PShape getShape() {
    return this.shape;
  }
  public void setShape(PShape newShape) {
    this.shape = newShape;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Myosin() {
    super();
  }

  // Constructor for myosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

  @Override
    public void coordinateGenerator() {
    strokeWeight(0.5);
    fill(#6F4040);
    stroke(#F7B1B1);
    
    shape = this.renderMeshGlobe(true, false);
    shape.rotateY(HALF_PI);
  }

  @Override
    public void displayShape() {
    renderMeshShape(shape, getPosition());
  }
}
