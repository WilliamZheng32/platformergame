import fisica.*;
FWorld world;

float checkpointx;
float checkpointy;

//pallete
color white = #ffffff;
color blue = #0000FF;
color purple = #A020F0;
color green = #0dFF00;
color darkred = #8B0000;

//terrain
color brickblack = #000000;//brick
color trampolineyellow = #ffff00;//trampoline
color treetrunkbrown = #3d2309;
color iceblue = #6ac3e6;
color spikegrey = #a1a1a1;
color waterblue = #2d2d80;
color bridgebrown = #c48037;
color lavared = #ff0000;
color wall = #787878;
color checkpointred = #990030;
color flaggrey = #464646;
color healthred = #b71c1c;

//enemies
color goombaorange = #ff8400;
color thowmppink = #edc5c5;
color hammerbropurple = #9d00ff;
color hammerpurple = #bf79e8;

//Fonts
PFont SuperMario;

PImage map;
PImage brick, ice, lefttree, righttree, treetrunk, treeintersect, treecenter, spike, bridge, trampoline, lava0, lava1, lava2, lava3, lava4, lava5, water0, water1, water2, water3;
PImage goomba0, goomba1, thwomp0, thwomp1, hammerbro0, hammerbro1, hammer, heart, checkpoint, flag;
int gridSize = 32;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, spacekey;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
float zoom =1.5;

void setup() {
  size(800, 800);
  Fisica.init(this);
  loadArrays();
  loadImages();
  makeWorld(map);
  loadPlayer();
}
//=====================================================================================================================================


void loadArrays() {
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
}
void loadImages() {
  map = loadImage("map.png");
  brick = loadImage("brick.png");
  lefttree = loadImage("treeleft.png");
  righttree = loadImage("treeright.png");
  treetrunk = loadImage("treetrunk.png");
  treeintersect = loadImage("treeintersect.png");
  treecenter = loadImage("treecenter.png");
  ice = loadImage("ice.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge.png");
  trampoline = loadImage("trampoline.png");
  hammer = loadImage("hammer.png");
  heart = loadImage("heart.png");
  checkpoint = loadImage("checkpoint.png");
  flag = loadImage("flag.png");
  //Load Fonts
  SuperMario = createFont("SuperMario.ttf", 100);

  textAlign(CENTER, CENTER);
}

void makeWorld(PImage img) {

  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); // color of current pixel
      color s = img.get(x, y+1); //color below current pixel
      color w = img.get(x-1, y); //color west current pixel
      color e = img.get(x+1, y); //color east current pixel

      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      b.setGrabbable(false);
      b.setFriction(4);

      if (c == brickblack) {
        b.attachImage(brick);
        b.setName("brick");

        world.add(b);
      } else if (c == iceblue) {

        b.attachImage(ice);
        ice.resize(gridSize, gridSize);
        b.setName("ice");
        b.setFriction(0.01);
        world.add(b);
      } else if (c == treetrunkbrown) {
        b.attachImage(treetrunk);
        b.setName("treetrunk");
        b.setSensor(true);
        world.add(b);
      } else if (c == green && s == treetrunkbrown) {
        b.attachImage(treeintersect);
        b.setName("treeintersect");
        world.add(b);
      } else if (c == green && w == green && e == green) {
        b.attachImage(treecenter);
        b.setName("treeinside");
        world.add(b);
      } else if (c == green && e != green) {
        b.attachImage(righttree);
        b.setName("righttree");
        world.add(b);
      } else if (c == green && w !=green) {
        b.attachImage(lefttree);
        b.setName("treeleft");
        world.add(b);
      } else if (c == spikegrey) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == bridgebrown) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == trampolineyellow) {
        b.attachImage(trampoline);
        trampoline.resize(gridSize, gridSize+30);
        b.setName("trampoline");
        b.setRestitution(2);
        world.add(b);
      } else if (c == lavared) {
        FLava la = new FLava(x*gridSize, y*gridSize);
        terrain.add(la);
        world.add(la);
      } else if (c == waterblue) {
        FWater wa = new FWater(x*gridSize, y*gridSize);
        wa.setFriction(8);
        wa.setSensor(true);
        terrain.add(wa);
        world.add(wa);
      } else if (c == wall) {
        b.attachImage(brick);
        b.setName("wall");
        b.setFriction(4);
        world.add(b);
      } else if (c == goombaorange) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == thowmppink) {
        FThwomp th = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(th);
        world.add(th);
      } else if (c == hammerbropurple) {
        FHammerbro ha = new FHammerbro(x*gridSize, y*gridSize);
        enemies.add(ha);
        world.add(ha);
      } else if (c == checkpointred) {
        FCheckpoint ch = new FCheckpoint(x*gridSize, y*gridSize);
        terrain.add(ch);
        world.add(ch);
      } else if (c == flaggrey) {
        b.attachImage(flag);
        flag.resize(gridSize, gridSize);
        b.setName("flag");
        b.setSensor(true);
        world.add(b);
      } else if (c == healthred) {
        FHealth he = new FHealth(x*gridSize, y*gridSize);
        terrain.add(he);
        world.add(he);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  drawWorld();
  actWorld();
  player.act();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
