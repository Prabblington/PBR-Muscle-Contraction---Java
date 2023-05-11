class Collision extends PerlinNoise {

  private boolean collided = false;
  private float leftBound, rightBound; // upperBound, lowerBound, forwardBound, backwardBound;

  private boolean xForward = true;
  private boolean yUp = true;
  private boolean zForward = true;
  private float xSpeed = 0.2;
  //private float ySpeed = 0.5;
  //private float zSpeed = 0.5;

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

  //// Upper-most bound
  //public void setUpperBound(float up) {
  //  this.upperBound = up;
  //}
  //public float getUpperBound() {
  //  return this.upperBound;
  //}

  //// Lower-most bound
  //public void setLowerBound(float down) {
  //  this.lowerBound = down;
  //}
  //public float getLowerBound() {
  //  return this.lowerBound;
  //}
  
  //// Forward-most bound
  //public void setForwardBound(float forward)  {
  // this.forwardBound = forward;
  //}
  //public float getForwardBound()  {
  // return this.forwardBound; 
  //}
  
  //// Backward bound
  //public void setBackwardBound(float backward)  {
  // this.backwardBound = backward;
  //}
  //public float getBackwardBound()  {
  // return this.backwardBound; 
  //}

  // Direction properties
  public void setXForward(boolean isForward) {
    this.xForward = isForward;
  }
  public boolean getXForward() {
    return this.xForward;
  }

  // Movement speed properties
  // X speed
  public void setXSpeed(float newSpeed) {
    this.xSpeed = newSpeed;
  }
  public float getXSpeed() {
    return this.xSpeed;
  }
  //// Y speed
  //public void setYSpeed(float newSpeed) {
  //  this.ySpeed = newSpeed;
  //}
  //public float getYSpeed() {
  //  return this.ySpeed;
  //}
  //// Z speed
  //public void setZSpeed(float newSpeed) {
  //  this.zSpeed = newSpeed;
  //}
  //public float getZSpeed() {
  //  return this.zSpeed;
  //}

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
  public PVector update(PVector oldPoint)  { //, boolean canMoveYZ) {
    PVector newPos = oldPoint;

    // X MOVEMENT
    // If forward and x is not at rightBound, keep going
    if (xForward && oldPoint.x < rightBound) {
      newPos.x += xSpeed;
    }
    // Else if going forward and x reaches rightBound, reverse
    else if (xForward && oldPoint.x >= rightBound) {
      newPos.x -= xSpeed;
      xForward = false;
    }
    // Else if not going forward and x is greater than leftBound, keep reversing
    else if (!xForward && oldPoint.x >= leftBound) {
      newPos.x -= xSpeed;
    }
    // Otherwise, it's going forward, reset speed to positive
    else {
      xForward = true;
      xSpeed = + xSpeed;
    }

    //// If the object can move along Y and Z axis, update positions
    //if (canMoveYZ) {
    //  // If forward and x is not at rightBound, keep going
    //  if (yUp && oldPoint.y < upperBound) {
    //    newPos.y += ySpeed;
    //  }
    //  // Else if going forward and x reaches rightBound, reverse
    //  else if (yUp && oldPoint.y >= upperBound) {
    //    newPos.y -= ySpeed;
    //    yUp = false;
    //  }
    //  // Else if not going forward and x is greater than leftBound, keep reversing
    //  else if (!yUp && oldPoint.y >= lowerBound) {
    //    newPos.y -= ySpeed;
    //  }
    //  // Otherwise, it's going forward, reset speed to positive
    //  else {
    //    yUp = true;
    //    ySpeed = + ySpeed;
    //  }
    //  // If forward and x is not at rightBound, keep going
    //  if (zForward && oldPoint.y < forwardBound) {
    //    newPos.z += zSpeed;
    //  }
    //  // Else if going forward and x reaches rightBound, reverse
    //  else if (zForward && oldPoint.z >= forwardBound) {
    //    newPos.z -= zSpeed;
    //    zForward = false;
    //  }
    //  // Else if not going forward and x is greater than leftBound, keep reversing
    //  else if (!zForward && oldPoint.z >= backwardBound) {
    //    newPos.z -= zSpeed;
    //  }
    //  // Otherwise, it's going forward, reset speed to positive
    //  else {
    //    zForward = true;
    //    zSpeed = + zSpeed;
    //  }
    //}

    return newPos;
  }
}
