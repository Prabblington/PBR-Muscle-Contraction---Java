class Actin extends ShapeRenderer {

  private final int NUM_SPHERES, SPHERE_RADIUS;
  private final float X_START, SPACING, SIN_COS_VAL;

  private ArrayList<PVector> points1;
  private ArrayList<PVector> points2;

  // ------------------------------ GETTERS AND SETTERS ------------------------------



  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Actin() {
    points1 = new ArrayList<PVector>();
    points2 = new ArrayList<PVector>();
    
    this.NUM_SPHERES = 30;
    this.X_START = -600;
    this.SPHERE_RADIUS = 30;
    this.SIN_COS_VAL = 0.053;
    this.SPACING = SPHERE_RADIUS * 1.05;
  }

  private void generateStruct1() {
    float x = X_START;
    float y = 0;
    float z = 0;

    for (int i = 0; i < NUM_SPHERES; i++) {
      points1.add(new PVector(x, y, z));
      x += SPACING;
      y = sin(x * SIN_COS_VAL) * SPACING;
      z = cos(x * SIN_COS_VAL) * SPACING;
    }
  }

  private void generateStruct2() {
    float x = X_START;
    float y = 0;
    float z = 0;

    for (int i = 0; i < NUM_SPHERES; i++) {
      points2.add(new PVector(x, y, z));
      x += SPACING;
      y = -sin(x * SIN_COS_VAL) * SPACING;
      z = -cos(x * SIN_COS_VAL) * SPACING;
    }
  }
}
