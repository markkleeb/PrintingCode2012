import geomerative.*;

PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 3300;


void setup() 
{
  size(1280, 800);
  background(150);
  colorMode(HSB, 360, 100, 100);
  smooth();
  
   float h = random(0, 360);
  float s = random(50, 100);
  float b = random(50, 100);
  
  
  
 color color1 =  color(h, s, b);
  color color2 = color((h+180)%360, s, b);
  
  canvas = createGraphics(canvas_width, canvas_height, P2D);

  canvas.beginDraw();
  
  int fontSize = 1000;
  
  // initialize the geomerative library
  RG.init(this);
  
  // create a new font
  RFont font = new RFont("Audiowide-Regular.ttf", fontSize, RFont.LEFT);

  // tell library we want 11px between each point on the font path
  RCommand.setSegmentLength(50);
  
  // tell the library that the points should have same distance
  //RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  //RCommand.setSegmentator(RCommand.UNIFORMSTEP);
  //RCommand.setSegmentator(RCommand.ADAPTATIVE);  

  // get the points on font outline.
  RGroup grp;
  grp = font.toGroup("Digital");
  grp = grp.toPolygonGroup();
  RPoint[] pnts = grp.getPoints();


 
  
  canvas.background(255);
  canvas.noFill();
  canvas.strokeWeight(20);
  canvas.stroke(color2);
  canvas.beginShape();
  canvas.vertex(0, 1000);
  canvas.vertex(800, 1000);
  canvas.vertex(1000, 200);
  canvas.vertex(1200, 1000);
  canvas.vertex(1600, 1000);
  canvas.vertex(1600, 400);
  canvas.vertex(2000, 1400);
  canvas.vertex(2000, 1000);
  canvas.vertex(2400, 1000);
  canvas.vertex(2600, 200);
  canvas.vertex(2800, 1000);
  canvas.vertex(3200, 1000);
  canvas.vertex(3200, 200);
  canvas.vertex(3200, 1000);
  canvas.vertex(3600, 1000);
  canvas.vertex(3600, 600);
  canvas.vertex(3800, 600);
  canvas.vertex(3800, 1000);
  canvas.vertex(4200, 1000);
  canvas.vertex(4200, 600);
  canvas.vertex(4400, 600);
  canvas.vertex(4400, 1400);
  canvas.vertex(4400, 1000);
  canvas.vertex(6000, 1000);
  canvas.endShape();


  canvas.pushMatrix();
  canvas.translate(800, 2500);

  // dots
  canvas.fill(color2);
  canvas.noStroke();
  for (int i = 0; i < pnts.length; i++ ) 
  {

    canvas.rect(pnts[i].x, pnts[i].y, 40, 20);
}
  canvas.popMatrix();


  canvas.endDraw();


  image(canvas, 0, 0, canvas.width*0.2, canvas.height*0.2);

  canvas.save("fonts.tiff");
}

