CameraOrbit c_Camera;
Actin a_Actin;
MyosinFilament mf_Myofilament;

float c_OrbitSpeed = 0.05;
PVector i_Position;

// Object lists
ArrayList<Actin> a_List;
ArrayList<MyosinHead> mh_List;
ArrayList<Tropomyosin> t_List;

void setup() {
  size(1600, 1000, P3D);
  background(20, 5, 15);
  frameRate(30);

  // Init object lists
  a_List = new ArrayList<Actin>();
  mh_List = new ArrayList<MyosinHead>();
  t_List = new ArrayList<Tropomyosin>();

  // Init starting placement PVector
  i_Position = new PVector(-600, -20, 0);
  // Init Myosin heads init position PVector
  PVector mh_InitPosition = new PVector(-550, 80, 0);

  // Object creation
  c_Camera = new CameraOrbit(800, 0, 0, new PVector(0, 0, 0));
  a_List.add(new Actin(i_Position, true));
  a_List.add(new Actin(i_Position, false));
  // Initiate myosin filment which holds Myosin heads to form cross-bridge
  mf_Myofilament = new MyosinFilament(new PVector(i_Position.x + 580, i_Position.y + 160, 0), 12);

  // Initiate tropomyosin list of binding sites for myosin heads
  t_List.add(new Tropomyosin(new PVector(i_Position.x, i_Position.y - 10, 0), 5, true));
  t_List.add(new Tropomyosin(new PVector(i_Position.x, i_Position.y - 10, 0), 5, false));
  // Set tropomyosin variables
  for (int i = 0; i < t_List.size(); i++) {
    t_List.get(i).setNumPoints(a_List.get(0).NUM_SPHERES());
    t_List.get(i).setRadius(a_List.get(0).SPHERE_RADIUS() / 1.8f);
    t_List.get(i).coordinateGenerator();
  }

  // Set myosinFilament variables
  mf_Myofilament.setHeight(1100);
  mf_Myofilament.setRadius(30);

  // Generate points for Actin to be rendered
  float numMyosinHeads = mf_Myofilament.getHeight() / (a_List.get(0).SPACING() * 2);
  mf_Myofilament.coordinateGenerator();

  for (int i = 0; i < a_List.size(); i++) {
    a_List.get(i).coordinateGenerator();
  }

  for (int i = 0; i < numMyosinHeads; i++) {
    mh_List.add(new MyosinHead(mh_InitPosition, 42));
    mh_InitPosition.set(mh_InitPosition.x + a_List.get(0).SPACING() * 2, mh_InitPosition.y, mh_InitPosition.z);

    mh_List.get(i).setRadius(a_List.get(0).SPHERE_RADIUS() / 2);
    mh_List.get(i).coordinateGenerator(); //MOVE TO DRAW
    mh_List.get(i).setPerlinHeight(12);
  }
}

void draw() {
  background(20, 5, 15);
  c_Camera.update();
  stroke(0);

  // Display rendered structures
  mf_Myofilament.displayShape();

  for (int i = 0; i < a_List.size(); i++) {
    // Save the current translation matrix
    pushMatrix();

    // Apply a rotation to the translation matrix
    translate(0, 0, 0);
    rotateX(frameCount * c_OrbitSpeed);

    stroke(1);
    strokeWeight(1);

    if (i % 2 == 0) {
      fill(70, 20, 150, 180);
    } else {
      fill(255, 0, 255, 180);
    }
    a_List.get(i).draw();
    t_List.get(i).draw();
    // Apply an orbit translation to the rotation matrix
    translate(a_List.get(i).SPHERE_RADIUS() * 2, 0, 0);
    rotateX(frameCount * c_OrbitSpeed);
    popMatrix(); // Restore the saved translation and rotation matrix
  }

  for (int i = 0; i < mh_List.size(); i++) {
    mh_List.get(i).displayShape();
    mh_List.get(i).renderMyosinHeadConnection( mh_List.get(i).getPosition(), mf_Myofilament.getPosition() );
  }

  // check collision between objects here


  //Update all values
  update(a_List, 0, false);
  update(t_List, 600, false);


  update(mh_List, 0, true);

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
      obj.get(i).setLeftBound(m - mf_Myofilament.getHeight());
      obj.get(i).setRightBound(m + mf_Myofilament.getHeight());

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
    c_Camera.orbit((mouseX - pmouseX) * c_Camera.CAMERA_ORBIT_SPEED(), (mouseY - pmouseY) * c_Camera.CAMERA_ORBIT_SPEED());
  } else if (mouseButton == LEFT) {
    c_Camera.pan(mouseX - pmouseX, mouseY - pmouseY);
  }
}

// Control the zoom of the camera
void mouseWheel(MouseEvent event) {
  c_Camera.zoom(event.getCount() * c_Camera.CAMERA_ZOOM_SPEED());
}
