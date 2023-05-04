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

  public void renderSphere(PVector pos, float radius) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }
}
