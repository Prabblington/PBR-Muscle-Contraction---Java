class MeshRenderer extends Protein {

  private ArrayList<PVector> coordinates;

  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public MeshRenderer() {
    super();
  }

  public MeshRenderer(PVector initLocation, int initNumPoints) {
    super(initLocation, initNumPoints);
  }

  public MeshRenderer(PVector pos) {
    super(pos);
  }

  public MeshRenderer(PVector pos, float r, int initPoints) {
    super(pos, r, initPoints);
  }

  // Renders shape mesh
  public void renderMeshShape(PShape shape, PVector pos) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    shape(shape, 0, 0);
    popMatrix();
  }

  // Renders a sphere at PVector pos (position) with a defined radius
  public void renderSphere(PVector pos, float radius) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }

  // Generates a helical shape for tropomyosin using quadratic bezier
  public PShape generateBezierStructure(ArrayList<PVector> points) {
    PShape bezier = createShape();
    bezier.beginShape();

    int numPoints = points.size();

    if (numPoints < 3) {
      throw new RuntimeException("Cannot generate a quadratic bezier with less than three points.");
    }

    bezier.vertex(points.get(0).x, points.get(0).y, points.get(0).z);

    for (int i = 1; i < numPoints - 1; i++) {
      PVector p1 = points.get(i - 1);
      PVector p2 = points.get(i);
      PVector p3 = points.get(i + 1);
      PVector c1 = PVector.lerp(p1, p2, 0.5f);
      PVector c2 = PVector.lerp(p2, p3, 0.5f);
      bezier.bezierVertex(c1.x, c1.y, c1.z, p2.x, p2.y, p2.z, c2.x, c2.y, c2.z);
    }
    bezier.vertex(points.get(numPoints - 1).x, points.get(numPoints - 1).y, points.get(numPoints - 1).z);
    bezier.endShape();

    return bezier;
  }

  // Returns a PShape of a defined structure of a cylinder
  public PShape generateMeshCylinder(int sides, float h) {
    PShape cylinder = createShape(GROUP);

    float angle = 360 / sides;
    float halfHeight = h / 2;
    float radius = this.getRadius();

    // Generate top of the tube
    PShape cylinderTop = createShape();
    cylinderTop.beginShape();

    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderTop.vertex( x, y, -halfHeight);
    }
    cylinderTop.endShape(CLOSE);
    cylinder.addChild(cylinderTop);

    // Generate bottom of the tube
    PShape cylinderBottom = createShape();
    cylinderBottom.beginShape();

    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderBottom.vertex( x, y, halfHeight);
    }
    cylinderBottom.endShape(CLOSE);
    cylinder.addChild(cylinderBottom);

    // Generate sides
    PShape cylinderBody = createShape();
    cylinderBody.beginShape(TRIANGLE_STRIP);

    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * radius;
      float y = sin( radians( i * angle ) ) * radius;

      cylinderBody.vertex( x, y, halfHeight);
      cylinderBody.vertex( x, y, -halfHeight);
    }
    cylinderBody.endShape(CLOSE);
    cylinder.addChild(cylinderBody);

    return cylinder;
  }

  // Renders the mesh globe as a custom shape
  public PShape renderMeshGlobe(boolean isFull, boolean isTop) {
    this.generateMeshGlobePoints(isFull, isTop);

    int numPoints = this.getNumPoints();

    PShape globe = createShape();
    globe.beginShape(TRIANGLE_STRIP);

    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        // These vertices form a square on the globe's surface
        // -- top left
        globe.vertex(coordinates.get(i * numPoints + j).x,
          coordinates.get(i * numPoints + j).y,
          coordinates.get(i * numPoints + j).z);
        // -- bottom left
        globe.vertex(coordinates.get((i + 1) % numPoints * numPoints + j).x,
          coordinates.get((i + 1) % numPoints * numPoints + j).y,
          coordinates.get((i + 1) % numPoints * numPoints + j).z);
        // -- top right
        globe.vertex(coordinates.get(i * numPoints + (j + 1) % numPoints).x,
          coordinates.get(i * numPoints + (j + 1) % numPoints).y,
          coordinates.get(i * numPoints + (j + 1) % numPoints).z);
        // -- bottom right
        globe.vertex(coordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).x,
          coordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).y,
          coordinates.get((i + 1) % numPoints * numPoints + (j + 1) % numPoints).z);
      }
    }
    globe.endShape(CLOSE);
    return globe;
  }

  // Generates the co-ordinates for a mesh globe
  private void generateMeshGlobePoints(boolean isFull, boolean isTop) {
    coordinates = new ArrayList<PVector>();
    int numPoints = this.getNumPoints();
    float radius = this.getRadius();

    for (int i = 0; i < numPoints; i++) {
      float theta = map(i, 0, numPoints, 0, (isFull && !isTop) ? TWO_PI : PI);

      for (int j = 0; j < numPoints; j++) {
        // T
        float phi = map(j, 0, numPoints, 0, (isFull && !isTop) ? PI : HALF_PI); // angle from the top of the sphere
        float x = radius * sin(phi) * cos(theta); // calculate x coordinate
        float y = radius * sin(phi) * sin(theta); // calculate y coordinate
        float z = radius * cos(phi); // calculate z coordinate

        PVector coordinate = new PVector(x, y, z);

        coordinates.add(coordinate);
      }
    }
    // Applies perlin noise to all globeCoordinates to generate jagged height map
    this.applyPerlin(coordinates);
  }

  // helicalPointsGenerator():
  // Returns an ArrayList of points for a helical structure
  // along the x value, left to right
  // ----
  // isPositive refers to the initial direction of the spiral for the helical structures
  // if positive, points will spiral along the x-axis with positive sin and cos waves
  // else - these values become negative to spiral and wrap the other way
  public ArrayList<PVector> helicalPointsGenerator(boolean sinCosPositive, int amount, float SIN_COS_VAL, float SPACING, float xStart, float yStart) {
    float x = xStart;
    float y = yStart;
    float z = 0;

    ArrayList<PVector> points = new ArrayList<PVector>();

    if (sinCosPositive) {
      for (int i = 0; i < amount; i++) {
        points.add(new PVector(x, y, z));
        x += SPACING * 1.63;
        y = -sin(x * SIN_COS_VAL) * SPACING;
        z = -cos(x * SIN_COS_VAL) * SPACING;
      }

      return points;
    } else if (!sinCosPositive) {
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

  //// Generate and render a mesh capsule
  //public void renderMeshCapsule(PVector location, int stepSize, float h) {
  //  capsuleCoordinates = new ArrayList<PVector>();

  //  // Calculate sin and cos values for each step so we don't have to re-do it
  //  float[] sinVals = new float[360 / stepSize + 1];
  //  float[] cosVals = new float[360 / stepSize + 1];

  //  for (int i = 0; i < sinVals.length; i++) {
  //    float angle = radians(i * stepSize - 180);
  //    sinVals[i] = sin(angle);
  //    cosVals[i] = cos(angle);
  //  }

  //  // Init capsule body as a GROUP shape
  //  PShape capsule = createShape(GROUP);
  //  capsule.beginShape();

  //  PShape capsuleBody = createShape();
  //  capsuleBody.beginShape(TRIANGLE_STRIP);

  //  // Generate cylinder body vertices
  //  for (int i = 0; i < sinVals.length; i++) {
  //    float x = radius * cosVals[i];
  //    float z = radius * sinVals[i];
  //    float y1 = -h / 2;
  //    float y2 = y1 + h;

  //    capsuleBody.vertex(x, y1, z);
  //    capsuleBody.vertex(x, y2, z);

  //    capsuleCoordinates.add(new PVector(x, y1, z));
  //    capsuleCoordinates.add(new PVector(x, y2, z));
  //  }
  //  capsuleBody.endShape(CLOSE);
  //  capsule.addChild(capsuleBody);

  //  PShape capsuleTop = createShape();
  //  capsuleTop.beginShape(TRIANGLE_FAN);

  //  // Draw top cap vertices
  //  float yTop = -h / 2;
  //  capsuleTop.vertex(0, yTop, 0);
  //  capsuleCoordinates.add(new PVector(0, yTop, 0));

  //  for (int i = 0; i < sinVals.length; i++) {
  //    float x = radius * cosVals[i];
  //    float z = radius * sinVals[i];

  //    capsuleTop.vertex(x, yTop, z);
  //    capsuleCoordinates.add(new PVector(x, yTop, z));
  //  }
  //  capsuleTop.endShape(CLOSE);
  //  capsule.addChild(capsuleTop);

  //  PShape capsuleBottom = createShape();
  //  capsuleBottom.beginShape(TRIANGLE_FAN);

  //  // Draw bottom cap vertices
  //  float yBottom = h / 2;
  //  capsuleBottom.vertex(0, yBottom, 0);
  //  capsuleCoordinates.add(new PVector(0, yBottom, 0));

  //  for (int i = sinVals.length - 1; i >= 0; i--) {
  //    float x = radius * cosVals[i];
  //    float z = radius * sinVals[i];

  //    capsuleBottom.vertex(x, yBottom, z);
  //    capsuleCoordinates.add(new PVector(x, yBottom, z));
  //  }
  //  capsuleBottom.endShape(CLOSE);
  //  capsule.addChild(capsuleBottom);

  //  // RENDER
  //  pushMatrix();
  //  translate(location.x, location.y, location.z);
  //  capsule.rotateY(PI/2);
  //  shape(capsule, 0, 0);
  //  popMatrix();
  //}
}
