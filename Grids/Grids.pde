import geomerative.*;

PGraphics canvas;
int canvas_width = 5100;
int canvas_height = 3300;

PFont font;
// The font must be located in the sketch's 
// "data" directory to load successfully


void setup()
{

  
  size(1280, 900, P2D);
  background(150);


  colorMode(HSB, 360, 100, 100);
  smooth();
  
  canvas = createGraphics(canvas_width, canvas_height, P2D);

  canvas.beginDraw();
/*  
  int fontSize = 200;
RG.init(this);
RFont font = new RFont("Audiowide-Regular.ttf", fontSize, RFont.LEFT);
RCommand.setSegmentLength(50);
RGroup date;
date = font.toGroup("NOV 1 4");
date = date.toPolygonGroup();
RPoint[] datePnts = date.getPoints();
  */
  
  font = createFont("Audiowide-Regular.ttf", 200);
  canvas.textFont(font);
  
  canvas.noStroke();
  canvas.fill(30);
  
  // create a grid object
  ModularGrid grid = new ModularGrid(50, 50, 20, 20);
  
  float h= random(0, 360);
  float s= random(50, 100);
  float b=random(50,75);
  
  color c1 = color(h, s, b);
  color c2 = color((h+120)%360, s, b);
  color c3 = color((h-120)%360, s, b);
  
 color colors[] = {c1, c2, c3};
  
  canvas.background(255);
  
  canvas.fill(colors[0]);
  canvas.noStroke();
    Module dateMod = grid.getRandomModule(9, 4);
  canvas.pushMatrix();
  canvas.translate(dateMod.x, dateMod.y+dateMod.h*3/4);
  canvas.text("NOV 27", 0, 0);
  canvas.popMatrix();
  
  Module place = grid.getRandomModule(22, 6);
  canvas.fill(colors[1]);
  canvas.pushMatrix();
  canvas.translate(place.x, place.y+place.h/2);
  canvas.text("THE DELINQUENCY", 0, 0);
  canvas.translate(0, 150);
  canvas.textSize(75);
  canvas.text("1031 GRAND ST >> 8PM", 0, 0);
  canvas.popMatrix();
  // loop forever until we break out
  
  Module ton = grid.getRandomModule(12, 4);
  canvas.fill(colors[2]);
  canvas.textSize(200);
  canvas.pushMatrix();
  canvas.translate(ton.x, ton.y + ton.h*3/4);
  canvas.text("FUCK TON",0, 0);
  canvas.popMatrix();
  
  Module watts = grid.getRandomModule(16, 4);
  canvas.fill(colors[1]);
  canvas.textSize(200);
  canvas.pushMatrix();
  canvas.translate(watts.x, watts.y + watts.h*3/4);
  canvas.text("ALAN WATTS",0, 0);
  canvas.popMatrix();
  
   Module yvette = grid.getRandomModule(14, 4);
  canvas.fill(colors[0]);
  canvas.textSize(200);
  canvas.pushMatrix();
  canvas.translate(yvette.x, yvette.y + yvette.h*3/4);
  canvas.text("YVETTE",0, 0);
  canvas.popMatrix();
  
   Module chat = grid.getRandomModule(14, 4);
  canvas.fill(colors[2]);
  canvas.textSize(200);
  canvas.pushMatrix();
  canvas.translate(chat.x, chat.y + chat.h*3/4);
  canvas.text("CHAT LOGS",0, 0);
  canvas.popMatrix();
  
  
  while(true)
  {
    
    
    // get a random collection of modules max 3x4
    Module module = grid.getRandomModule(6,6);
    
    // if there are any left, draw them
    if(module != null)
    {
      if(random(1) < 0.75){
      canvas.fill(colors[int(random(0,3))]);
      }
      else{
        canvas.noStroke();
        canvas.noFill();
      }
        canvas.rect(module.x, module.y, module.w, module.h);
    }
    // else break out
    else
    {
      break;
    } 
  }
  
  // we can even implement a function that draws the grid for us
  grid.display();
  canvas.endDraw();
  
    image(canvas, 0, 0, canvas.width*0.25, canvas.height*0.25);
  
  canvas.save("grid.tiff");
}
