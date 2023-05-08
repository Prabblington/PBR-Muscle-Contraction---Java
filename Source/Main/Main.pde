CameraOrbit camera;
Actin actin;
Myosin myosinFilament;
Myosin globule;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);
  
  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  actin = new Actin(-600, 0);

  myosinFilament = new Myosin(new PVector(-25, 150, 0), 12);
  myosinFilament.setHeight(1000);
  myosinFilament.setRadius(30);
  myosinFilament.generateThickFilamentShape();

  globule = new Myosin(new PVector(-475, 90, 0), 42);
  globule.setRadius(actin.SPHERE_RADIUS() / 2);
  globule.setPerlinHeight(12);  
  globule.generateMyosinHeadShape();
}

void draw() {
  background(20, 5, 15);
  camera.update();

  // Actin renderings
  stroke(0);
  for (int i = 0; i < actin.NUM_SPHERES(); i++) {
    ArrayList<PVector> points1 = actin.getStruct1Points();
    ArrayList<PVector> points2 = actin.getStruct2Points();

    fill(255, 0, 255);
    actin.renderSphere(points1.get(i), actin.SPHERE_RADIUS());

    fill(70, 20, 150);
    actin.renderSphere(points2.get(i), actin.SPHERE_RADIUS());
  }
  // Myosin thick filament render
  fill(55);
  stroke(255);
  myosinFilament.displayThickFilament();

  // Render myosin head globules  
  globule.displayMyosinHead();
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
