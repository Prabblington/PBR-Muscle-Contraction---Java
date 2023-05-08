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
  myosinFilament = new MyosinFilament(new PVector(-25, 150, 0), 12);
  globule = new Myosin(new PVector(-475, 90, 0), 42);
  
  myosinFilament.setHeight(1000);
  myosinFilament.setRadius(30);
  
  globule.setRadius(actin.SPHERE_RADIUS() / 2);
  globule.setPerlinHeight(12);
  
  actin.coordinateGenerator(); 
  myosinFilament.coordinateGenerator(); 
  globule.coordinateGenerator();
}

void draw() {
  background(20, 5, 15);
  camera.update();

  // Actin renderings
  stroke(0);
  actin.displayShape();
  
  // Myosin thick filament render
  fill(55);
  stroke(255);
  myosinFilament.displayShape();

  // Render myosin head globules
  globule.displayShape();
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
