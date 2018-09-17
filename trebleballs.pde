// some kind of simulation partially made by James Kee and a unnamed friend
// contains 5 types of balls 0, 1, 2, 3, 4
//
// particles are attracted to one with a value one higher
// and repulsed to one with a value lesser
// if they are too close it will be converted to the lesser value
//
// attraction and repulsion is inversely proportional to the square of distance between the balls
//
// 5 balls was chosen as you have a compromise of balls directly interacting with eachother and not interacting with eachor 

ArrayList<particle> particles = new ArrayList<particle>();
int types = 5;

// Movement variables
float gravity = 10;
float repulsion = 0.2;
float drag = 0.95;
float speed_limit = 15;

// Range values
float conversion_range = 6;
float gravity_range = 150;

// Spawning properties
int balls = 100;

int start_distance = 10;
int ball_spacing = 4;
float angle_shift = 0.125;

// Appearance properties
int particle_diameter = 6;
int colors[][] = {{0,0,250},{250,0,0},{35,250,20},{250,175,0},{220,0,130},{250,250,250}};

// HOW THE PATHS FADE
void fade(){
  if(frameCount % 5 == 0){
   fill(0, 0, 0, 20);
   loadPixels();
   for(int i = 0; i < width*height ; i++)if(brightness(pixels[i])<10)pixels[i]=color(0);
   updatePixels();
 }
 else fill(0,0,0,4);
 rect(0, 0, width, height);
}

float sign(float num){
  if(num >= 0)return 1;
  else return -1;
}

void setup(){
  size(1600, 900);
  noStroke();
  background(0);
  
  conversion_range = sq(conversion_range);
  gravity_range = sq(gravity_range);
  
  // SPAWN BALLS
  for(int i = 0; i < types; i++){
    float angle = TWO_PI/types*i;
    float dis = start_distance;
    float shift = 0;
    for(float j = 0; j < balls; j++){
      int[] color_variance = {int(random(10,100)), int(random(10,100)), int(random(10,100))};
      particles.add(new particle(dis*cos(angle+shift), dis*sin(angle+shift), 0, 0, i, color_variance));
      dis += ball_spacing;
      shift += angle_shift;
    }
  }
  noStroke();
}

void draw(){
 fade();
 translate(width/2, height/2);
 for(particle p: particles){
   p.gravitate();
   p.move();
   p.bounce();
   p.show();
 }
 
 println(frameRate);
}
