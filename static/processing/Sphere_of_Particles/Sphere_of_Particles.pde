/* 


This sketch is created by yang wang @ 2013-11 
belongs to project Balance, collabrated with Zhenzhen Qi
http://yangwangphilo.com/
http://zhenzhenqi.info/

*/


var page_width = $( document ).width();
var page_height = $( document ).height();



ArrayList<Particle> particles;
ArrayList<Sphere> spheres;
ArrayList<PVector> tail;




int particle_amount, sphere_amount;
float false_amount_0;
float false_amount_1;
float false_amount_2;
float false_amount_3;
float false_amount_4;
float r_angle;
float sphere_radius;
float sphere_volume, connection_weight;
Slider slider;



void setup() {


  connection_weight = 0.7;
  sphere_volume = particle_amount/-10;
  sphere_radius= 220;
  size(page_width, page_height, P3D);
  particle_amount = 90;
  sphere_amount = 5;
  particles = new ArrayList<Particle>();
  spheres = new ArrayList<Sphere>();
  tail = new ArrayList<PVector>();
  slider = new Slider();
  for (int i=0;i<sphere_amount;i++) {
    spheres.add(new Sphere());
  }

  for (int i=0;i<particle_amount;i++) {
    particles.add(new Particle());
  }
}



void draw() {



  background(0);
  slider.display();

  translate(0, 0, -1000);

  for (Particle this_particle:particles) {


    //draw mesh


    for ( int p=0 ; p < particles.size(); p++) {  

      if (this_particle.travelling == true && particles.get(p).travelling == true
        && 
        PVector.dist(this_particle.location, particles.get(p).location) < 80
        &&
        (
      spheres.get(parseInt(this_particle.origin)).location == particles.get(p).target
        || 
        this_particle.target ==  spheres.get(parseInt(particles.get(p).origin)).location
        ||
        this_particle.target == particles.get(p).target
        ||
        this_particle.origin == particles.get(p).origin
        )
        ) {
        strokeWeight(connection_weight);
        stroke(255, 150);
        line(particles.get(p).location.x, particles.get(p).location.y, particles.get(p).location.z, 
        this_particle.location.x, this_particle.location.y, this_particle.location.z);
        stroke(255, 150);
        line(this_particle.location.x, this_particle.location.y, this_particle.location.z, this_particle.target.x, this_particle.target.y, this_particle.target.z);
        line(this_particle.location.x, this_particle.location.y, this_particle.location.z, 
        spheres.get(parseInt(this_particle.origin)).location.x, 
        spheres.get(parseInt(this_particle.origin)).location.y, 
        spheres.get(parseInt(this_particle.origin)).location.z);
      }

      if (this_particle.travelling == false && particles.get(p).travelling == false) {

        if (PVector.dist(particles.get(p).location, this_particle.location)< 430) 
        {
          strokeWeight(connection_weight);
          stroke(255);
          line(particles.get(p).location.x, particles.get(p).location.y, particles.get(p).location.z, 
          this_particle.location.x, this_particle.location.y, this_particle.location.z);
        }
      }
    }

    //end mesh drawing



    if (this_particle.id=="0" ) {
      spheres.get(0).particle_count++;
    }
    if (this_particle.id=="1" ) {
      spheres.get(1).particle_count++;
    }
    if (this_particle.id=="2" ) {
      spheres.get(2).particle_count++;
    }

    if (this_particle.id=="3" ) {
      spheres.get(3).particle_count++;
    }
    if (this_particle.id=="4" ) {
      spheres.get(4).particle_count++;
    }





    if (this_particle.travelling == false) {
      if (this_particle.id == "0") {
        this_particle.haunt(spheres.get(0).location);
        this_particle.origin = "0";
        false_amount_0++;
        if (false_amount_0 >= particle_amount/5 - spheres.get(0).release_amount) {
          for (int i=0;i<spheres.get(0).release_amount;i++) {
            this_particle.travelling = true;
          }
        }
      }
      if (this_particle.id == "1") {
        this_particle.haunt(spheres.get(1).location);
        this_particle.origin = "1";
        false_amount_1++;
        if (false_amount_1 >= particle_amount/5 - spheres.get(1).release_amount) {
          for (int i=0;i<spheres.get(1).release_amount;i++) {
            this_particle.travelling = true;
          }
        }
      }
      if (this_particle.id == "2") {
        this_particle.haunt(spheres.get(2).location);
        this_particle.origin = "2";
        false_amount_2++;
        if (false_amount_2 >= particle_amount/5 - spheres.get(2).release_amount) {
          for (int i=0;i<spheres.get(2).release_amount;i++) {
            this_particle.travelling = true;
          }
        }
      }
      if (this_particle.id == "3") {
        this_particle.haunt(spheres.get(3).location);
        this_particle.origin = "3";
        false_amount_3++;
        if (false_amount_3 >= particle_amount/5 - spheres.get(3).release_amount) {
          for (int i=0;i<spheres.get(3).release_amount;i++) {
            this_particle.travelling = true;
          }
        }
      }
      if (this_particle.id == "4") {
        this_particle.haunt(spheres.get(4).location);
        this_particle.origin = "4";
        false_amount_4++;
        if (false_amount_4 >= particle_amount/5 - spheres.get(4).release_amount) {
          for (int i=0;i<spheres.get(4).release_amount;i++) {
            this_particle.travelling = true;
          }
        }
      }
    }


    if (this_particle.travelling == true) {
      if (this_particle.has_a_target == false) {
        this_particle.seek_target_move();
      }
      this_particle.target.set(
      spheres.get(parseInt(this_particle.id)).location.x, 
      spheres.get(parseInt(this_particle.id)).location.y, 
      spheres.get(parseInt(this_particle.id)).location.z);



      this_particle.move_towards_target();
      if (PVector.sub(this_particle.target, this_particle.location).mag() < sphere_radius+random(-20, -10)) {
        this_particle.travelling = false;
        this_particle.has_a_target = false;
      }
    }



    this_particle.display();
  }

  for (int i=0;i<spheres.size();i++) {

    for (Sphere this_sphere:spheres) {
      if (abs(this_sphere.location.z - spheres.get(i).location.z) < 800) {
        this_sphere.velocity.set(this_sphere.velocity.x, this_sphere.velocity.y, this_sphere.velocity.z * -1);
      }
    }
    spheres.get(i).move();
    spheres.get(i).decide();
  }

  spheres.get(0).particle_count = 0;
  spheres.get(1).particle_count = 0;
  spheres.get(2).particle_count = 0;
  spheres.get(3).particle_count = 0;
  spheres.get(4).particle_count = 0;
  false_amount_0=0;
  false_amount_1=0;
  false_amount_2=0;
  false_amount_3=0;
  false_amount_4=0; 


  for (Particle this_particle:particles) {
    this_particle.connected = false;
    this_particle.origin_connected = false;
    this_particle.target_connected = false;
  }
}


void mouseDragged() {

  slider.moveScale();
  sphere_volume=map(slider.xscale, slider.xhead, slider.xhead+slider.myW, 0, 1);
}
void drawSphere(int i) {
  pushMatrix();
  stroke(255, 0, 0);
  noFill();
  sphereDetail(20, 20);
  translate(spheres.get(i).location.x, spheres.get(i).location.y, spheres.get(i).location.z);
  sphere(sphere_radius);
  popMatrix();
}

class Particle {
  float diameter;
  float noise_seed;
  float speed, minSpeed, maxforce, haunting_speed;
  PVector location;
  PVector velocity;
  PVector target;
  boolean travelling, has_a_target, connected, origin_connected, target_connected;
  String id;
  float angle;
  float floating;
  PVector temp_target;
  PVector acceleration;
  ArrayList<PVector> tail;
  float  u, v;
  String origin;

  Particle() {
    haunting_speed = random(0.0005, 0.004);
    connected = false;
    origin_connected = false;
    target_connected = false;
    u = random(0, 40);
    v = random(0, 40);
    temp_target = new PVector(0, 0, 0);
    tail = new ArrayList<PVector>();
    speed  = 8;
    angle=0;
    floating=8;
    maxforce=0.5;
    travelling = false;
    has_a_target = false;
    acceleration = new PVector(0, 0);
    location = new PVector(0, 0, 0);
    float random_number = (random(sphere_amount));
    minSpeed = 0.3 * ( 1-sphere_volume );
    int random_int=0;
    if (random_number>=1)random_int = 1;
    if (random_number<1)random_int = 0;
    if ( random_number>=2)random_int = 2;

    if ( random_number>=3)random_int = 3;
    if ( random_number>=4)random_int = 4;

    if (random_int==0) {
      location = spheres.get(0).location.get();
      id="0";
    }
    if (random_int==1) {
      location = spheres.get(1).location.get();
      id="1";
    }
    if (random_int==2) {
      location = spheres.get(2).location.get();
      id="2";
    }
    if (random_int==3) {
      location = spheres.get(3).location.get();
      id="3";
    }
    if (random_int==4) {
      location = spheres.get(4).location.get();
      id="4";
    }

    origin = id;


    velocity = new PVector(random(-0.5, 0.5), random(-0.5, 0.5), random(-0.5, 0.5));
    target = new PVector(0, 0, 0);
  }



  void haunt(PVector target_location) { 
    u = u+ (0.001 + haunting_speed);  
    v = v+(0.001+ haunting_speed); 
    location.x = sphere_radius * sin(u) * cos(v)+target_location.x;
    location.y = sphere_radius * cos(u) * cos(v)+target_location.y;
    location.z = sphere_radius * sin(v) + target_location.z;
  }



  void seek_target_move() {


    for (int i=0;i<sphere_amount;i++) {
      float random_number = (random(sphere_amount));
      int random_int=0;
      if (random_number<1) random_int = 0;
      if (random_number>=1)random_int = 1;
      if ( random_number>=2)random_int = 2;
      if (random_number>=3) random_int = 3;
      if ( random_number>=4)random_int = 4;


      if (random_int==0) {

        target = spheres.get(0).location.get();
        id = "0";
        travelling = true;
        has_a_target = true;
        break;
      }

      if (random_int==1) {
        target = spheres.get(1).location.get();
        id = "1";
        travelling = true;
        has_a_target = true;
        break;
      }

      if (random_int==2) {
        target = spheres.get(2).location.get();
        id = "2";
        travelling = true;
        has_a_target = true;
        break;
      }
      if (random_int==3) {
        target = spheres.get(3).location.get();
        id = "3";
        travelling = true;
        has_a_target = true;
        break;
      }
      if (random_int==4) {
        target = spheres.get(4).location.get();
        id = "4";
        travelling = true;
        has_a_target = true;
        break;
      }
    }
  }

  void move_towards_target() {
    minSpeed = 1 * ( 1-sphere_volume );
    PVector desired = PVector.sub(target, location);//get "should" direction
    desired.normalize();//get the dir. with a unit length
    desired.mult(speed*sphere_volume+minSpeed);
    PVector steer = PVector.sub(desired, velocity); //get move dir.
    steer.limit(maxforce);//limit the force to make a better animation...
    acceleration.add(steer);
    velocity.add(acceleration);//acce. it
    //  velocity.limit(speed*sphere_volume+minSpeed);
    location.add(velocity);//literally MOVE
    acceleration.mult(0);
  }

  void display() {
    pushMatrix();
    fill(255);
    noStroke();
    translate(location.x, location.y, location.z);
    sphereDetail(3, 3);
    sphere(8);
    popMatrix();
  }




  void update_tail() {
    tail.add(new PVector(location.x, location.y, location.z));
    if (tail.size()>80)tail.remove(0);
  }


  void display_tail() {
    for (int i=0;i<tail.size();i++) {

      stroke(255);
      strokeWeight(0.5);
      point(tail.get(i).x, tail.get(i).y, tail.get(i).z);
    }
  }
}


class Slider {

  int xword, yword, xhead, yhead, xscale, yscale, myW, myH, myS;

  Slider() {
    
    xhead = 90;
    yhead = height - 35;
    myW = 240;
    myH = 10;
    myS = 20;
    xword = xhead-70;
    yword = yhead;
    xscale = xhead+myW-myS;
    yscale = yhead;
    
  }

  void display() {

    strokeWeight(0.5);
    fill(200);
    text("STILL", xword, yword);


    noStroke();
    fill(200, 200);
    rect(xscale, yscale, myS, myH);


    noStroke();
    fill(100, 200);
    rect(xhead, yhead, myW, myH);
  }

  void moveScale() {
    if (mouseX>xhead && mouseX<xhead+myW && mouseY>yhead - 20 && mouseY< yhead+myH+20) {
      xscale=mouseX-myS/2;
      xscale=constrain(xscale, xhead, xhead+myW-myS);
    }
  }
}

class Sphere {

  PVector location;
  PVector velocity;
  PVector center ;


  float particle_count;
  float release_amount;
  float noise_seed;
  float  u, v, moving_speed;
  float The_radius;

  Sphere () {

    The_radius = 800;
    moving_speed = random(0.001, 0.007) * 0.1;
    u = random(0, 40);
    v = random(0, 40);
    particle_count = 0;
    velocity = new PVector(random(-0.03, 0.03), random(-0.03, 0.03), random(-0.03, 0.03));  
    center = new PVector(width/2, height/2, 0);
    noise_seed = 0;
    location  = new PVector(random(0, width), random(0, height), random(-1000, 1000));
  }


  void move() {
    u = u + (0.001 + moving_speed );  
    v = v + (0.001 + moving_speed ); 
    location.x = The_radius*1.3 * sin(u) * cos(v)+ center.x;
    location.y = The_radius*0.8 * cos(u) * cos(v)+center.y;
    location.z = The_radius*1.5 * sin(v) + center.z;
  }

  void decide() {
    release_amount = sphere_volume*particle_count*0.6;
  }
}



