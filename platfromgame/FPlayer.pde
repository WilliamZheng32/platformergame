class FPlayer extends FGameObject {

  int lives = 4;
  int frame = 0;
  int timer = 0;
  int direction = R;

  int numberofframes;
  PImage[]action;
  PImage[] idle = new PImage[2];
  PImage[] jump = new PImage[1];
  PImage[] run = new PImage[3];

  FPlayer() {
    super();
    checkpointx = 50;
    checkpointy = 1300;
    setPosition(checkpointx, checkpointy); //(50,1300);
    setName("player");
    setRotatable(false);

    idle[0] = loadImage("idle0.png");
    idle[1] = loadImage("idle1.png");

    jump[0] = loadImage("jump0.png");

    run[0] = loadImage("runright0.png");
    run[1] = loadImage("runright1.png");
    run[2] = loadImage("runright2.png");

    action = idle;
  }

  void act() {
    println(lives);
    handleinput();
    collisions();
    animate();
  }

  void collisions() {

    if (isTouching("checkpoint")) {
      checkpointx = getX();
      checkpointy = getY();
    }
    if (isTouching("spike") || (isTouching("lava")) || (isTouching("hammer"))) {
      setPosition(checkpointx, checkpointy);
      lives--;
    }

    if (isTouching("flag")) {
      textSize(100);
      fill(blue);
      textFont(SuperMario);
      text("YOU WIN!", 400, 300);
      reset();
    }

    if (lives <= 0) {
      textSize(100);
      fill(darkred);
      textFont(SuperMario);
      text("GAMEOVER!", 400, 300);
      textSize(10);
      reset();
    }
  }
  void animate() {
    if (frame >= action.length) frame = 0;
    timer--;
    if (timer<0) {
      timer = 25;
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
    }
    frame++;

    int i = 0;
    int x = 50;
    while (i<lives) {
      heart.resize(64, 64);
      image(heart, x, 50);
      i++;
      x+=50;
    }
  }

  void handleinput() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    } else if (!akey) {
      action = idle;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (skey) setVelocity(vx, 200);
    if (spacekey) {
      setVelocity(vx, -300);
      action = jump;
    }
  }
  void reset() {
    if (mousePressed) {
      lives = 4;
      checkpointx = 50;
      checkpointy = 1300;
      setPosition(checkpointx, checkpointy);
      makeWorld(map);
      loadPlayer();
    }
  }
}
