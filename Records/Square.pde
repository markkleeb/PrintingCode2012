class Square {

  PVector loc;
  PVector siz;
  color col;
  int a;
  float fade=0.5;


  Square(PVector l, color c, PVector s) {

    loc = l.get();
    siz = s.get();
    col = c;
    a = int(random(50, 150));
  }



  void display() {


    canvas.pushMatrix();
    canvas.translate(loc.x, loc.y);
    canvas.stroke(col, a);
    canvas.strokeWeight(5);
    canvas.noFill();
    canvas.rect(0, 0, siz.x, siz.y);

    canvas.popMatrix();

    a+=fade;

    if (a > 150 || a < 50) fade*=-1;
  }
}

