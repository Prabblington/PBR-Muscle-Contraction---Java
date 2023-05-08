CameraOrbit camera;

Actin actin;
Myosin myosinHead;
MyosinFilament myosinFilament;

Tropomyosin bindingSiteA;
Tropomyosin bindingSiteB;


void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  actin = new Actin(-600, 0);
  myosinFilament = new MyosinFilament(new PVector(-25, 150, 0), 12);
  myosinHead = new Myosin(new PVector(-475, 90, 0), 42);
  bindingSiteA = new Tropomyosin(new PVector(-600, -10, 0), 5, true);
  bindingSiteB = new Tropomyosin(new PVector(-600, -10, 0), 5, false);

  // Set variables
  myosinFilament.setHeight(1000);
  myosinFilament.setRadius(30);

  myosinHead.setRadius(actin.SPHERE_RADIUS() / 2);
  myosinHead.setPerlinHeight(12);

  bindingSiteA.setNumPoints(actin.NUM_SPHERES());
  bindingSiteB.setNumPoints(actin.NUM_SPHERES());

  // Generate points for shapes to be rendered
  actin.coordinateGenerator();
  myosinFilament.coordinateGenerator();
  myosinHead.coordinateGenerator();

  bindingSiteA.coordinateGenerator();
  bindingSiteB.coordinateGenerator();
}

void draw() {
  background(20, 5, 15);
  camera.update();
  stroke(0);

  // Display rendered structures
  actin.displayShape();
  myosinFilament.displayShape();
  myosinHead.displayShape();

  bindingSiteA.displayShape();
  bindingSiteB.displayShape();
}

// Controlls camera panning
void mouseDragged() {
  if (mouseButton == RIGHT) {
    camera.orbit((mouseX - pmouseX) * camera.CAMERA_ORBIT_SPEED(), (mouseY - pmouseY) * camera.CAMERA_ORBIT_SPEED());
  } else if (mouseButton == LEFT) {
    camera.pan(mouseX - pmouseX, mouseY - pmouseY);
  }
}

// Control the zoom of the camera
void mouseWheel(MouseEvent event) {
  camera.zoom(event.getCount() * camera.CAMERA_ZOOM_SPEED());
}
