float k = 1;
float c = 1.2;
float k1, k2, k3, k4;

/******* User variable ***********/
int vertexNum = 20;
int vertexSize = 60;
float dt = 0.1;

float[][] matrix =
  {{0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
{0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
{0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0}, 
{0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0}, 
{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
{0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0}, 
{0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, 
{0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0}, 
{1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1}, 
{1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ,0, 0, 1, 0, 0, 0}, 
{1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
{1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0},
{1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
{0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1},
{1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0},
{1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0}};
float[] omega = new float[vertexNum];
float[] mu = new float[vertexNum];
/*********************************/

float[] accX = new float[vertexNum];
float[] accY = new float[vertexNum];
float[] veloX = new float[vertexNum];
float[] veloY = new float[vertexNum];
float[] X = new float[vertexNum];
float[] Y = new float[vertexNum];
float[] Xd = new float[vertexNum];
float[] Yd = new float[vertexNum];
float[] theta = new float[vertexNum];
float[] dtheta = new float[vertexNum];
graph[] Graph = new graph[vertexNum];

void setup() {
  size(1280, 720);
  for (int i = 0; i < vertexNum; i++) {
    Xd[i] = width/3 + 250*cos((2*PI/vertexNum)*i);
    Yd[i] = height/2 + 250*sin((2*PI/vertexNum)*i);
  }
}

void draw() {
  background(150);

  strokeWeight(2);
  noFill();
  stroke(0);
  ellipse((4*width)/5, height/2 - 100, 250, 250);
  interaction();
  float[][] t = new float[vertexNum][vertexNum];
  float[] s = new float[vertexNum];
  for (int i = 0; i < vertexNum; i++) {

    if (cos(theta[i])>0&&sin(theta[i])>0)
      s[i] = abs(1-sin(theta[i]));
    for (int j = 0; j < vertexNum; j++) {
      float[] N = {X[j]-X[i], Y[j]-Y[i]};
      if (i!=j) {
        t[i][j]  = atan2(N[1], N[0]);
      }
      if (matrix[i][j] > 0) {
        stroke(0);
        strokeWeight(2);
        line(X[i], Y[i], X[j], Y[j]);
        fill(0);
        if (matrix[i][j] > matrix[j][i]) {
          drawTriangle(0.5*X[i]+0.5*X[j], 0.5*Y[i]+0.5*Y[j], 5, t[i][j]);
        }
        if (matrix[i][j] < matrix[j][i]) {
          drawTriangle(0.5*X[i]+0.5*X[j], 0.5*Y[i]+0.5*Y[j], 5, t[i][j]);
        }
      }
    }
  }
  for (int i = 0; i < vertexNum; i++) {
    dtheta[i] = omega[i];
    for (int j = 0; j < vertexNum; j++) {
      if (i != j) {
        accX[i] =  - c*veloX[i] - k*(X[i]- Xd[i]);
        accY[i] =  - c*veloY[i] - k*(Y[i]- Yd[i]);
        if (matrix[j][i] > 0 && keyPressed ==true && key == 'c'||key == 'C') {
          dtheta[i] -=mu[i]*sin(theta[i]-theta[j]);
        }
      }
    }

    veloX[i] += accX[i]*dt;
    veloY[i] += accY[i]*dt;
    X[i] += veloX[i]*dt;
    Y[i] += veloY[i]*dt;

    k1 = dtheta[i]*dt;
    k2 = (dtheta[i] + k1/2)*dt;
    k3 = (dtheta[i] + k2/2)*dt;
    k4 = (dtheta[i] + k3)*dt;
    theta[i] += (k1 + 2*k2 + 2*k3 + k4)/6;
    //if (theta[i]>2*PI)
      //theta[i] = 0;

    Graph[i] = new graph(i);
    Graph[i].vertexColor(60*i, 255, 255);
    for (int j = 0; j < vertexNum; j++) {
      if (matrix[i][j] > 0) {
        strokeWeight(10);
        point(s[i]*X[i]+(1-s[i])*X[j], s[i]*Y[i]+(1-s[i])*Y[j]);
      }
    }

    //strokeWeight(20);
    //point((4*width)/5 + 250*cos(theta[i]-PI/2)/2, height/2 - 100 + 250*sin(theta[i]-PI/2)/2);
    //strokeWeight(15);
    //point(X[i]+ vertexSize*cos(theta[i]-PI/2)/2, Y[i]+ vertexSize*sin(theta[i]-PI/2)/2);
  }
  for (int i = 0; i < vertexNum; i++) {
    Graph[i].vertexColor(255/(i+1), 255, 255);
    Graph[i].vertexDraw(vertexSize, X[i], Y[i]);
    textSize(20);
    text("theta", (4*width)/5-130, height/2+150+30*i);
    text(i, (4*width)/5-100, height/2+150+30*i);
    text(theta[i], (4*width)/5-60, height/2+150+30*i);
    text("dtheta", (4*width)/5+60, height/2+150+30*i);
    text(i, (4*width)/5+95, height/2+150+30*i);
    text(dtheta[i], (4*width)/5+130, height/2+150+30*i);
  }

  if (keyPressed ==true && key == 'c'||key == 'C') {
    textSize(20);
    text("on control", (4*width)/5, height/2-100);
  } else {
    textSize(20);
    text("Press 'C' key to control", (4*width)/5, height/2-100);
  }
}

void interaction() {
  //user interaction rule
  if (mousePressed == true) {
    noCursor();
    if (mouseButton == LEFT) {
      for (int i = 0; i < vertexNum; i++) {
        if (abs(mouseX - Xd[i])< vertexSize/2 && abs(mouseY - Yd[i])< vertexSize/2) {
          Xd[i] = mouseX;
          Yd[i] = mouseY;
        }
      }
    }
  } else {
    cursor(HAND);
  }
}

void drawTriangle(float x, float y, int r, float theta) {
  pushMatrix();
  translate(x, y);
  rotate(theta);

  beginShape();
  for (int i = 0; i < 3; i++) {
    vertex(r*cos(radians(360*i/3)), r*sin(radians(360*i/3)));
  }
  endShape(CLOSE);

  popMatrix();
}
