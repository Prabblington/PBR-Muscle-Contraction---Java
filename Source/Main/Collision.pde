class Collision extends PerlinNoise {

  private boolean collided = false;
  private float leftBound, rightBound;

  public boolean xForward = true;
  public float speed = 1;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // Collision boolean properties
  public void setCollided(boolean isCollided) {
    this.collided = isCollided;
  }
  public boolean getCollided() {
    return this.collided;
  }

  // Bounds for movement properties
  // Left-most bound
  public void setLeftBound(float left) {
    this.leftBound = left;
  }
  public float getLeftBound() {
    return this.leftBound;
  }

  // Right-most bound
  public void setRightBound(float right) {
    this.rightBound = right;
  }
  public float getRightBound(float right) {
    return this.rightBound;
  }

  // Direction properties
  public void setXForward(boolean isForward) {
    this.xForward = isForward;
  }
  public boolean getXForward() {
    return this.xForward;
  }

  // Movement speed properties
  public void setSpeed(float newSpeed) {
    this.speed = newSpeed;
  }
  public float getSpeed() {
    return this.speed;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Collision() {
    super();
  }
  
  // Checks if current object is colliding with the paramater object using sphere collision detection
  public boolean collides(Protein object1, Protein object2) {
    float d = dist(object1.getPosition().x, object1.getPosition().y, object1.getPosition().z, object2.getPosition().x, object2.getPosition().y, object2.getPosition().z);
    return d < object1.getRadius() + object2.getRadius();
  }
  
  // Updates the object's position to a new one depending on where it currently is
  public void update(Protein object) {
    PVector newPos = object.getPosition();

    if (xForward && object.getPosition().x <  leftBound) {
      newPos.x += speed;
    } else if (xForward && object.getPosition().x ==  rightBound) {
      newPos.x -= speed;
    } else {
      xForward = true;
      speed = +speed;
    }
    
    object.setPosition(newPos.x, newPos.y, newPos.z);
  }
  
}
