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
    stroke(20, 60, 0, 180);
    strokeWeight(10);

    populateStruct1Points( helicalPointsGenerator(isSiteA, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), 0, 0 ));

    PShape s = generateBezierStructure(getStruct1Points());
    setShape(s);
  }

  @Override
    public void displayShape() {
    stroke(0);
    fill(255, 0, 0);

    for (int i = 0; i < getStruct1Points().size(); i++) {
      renderSphere(getStruct1Points().get(i), getRadius());
    }

    renderMeshShape(getShape(), getPosition());
  }
}
