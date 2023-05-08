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

  // Constructor for myosin head and tropomyosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }
  
}
