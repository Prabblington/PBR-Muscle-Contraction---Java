class MeshRenderer {

  private PVector position;
  private float radius;

  private int vertexGap;
  private float perlinHeight;

  private int[] meshDimensions;
  //private float[][] perlin;
  private ArrayList<PVector> globeCoordinates, capsuleCoordinates;
  private int numPoints;


  // ------------------------------ GETTERS AND SETTERS ------------------------------

  // Position properties
  public void setPosition(float x, float y, float z) {
    this.position.set(x, y, z);
  }
  public PVector getPosition() {
    return this.position;
  }

  // Sphere radius properties
  public void setRadius(float newRadius) {
    this.radius = newRadius;
  }
  public float getRadius() {
    return this.radius;
  }

  // Perlin density properties
  public void setPerlinHeight(float newHeight) {
    this.perlinHeight = newHeight;
  }
  public float getPerlinHeight() {
    return this.perlinHeight;
  }

  // Mesh properties
  public void setMeshDimensions(int[] newDims) {
    this.meshDimensions = newDims;
  }
  public int[] getMeshDimensions() {
    return this.meshDimensions;
  }

  // Points generated for globes
  public void setNumPoints(int num) {
    this.numPoints = num;
  }
  public int getNumPoints() {
    return this.numPoints;
  }

  // Scale properties
  public void setVertexGap(int newVertexGap) {
    this.vertexGap = newVertexGap;
  }
  public float getVertexGap() {
    return this.vertexGap;
  }

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public MeshRenderer() {
    position = new PVector(0, 0, 0);
    this.radius = 0;
  }

  // Generate and render a mesh capsule
  public void renderMeshCapsule(PVector location, int stepSize, float h) {
    capsuleCoordinates = new ArrayList<PVector>();

    // Calculate sin and cos values for each step so we don't have to re-do it
    float[] sinVals = new float[360 / stepSize + 1];
    float[] cosVals = new float[360 / stepSize + 1];

    for (int i = 0; i < sinVals.length; i++) {
      float angle = radians(i * stepSize - 180);
      sinVals[i] = sin(angle);
      cosVals[i] = cos(angle);
    }

    // Init capsule body as a GROUP shape
    PShape capsule = createShape(GROUP);
    capsule.beginShape();

    PShape capsuleBody = createShape();
    capsuleBody.beginShape(TRIANGLE_STRIP);

    // Generate cylinder body vertices
    for (int i = 0; i < sinVals.length; i++) {
      float x = radius * cosVals[i];
      float z = radius * sinVals[i];
      float y1 = -h / 2;
      float y2 = y1 + h;

      capsuleBody.vertex(x, y1, z);
      capsuleBody.vertex(x, y2, z);

      capsuleCoordinates.add(new PVector(x, y1, z));
      capsuleCoordinates.add(new PVector(x, y2, z));
    }
    capsuleBody.endShape(CLOSE);
    capsule.addChild(capsuleBody);

    PShape capsuleTop = createShape();
    capsuleTop.beginShape(TRIANGLE_FAN);

    // Draw top cap vertices
    float yTop = -h / 2;
    capsuleTop.vertex(0, yTop, 0);
    capsuleCoordinates.add(new PVector(0, yTop, 0));

    for (int i = 0; i < sinVals.length; i++) {
      float x = radius * cosVals[i];
      float z = radius * sinVals[i];

      capsuleTop.vertex(x, yTop, z);
      capsuleCoordinates.add(new PVector(x, yTop, z));
    }
    capsuleTop.endShape(CLOSE);
    capsule.addChild(capsuleTop);

    PShape capsuleBottom = createShape();
    capsuleBottom.beginShape(TRIANGLE_FAN);

    // Draw bottom cap vertices
    float yBottom = h / 2;
    capsuleBottom.vertex(0, yBottom, 0);
    capsuleCoordinates.add(new PVector(0, yBottom, 0));

    for (int i = sinVals.length - 1; i >= 0; i--) {
      float x = radius * cosVals[i];
      float z = radius * sinVals[i];

      capsuleBottom.vertex(x, yBottom, z);
      capsuleCoordinates.add(new PVector(x, yBottom, z));
    }
    capsuleBottom.endShape(CLOSE);
    capsule.addChild(capsuleBottom);

    // RENDER
    pushMatrix();
    translate(location.x, location.y, location.z);
    capsule.rotateY(PI/2);
    shape(capsule, 0, 0);
    popMatrix();
  }


  // Generates cylinder co-ordinates
  public void renderMeshCylinder(PVector location, int sides, float h) {
    capsuleCoordinates = new ArrayList<PVector>();
    PShape cylinder = createShape(GROUP);

    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    PShape cylinderTop = createShape();
    cylinderTop.beginShape();

    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderTop.vertex( x, y, -halfHeight);

      capsuleCoordinates.add(new PVector(x, y, -halfHeight));
    }
    cylinderTop.endShape(CLOSE);
    cylinder.addChild(cylinderTop);

    // draw bottom of the tube
    PShape cylinderBottom = createShape();
    cylinderBottom.beginShape();

    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderBottom.vertex( x, y, halfHeight);

      capsuleCoordinates.add(new PVector(x, y, -halfHeight));
    }
    cylinderBottom.endShape(CLOSE);
    cylinder.addChild(cylinderBottom);


    // draw sides
    PShape cylinderBody = createShape();
    cylinderBody.beginShape(TRIANGLE_STRIP);

    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderBody.vertex( x, y, halfHeight);
      cylinderBody.vertex( x, y, -halfHeight);

      capsuleCoordinates.add(new PVector(x, y, halfHeight));
      capsuleCoordinates.add(new PVector(x, y, -halfHeight));
    }
    cylinderBody.endShape(CLOSE);
    cylinder.addChild(cylinderBody);

    this.applyPerlin(capsuleCoordinates);

    pushMatrix();
    translate(location.x, location.y, location.z);
    cylinder.rotateY(PI/2);
    shape(cylinder, 0, 0);
    popMatrix();
  }


  // Renders the mesh globe as a custom shape
  public void renderMeshGlobe(PVector location, boolean isFull) {
    if (isFull) {
      this.generateMeshGlobe();
    } else {
      this.generateMeshHalfGlobe();
    }

    PShape customShape = createShape();
    customShape.beginShape(TRIANGLE_STRIP);

    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        // These vertices form a square on the globe's surface
        // -- top left
        customShape.vertex(globeCoordinates.get(i * numPoints + j).x,
          globeCoordinates.get(i * numPoints + j).y,
          globeCoordinates.get(i * numPoints + j).z);
        // -- bottom left
        customShape.vertex(globeCoordinates.get((i + 1) % numPoints * numPoints + j).x,
          globeCoordinates.get((i + 1) % numPoints * numPoints + j).y,
          globeCoordinates.get((i + 1) % numPoints * numPoints + j).z);
        // -- top right
        customShape.vertex(globeCoordinates.get(i * numPoints + (j + 1) % numPoints).x,
          globeCoordinates.get(i * numPoints + (j + 1) % numPoints).y,
          globeCoordinates.get(i * numPoints + (j + 1) % numPoints).z);
        // -- bottom right
        customShape.vertex(globeCoordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).x,
          globeCoordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).y,
          globeCoordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).z);
      }
    }
    customShape.endShape(CLOSE);

    pushMatrix();
    translate(location.x, location.y, location.z);
    shape(customShape, 0, 0); //display
    popMatrix();
  }

  // Generates the co-ordinates for a mesh globe
  private void generateMeshGlobe() {
    globeCoordinates = new ArrayList<PVector>();

    for (int i = 0; i < numPoints; i++) {
      float theta = map(i, 0, numPoints, 0, TWO_PI); // angle around the sphere
      for (int j = 0; j < numPoints; j++) {
        float phi = map(j, 0, numPoints, 0, PI); // angle from the top of the sphere
        float x = radius * sin(phi) * cos(theta); // calculate x coordinate
        float y = radius * sin(phi) * sin(theta); // calculate y coordinate
        float z = radius * cos(phi); // calculate z coordinate

        PVector coordinate = new PVector(x, y, z);

        globeCoordinates.add(coordinate);
      }
    }
    this.applyPerlin(globeCoordinates);
  }

  // Generates the co-ordinates for a mesh globe
  private void generateMeshHalfGlobe() {
    globeCoordinates = new ArrayList<PVector>();
    //globePoints = new float[numPoints * numPoints][3]; // array to hold the points

    for (int i = 0; i < numPoints; i++) {
      float theta = map(i, 0, numPoints, 0, PI); // angle around the sphere
      for (int j = 0; j < numPoints; j++) {
        float phi = map(j, 0, numPoints, 0, HALF_PI); // angle from the top of the sphere
        float x = radius * sin(phi) * cos(theta); // calculate x coordinate
        float y = radius * sin(phi) * sin(theta); // calculate y coordinate
        float z = radius * cos(phi); // calculate z coordinate

        PVector coordinate = new PVector(x, y, z);

        globeCoordinates.add(coordinate);
      }
    }
    this.applyPerlin(globeCoordinates);
  }

  // CONVERT FLOAT[][] TO PVECTOR
  // FIND NORMAL USING NORMALIZE()
  // APPLY PERLIN TO NORMALIZE() DIRECTION
  // Set perlin noise values once so values don't change constantly throughout draw()
  private void applyPerlin(ArrayList<PVector> originalPoints) {
    for (int i = 0; i < originalPoints.size(); i++) {
      PVector tempCoords = new PVector(originalPoints.get(i).x, originalPoints.get(i).y, originalPoints.get(i).z);

      tempCoords.normalize();
      float noise = noise(i) * perlinHeight;

      tempCoords.mult(noise);
      originalPoints.get(i).add(tempCoords);
    }
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

  // Renders anything spherical
  public void renderSphere(PVector pos, float radius) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }
}
