class MyosinFilament extends Myosin  {
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------
  
  // Empty constructor
  public MyosinFilament() {
    super();
  }

  // Constructor for myosin
  public MyosinFilament(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }
  
  @Override
  public void coordinateGenerator()  {
    PShape s = generateMeshCylinder(getNumPoints(), getHeight());
    s.rotateY(HALF_PI);
    
    setShape(s);
  }
  
  @Override
  public void displayShape()  {
    renderMeshShape(getShape(), getPosition());
  }
}
