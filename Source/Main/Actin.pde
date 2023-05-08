class Actin extends MeshRenderer {

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(float initX, float initY) {
    super(initX, initY);
    this.populateStruct1Points(this.helicalPointsGenerator(true, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), initX, initY ));
    this.populateStruct2Points(this.helicalPointsGenerator(false, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), initX, initY ));
  }
  
}
