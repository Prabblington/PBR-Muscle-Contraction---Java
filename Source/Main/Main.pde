CameraOrbit camera;
Actin actin;
Myosin myosinFilament;
Myosin myosinHeads;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);

  camera = new CameraOrbit(1000, 0, 0, new PVector(0, 0, 0));

  actin = new Actin(-600, 0);
  // Myosin dimentions: 1 = x, 2 = y(range), 3 = z(range)
  float[] d = {900, 100, 50};  

  myosinFilament = new Myosin(d);
  //myosinHeads = new Myosin(); // ADD MYOSIN HEAD VERTEXS
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
  myosinFilament.renderQuadShape(myosinFilament.getVertexList());
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
