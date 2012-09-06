

PGraphics canvas;
int canvas_width = 2480;
int canvas_height = 3508;


void setup()
{ 
  size(1300, 850);
  background(150);
  
  canvas = createGraphics(canvas_width, canvas_height, P2D);
  
  canvas.beginDraw();
    canvas.background(255);
    canvas.noStroke();
        for(int i = 0; i < 75; i++){
    canvas.pushMatrix();
    canvas.translate(canvas.width/2+noise(i)*random(-350,350), (canvas.height/2-500)+noise(i)*random(-350,350));
    println(noise(i));
   canvas.stroke(0);
    canvas.strokeWeight(10);
    canvas.fill(255,255,255,0);
    canvas.ellipse(0, 0, 1000, 1000);
    canvas.triangle(-400 ,300, 0, 1600, 400, 300);
  canvas.popMatrix();
        }
  canvas.endDraw();
  
  
  image(canvas, 0, 0, canvas.width*0.2, canvas.height*0.2);
  
  saveFrame("icecream.png");
}


