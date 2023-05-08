class Myosin extends MeshRenderer {
  private PShape shape;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  public PShape getShape() {
    return this.shape;
  }
  public void setShape(PShape newShape) {
    this.shape = newShape;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Empty constructor
  public Myosin() {
    super();
  }

  // Constructor for myosin head and tropomyosin
  public Myosin(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

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

  public ArrayList<PVector> formMyosinHeadConnection(PVector s, PVector e, float spacing) {
    ArrayList<PVector> points = new ArrayList<PVector>();

    PVector startPos = new PVector(s.x + spacing, s.y + spacing, s.z);
    PVector endPos = new PVector(e.x + spacing, e.y + spacing, e.z);
    PVector midPoint = new PVector((startPos.x + endPos.x) /2, (startPos.y + endPos.y) / 2, startPos.z);

    points.add(startPos);
    for (float t = 0.1f; t < 1.0f; t += 0.1f) {

      if (t > 1.0f) {
        t = 1.0f;
      }

      PVector point = PVector.lerp(startPos, midPoint, t);
      point.y += (1 - t) * (1 - t) * (endPos.y - startPos.y) + t * t * (midPoint.y - startPos.y);
      points.add(point);
    }
    points.add(endPos);

    return points;
  }

  public void renderMyosinHeadConnection(PVector startPos, PVector endPos) {
    noFill();
    stroke(#6F4040);
    strokeWeight(3);

    PShape connection = generateBezierStructure(formMyosinHeadConnection(startPos, endPos, 0));
    renderMeshShape(connection, new PVector(endPos.x + (getRadius()/2), -10, 0));
  }
}
