class FLava extends FGameObject {

  PImage[] lava;
  int numberofframes;
  int f;
  int timer;

  FLava(float x, float y) {
    super();
    setPosition(x, y);
    setName("lava");

    timer = 0;
    numberofframes = 6;
    lava = new PImage[numberofframes];
    int i = 0;
    while ( i < numberofframes) {
      lava[i] = loadImage("lava"+i+".png");
      i++;
    }

    setStatic(true);
  }


  void act() {
    timer--;
    if (timer<0) {
      attachImage(lava[f]);
      timer = 25;
    }
    f++;
    if ( f == numberofframes) f = (int) random(0, numberofframes);
  }
}
