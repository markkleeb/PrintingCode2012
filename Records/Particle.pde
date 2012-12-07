class Particle {

  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float wandertheta;
  float maxforce;
  float maxspeed;
  color col;


  Particle(PVector l, float ms, float mf, color c) {

    acc = new PVector(0, 0);
    vel = new PVector(random(-10, 10), random(-10, 10));
    loc = l.get();
    r = 5.0;
    wandertheta = 0.0;
    maxspeed = ms;
    maxforce = mf;
    col = c;
  }

  void run() {

    update();
    borders();
    render();
  }


  // Method to update location
  void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    loc.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }


  void seek(PVector target) {
    acc.add(steer(target, false));
  }

  void arrive(PVector target) {
    acc.add(steer(target, true));
  }

  void wander() {
    float wanderR = 16.0f;         // Radius for our "wander circle"
    float wanderD = 60.0f;         // Distance for our "wander circle"
    float change = 0.25f;
    wandertheta += random(-change, change);     // Randomly change wander theta

    // Now we have to calculate the new location to steer towards on the wander circle
    PVector circleloc = vel.get();  // Start with velocity
    circleloc.normalize();            // Normalize to get heading
    circleloc.mult(wanderD);          // Multiply by distance
    circleloc.add(loc);               // Make it relative to boid's location

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta), wanderR*sin(wandertheta));
    PVector target = PVector.add(circleloc, circleOffSet);
    acc.add(steer(target, false));  // Steer towards it

    // Render wandering circle, etc. 
    //if (debug) drawWanderStuff(loc,circleloc,target,wanderR);
  }  

  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  PVector steer(PVector target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector desired = PVector.sub(target, loc);  // A vector pointing from the location to the target
    float d = desired.mag(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
      if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
      else desired.mult(maxspeed);
      // Steering = Desired minus Velocity
      steer = PVector.sub(desired, vel);
      steer.limit(maxforce);  // Limit to maximum steering force
    } 
    else {
      steer = new PVector(0, 0);
    }
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + radians(90);
    canvas.fill(col);
    canvas.stroke(col);
    canvas.pushMatrix();
    canvas.translate(loc.x, loc.y);
    canvas.rotate(theta);
    //beginShape(TRIANGLES);
    //vertex(0, -r*2);
    //vertex(-r, r*2);
    //vertex(r, r*2);
    //endShape();
    canvas.ellipse(0, 0, 1.5*r, 1.5*r);

    canvas.popMatrix();
  }

  // Wraparound
  void borders() {
    if (loc.x < -r) loc.x=canvas.width+r;
    if (loc.y < -r) loc.y= canvas.height+r;
    if (loc.x > canvas.width+r) loc.x=-r;
    if (loc.y > canvas.height+r) loc.y=-r;
  }
}


