class PerlinNoise {
  private float perlinHeight;

  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // Perlin density properties
  public void setPerlinHeight(float newHeight) {
    this.perlinHeight = newHeight;
  }
  public float getPerlinHeight() {
    return this.perlinHeight;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  // Default the perlinHeight to 12
  public PerlinNoise() {
    this.perlinHeight = 12;
  }

  // CONVERT FLOAT[][] TO PVECTOR
  // FIND NORMAL USING NORMALIZE()
  // APPLY PERLIN TO NORMALIZE() DIRECTION
  // Set perlin noise values once so values don't change constantly throughout draw()
  public void applyPerlin(ArrayList<PVector> originalPoints) {
    for (int i = 0; i < originalPoints.size(); i++) {
      PVector tempCoords = new PVector(originalPoints.get(i).x, originalPoints.get(i).y, originalPoints.get(i).z);

      tempCoords.normalize();
      float noise = noise(i) * perlinHeight * 0.9;

      tempCoords.mult(noise);
      originalPoints.get(i).add(tempCoords);
    }
  }
}
