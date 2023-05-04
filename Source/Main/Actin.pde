class Actin extends ShapeRenderer {

  private final int NUM_SPHERES = 30;
  private final int SPHERE_RADIUS = 30;
  private final float SPACING = SPHERE_RADIUS * 1.05;
  private final float SIN_COS_VAL = 0.053;
  
  private float xStart, yStart;

  private ArrayList<PVector> points1;
  private ArrayList<PVector> points2;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  public ArrayList<PVector> getStruct1Points()  {
   return this.points1; 
  }
  public ArrayList<PVector> getStruct2Points()  {
   return this.points2; 
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin(float initX, float initY) {
    super();

    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();

    //this.X_START = -600;
    this.xStart = initX;
    this.yStart = initY;

    this.generateStruct1();
    this.generateStruct2();
  }

  // Generates a value of positions forming a helical form
  // along the x value, left to right
  private void generateStruct1() {
    float x = xStart;
    float y = yStart;
    float z = 0;

    for (int i = 0; i < NUM_SPHERES; i++) {
      points1.add(new PVector(x, y, z));
      x += SPACING;
      y = sin(x * SIN_COS_VAL) * SPACING;
      z = cos(x * SIN_COS_VAL) * SPACING;
    }
  }

  // Generates a value of positions forming a helical form
  // along the x value, left to right which intertwines with struct1
  private void generateStruct2() {
    float x = xStart;
    float y = yStart;
    float z = 0;

    for (int i = 0; i < NUM_SPHERES; i++) {
      points2.add(new PVector(x, y, z));
      x += SPACING;
      y = -sin(x * SIN_COS_VAL) * SPACING;
      z = -cos(x * SIN_COS_VAL) * SPACING;
    }
  }
}
