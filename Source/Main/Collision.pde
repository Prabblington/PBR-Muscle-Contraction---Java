class Collision extends Protein  {
 
  public Collision()  {
    super();
  }
  
  boolean intersects(Sphere other) {
    float d = dist(x, y, z, other.x, other.y, other.z);
    return d < r + other.r;
  }
}
