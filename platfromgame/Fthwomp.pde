class FThwomp extends FGameObject {

  PImage[] thwomp;
  int timer = 0;
  int f = 0;
  int speed = 50;

  FThwomp(float x, float y) {
    super(64, 64);
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);

    thwomp = new PImage[2];
    thwomp[0] = loadImage("thwomp0.png");
    thwomp[1] = loadImage("thwomp1.png");
  }

  void act() {
    animate();
    collide();
    move();
  }
  void animate() {
    timer--;
    if ( f >= thwomp.length) f = 0;
    attachImage(thwomp[0]);

    if (getY() > 820) {
      attachImage(thwomp[1]);
    }
  }

  void collide() {
    if (isTouching("player") && (player.getY() > getY()-gridSize/2)) {
      player.lives--;
      player.setPosition(checkpointx, checkpointy);
    }
  }


  void move() {
    if (player.getY() > getY() && player.getY() < 930 && player.getX() >= getX()-gridSize) {
      float vx = getVelocityX();
      setVelocity(vx, 1);
      setStatic(false);
    }
  }
}
