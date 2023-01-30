class FHealth extends FGameObject {

  FHealth(float x, float y) {
    super();
    setPosition(x, y);
    setName("health");
    setStatic(true);
    heart.resize(gridSize, gridSize);
    attachImage(heart);
  }

  void act() {
    collide();
  }
  void collide() {
    if (isTouching("player")) {
      player.lives++;
      world.remove(this);
      terrain.remove(this);
      text("+1 lives", 400, 200);
    }
  }
}
