final int NUM_SPHERES = 30;
final float X_START = -600;
final float SPHERE_RADIUS = 30;
final float SIN_COS_VAL = 0.053;
final float SPACING = SPHERE_RADIUS * 1.05;
ArrayList<PVector> points1 = new ArrayList<PVector>();
ArrayList<PVector> points2 = new ArrayList<PVector>();

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  generateStruct1();
  generateStruct2();
}

void draw() {
  background(20, 5, 15);
  //orbitControl();
  
  for (int i = 0; i < NUM_SPHERES; i++) {
    PVector point = points1.get(i);
    PVector point2 = points2.get(i);
    
    fill(255, 0, 255);
    renderSphere(point.x, point.y, point.z, SPHERE_RADIUS);
    fill(70, 20, 150);
    renderSphere(point2.x, point2.y, point2.z, SPHERE_RADIUS);
  }
}

void generateStruct1() {
  float x = X_START;
  float y = 0;
  float z = 0;

  for (int i = 0; i < NUM_SPHERES; i++) {
    points1.add(new PVector(x, y, z));
    x += SPACING;
    y = sin(x * SIN_COS_VAL) * SPACING;
    z = cos(x * SIN_COS_VAL) * SPACING;
  }
}

void generateStruct2() {
  float x = X_START;
  float y = 0;
  float z = 0;

  for (int i = 0; i < NUM_SPHERES; i++) {
    points2.add(new PVector(x, y, z));
    x += SPACING;
    y = -sin(x * SIN_COS_VAL) * SPACING;
    z = -cos(x * SIN_COS_VAL) * SPACING;
  }
}

void renderSphere(float x, float y, float z, float radius) {
  pushMatrix();
  translate(x, y, z);
  sphere(radius);
  popMatrix();
}
