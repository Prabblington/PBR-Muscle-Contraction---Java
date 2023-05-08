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

  //@Override
  //  public void coordinateGenerator() {
  //  fill(#464343);
  //  noStroke();

  //  PShape s = generateMeshCylinder(getNumPoints(), getHeight());
  //  s.rotateY(HALF_PI);

  //  setShape(s);
  //}

  //@Override
  //  public void displayShape() {
  //  renderMeshShape(getShape(), getPosition());
  //}
}
