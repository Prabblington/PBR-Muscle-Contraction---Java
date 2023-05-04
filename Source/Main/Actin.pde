class Actin extends ShapeRenderer {

  private final int NUM_SPHERES = 22;
  private final int SPHERE_RADIUS = 30;
  private final float SPACING = SPHERE_RADIUS * 1.05;
  //1.05
  private final float SIN_COS_VAL = 0.019;
  //0.053

  private float xStart, yStart;

  private ArrayList<PVector> points1;
  private ArrayList<PVector> points2;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  public ArrayList<PVector> getStruct1Points() {
    return this.points1;
  }
  public ArrayList<PVector> getStruct2Points() {
    return this.points2;
  }

  public int NUM_SPHERES() {
    return this.NUM_SPHERES;
  }
  public int SPHERE_RADIUS() {
    return this.SPHERE_RADIUS;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(float initX, float initY) {
    super();

    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    this.xStart = initX;
    this.yStart = initY;

    points1 = this.helicalPointsGenerator(1, NUM_SPHERES, SIN_COS_VAL, SPACING, xStart, yStart);
    points2 = this.helicalPointsGenerator(2, NUM_SPHERES, SIN_COS_VAL, SPACING, xStart, yStart);
  }
}
