/*  Properties
_________________________________________________________________ */

PGraphics canvas;
int canvas_width = 2480;
int canvas_height = 3508;

float ratioWidth = 1;
float ratioHeight = 1;
float ratio = 1;


float xoff = 0.0;

/*  Setup
_________________________________________________________________ */

void setup()
{ 
  size(1300, 850);
  background(150);
  
  canvas = createGraphics(canvas_width, canvas_height, P2D);
  
  calculateResizeRatio();
  
  canvas.beginDraw();
    canvas.background(255);
    canvas.noStroke();
        for(int i = 0; i < 75; i++){
    canvas.pushMatrix();
    canvas.translate(canvas.width/2+noise(i)*random(-350,350), (canvas.height/2-500)+noise(i)*random(-350,350));
    println(noise(i*1000));
   canvas.stroke(0);
    canvas.strokeWeight(10);
    canvas.fill(255,255,255,0);
    canvas.ellipse(0, 0, 1000, 1000);
    canvas.triangle(-400 ,300, 0, 1600, 400, 300);
  canvas.popMatrix();
        }
  canvas.endDraw();
  
  float resizedWidth = (float) canvas.width * ratio;
  float resizedHeight = (float) canvas.height * ratio;
  
  image(canvas, (width / 2) - (resizedWidth / 2), (height / 2) - (resizedHeight / 2), resizedWidth, resizedHeight);
  
  saveFrame("icecream.png");
}

/*  Calculate resizing
_________________________________________________________________ */

void calculateResizeRatio()
{
  ratioWidth = (float) width / (float) canvas.width;
  ratioHeight = (float) height / (float) canvas.height;
  
  if(ratioWidth < ratioHeight)  ratio = ratioWidth;
  else                          ratio = ratioHeight;
}
