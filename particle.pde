class particle{
  private float posx,posy;
  private float velx,vely;
  private int[] colour_variance;
  private int type;
  
  public particle(float posx,float posy, float velx, float vely,int type, int[] colour_variance){
    this.posx = posx;
    this.posy = posy;
    this.velx = velx;
    this.vely = vely;
    this.type = type;
    this.colour_variance = colour_variance;
  }
  
  public void gravitate(){
    for(particle p : particles){
      if(p.type != this.type){
        float distance = sq(posx-p.posx) + sq(posy-p.posy);
        
        //convert particle
        if(distance < conversion_range && (type+1) % types == p.type)p.type = type;
        
        //succ particle
        else if (distance < gravity_range){
          float angle = atan2(p.posy-posy, p.posx-posx);
          if((type+1) % types == p.type){
            velx += gravity * cos(angle) / distance;
            vely += gravity * sin(angle) / distance;
          }
          else if((type-1) % types == p.type){
            velx -= repulsion * gravity * cos(angle) / distance;
            vely -= repulsion * gravity * sin(angle) / distance;
          }
        }
      }
    }
  }
  
  public void move(){
    //Drag
    velx *= drag;
    vely *= drag;
    
    if(abs(velx) > speed_limit)velx = sign(velx) * speed_limit;
    if(abs(vely) > speed_limit)vely = sign(vely) * speed_limit;
    
    
    // Moving
    posx += velx;
    posy += vely;
  }
  
  public void bounce(){
    if((posx < -width /2 - 100)||(posx > width /2 + 100))velx *= -1;
    if((posy < -height/2 - 100)||(posy > height/2 + 100))vely *= -1;
  }
  
  public void show(){
    int[] colour = colors[type];
    if(type <= 4)fill(colour[0]+colour_variance[0], colour[1]+colour_variance[1], colour[2] + colour_variance[2]);
    ellipse(posx, posy, particle_diameter, particle_diameter);
  }
}
