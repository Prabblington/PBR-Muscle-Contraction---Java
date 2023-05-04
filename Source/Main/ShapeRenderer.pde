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

  ShapeRenderer(float x, float y, float z, float radius) {
    position = new PVector(x, y, z);
    this.radius = radius;
  }

  public void renderSphere(float x, float y, float z, float radius) {
    pushMatrix();
    translate(x, y, z);
    sphere(radius);
    popMatrix();
  }
}
