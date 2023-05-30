CameraOrbit c_camera;
Actin a_actin;
MyosinFilament mf_myofilament;

float c_orbitSpeed = 0.05;
PVector i_position;

// Object lists
ArrayList<Actin> a_list;
ArrayList<MyosinHead> mh_list;
ArrayList<Tropomyosin> t_list;

void setup() {
  size(1600, 1000, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Init object lists
  a_list = new ArrayList<Actin>();
  mh_list = new ArrayList<MyosinHead>();
  t_list = new ArrayList<Tropomyosin>();

  // Init starting placement PVector for actin
  i_position = new PVector(-600, -20, 0);
  // Init Myosin heads init position PVector
  PVector mh_initPosition = new PVector(-550, 80, 0);

  // Object creation
  c_camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  a_list.add(new Actin(i_position, true, 22, 30));
  a_list.add(new Actin(i_position, false, 22, 30));
  // Initiate myosin filment which holds Myosin heads to form cross-bridge
  mf_myofilament = new MyosinFilament(new PVector(i_position.x + 580, i_position.y + 160, 0), 12);

  // Initiate tropomyosin list of binding sites for myosin heads
  t_list.add(new Tropomyosin(new PVector(i_position.x, i_position.y - 10, 0), 5, true));
  t_list.add(new Tropomyosin(new PVector(i_position.x, i_position.y - 10, 0), 5, false));
  // Set tropomyosin variables
  for (int i = 0; i < t_list.size(); i++) {
    t_list.get(i).setNumPoints(a_list.get(0).getAmount());
    t_list.get(i).setRadius(a_list.get(0).getRadius() / 1.8f);
    t_list.get(i).coordinateGenerator();
  }

  // Set myosinFilament variables
  mf_myofilament.setHeight(1100);
  mf_myofilament.setRadius(30);

  // Generate points for Actin to be rendered
  float mh_numObjects = mf_myofilament.getHeight() / (a_list.get(0).getSpacing() * 2);
  int mh_numPoints = 42;
  mf_myofilament.coordinateGenerator();

  for (int i = 0; i < a_list.size(); i++) {
    a_list.get(i).coordinateGenerator();
  }

  for (int i = 0; i < mh_numObjects; i++) {
    mh_list.add(new MyosinHead(mh_initPosition, mh_numPoints));
    mh_initPosition.set(mh_initPosition.x + a_list.get(0).getSpacing() * 2, mh_initPosition.y, mh_initPosition.z);

    mh_list.get(i).setRadius(a_list.get(0).getRadius() / 2);
    mh_list.get(i).coordinateGenerator();
    mh_list.get(i).setPerlinHeight(12);
  }
}

void draw() {
  background(20, 5, 15);
  c_camera.update();
  stroke(0);

  // Display rendered structures
  mf_myofilament.displayShape();

  for (int i = 0; i < a_list.size(); i++) {
    // Save the current translation matrix
    pushMatrix();

    // Apply a rotation to the translation matrix
    translate(0, 0, 0);
    rotateX(frameCount * c_orbitSpeed);

    stroke(1);
    strokeWeight(1);

    if (i % 2 == 0) {
      fill(70, 20, 150, 180);
    } else {
      fill(255, 0, 255, 180);
    }
    a_list.get(i).draw();
    t_list.get(i).draw();
    // Apply an orbit translation to the rotation matrix
    translate(a_list.get(i).getRadius() * 2, 0, 0);
    rotateX(frameCount * c_orbitSpeed);
    popMatrix(); // Restore the saved translation and rotation matrix
  }

  for (int i = 0; i < mh_list.size(); i++) {
    mh_list.get(i).displayShape();
    mh_list.get(i).renderMyosinHeadConnection( mh_list.get(i).getPosition(), mf_myofilament.getPosition() );
  }

  // check collision between objects here


  //Update all values
  update(a_list, 0, false);
  update(t_list, 600, false);
  update(mh_list, 0, true);

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
      obj.get(i).setLeftBound(m - mf_myofilament.getHeight());
      obj.get(i).setRightBound(m + mf_myofilament.getHeight());

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
    c_camera.orbit((mouseX - pmouseX) * c_camera.CAMERA_ORBIT_SPEED(), (mouseY - pmouseY) * c_camera.CAMERA_ORBIT_SPEED());
  } else if (mouseButton == LEFT) {
    c_camera.pan(mouseX - pmouseX, mouseY - pmouseY);
  }
}

// Control the zoom of the camera
void mouseWheel(MouseEvent event) {
  c_camera.zoom(event.getCount() * c_camera.CAMERA_ZOOM_SPEED());
}
