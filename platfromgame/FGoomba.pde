class FGoomba extends FGameObject {

  PImage[] goomba;
  int timer = 0;
  int f = 0;
  int direction = L;
  int speed = 50;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);

    goomba = new PImage[2];
    goomba[0] = loadImage("goomba0.png");
    goomba[0].resize(gridSize, gridSize);
    goomba[1] = loadImage("goomba1.png");
    goomba[1].resize(gridSize, gridSize);
  }

  FGoomba() {
    super(gridSize, gridSize);
  }

  void act() {
    animate();
    collide();
    move();
  }
  void animate() {
    timer--;
    if ( f >= goomba.length) f = 0;
    if (timer < 0) {
      if (direction == R) attachImage(goomba[f]);
      if (direction == L) attachImage(reverseImage(goomba[f]));
      timer = 5;
      f++;
    }
  }

  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction*5, getY());
    }

    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
      } else {
        player.lives--;
        player.setPosition(checkpointx, checkpointy);

      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
