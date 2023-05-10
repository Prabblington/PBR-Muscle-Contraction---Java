abstract class Protein extends Collision {

  // FOR ACTIN MAINLY
  private final int NUM_SPHERES = 22;
  private final int SPHERE_RADIUS = 30;
  private final float SPACING = SPHERE_RADIUS * 1.05;
  private final float SIN_COS_VAL = 0.019;

  private float xStart, yStart;

  private ArrayList<PVector> points1;
  private ArrayList<PVector> points2;

  private PVector position;
  private float radius;
  private int numPoints;
  private int numObjects;
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
  public void setNumObjects(int num) {
    this.numObjects = num;
  }
  public int getNumObjects() {
    return this.numObjects;
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
  public ArrayList<PVector> getStruct1Points() {
    return this.points1;
  }
  public ArrayList<PVector> getStruct2Points() {
    return this.points2;
  }
  public void populateStruct1Points(ArrayList<PVector> generatedPoints) {
    this.points1 = generatedPoints;
  }
  public void populateStruct2Points(ArrayList<PVector> generatedPoints) {
    this.points2 = generatedPoints;
  }

  // Finalised temp properties for actin
  public int NUM_SPHERES() {
    return this.NUM_SPHERES;
  }
  public int SPHERE_RADIUS() {
    return this.SPHERE_RADIUS;
  }
  public float SIN_COS_VAL() {
    return this.SIN_COS_VAL;
  }
  public float SPACING() {
    return this.SPACING;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Protein() {
    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    this.position = new PVector(0, 0, 0);
    this.radius = 0;
  }

  //Actin generation
  public Protein(PVector pos) {
    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    this.position = pos;
    this.xStart = pos.x;
    this.yStart = pos.y;
  }
  // Myosin heads generation
  public Protein(PVector pos, float r, int initPoints) {
    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    this.position = new PVector(pos.x, pos.y, pos.z);
    this.xStart = pos.x;
    this.yStart = pos.y;
    this.radius = r;
    this.numPoints = initPoints;
  }
  // Constructor for myosin filament
  public Protein(PVector pos, int initNumPoints) {
    super();
    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    this.xStart = pos.x;
    this.yStart = pos.y;
    this.position = new PVector(pos.x, pos.y, pos.z);
    setNumPoints(initNumPoints);
  }

  public void coordinateGenerator() {
  }

  public void displayShape() {
  }
}
