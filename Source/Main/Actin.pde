class Actin extends MeshRenderer {
  private boolean isPos = true;

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(PVector pos, boolean isPositive, int amount, int r) {
    super(pos, amount, r);
    this.isPos = isPositive;    
  }

  @Override
    public void coordinateGenerator() {
    setPoints(helicalPointsGenerator(isPos, getAmount(), SIN_COS_VAL(), getSpacing(), getXStart(), getYStart() ));
  }

  public void draw() {
    for (int i = 0; i < getAmount(); i++) {
      renderSphere(getPoints().get(i), getRadius());
    }
  }
}
