class Pattern
{
  PVector loc;
  PVector area;

  float a;
  float b;
  float c;
  float d;
  float e;
  
  color col;

  Pattern(int _x, int _y, int _w, int _h, int _siz, color _col)
  {
    loc = new PVector(_x, _y);
    area = new PVector(_w, _h);

    a = _siz;
    b = _siz * 2;
    c = _siz * 3;
    d = _siz * 4;
    e = _siz *5;
    
    col = _col;
    
  }

  void display()
  {
    canvas.translate(loc.x, loc.y);
    for(float y = 0; y <= area.y; y += c) 
    {
      for(float x = 0; x <= area.x; x += d)
      {
        canvas.pushMatrix();
        
       
        
        if((y/c) % 2 == 0)  canvas.translate(x - b, y);
        else            canvas.translate(x, y);
        canvas.fill(col);
        canvas.beginShape();
        canvas.vertex(a, 0);
        canvas.bezierVertex(0, 0, 0, 0, 0, a);
        canvas.vertex(0, b-a);
        canvas.bezierVertex(0, b, a/2, b, a/2, b-a);
        canvas.vertex(a/2, b);
        canvas.vertex(a/2, a/2);
        canvas.vertex(a, a/2);
        canvas.vertex(a, b-a/4);
        canvas.bezierVertex(a, b, 3*a/2, b, 3*a/2, b-a/4);
        canvas.vertex(3*a/2, a/2);
        canvas.vertex(2*a, a/2);
        canvas.vertex(2*a, b-a/2);
        canvas.bezierVertex(2*a, b+a/2, 2*a, b+a/2, 2*a+a, b+a/2);
        canvas.vertex(9*a/2-a, b+a/2);
        canvas.bezierVertex(9*a/2, b+a/2, 9*a/2, b+a/2, 9*a/2, b-a/2);
        canvas.vertex(9*a/2, a/2);
        canvas.vertex(8*a/2, a/2);
        canvas.vertex(8*a/2, b);
        canvas.vertex(7*a/2, b);
        canvas.vertex(7*a/2, 3*a/4);
        canvas.bezierVertex(7*a/2, a/2, 6*a/2, a/2, 6*a/2, 3*a/4);
        canvas.vertex(6*a/2, b);
        canvas.vertex(5*a/2, b);
        canvas.vertex(5*a/2, a);
        canvas.bezierVertex(5*a/2, 0, 5*a/2, 0, 5*a/2-a, 0);
        
        
        canvas.endShape();

        canvas.popMatrix();
      }
    }
  }
}
