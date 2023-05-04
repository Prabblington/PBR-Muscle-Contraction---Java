class ShapeRenderer {

  private PVector position;
  private float radius;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // Position properties
  public void setPosition(float x, float y, float z) {
    this.position.set(x, y, z);
  }
  public PVector getPosition() {
    return this.position;
  }

  // Radius properties
  public void setRadius(float radius) {
    this.radius = radius;
  }
  public float setRadius() {
    return this.radius;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public ShapeRenderer() {
    position = new PVector(0, 0, 0);
    this.radius = 0;
  }

  // helicalPointsGenerator():
  // Returns an ArrayList of points for a helical structure
  // along the x value, left to right
  // ----
  // isPositive refers to the initial direction of the spiral for the helical structures
  // if positive, points will spiral along the x-axis with positive sin and cos waves
  // else - these values become negative to spiral and wrap the other way
  public ArrayList<PVector> helicalPointsGenerator(int direction, int amount, float SIN_COS_VAL, float SPACING, float xStart, float yStart) {
    boolean isPositive = false;
    float x = xStart;
    float y = yStart;
    float z = 0;

    ArrayList<PVector> points = new ArrayList<PVector>();

    switch(direction) {
    case 1:
      isPositive = true;
      break;
    case 2:
      isPositive = false;
      break;
    default:
      System.out.println("Invalid choice, you must pick 1 (positive) or 2 (negative)");
      break;
    }

    if (isPositive) {
      for (int i = 0; i < amount; i++) {
        points.add(new PVector(x, y, z));
        x += SPACING * 1.63;
        y = -sin(x * SIN_COS_VAL) * SPACING;
        z = -cos(x * SIN_COS_VAL) * SPACING;
      }

      return points;
    } else if (!isPositive) {
      for (int i = 0; i < amount; i++) {
        points.add(new PVector(x, y, z));
        x += SPACING * 1.63;
        y = sin(x * SIN_COS_VAL) * SPACING;
        z = cos(x * SIN_COS_VAL) * SPACING;
      }

      return points;
    }
    return null;
  }
  // Renders anything rectangular
  public void renderRectangle(PVector pos, float size)  {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(pos.x, pos.y, size);
    popMatrix();
  }

  // Renders anything spherical
  public void renderSphere(PVector pos, float radius) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }
}
