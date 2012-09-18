

PGraphics canvas;
int canvas_width = 3300;
int canvas_height = 5100;


void setup()
{ 
  size(1300, 850);
  background(150);

  canvas = createGraphics(canvas_width, canvas_height, P2D);

  canvas.beginDraw();
  canvas.background(255);
  
  //Sharp Ceiling
  
  canvas.beginShape();

  for (int i = 0; i < canvas.width; i++) {

    canvas.stroke(0);
    canvas.fill(0);
    if (i ==0 || i == canvas.width-1) {
      canvas.vertex(i, 0);
    }
    if (random(1)< 0.1) {
      canvas.vertex(i, random(0, canvas.height/2));
    }
  }

  canvas.endShape();



  //Wet droplets

  canvas.fill(0);
  for (int i = 0;  i < 300; i++) {

    canvas.pushMatrix();
    canvas.translate(random(0, canvas.width), random(canvas.height/2-200, canvas.height));

    canvas.beginShape();
    canvas.stroke(0);
    canvas.strokeWeight(5);
    canvas.vertex(0, 0);
    float bezx = noise(1)*random(50, 100);
    float bezy = noise(1)*random(250, 400);
    canvas.bezierVertex(-bezx, bezy, bezx, bezy, 0, 0);

    canvas.endShape();
    canvas.popMatrix();
  }

  canvas.endDraw();


  image(canvas, 0, 0, canvas.width*0.2, canvas.height*0.2);

  canvas.save("sharpwet.tiff");
}

