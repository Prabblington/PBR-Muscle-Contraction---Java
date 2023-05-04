class CameraOrbit {
  final float CAMERA_PAN_SPEED = 0.8;
  final float CAMERA_ORBIT_SPEED = 0.1;
  final float CAMERA_ZOOM_SPEED = 15;

  private float distance, angleX, angleY;
  private PVector target;
  private boolean isOrbiting, isPanning = false;
  private int prevMouseX, prevMouseY;
  
  
  // ------------------------------ GETTERS AND SETTERS ------------------------------
    
  public float CAMERA_PAN_SPEED() {
    return this.CAMERA_PAN_SPEED;
  }
  public float CAMERA_ORBIT_SPEED() {
    return this.CAMERA_ORBIT_SPEED;
  }
  public float CAMERA_ZOOM_SPEED() {
    return this.CAMERA_ZOOM_SPEED;
  }
  
  // ------------------------------ CONSTRUCTOR AND FUNCTIONS ------------------------

  public CameraOrbit(float distance, float angleX, float angleY, PVector target) {
    this.distance = distance;
    this.angleX = angleX;
    this.angleY = angleY;
    this.target = target;
  }

  public void update() {
    // Compute camera position
    float x = target.x + distance * sin(angleY) * cos(angleX);
    float y = target.y + distance * sin(angleX);
    float z = target.z + distance * cos(angleY) * cos(angleX);
    // Update camera position
    camera(x, y, z, target.x, target.y, target.z, 0, 1, 0);
  }

  public void mousePressed() {
    if (mouseButton == LEFT) {
      isOrbiting = true;
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    } else if (mouseButton == RIGHT) {
      isPanning = true;
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    }
  }

  public void mouseReleased() {
    isOrbiting = false;
    isPanning = false;
  }

  public void mouseDragged() {
    if (isOrbiting) {
      float dx = mouseX - prevMouseX;
      float dy = mouseY - prevMouseY;
      
      orbit(dx, dy);
      
      prevMouseX = mouseX;
      prevMouseY = mouseY;
      
    } else if (isPanning) {
      float dx = mouseX - prevMouseX;
      float dy = mouseY - prevMouseY;
      
      pan(dx, dy);
      
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    }
  }

  public void mouseWheel(MouseEvent event) {
    float delta = event.getCount();
    zoom(delta);
  }
  
  // Makes the camera look around the current position
  public void orbit(float dx, float dy) {
    angleX += dy * this.CAMERA_ORBIT_SPEED;
    angleY += dx * this.CAMERA_ORBIT_SPEED;
  }

 public void pan(float dx, float dy) {
    float forwardX = target.x - (target.x - distance * sin(angleY) * cos(angleX)) * this.CAMERA_PAN_SPEED;
    float forwardY = target.y - (target.y - distance * sin(angleX)) * this.CAMERA_PAN_SPEED;
    float forwardZ = target.z - (target.z - distance * cos(angleY) * cos(angleX)) * this.CAMERA_PAN_SPEED;
    float rightX = (target.x - forwardX) * cos(HALF_PI) - (target.z - forwardZ) * sin(HALF_PI);
    float rightZ = (target.x - forwardX) * sin(HALF_PI) + (target.z - forwardZ) * cos(HALF_PI);
    
    target.x += (rightX * dx / width + forwardX * dy / height) * this.CAMERA_PAN_SPEED;
    target.y += forwardY * dy / height * this.CAMERA_PAN_SPEED;
    target.z += (rightZ * dx / width + forwardZ * dy / height) * this.CAMERA_PAN_SPEED;
}


  public void zoom(float amount) {
    distance -= amount * 10;
    distance = max(distance, 1);
  }
}
