class Collision extends PerlinNoise {

  private boolean collided = false;
  private float leftBound, rightBound;

  public boolean xForward = true;
  public float speed = 8;

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
  public float getRightBound() {
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
  public boolean checkCollision(Protein object1, Protein object2) {
    float d = dist(object1.getPosition().x, object1.getPosition().y, object1.getPosition().z, object2.getPosition().x, object2.getPosition().y, object2.getPosition().z);
    return d < object1.getRadius() + object2.getRadius();
  }
  
  // Updates the object's position to a new one depending on where it currently is
  public PVector update(PVector oldPoint) {
    PVector newPos = oldPoint;
    
    // If forward and x is not at rightBound, keep going
    if (xForward && oldPoint.x <  rightBound) {
      newPos.x += speed;
    } 
    // Else if going forward and x reaches rightBound, reverse
    else if (xForward && oldPoint.x >=  rightBound) {
      newPos.x -= speed;
      xForward = false;
    }
    // Else if not going forward and x is greater than leftBound, keep reversing
    else if(!xForward && oldPoint.x >= leftBound)  {
      newPos.x -= speed;
    }
    // Otherwise, it's going forward, reset speed to positive
    else {
      xForward = true;
      speed = +speed;
    }
    
    return new PVector(newPos.x, newPos.y, newPos.z);
  }
  
}
