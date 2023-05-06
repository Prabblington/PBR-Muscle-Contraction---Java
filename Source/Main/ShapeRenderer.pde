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

  // helicalPointsGenerator():
  // Returns an ArrayList of points for a helical structure
  // along the x value, left to right
  // ----
  // isPositive refers to the initial direction of the spiral for the helical structures
  // if positive, points will spiral along the x-axis with positive sin and cos waves
  // else - these values become negative to spiral and wrap the other way
  public ArrayList<PVector> helicalPointsGenerator(int direction, int amount, float SIN_COS_VAL, float SPACING, float xStart, float yStart) {
    boolean isPositive = false;
    float x = xStart;
    float y = yStart;
    float z = 0;

    ArrayList<PVector> points = new ArrayList<PVector>();

    switch(direction) {
    case 1:
      isPositive = true;
      break;
    case 2:
      isPositive = false;
      break;
    default:
      System.out.println("Invalid choice, you must pick 1 (positive) or 2 (negative)");
      break;
    }

    if (isPositive) {
      for (int i = 0; i < amount; i++) {
        points.add(new PVector(x, y, z));
        x += SPACING * 1.63;
        y = -sin(x * SIN_COS_VAL) * SPACING;
        z = -cos(x * SIN_COS_VAL) * SPACING;
      }

      return points;
    } else if (!isPositive) {
      for (int i = 0; i < amount; i++) {
        points.add(new PVector(x, y, z));
        x += SPACING * 1.63;
        y = sin(x * SIN_COS_VAL) * SPACING;
        z = cos(x * SIN_COS_VAL) * SPACING;
      }

      return points;
    }
    return null;
  }
  
  // Renders 6 sided 3D shape
  public void renderQuadShape(ArrayList<PVector> vertices) {
    // Define the indices for each face
    int[][] faces = {
      {0, 1, 2, 3}, // Front face
      {4, 5, 6, 7}, // Back face
      {3, 2, 6, 7}, // Top face
      {0, 1, 5, 4}, // Bottom face
      {0, 3, 7, 4}, // Left face
      {1, 2, 6, 5}  // Right face
    };

    PShape customShape = createShape();
    customShape.beginShape(QUADS);

    for (int i = 0; i < faces.length; i++) {
      int[] face = faces[i];
      for (int j = 0; j < face.length; j++) {
        PVector vertex = vertices.get(face[j]);
        customShape.vertex(vertex.x, vertex.y, vertex.z);
      }
    }

    customShape.endShape(CLOSE);

    pushMatrix();
    translate(400, 250, 0);
    shape(customShape, 0, 0); //display
    popMatrix();
  }

  // Renders any specified shape using vertex custom creation
  public void renderCustomVertex(ArrayList<PVector> ver) {
    PShape customShape = createShape();

    customShape.beginShape();
    for (int i = 0; i < ver.size(); i++) {
      customShape.vertex(ver.get(i).x, ver.get(i).y, ver.get(i).z);
    }
    customShape.endShape(CLOSE);
    pushMatrix();
    translate(400, 350, 0);
    shape(customShape, 0, 0); //display
    popMatrix();
  }

  // Renders anything spherical
  public void renderSphere(PVector pos, float radius) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }
}
