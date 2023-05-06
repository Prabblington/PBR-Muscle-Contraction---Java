CameraOrbit camera;
Actin actin;
Myosin myosinFilament;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);

  camera = new CameraOrbit(1000, 0, 0, new PVector(0, 0, 0));
  
  actin = new Actin(-600, 0);
  
  // Myosin filament vertex arrayList
  ArrayList<PVector> vertex = new ArrayList<PVector>();
  
  stroke(255, 255, 255);
  vertex.add(new PVector(-600, -200, 0));
  vertex.add(new PVector(-600, -200, 50));
  vertex.add(new PVector(-600, -250, 50));
  vertex.add(new PVector(-600, -250, 0));
  vertex.add(new PVector(-600, -200, 0));
  
  vertex.add(new PVector(200, -200, 0));
  vertex.add(new PVector(200, -250, 0));
  //vertex.add(new PVector(200, -250, 50));
  //vertex.add(new PVector(200, -200, 50));
  //vertex.add(new PVector(200, -250, 50));
  
  //vertex.add(new PVector(-600, -250, 0));
  //vertex.add(new PVector(-600, -250, 50)); 
  
  //vertex.add(new PVector(200, -250, 0));  
  //vertex.add(new PVector(200, -250, 50));
  
  //vertex.add(new PVector(200, -200, 50));
  //vertex.add(new PVector(200, -200, 0));
  myosinFilament = new Myosin(vertex);
}

void draw() {
  background(20, 5, 15);
  camera.update();

  for (int i = 0; i < actin.NUM_SPHERES(); i++) {
    ArrayList<PVector> points1 = actin.getStruct1Points();
    ArrayList<PVector> points2 = actin.getStruct2Points();

    fill(255, 0, 255);
    actin.renderSphere(points1.get(i), actin.SPHERE_RADIUS());

    fill(70, 20, 150);
    actin.renderSphere(points2.get(i), actin.SPHERE_RADIUS());
    
    fill(255, 255, 255);
    myosinFilament.displayThickFilament();
  }

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
