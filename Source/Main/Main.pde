CameraOrbit camera;

Actin actin;
MyosinFilament myosinFilament;

Tropomyosin bindingSiteA;
Tropomyosin bindingSiteB;

PVector sPos;

// Object lists
ArrayList<Actin> actinList;
ArrayList<MyosinHead> myosinHeadList;
ArrayList<Tropomyosin> tropoList;

ArrayList<Protein> movableObjs;

void setup() {
  size(1200, 800, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Init object lists
  actinList = new ArrayList<Actin>();
  myosinHeadList = new ArrayList<MyosinHead>();
  tropoList = new ArrayList<Tropomyosin>();

  movableObjs = new ArrayList<Protein>();
  // Init starting placement PVector
  sPos = new PVector(-600, 0, 0);
  // Init Myosin heads init position PVector
  PVector MHInitPosition = new PVector(-550, 90, 0);

  // Object creation
  camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));

  // Initiate actin list which forms the helical structure
  actinList.add(new Actin(sPos, true));
  actinList.add(new Actin(sPos, false));
  // Initiate myosin filment which holds Myosin heads to form cross-bridge
  myosinFilament = new MyosinFilament(new PVector(sPos.x + 580, sPos.y + 160, 0), 12);

  // Initiate tropomyosin list of binding sites for myosin heads
  tropoList.add(new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, true));
  tropoList.add(new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, false));
  // Set tropomyosin variables
  for (int i = 0; i < tropoList.size(); i++) {
    tropoList.get(i).setNumPoints(actinList.get(0).NUM_SPHERES());
    tropoList.get(i).setRadius(actinList.get(0).SPHERE_RADIUS() / 1.8f);
    tropoList.get(i).coordinateGenerator();

    // Add as a movable object
    movableObjs.add(tropoList.get(i));
  }
  //bindingSiteA = new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, true);
  //bindingSiteB = new Tropomyosin(new PVector(sPos.x, sPos.y - 10, 0), 5, false);

  // Set myosinFilament variables
  myosinFilament.setHeight(1100);
  myosinFilament.setRadius(30);

  // Initiate tropomyosin array list

  //bindingSiteA.setNumPoints(actinList.get(0).NUM_SPHERES());
  //bindingSiteB.setNumPoints(actinList.get(0).NUM_SPHERES());

  // Generate points for shapes to be rendered
  float numMyosinHeads =  myosinFilament.getHeight() / (actinList.get(0).SPACING() * 2);
  myosinFilament.coordinateGenerator();

  for (int i = 0; i < actinList.size(); i++) {
    actinList.get(i).coordinateGenerator();

    // Add as movable object
    movableObjs.add(actinList.get(i));
  }

  for (int i = 0; i < numMyosinHeads; i++) {
    myosinHeadList.add(new MyosinHead(MHInitPosition, 42));
    MHInitPosition.set(MHInitPosition.x + actinList.get(0).SPACING() * 2, MHInitPosition.y, MHInitPosition.z);

    myosinHeadList.get(i).setRadius(actinList.get(0).SPHERE_RADIUS() / 2);
    myosinHeadList.get(i).coordinateGenerator();
    myosinHeadList.get(i).setPerlinHeight(12);

    //movableObjs.add(myosinHeadList.get(i));
  }

  //bindingSiteA.setRadius(actinList.get(0).SPHERE_RADIUS() / 1.8f);
  //bindingSiteB.setRadius(actinList.get(0).SPHERE_RADIUS() / 1.8f);

  //bindingSiteA.coordinateGenerator();
  //bindingSiteB.coordinateGenerator();

  //collision.setLeftBound(actinList.get(0).getPosition().x - myosinFilament.getHeight() /2);
  //collision.setRightBound(0 - myosinFilament.getHeight());
}

void draw() {
  background(20, 5, 15);
  camera.update();
  stroke(0);

  // Display rendered structures
  myosinFilament.displayShape();

  for (int i = 0; i < actinList.size(); i++) {
    stroke(1);
    if (i % 2 == 0) {
      fill(70, 20, 150, 180);
      actinList.get(i).displayShape();
    } else {
      fill(255, 0, 255, 180);
      actinList.get(i).displayShape();
    }
  }
  for (int i = 0; i < myosinHeadList.size(); i++) {
    myosinHeadList.get(i).displayShape();
    myosinHeadList.get(i).renderMyosinHeadConnection( myosinHeadList.get(i).getPosition(), myosinFilament.getPosition() );

    // check collision between objects here
    //for(int j = 0; j < bindingSiteA.getStruct1Points().size(); j++)  {
    //  collision.checkCollision();
    //}
  }
  for (int i = 0; i < tropoList.size(); i++) {
    tropoList.get(i).displayShape();
  }

  //Update all values
  update(actinList);


  //// Update values
  //for (int i = 0; i < actinList.size(); i++) {
  //  actinList.get(i).setLeftBound(0 - myosinFilament.getHeight());
  //  actinList.get(i).setRightBound(0 + myosinFilament.getHeight());

  //  ArrayList<PVector> points = actinList.get(i).getPoints();

  //  for (int j = 0; j < points.size(); j++) {
  //    PVector updatedPoint = actinList.get(i).update(points.get(j));
  //    points.get(j).set(updatedPoint);
  //  }
  //  actinList.get(i).setPoints(points);
  //}
}

private void update(ArrayList<? extends Protein> obj) {
  // Update values
  for (int i = 0; i < obj.size(); i++) {
    obj.get(i).setLeftBound(0 - myosinFilament.getHeight());
    obj.get(i).setRightBound(0 + myosinFilament.getHeight());

    ArrayList<PVector> points = obj.get(i).getPoints();
    System.out.println("Points: " + i + " " + points);

    for (int j = 0; j < points.size(); j++) {
      PVector updatedPoint = obj.get(i).update(points.get(j));
      points.get(j).set(updatedPoint);
    }
    obj.get(i).setPoints(points);
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
