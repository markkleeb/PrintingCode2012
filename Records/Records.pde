import geomerative.*;

//setup Canvas
//---------------------------------------
PGraphics canvas;
int canvas_width = 4200;
int canvas_height = 2100;

//Colors---------------------------------
color color1, color2, color3, color4;
color[] colors = {
  0, 0, 0
};

//Fonts-----------------------------------
PFont font2;
RPoint[] pnts1;
RPoint[] pnts2;

//Particles-------------------------------

ArrayList<Particle> particles = new ArrayList();

void setup() 
{
  //Setup Window------------------------------
  size(1280, 800, P3D);

  smooth();

  //Setup Colors--------------------------------
  colorMode(HSB, 360, 100, 100);

  float h = random(0, 360);
  float s = random(50, 100);
  float b = random(50, 100);

  color1 = color(h+60, s, b);
  color2 = color((h-60)%360, s, b);
  color3 = color((h)%360, s, b);
  color4 = color((h+180)%360, s, b);

  colors[0] = color1;
  colors[1] = color2;
  colors[2] = color3;



  //Setup Fonts-----------------------------------------
  font2 = createFont("Audiowide-Regular.ttf", 50);

  int fontSize = 400;
  RG.init(this);
  RFont font = new RFont("Audiowide-Regular.ttf", fontSize, RFont.LEFT);
  // tell library we want 11px between each point on the font path
  RCommand.setSegmentLength(25);


  RGroup grp1;
  grp1 = font.toGroup("CLINTON");
  grp1 = grp1.toPolygonGroup();
  pnts1 = grp1.getPoints();


  RGroup grp2;
  grp2 = font.toGroup("GORE");
  grp2 = grp2.toPolygonGroup();
  pnts2 = grp2.getPoints();

  //Create canvas-------------------------------------------
  canvas = createGraphics(canvas_width, canvas_height, P2D);  


  //Particles
  for (int i=0; i<50; i++) {

    Particle particle = new Particle(new PVector(random(2100, 4200), int(random(0, canvas_height))), 4.0, 0.1, colors[2]); 
    particles.add(particle);
  }
}



void draw() {

  background(150);
  canvas.beginDraw();


  canvas.textFont(font2, 60);
  canvas.background(color4);


  //Squares
  //----------------------------------------------------

  for (int i=0; i < 250; i++) {

    canvas.pushMatrix();

    canvas.translate(random(0, canvas.width/2-200), random(0, canvas.height));
    canvas.stroke(colors[int(random(0, 2))]);
    canvas.strokeWeight(5);
    canvas.noFill();
    canvas.rect(0, 0, random(0, 200), random(0, 200));

    canvas.popMatrix();
  }

  //ellipses
  //*-----------------------------------------------------
  //  for(int i=0; i <250; i++){
  //    canvas.ellipseMode(CORNER);
  //   canvas.pushMatrix();
  //   canvas.translate(random(0, canvas.width/2-200), random(0, canvas.height));
  //   canvas.noStroke();
  //    canvas.fill(colors[int(random(0,2))]);
  //   canvas.strokeWeight(5);
  //  
  // canvas.ellipse(0,0, random(0, 200), random(0, 200));
  //canvas.popMatrix(); 
  //    
  //    
  //  }


  //Main title----------------------------------------------
  //CLINTON
  canvas.pushMatrix();
  canvas.translate(canvas.width/2+50, 700);
  canvas.fill(color3);
  canvas.noStroke();
  for (int i = 0; i < pnts1.length; i++ ) 
  {

    //canvas.pushMatrix();
    //canvas.translate(pnts1[i].x, pnts1[i].y);
    //canvas.rotate(random(-PI/6, PI/6));
    //canvas.rect(0, 0, 25, 50);
    //canvas.popMatrix();

    for (int j=0; j < particles.size(); j++) {
      Particle p = particles.get(j);
      if (p.loc.x == pnts1[i].x && p.loc.y == pnts1[i].y) {
        p.seek(new PVector(pnts1[i].x, pnts1[i].y));
        p.run();
      }

      else {

        p.wander();
        p.run();
      }
    }
  }
  canvas.popMatrix();



  //GORE  
  canvas.pushMatrix();
  canvas.translate(canvas.width/2+350, 1400);
  canvas.fill(color3);
  canvas.noStroke();
  for (int i = 0; i < pnts2.length; i++ ) 
  {

    //    canvas.pushMatrix();
    //    canvas.translate(pnts2[i].x, pnts2[i].y);
    //    canvas.rotate(random(-PI/6, PI/6));
    //    canvas.rect(0, 0, 25, 50);
    //    canvas.popMatrix();
    for (int j=0; j < particles.size(); j++) {
      Particle p = particles.get(j);
      if (p.loc.x == pnts2[i].x && p.loc.y == pnts2[i].y) {
        p.seek(new PVector(pnts2[i].x, pnts2[i].y));
        p.run();
      }

      else {

        p.wander();
        p.run();
      }
    }
  }
  canvas.popMatrix();



  //Liner Notes----------------------------------------------
  canvas.stroke(0);
  canvas.strokeWeight(5);


  //Track 1
  canvas.pushMatrix();
  canvas.translate(int(random(0, 1000)), int(random(50, canvas.height/3-200)));
  canvas.fill(colors[2]);
  canvas.text("TRACK 1 - I NEED A STAR", 0, 0);
  canvas.text("DRUMS & SYNTH - CHRIS CRAWFORD", 0, 50);
  canvas.text("GUITARS - ROLAND CURTIS", 0, 100);
  canvas.text("VOX - SIERRA FROST", 0, 150);
  canvas.popMatrix();


  //Track 2  
  canvas.pushMatrix();
  canvas.translate(int(random(0, 1000)), int(random(canvas.height/3, 2*canvas.height/3-200)));
  canvas.fill(colors[2]);
  canvas.text("TRACK 2 - YOU'RE SO BAD", 0, 0);
  canvas.text("ORIGINAL SONG BY TOM PETTY", 0, 50);
  canvas.text("DRUMS & SYNTH - CHRIS CRAWFORD", 0, 100);
  canvas.text("VOX - SIERRA FROST", 0, 150);
  canvas.popMatrix();


  //Credits
  canvas.pushMatrix();
  canvas.translate(int(random(0, 1000)), int(random(2*canvas.height/3, canvas.height-200)));
  canvas.fill(colors[2]);
  canvas.text("RECORDED AND MIXED AT", 0, 0);
  canvas.text("DEATH BY AUDIO", 0, 50);
  canvas.text("BROOKLYN, NY", 0, 100);
  canvas.popMatrix();


  //Fold along this line
  canvas.stroke(10);
  canvas.line(canvas.width/2, 0, canvas.width/2, canvas.height);


  canvas.endDraw();

  //Display image
  image(canvas, 0, 0, canvas.width*0.3, canvas.height*0.3);
}


void keyPressed()
{
  if (key == 's')
  {  
    println("Saving Image");
    canvas.save("clintongore" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".tiff");
    println("Saved Image");
  }
}








