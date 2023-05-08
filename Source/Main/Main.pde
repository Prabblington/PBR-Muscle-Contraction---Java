CameraOrbit camera;
Actin actin;
Myosin myosinHead;
MyosinFilament myosinFilament;
Tropomyosin bindingSite;


void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  actin = new Actin(-600, 0);
  myosinFilament = new MyosinFilament(new PVector(-25, 150, 0), 12);
  myosinHead = new Myosin(new PVector(-475, 90, 0), 42);
  bindingSite = new Tropomyosin(new PVector(0, 0, 250), 5);
  
  // Set variables
  myosinFilament.setHeight(1000);
  myosinFilament.setRadius(30);

  myosinHead.setRadius(actin.SPHERE_RADIUS() / 2);
  myosinHead.setPerlinHeight(12);
  
  // Generate points for shapes to be rendered
  actin.coordinateGenerator();
  myosinFilament.coordinateGenerator();
  myosinHead.coordinateGenerator();
  bindingSite.coordinateGenerator();
}

void draw() {
  background(20, 5, 15);
  camera.update();
  stroke(0);

  // Display rendered structures
  actin.displayShape();
  myosinFilament.displayShape();
  myosinHead.displayShape();
  bindingSite.displayShape();
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
