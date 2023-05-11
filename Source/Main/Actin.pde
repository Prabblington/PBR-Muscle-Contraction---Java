class Actin extends MeshRenderer {
  private boolean isPos = true;

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(PVector pos, boolean isPositive) {
    super(pos);
    this.isPos = isPositive;
  }

  @Override
    public void coordinateGenerator() {
    setPoints(helicalPointsGenerator(isPos, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), getXStart(), getYStart() ));
  }

  public void draw() {
    for (int i = 0; i < NUM_SPHERES(); i++) {
      renderSphere(getPoints().get(i), SPHERE_RADIUS());
    }
  }
}
