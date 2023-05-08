class Tropomyosin extends Myosin {
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Tropomyosin() {
    super();
  }

  // Constructor for myosin
  public Tropomyosin(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

  @Override
    public void coordinateGenerator() {
    noFill();
    stroke(255, 255, 0);
    strokeWeight(15);
    
    populateStruct1Points(helicalPointsGenerator(true, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), this.getXStart(), this.getYStart() ));
    populateStruct2Points(helicalPointsGenerator(false, this.NUM_SPHERES(), this.SIN_COS_VAL(), this.SPACING(), this.getXStart(), this.getYStart() ));
    
    PShape s = generateHelicalBezier(getStruct1Points());
    //s.rotateY(HALF_PI);

    setShape(s);
  }

  @Override
    public void displayShape() {
    renderMeshShape(getShape(), getPosition());
  }
}
