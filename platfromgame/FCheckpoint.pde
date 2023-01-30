class FCheckpoint extends FGameObject {

  FCheckpoint(float x, float y) {
    super();
    setPosition(x, y);
    setName("checkpoint");
    setStatic(true);
    checkpoint.resize(gridSize+5, gridSize+5);
    attachImage(checkpoint);
  }

  void act() {
    if (isTouching("player")) {
      checkpointx = getX();
      checkpointy = getY();
      fill(green);
      textSize(20);
      textFont(SuperMario);
      text("checkpoint", 400, 200);
    }
  }
}
