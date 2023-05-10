CameraOrbit camera;

Actin actin;
MyosinFilament myosinFilament;
ArrayList<MyosinHead> myosinHeadList;

Tropomyosin bindingSiteA;
Tropomyosin bindingSiteB;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  actin = new Actin(-600, 0);

  myosinHeadList = new ArrayList<MyosinHead>();
  PVector MHInitPosition = new PVector(-475, 90, 0);

  myosinFilament = new MyosinFilament(new PVector(-20, 160, 0), 12);

  // Tropomyosin binding sites for myosin heads
  bindingSiteA = new Tropomyosin(new PVector(-600, -10, 0), 5, true);
  bindingSiteB = new Tropomyosin(new PVector(-600, -10, 0), 5, false);

  // Set variables
  myosinFilament.setHeight(1000);
  myosinFilament.setRadius(30);

  bindingSiteA.setNumPoints(actin.NUM_SPHERES());
  bindingSiteB.setNumPoints(actin.NUM_SPHERES());

  // Generate points for shapes to be rendered
  actin.coordinateGenerator();
  myosinFilament.coordinateGenerator();
  
  for (int i = 0; i < actin.getStruct1Points().size() / 1.4; i++) {
    myosinHeadList.add(new MyosinHead(MHInitPosition, 42));
    MHInitPosition.set(MHInitPosition.x + actin.SPACING() * 2, MHInitPosition.y, MHInitPosition.z);
    myosinHeadList.get(i).setRadius(actin.SPHERE_RADIUS() / 2);
    myosinHeadList.get(i).coordinateGenerator();
    myosinHeadList.get(i).setPerlinHeight(12);
  }

  bindingSiteA.setRadius(actin.SPHERE_RADIUS() / 2);
  bindingSiteB.setRadius(actin.SPHERE_RADIUS() / 2);

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

  for (int i = 0; i < myosinHeadList.size(); i++) {
    myosinHeadList.get(i).displayShape();
    myosinHeadList.get(i).renderMyosinHeadConnection( myosinHeadList.get(i).getPosition(), myosinFilament.getPosition());
  }

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
