CameraOrbit camera;
Actin actin;
Myosin myosinFilament;

private ArrayList<PVector> vertex = new ArrayList<PVector>();

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);

  camera = new CameraOrbit(1000, 0, 0, new PVector(0, 0, 0));

  actin = new Actin(-600, 0);

  // Myosin filament vertex arrayList
  vertex.add(new PVector(-900, -100, -50));
  vertex.add(new PVector(50, -100, -50));
  vertex.add(new PVector(50, 50, -50));
  vertex.add(new PVector(-900, 50, -50));
  
  vertex.add(new PVector(-900, -100, 50));
  vertex.add(new PVector(50, -100, 50));
  vertex.add(new PVector(50, 50, 50));
  vertex.add(new PVector(-900, 50, 50));  

  myosinFilament = new Myosin(vertex);
  
}

void draw() {
  background(20, 5, 15);
  camera.update();
  stroke(0);
  for (int i = 0; i < actin.NUM_SPHERES(); i++) {
    ArrayList<PVector> points1 = actin.getStruct1Points();
    ArrayList<PVector> points2 = actin.getStruct2Points();

    fill(255, 0, 255);
    actin.renderSphere(points1.get(i), actin.SPHERE_RADIUS());

    fill(70, 20, 150);
    actin.renderSphere(points2.get(i), actin.SPHERE_RADIUS());
  }
  fill(55);
  myosinFilament.renderQuadShape(vertex);
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
