PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 6600;

void setup()
{
  size(1280, 800, P2D);
  background(150);  
  canvas = createGraphics(canvas_width, canvas_height, P2D);
  canvas.beginDraw();

  canvas.smooth();
  canvas.noStroke();
  color col1;
  color col2;
  color col3;

  col1 = color(162, 25, 37);
  col2 = color(0, 0, 0);
  col3 = color(25, 162, 37);

  canvas.background(0,0,0);

   
 
Pattern p1 = new Pattern(-60, 0, canvas.width+100, canvas.height+100, 50,col1);
 

//Pattern p3 = new Pattern(-60, -15, canvas.width+100, canvas.height+100, 50, col3);


 //p3.display();
 p1.display();


  //Pattern p2 = new Pattern(0, 0, canvas.width + 100, canvas.height + 100, 10, col2);
 //p2.display();
  

  canvas.endDraw();

 image(canvas, 0, 0, canvas.width*0.15, canvas.height*0.15);
  
  canvas.save("pattern.tiff");

}
