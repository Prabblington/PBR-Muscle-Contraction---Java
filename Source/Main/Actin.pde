class Actin extends MeshRenderer {

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(float initX, float initY) {
    super(initX, initY);
  }

  @Override
    public void coordinateGenerator() {
    this.populateStruct1Points(this.helicalPointsGenerator(true, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), this.getXStart(), this.getYStart() ));
    this.populateStruct2Points(this.helicalPointsGenerator(false, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), this.getXStart(), this.getYStart() ));
  }

  @Override
    public void displayShape() {
    for (int i = 0; i < actin.NUM_SPHERES(); i++) {
      ArrayList<PVector> points1 = this.getStruct1Points();
      ArrayList<PVector> points2 = this.getStruct2Points();

      fill(255, 0, 255);
      actin.renderSphere(points1.get(i), this.SPHERE_RADIUS());

      fill(70, 20, 150);
      actin.renderSphere(points2.get(i), this.SPHERE_RADIUS());
    }
  }
}
