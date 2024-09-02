class graph {
  int textsize = 45;
  int weight = 60;
  int num = 0;
  int h = 255;
  int s = 255;
  int b = 255;
  float x;
  float y;

  graph(int num_) {
    num = num_;
  }
  
  void vertexColor(int h_, int s_, int b_){
    h = h_;
    s = s_;
    b = b_;
    colorMode(HSB);
    stroke(h, s, b);
  }

  void vertexDraw(int weight_, float x_, float y_) {
    if (weight_ > 1) {
      textsize = weight * 1/2;
    } else {
      textsize = 1;
    }
    weight = weight_;
    x = x_;
    y = y_;
    fill(220);
    strokeWeight(2);
    ellipseMode(DIAMETER);
    ellipse(x, y, weight, weight);
    textAlign(CENTER);
    textSize(textsize);
    fill(0);
    text(num+1, x, y+textsize*1/3);
    stroke(0);
  }
}
