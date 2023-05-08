class Tropomyosin extends Myosin {

  private boolean isSiteA;

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Tropomyosin() {
    super();
  }

  // Constructor for myosin
  public Tropomyosin(PVector initLocation, int initNumPoints, boolean isSiteA) {
    super(initLocation, initNumPoints);
    this.isSiteA = isSiteA;
  }

    @Override
    public void coordinateGenerator() {
    noFill();
    stroke(20, 60, 0);
    strokeWeight(10);

    populateStruct1Points(helicalPointsGenerator(isSiteA, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), this.getXStart(), this.getYStart() ));

    PShape s = generateBezierStructure(getStruct1Points());
    setShape(s);
  }

  @Override
    public void displayShape() {
    renderMeshShape(getShape(), getPosition());
  }
}
