class Collision extends Protein {
  
  private boolean collided = false;
  
  // ------------------------------ GETTERS AND SETTERS ------------------------------
  
  public void setCollided(boolean isCollided)  {
   this.collided = isCollided; 
  }
  public boolean getCollided()  {
   return this.collided; 
  }
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------
  
  public Collision() {
    super();
  }

  boolean collides(ArrayList<? extends Protein> object) {
    float d = dist(getPosition().x, getPosition().y, getPosition().z, object.getPosition().x, object.getPosition().y, object.getPosition().z);
    return d < getRadius() + object.getRadius();
  }

  public PVector update(Protein) {
    if (xForward && this.getPosition().x <  0 - myosinFilament.getHeight/2) {
    }
  }
}
