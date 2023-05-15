CameraOrbit camera;

Actin actin;
MyosinFilament myosinFilament;

float orbitSpeed = 0.05;

PVector sPos;

// Object lists
ArrayList<Actin> actinList;
ArrayList<MyosinHead> myosinHeadList;
ArrayList<Tropomyosin> tropoList;

void setup() {
  size(1600, 1000, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Init object lists
  actinList = new ArrayList<Actin>();
  myosinHeadList = new ArrayList<MyosinHead>();
  tropoList = new ArrayList<Tropomyosin>();

  // Init starting placement PVector
  sPos = new PVector(-600, -20, 0);
  // Init Myosin heads init position PVector
  PVector MHInitPosition = new PVector(-550, 80, 0);

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
  }

  // Set myosinFilament variables
  myosinFilament.setHeight(1100);
  myosinFilament.setRadius(30);

  // Generate points for Actin to be rendered
  float numMyosinHeads =  myosinFilament.getHeight() / (actinList.get(0).SPACING() * 2);
  myosinFilament.coordinateGenerator();

  for (int i = 0; i < actinList.size(); i++) {
    actinList.get(i).coordinateGenerator();
  }

  for (int i = 0; i < numMyosinHeads; i++) {
    myosinHeadList.add(new MyosinHead(MHInitPosition, 42));
    MHInitPosition.set(MHInitPosition.x + actinList.get(0).SPACING() * 2, MHInitPosition.y, MHInitPosition.z);

    myosinHeadList.get(i).setRadius(actinList.get(0).SPHERE_RADIUS() / 2);
    myosinHeadList.get(i).coordinateGenerator(); //MOVE TO DRAW
    myosinHeadList.get(i).setPerlinHeight(12);
  }
}

void draw() {
  background(20, 5, 15);
  camera.update();
  stroke(0);

  // Display rendered structures
  myosinFilament.displayShape();


  for (int i = 0; i < actinList.size(); i++) {
    // Save the current translation matrix
    pushMatrix();

    // Apply a rotation to the translation matrix
    translate(0, 0, 0);
    rotateX(frameCount*orbitSpeed);

    stroke(1);
    strokeWeight(1);

    if (i % 2 == 0) {
      fill(70, 20, 150, 180);
    } else {
      fill(255, 0, 255, 180);
    }
    actinList.get(i).draw();
    tropoList.get(i).draw();
    // Apply an orbit translation to the rotation matrix
    translate(actinList.get(i).SPHERE_RADIUS() * 2, 0, 0);
    rotateX(frameCount*orbitSpeed);
    popMatrix(); // Restore the saved translation and rotation matrix
  }

  for (int i = 0; i < myosinHeadList.size(); i++) {

    myosinHeadList.get(i).displayShape();
    myosinHeadList.get(i).renderMyosinHeadConnection( myosinHeadList.get(i).getPosition(), myosinFilament.getPosition() );
  }

  // check collision between objects here


  //Update all values
  update(actinList, 0, false);
  update(tropoList, 600, false);


  update(myosinHeadList, 0, true);

  // UPDATE MYOSIN HEADS HERE
}

// Update: updates positions of movable objects
// obj = takes in an object which extends Protein
// m = middleOfMatrix in relation to other objects
private void update(ArrayList<? extends Protein> obj, float m, boolean canMoveYZ) {
  // Update values
  for (int i = 0; i < obj.size(); i++) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    float r = obj.get(i).getRadius();

    // If the object is MyosinHead, set seperate bounds left and right, add just the position to the points arrayList
    if (obj.get(i) instanceof MyosinHead) {
      float originX = obj.get(i).getXStart();
      float originY = obj.get(i).getYStart();
      
      obj.get(i).setXSpeed(4);
      obj.get(i).setLeftBound(originX - (r * 2));
      obj.get(i).setRightBound(originX + (r * 2));
      
      obj.get(i).setLowerBound(originY + (r / 1.6));
      obj.get(i).setUpperBound(originY - (r / 1.6));

      points.add(obj.get(i).getPosition());
    }
    // Else, set left and right bound as needed and add all points to points arrayList
    else {
      obj.get(i).setLeftBound(m - myosinFilament.getHeight());
      obj.get(i).setRightBound(m + myosinFilament.getHeight());

      points = obj.get(i).getPoints();
    }

    // Loop through all points and update them, saving to updatedPoint
    // Set object's points to the new points generated after moving
    for (int j = 0; j < points.size(); j++) {
      PVector updatedPoint = obj.get(i).update(points.get(j), canMoveYZ);

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
