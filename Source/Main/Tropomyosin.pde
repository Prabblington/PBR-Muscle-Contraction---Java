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

    setPoints( helicalPointsGenerator(isSiteA, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), 0, 0 ));
  }

  public void draw() {
    stroke(10, 20, 0, 200);
    strokeWeight(1);
    fill(20, 60, 0, 180);

    for (int i = 0; i < getPoints().size(); i++) {
      pushMatrix();
      translate(getPosition().x, getPosition().y, getPosition().z);
      renderSphere(getPoints().get(i), getRadius());
      popMatrix();
    }
    PShape s = generateBezierStructure(getPoints());
    setShape(s);

    renderMeshShape(getShape(), getPosition());
  }
}
