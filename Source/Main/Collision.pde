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
  public void setXForward(boolean isForward)  {
   this.xForward = isForward; 
  }
  public boolean getXForward()  {
    return this.xForward;
  }
  
  // Movement speed properties
  public void setSpeed(float newSpeed)  {
   this.speed = newSpeed; 
  }
  public float getSpeed()  {
   return this.speed; 
  }  

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public Collision() {
    super();
  }

  public boolean collides(ArrayList<? extends Protein> object) {
    float d = dist(getPosition().x, getPosition().y, getPosition().z, object.getPosition().x, object.getPosition().y, object.getPosition().z);
    return d < getRadius() + object.getRadius();
  }

  public PVector update(? extends Protein object) {
    PVector newPos = object.getPosition();

    if (xForward && this.getPosition().x <  0 - myosinFilament.getHeight/2) {
      newPos.x += speed;
    } else if (xForward && this.getPosition().x ==  myosinFilament.getHeight) {

      newPos.x -= speed;
    } else {
      xForward = true;
      speed = +speed;
    }
  }
}
