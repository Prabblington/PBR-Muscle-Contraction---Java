class MyosinHead extends Myosin {

  public MyosinHead(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------  

  @Override
    public void coordinateGenerator() {
    strokeWeight(0.5);
    fill(#6F4040);
    stroke(#F7B1B1);

    PShape s = this.renderMeshGlobe(true, false);
    s.rotateY(HALF_PI);

    setShape(s);
  }  

  @Override
    public void displayShape() {
    renderMeshShape(getShape(), getPosition());
  }
}
