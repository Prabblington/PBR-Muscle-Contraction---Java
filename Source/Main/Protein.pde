abstract class Protein extends Collision {
  private final float SIN_COS_VAL = 0.019;

  private ArrayList<PVector> points;

  private float xStart, yStart;
  private PVector position;
  
  private float spacing;
  private float radius;
  private int numPoints;
  private int amount;
  private float objectHeight;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // Position properties
  public void setPosition(float x, float y, float z) {
    this.position.set(x, y, z);
  }
  public PVector getPosition() {
    return this.position;
  }

  // Number of objects to spawn properties
  public void setAmount(int num) {
    this.amount = num;
  }
  public int getAmount() {
    return this.amount;
  }

  // X start properties
  public void setXStart(float xPos) {
    this.xStart = xPos;
  }
  public float getXStart() {
    return this.xStart;
  }

  // Y start properties
  public void setYStart(float yPos) {
    this.yStart = yPos;
  }
  public float getYStart() {
    return this.yStart;
  }

  // Sphere radius properties
  public void setRadius(float newRadius) {
    this.radius = newRadius;
  }
  public float getRadius() {
    return this.radius;
  }

  // Points generated for globes
  public void setNumPoints(int num) {
    this.numPoints = num;
  }
  public int getNumPoints() {
    return this.numPoints;
  }

  // Myosin thick filament height properties
  public float getHeight() {
    return this.objectHeight;
  }
  public void setHeight(float newHeight) {
    this.objectHeight = newHeight;
  }

  // Helical structure points properties
  public ArrayList<PVector> getPoints() {
    return this.points;
  }
  public void setPoints(ArrayList<PVector> newPoints) {
    this.points = newPoints;
  }
  public float SIN_COS_VAL() {
    return this.SIN_COS_VAL;
  }
  public float getSpacing() {
    return this.spacing;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Protein() {
    points = new ArrayList<PVector>();

    this.position = new PVector(0, 0, 0);
    this.radius = 0;
  }

  //Actin generation  
  public Protein(PVector pos, int amount, int r) {
    points = new ArrayList<PVector>();

    this.position = pos;
    this.xStart = pos.x;
    this.yStart = pos.y;

    this.amount = amount;
    this.radius = r;
    this.spacing = r * 1.05;
  }
  // Myosin heads generation
  public Protein(PVector pos, float r, int initPoints) {
    super();
    points = new ArrayList<PVector>();

    this.position = new PVector(pos.x, pos.y, pos.z);
    this.xStart = pos.x;
    this.yStart = pos.y;
    this.radius = r;
    this.numPoints = initPoints;
  }
  // Constructor for myosin filament
  public Protein(PVector pos, int initNumPoints) {
    super();
    points = new ArrayList<PVector>();

    this.xStart = pos.x;
    this.yStart = pos.y;
    this.position = new PVector(pos.x, pos.y, pos.z);
    setAmount(initNumPoints);
    setNumPoints(initNumPoints);
  }

  public void coordinateGenerator() {
  }

  public void displayShape() {
  }

  //public void findBounds() {
  //  float modifier = 10;

  //  float maxY = Float.NEGATIVE_INFINITY;
  //  float minY = Float.POSITIVE_INFINITY;

  //  ArrayList<PVector> points = getPoints();

  //  for (int i = 0; i < points.size(); i++) {
  //    if (points.get(i).y < minY) {    // If the current point's y value is smaller than minY
  //      minY = points.get(i).y;        // Update minY to the current point's y value
  //    }
  //    if (points.get(i).y >= maxY) {    // If current point's y value is bigger than maxY
  //      maxY = points.get(i).y;        // Update maxY to current point's value
  //    }
  //  }

  //  setUpperBound(maxY + modifier);
  //  setLowerBound(minY - modifier);

  //  setForwardBound(maxY + modifier);
  //  setBackwardBound(minY - modifier);
  //}
}
