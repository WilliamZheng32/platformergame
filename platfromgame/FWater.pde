class FWater extends FGameObject {

  PImage[] water;
  int numberofframes;
  int f;
  int timer;

  FWater(float x, float y) {
    super();
    setPosition(x, y);
    setName("water");

    timer = 0;
    numberofframes = 4;
    water = new PImage[numberofframes];
    int i = 0;
    while ( i < numberofframes) {
      water[i] = loadImage("water"+i+".png");
      i++;
    }

    setStatic(true);
  }


  void act() {
    timer--;
    if (timer<0) {
      attachImage(water[f]);
      timer = 25;
    }
    f++;
    if (f == numberofframes) f = (int) random(0, numberofframes);
  }
}
