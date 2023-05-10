class Actin extends MeshRenderer {

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(PVector pos) {
    super(pos);
  }

  @Override
    public void coordinateGenerator() {
    populateStruct1Points( helicalPointsGenerator(true, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), getXStart(), getYStart() ));
    populateStruct2Points( helicalPointsGenerator(false, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), getXStart(), getYStart() ));
  }

  @Override
    public void displayShape() {
    for (int i = 0; i < actin.NUM_SPHERES(); i++) {
      strokeWeight(1);
      fill(255, 0, 255, 180);
      renderSphere(getStruct1Points().get(i), SPHERE_RADIUS());

      fill(70, 20, 150, 180);
      renderSphere( getStruct2Points().get(i), SPHERE_RADIUS());
    }
  }
}
