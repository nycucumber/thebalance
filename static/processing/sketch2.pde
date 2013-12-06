
var page_width = $( document ).width();
var page_height = $( document ).height();

console.log(page_width);
console.log(page_height);

ArrayList<Curve> curves;
Slider slider;
Curve finalC;
Ball ball;
boolean record;

float a;
float rx, ry, rz;

int seg;
void setup() {
  frameRate(60);
  size(page_width, page_height, P3D);
  rx=ry=rz=0;
  seg=0;
  record = false;
  a=0;

  curves = new ArrayList<Curve>(); 
  slider = new Slider();
  finalC = new Curve(0);
  ball = new Ball();
}

void draw() {


  background(255);
  
  slider.display();

  translate(width/2, height/2, 0);
  scale(100);
  rotateX(radians(frameCount*0.18));
  rotateY(radians(frameCount*0.2));


  for (int i=0; i<curves.size(); i++) {
      curves.get(i).displayLineFade(i);
//    curves.get(i).displayDot(i);
    if (curves.get(i).myTrans>100) {
      curves.remove(0);
    }
  }

  if (ball.move) {
    ball.display(curves.get(curves.size()-1));
  }
  if (ball.pause) {
    ball.stay();
  }
  //  println("------");
  //  println(ball.move+"   "+ball.pause);
}



void mouseDragged() {
  if (mouseX>slider.xhead+25 & mouseX<slider.xhead+slider.myW-25 & mouseY>slider.yhead - 100 & mouseY< slider.yhead+slider.myH+100) 
  {
    slider.moveScale();
    a=map(mouseX, slider.xhead+25, slider.xhead+slider.myW-25, -3, 3);
    curves.add(new Curve(a));
  }
}

void mouseReleased() {
  ball.move=true;
}

class Ball {
  int i;
  boolean move;
  boolean pause;
  Curve finalC;

  Ball() {
    i = 0;
  }

  void display(Curve tmp) {
    finalC=tmp;
    pushMatrix();
//    stroke(0);
//    strokeWeight(10);
    
    translate(finalC.x[i], finalC.y[i], finalC.z[i]);
    noStroke();
   
    sphere(0.04);
    popMatrix();
    i++;
    if (i==finalC.x.length-1) {
      //      move=false;
      i=0;
    }
  }

  void stay() {
    stroke(0);
    strokeWeight(10);
    point(finalC.x[i], finalC.y[i], finalC.z[i]);
  }
}

class Curve {

  float[] x, y, z, t;

  float a, step, degree, myTrans;

  int  start, end, myColor;

  Curve(float tmp_a) {
    a=tmp_a;

    start=-3;
    end=3;
    step = 0.06; 

    myTrans=250;

    x = new float[(int)((end-start)/step)+1];
    y = new float[(int)((end-start)/step)+1];
    z = new float[(int)((end-start)/step)+1];
    t = new float[(int)((end-start)/step)+1];

    for (int i=0; i<x.length; i++) {
      t[i] = start + i*step;
      degree = map(t[i], start, end, 0, 2*PI);
      x[i] = cos(degree)*a-a;
      y[i] = sin(degree)*a;
      z[i]= t[i];
      //      z[i] = sin(t[i]*PI/4+1.6)+0.7;
    }
  }

  void displayDot(int tmp_i) {
    myTrans = tmp_i*8;
    float myWeight = 0.01;
    strokeWeight(1);
    stroke(0, myTrans);
    
    for ( int i=0;i<t.length-1;i++) {
      point(x[i], y[i], z[i]);
    }
  }

  void displayLine() {
    strokeWeight(1);
    stroke(230, 255);
    for ( int i=0;i<t.length-1;i++) {
      line(x[i], y[i], z[i], x[i+1], y[i+1], z[i+1]);
    }
  }

  void displayLineFade(int tmp_i) {
    myTrans = tmp_i*8;
    float myWeight = 0.01;
    strokeWeight(myWeight);
    stroke(0, myTrans);

    for (int j=0; j<t.length-1; j++) {
      line(x[j], y[j], z[j], x[j+1], y[j+1], z[j+1]);
    }
  }
}

class Slider {

  int xword, yword, xhead, yhead, xscale, yscale, myW, myH, myS;

  Slider() {
    xhead = 130;
    yhead = height - 40;
    myW = 300;
    myH = 10;
    myS = 50;
    xword = xhead-myS;
    yword = yhead+9;
    xscale = xhead+myW/2-25;
    yscale = yhead;
  }

  void display() {
    //legend
    strokeWeight(0.5);
    fill(150);
    text("Detour", xword, yword);


 //slider
    noStroke();
    fill(150);
//    rect(xscale, yscale, 50, myH, 2);
    rect(xscale, yscale, 50, myH);
    
    
    //frame
    noStroke();
    fill(200);
//    rect(xhead, yhead, myW, myH, 2);
    rect(xhead, yhead, myW, myH);

   
  }

  void moveScale() {
      xscale=mouseX-25;
  }
  
}

