class FHammerbro extends FGoomba {

  PImage[] hammerbro;
  //int direction = L;

  FHammerbro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hammerbro");
    hammerbro = new PImage[2];
    hammerbro[0] = loadImage("hammerbro0.png");
    hammerbro[1] = loadImage("hammerbro1.png");
  }
  void act() {
    animate();
    collide();
    move();
    makeHammer();
  }

  void animate() {
    timer--;
    if ( f >= hammerbro.length) f = 0;
    if (timer < 0) {
      if (direction == R) attachImage(hammerbro[f]);
      if (direction == L) attachImage(reverseImage(hammerbro[f]));
      timer = 10;
      f++;
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
  void makeHammer() {
    FBox b = new FBox(50, 50);
    b.setPosition(getX(),getY());
    b.attachImage(hammer);
    b.setVelocity(100, -650);
    b.setAngularVelocity(100);
    b.setName("hammer");
    b.setSensor(true);
    if(frameCount % 150 == 0){
    world.add(b);
      } 
    }
     
 
}
