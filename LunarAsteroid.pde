// Define Ship Vectors
PVector p0;
PVector p1;
PVector p2;

// initial and define the sip width and height
float shipHeight = 15;
float shipWidth = 10;


/// Define Astroiid Vectors
PVector a0;
PVector a1;
PVector a2;
PVector a3;
PVector a4;
PVector a5;

// landing PVectors
PVector lPad0;
PVector lPad1;
PVector lPad2;
PVector lPad3;

// initialize and define th astroid size
float aHeight = 0;
float aWidth = 40;
float aCorner = 20;

// initialize originPOS and define the value to be at position (0,0)
PVector originPOS = new PVector(0,0);
PVector aOriginPOS = new PVector(0,0);


// initialize and define the gravity, velocity and thust
PVector gravity = new PVector(0,.02);
PVector velocity = new PVector(0,0);
PVector thrust = new PVector(0,0);



// rotation variables for the ship and asteroid
float arotatez = 0;
float rotatez = 0.0f;
float theta=0, cs=0, sn=0;
float x,y;


void setup() {
  // create the size of the screen
  size(800, 600);
  
  // change the position of originPOS to the center of the screen/ game window
  originPOS.x = width/2;
  originPOS.y = height/2;
  
  // origin of the asteroid
  aOriginPOS.x = width/2;
  aOriginPOS.y = height/2;
}


void draw(){
  
  background(242,34,55);
  if (gravity.y == 0 && originPOS.y < height - 16){
    // resets the gravity and velocity
      velocity.y = 0;
      gravity.y = .02;
  }
  renderSetup(); 
  renderShip();
  updateShip();
  updateAstroid();
  renderAstroid();
  arotatez += .5; // continuesly update the rotation of the asteroid
  renderLandingPad();
  isLanded();
  screenWrap();
  
}


void renderSetup(){
  // set the color of the ship
  fill(255);
  stroke(255);
}


void renderAstroid(){

  // create new astroid
  a0 = new PVector(30, -30);
  a1 = new PVector(-2, -30);
  a2 = new PVector(-30, 10);
  a3 = new PVector(20, 20);

  
  // rotate the asteroid
  if (arotatez == 360) {arotatez = 0;} 
  theta = radians(arotatez);
  cs = cos(theta);
  sn = sin(theta);
  
  x = a0.x;
  y = a0.y;
  a0.x = x * cs - y * sn;
  a0.y = x * sn + y * cs;
  x = a1.x;
  y = a1.y;
  a1.x = x * cs - y * sn;
  a1.y = x * sn + y * cs;
  x = a2.x;
  y = a2.y;
  a2.x = x * cs - y * sn;
  a2.y = x * sn + y * cs;
  x = a3.x;
  y = a3.y;
  a3.x = x * cs - y * sn;
  a3.y = x * sn + y * cs;
  // end of rotation code
  
   // center the ship on the screen
  a0.add(aOriginPOS);
  a1.add(aOriginPOS);
  a2.add(aOriginPOS);
  a3.add(aOriginPOS);
 
  
  line(a0.x +60, a0.y +60, a1.x +60, a1.y +60);
  line(a1.x +60, a1.y +60, a2.x +60, a2.y +60);
  line(a2.x +60, a2.y +60, a3.x +60, a3.y +60);
  line(a3.x +60, a3.y +60, a0.x +60, a0.y +60);
  
  line(a0.x-60, a0.y-60, a1.x-60,a1.y-60);
  line(a1.x-60, a1.y-60, a2.x-60,a2.y-60);
  line(a2.x-60, a2.y-60, a3.x-60,a3.y-60);
  line(a3.x-60, a3.y-60, a0.x-60,a0.y-60);
  
  
  
}

void renderLandingPad(){
  // create the landing pad
  lPad0 = new PVector(580,580 );
  lPad1 = new PVector(680,580);
  lPad2 = new PVector(580, height );
  lPad3 = new PVector(680, height);
  
  fill(255);
  stroke(255);
  
 
  // create the landing pad vector lines
  line(lPad0.x, lPad0.y, lPad1.x, lPad1.y);
  line(lPad1.x, lPad1.y, lPad2.x, lPad2.y); 
  line(lPad3.x, lPad3.y, lPad0.x, lPad0.y); 
  

}


void renderShip(){
  // create the ship
  
  p0 = new PVector(-shipWidth, shipHeight);
  p1 = new PVector(0, -shipHeight);
  p2 = new PVector(shipWidth, shipHeight);
  
  fill(255);
  stroke(255);
  
  // rotate teh ship
  theta = radians(rotatez);
  cs = cos(theta);
  sn = sin(theta);
    
  x = p0.x;
  y = p0.y;
  p0.x = x * cs - y * sn;
  p0.y = x * sn + y * cs;
  x = p1.x;
  y = p1.y;
  p1.x = x * cs - y * sn;
  p1.y = x * sn + y * cs;
  x = p2.x;
  y = p2.y;
  p2.x = x * cs - y * sn;
  p2.y = x * sn + y * cs;
  // rotate the thrust
  x = thrust.x;
  y = thrust.y;
  thrust.x = -(x * cs + y * sn);
  thrust.y = -(x * sn - y * cs);

  // end of ship rotation code

  // center the ship on the screen
  p0.add(originPOS);
  p1.add(originPOS);
  p2.add(originPOS);
 
  // create the ship vector lines
  line(p0.x, p0.y, p0.x, p0.y); // bottom left corner of the ship
  line(p1.x, p1.y, p2.x, p2.y); // right side of the ship
  line(p1.x, p1.y, p0.x, p0.y); // left side of the ship
  line(p2.x, p2.y, p0.x, p0.y); // bottom of the ship
  
  
    
  
}


void updateShip(){
  // update the ships vector positions on the screen
  
  
  // add thrust to velocity
  // velocity.x += thrust.x
  // velocity.y += thrust.y
  velocity.add(thrust);
  
  
  // add gravity to the thrust
  // velocity.x += gravity.x
  // velocity.y += gravity.y
  velocity.add(gravity);
  
  
  // add velocity to the originPOS "Move the ship"
  // originPOS.x += velocity.x
  // originPOS.y += velocity.y
  originPOS.add(velocity);
  
  
  // slow the ship down
  float drag = 0.99;
  velocity.mult(drag);
  
  
  // slow the thrust down
  // thrust.x = thrust.x * 0.97
  // thrust.y = thrust.y * 0.97
  thrust.mult(.99);
  
 

}

void updateAstroid(){
  // add gravity to the ship
  aOriginPOS.add(gravity);
  
}

// check if ship crashed
boolean isCrashed(){
  // check position of the ship
  // check the orientation of the ship
  // return a boolean for whether the ship has crashed 
  if (originPOS.y > (height - 35) && originPOS.x > lPad0.x && originPOS.x < lPad1.x){
    // check if on landing pad
    if(rotatez <= 350.0 && rotatez >= 10.0 || rotatez >= -350.0 && rotatez <= -10.0) {
      return true;
    }
  }
  
  if (originPOS.y > (height - 15) && originPOS.x < lPad0.x || originPOS.y > (height - 15)&& originPOS.x > lPad1.x){
    // check if off landing pad
   if(rotatez <= 350.0 && rotatez >= 10.0 || rotatez >= -350.0 && rotatez <= -10.0) {
     return true; 
   }
  }
  return false;
}

void isLanded(){
  // Check ships position in relation to height of the screen minus 15px and whether the postion is on the landing pad
  // Check if the ship has crashed
  // inform the player if ship is crashed
  // inform the player if the ship has landed corectly
  if (originPOS.y > (height - 35) && originPOS.x > lPad0.x && originPOS.x < lPad1.x){
    if (!isCrashed()){
      textSize(32);
      text("Win", originPOS.x, originPOS.y - 30); 
      fill(0, 102, 153);
      text("Win", originPOS.x, originPOS.y - 15);
      fill(0, 102, 153, 51);
      text("Win", originPOS.x, originPOS.y);
    }
    if (isCrashed()){
      textSize(32);
      textSize(32);
      text("Crash", originPOS.x, originPOS.y - 30); 
      fill(0, 102, 153);
      text("Crash", originPOS.x, originPOS.y - 15);
      fill(0, 102, 153, 51);
      text("Crash", originPOS.x, originPOS.y);
    }
    originPOS.y = height - 35;
    velocity.y *= 0;
    gravity.y *= 0;
  }
  
  // Check ships position in relation to height of the screen minus 15px and whether the postion is on the left or right side of the landing pad
  // Check if the ship has crashed
  // inform the player if ship is crashed
  if (originPOS.y > (height - 15) && originPOS.x < lPad0.x || originPOS.y > (height - 15)&& originPOS.x > lPad1.x){
    if (isCrashed()){
      textSize(32);
      text("Crash", originPOS.x, originPOS.y - 30); 
      fill(0, 102, 153);
      text("Crash", originPOS.x, originPOS.y - 15);
      fill(0, 102, 153, 51);
      text("Crash", originPOS.x, originPOS.y);
    }
    originPOS.y = height - 15;
    velocity.y *= 0;
    gravity.y *= 0;
  }
}


void screenWrap(){
  // screen wrap
  // Check ships position in relation to height and width minus the height of the ship
  if (originPOS.y < (0 + shipHeight)){
    originPOS.y = 580;
  }
  if (originPOS.x > (width + shipHeight)){
    originPOS.x = 20;
  }
  if (originPOS.x < (0 + shipHeight)){
    originPOS.x = 780;
  }
  
  // screen wrap asteroid
  // Check asteroids position in relation to height and width minus the height of the asteroids
  if (aOriginPOS.y > (height - aHeight)){
    aOriginPOS.y = 0;
  }
  if (aOriginPOS.y < (0 + aHeight)){
    aOriginPOS.y = 580;
  }
  if (aOriginPOS.x > (width + aHeight)){
    aOriginPOS.x = 20;
  }
  if (aOriginPOS.x < (0 + aHeight)){
    aOriginPOS.x = 780;
  }
}


void keyPressed(){
  
  if (key == 'w'){
    // Add Thrust
    thrust.y += -0.001;
  }
  else if (key == 's') {
    // reverse Thrust
    thrust.y += 0.001;
  }
  else if (key == 'a'){
    // Move Left
    thrust.x += -0.001;
  }
  else if (key == 'd'){
    // Move Right
    thrust.x += 0.001; 
  }
  else if (key == 'q'){
    // Rotate Left
    rotatez -= 1.0;
    if (rotatez < -360.0) rotatez = rotatez + 360.0;
  }
  else if (key == 'e'){
    // Rotate Right
    rotatez += 1.0;
    if (rotatez > 360) rotatez = rotatez - 360;
  }
}
