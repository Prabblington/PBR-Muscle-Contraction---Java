class MyosinHead extends Myosin {

  public MyosinHead(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  @Override
    public void coordinateGenerator() {
    strokeWeight(0.5);
    fill(180, 135, 135, 100);
    stroke(118, 67, 67);

    PShape s = this.renderMeshGlobe(true, false);
    s.rotateY(HALF_PI);

    setShape(s);
  }

  @Override
    public void displayShape() {
    renderMeshShape(getShape(), getPosition());
  }

  @Override
    PVector update(PVector oldPoint)  {
      // This function moves the myosin heads
      return new PVector(0,0,0); //TEMP, NEEDS CHANGING 
  }
}
