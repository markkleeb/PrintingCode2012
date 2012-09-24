

PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 3300;


void setup()
{ 
  size(1300, 850);
  background(150);
  colorMode(HSB, 360, 100, 100);
  
  float h = random(0, 360);
  float s = random(50, 100);
  float b = random(50, 100);
  
  
  
 color color1 =  color(h, s, b);
  color color2 = color((h+120)%360, s, b);
  color color3 = color((h-120)%360, s, b);
  color color4 = color((h+180)%360, s, b);

  

  canvas = createGraphics(canvas_width, canvas_height, P2D);

  canvas.beginDraw();
  canvas.background(color1);
  

/* 
 canvas.fill(color2);
canvas.noStroke();
canvas.strokeWeight(10); 
  for(float i = 0; i < 2*PI; i += PI/16){
canvas.pushMatrix();
canvas.translate(canvas.width/2, canvas.height/2);
canvas.rotate(i);
 canvas.triangle(random(-300, -50), 0, random(50, 300), 0, 0, random(1500,5000));

 canvas.popMatrix();
 
 
  }
  
  */

  canvas.strokeWeight(10);
canvas.stroke(color2);

int y = canvas.height/2;
canvas.beginShape();
for(int x = 0; x < canvas.width; x +=20){
float peak = random(50, 700);
canvas.line(x, peak, x, canvas.height-peak);
  
}


  
canvas.noFill();


  
  canvas.strokeWeight(30);
  canvas.stroke(color3);
  y = canvas.height/3;
  canvas.beginShape();
for(int x = 0; x < canvas.width; x+=200){
  float peak = random(50, 400);
  
  canvas.curveVertex(x, y);
  canvas.curveVertex(x+50, y +peak);
  canvas.curveVertex(x+100, y);
  canvas.curveVertex(x+150, y -peak);
  canvas.curveVertex(x+200, y);
  
}

  canvas.endShape();

y = 2*canvas.height/3;

  canvas.beginShape();
for(int x = 0; x < canvas.width; x+=200){
  float peak = random(50, 400);
  
  canvas.vertex(x, y);
  canvas.vertex(x, y +peak);
  canvas.vertex(x+100, y+peak);
  canvas.vertex(x+100, y-peak);
  canvas.vertex(x+200, y-peak);
  canvas.vertex(x+200, y);
  
}
canvas.endShape();










  canvas.endDraw();


  image(canvas, 0, 0, canvas.width*0.2, canvas.height*0.2);

  canvas.save("waveforms.tiff");
}

