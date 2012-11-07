

PGraphics canvas;
int canvas_width = 3300;
int canvas_height = 5100;

PFont font;

String strangers[] = {"A", "PL", "ACE", "TO", "BU", "RY", "STR", "ANG", "ERS"};
String rainbow[] = {"BL","EE","D","IN","G", "RA", "IN", "BO", "W"};
String fuckton[] = {"F","U","C","K","","T","O","N",""};
String bowery[] = {"BO","WE","RY","B", "A","LL","R","OO","M"};
String date[] = {"N","O","V","1","8","", "8","P","M"};
String price[] = {"$", "1", "5", "", "", "", "", "", ""};

String strarr[][] = {price, date, bowery, fuckton, rainbow, strangers};


void setup()
{


  size(900, 1280, P2D);
  background(150);



  colorMode(HSB, 360, 100, 100);
  smooth();

  canvas = createGraphics(canvas_width, canvas_height, P2D);

  canvas.beginDraw();
  
  
  font = createFont("Audiowide-Regular.ttf", 200);
  canvas.textFont(font);

  canvas.noStroke();
  canvas.fill(30);
  canvas.background(255);
  ModularGrid grid = new ModularGrid(100, 154, 20, 20);


  float h= random(0, 360);
  float s= random(20, 75);
  float b=random(50, 100);

  color c1 = color(h, s, b);
  color c2 = color((h+120)%360, s, b);
  color c3 = color((h-120)%360, s, b);
  color c4 = color((h+60)%360, s, b);
  color c5 = color((h-60)%360, s, b);
  color c6 = color((h+180)%360, s, b);

  color colors[] = {
    c1, c2, c3, c4, c5, c6
  };



  canvas.fill(colors[0]);
  canvas.noStroke();
  
  canvas.rectMode(CORNER);
   for(int r = 5; r > 0; r--){
   for(int t=5; t > 0; t--){
   PVector pos = new PVector(random(0, 1300), random(0, 1000));
   
   
   int siz = int(random(1000, 2000));
   
   int col = int(random(0, 6));
   canvas.fill(colors[col]);
   canvas.noStroke();
   canvas.pushMatrix();
   canvas.translate(pos.x*r-1000, pos.y*t-1000);
  // println("r : " + pos.x*r + " s : " + pos.y*t);
   canvas.rect(0, 0, siz*r, siz*t);
   
   canvas.popMatrix();
   }
   }
   

  Module[] modules = new Module[6];

  for (int k = 5; k >= 0; k--) {
    
    

    modules[k] = grid.getRandomModule((k+1)*4, (k+1)*4);


    if (modules[k] != null) {
     

      int rad = k+1;//int(random(1, 6)); 

      canvas.pushMatrix();
      canvas.translate(modules[k].x, modules[k].y);
      for (int i=0; i < 3; i++) {
        for (int j=0; j< 3; j++) {
          
          int l = i + j*3;
       
          
          String ch = strarr[k][l];
          //println(ch);
          
          int col = int(random(0, 6));

          canvas.fill(colors[col]);   
          canvas.noStroke();   
          canvas.ellipseMode(CORNER);

          canvas.ellipse(i*rad*100, j*rad*100, rad*100, rad*100);
          canvas.fill(0);
          canvas.textSize(40*(k+1));
          canvas.textAlign(CENTER, CENTER);
          canvas.text(ch, i*rad*100+(rad*100)/2, j*rad*100+(rad*100)/2);
        }
      }

      canvas.popMatrix();
    }
    else {
      break;
    }
  }



  grid.display();

  canvas.endDraw();

  image(canvas, 0, 0, canvas.width*0.20, canvas.height*0.20);

  canvas.save("olivetti.tiff");
}

