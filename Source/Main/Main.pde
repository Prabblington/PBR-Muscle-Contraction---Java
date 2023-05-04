int NUM_SPHERES = 30;
int SPHERE_RADIUS = 30;
float X_START = -600;
float SIN_COS_VAL = 0.053;
float SPACING = SPHERE_RADIUS * 1.05;
float points1 = [];
float points2 = [];

void setup() {
  createCanvas(1200, 800, WEBGL);
  background(20, 5, 15);
  generateStruct1();
  generateStruct2();
}
// orbitControl():  in-built function which allows for camera control
// using mouse:-
// ----- MOUSE1 = rotate around mouse click
// ----- MOUSE2 = move camera angle along x, y and z axis
// ----- scroll wheel = get closer / further away from target
void draw() {
  background(20, 5, 15);
  orbitControl();
  // rotate the model along the x-axis
  //rotateX(frameCount * -0.05);

  // draw spheres and lines from centre
  for (int i = 0; i < this.NUM_SPHERES; i++) {
    // get each point from each array
    float[] point = points1[i];
    float[] point2 = points2[i];
    // draw spheres
    fill(255, 0, 255);
    renderSphere(point.x, point.y, point.z, SPHERE_RADIUS);
    fill(70, 20, 150);
    renderSphere(point2.x, point2.y, point2.z, SPHERE_RADIUS);
  }
}

// define the points1 of the sphere
public void generateStruct1 = () => {
  let x = X_START;
  let y,
    z = 0;

  for (let i = 0; i < NUM_SPHERES; i++) {
    points1.push(createVector(x, y, z));
    // change positions so it forms a spiral along the x-axis
    x += SPACING;
    y = Math.sin(x * SIN_COS_VAL) * SPACING;
    z = Math.cos(x * SIN_COS_VAL) * SPACING;
  }
};

// define the points1 of the sphere
public void generateStruct2 = () => {
  let x = X_START;
  let y,
    z = 0;

  for (let i = 0; i < NUM_SPHERES; i++) {
    points2.push(createVector(x, y, z));
    // change positions so it forms a spiral along the x-axis
    x += SPACING;
    y = -Math.sin(x * SIN_COS_VAL) * SPACING;
    z = -Math.cos(x * SIN_COS_VAL) * SPACING;
  }
};

public void renderSphere = (x, y, z, radius) => {
  push(); // enter local coordinate system
  translate(x, y, z);
  sphere(radius, 6);
  pop(); // exit local coordinate system (back to global coordinates)
};
