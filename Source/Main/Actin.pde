class Actin extends MeshRenderer {

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(float initX, float initY) {
    super(initX, initY);
  }

  @Override
    public void coordinateGenerator() {
    populateStruct1Points(this.helicalPointsGenerator(true, NUM_SPHERES(), SIN_COS_VAL(), SPACING(),getXStart(), getYStart() ));
    populateStruct2Points(this.helicalPointsGenerator(false, NUM_SPHERES(), SIN_COS_VAL(), SPACING(), getXStart(), getYStart() ));
  }

  @Override
    public void displayShape() {
    for (int i = 0; i < actin.NUM_SPHERES(); i++) {
      ArrayList<PVector> points1 = this.getStruct1Points();
      ArrayList<PVector> points2 = this.getStruct2Points();
      strokeWeight(1);

      fill(255, 0, 255, 180);
      renderSphere(points1.get(i), this.SPHERE_RADIUS());

      fill(70, 20, 150, 180);
      renderSphere(points2.get(i), this.SPHERE_RADIUS());
    }
  }
}
