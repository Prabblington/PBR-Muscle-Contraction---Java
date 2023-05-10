class Collision extends Protein  {
 
  public Collision()  {
    super();
  }
  
  boolean collides(Protein object) {
    float d = dist(getPosition().x, getPosition().y, getPosition().z, object.getPosition().x, object.getPosition().y, object.getPosition().z);
    return d < getRadius() + object.getRadius();
  }
}
