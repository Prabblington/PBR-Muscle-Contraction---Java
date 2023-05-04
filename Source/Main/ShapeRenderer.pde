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

  ShapeRenderer(PVector position, float radius) {
    position = new PVector(position.x, position.y, position.z);
    this.radius = radius;
  }

  public void renderSphere(PVector position, float radius) {
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(radius);
    popMatrix();
  }
}
