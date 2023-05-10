CameraOrbit camera;

Collision collision;

Actin actin;
MyosinFilament myosinFilament;

Tropomyosin bindingSiteA;
Tropomyosin bindingSiteB;

PVector sPos;
ArrayList<MyosinHead> myosinHeadList;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);

  sPos = new PVector(-600, 0, 0);
  myosinHeadList = new ArrayList<MyosinHead>();

  PVector MHInitPosition = new PVector(-550, 90, 0);

  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  collision = new Collision();

  // Actin object which forms the helical structure
  actin = new Actin(sPos);
  // Myosin filment which holds Myosin heads to form cross-bridge
  myosinFilament = new MyosinFilament(new PVector(sPos.x + 580, sPos.y + 160, 0), 12);

  // Tropomyosin binding sites for myosin heads
  bindingSiteA = new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, true);
  bindingSiteB = new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, false);
  // Set variables
  myosinFilament.setHeight(1100);
  myosinFilament.setRadius(30);

  bindingSiteA.setNumPoints(actin.NUM_SPHERES());
  bindingSiteB.setNumPoints(actin.NUM_SPHERES());

  // Generate points for shapes to be rendered
  actin.coordinateGenerator();
  myosinFilament.coordinateGenerator();

  float numMyosinHeads =  myosinFilament.getHeight() / (actin.SPACING() * 2);

  for (int i = 0; i < numMyosinHeads; i++) {
    myosinHeadList.add(new MyosinHead(MHInitPosition, 42));
    MHInitPosition.set(MHInitPosition.x + actin.SPACING() * 2, MHInitPosition.y, MHInitPosition.z);

    myosinHeadList.get(i).setRadius(actin.SPHERE_RADIUS() / 2);
    myosinHeadList.get(i).coordinateGenerator();
    myosinHeadList.get(i).setPerlinHeight(12);
  }

  bindingSiteA.setRadius(actin.SPHERE_RADIUS() / 1.8f);
  bindingSiteB.setRadius(actin.SPHERE_RADIUS() / 1.8f);

  bindingSiteA.coordinateGenerator();
  bindingSiteB.coordinateGenerator();

  collision.setLeftBound(actin.getPosition().x - myosinFilament.getHeight() /2);
  collision.setRightBound(0 - myosinFilament.getHeight());
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
    myosinHeadList.get(i).renderMyosinHeadConnection( myosinHeadList.get(i).getPosition(), myosinFilament.getPosition() );

    // check collision between objects here
    //for(int j = 0; j < bindingSiteA.getStruct1Points().size(); j++)  {
    //  collision.checkCollision();
    //}
  }
  for (int i = 0; i < actin.getStruct1Points().size(); i++) {
    collision.update(actin);
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
