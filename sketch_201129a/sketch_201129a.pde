import processing.serial.*;
import processing.sound.*;
import processing.video.*;

PImage bedroomImg;
PImage balconyImg;
PImage bathRoomImg;
PImage livingRoomImg;
PImage diningRoomImg;

Movie livingRoomVideo;
Movie bedroomVideo;
Movie balconyVideo;
Movie diningRoomVideo;
SoundFile flushingSound;
SoundFile balconyMusic;
int playOnce = -1;
Serial myPort;
int input;
int currentRoom = -1;
int count = 0;

void setup() {
  //size(2560,1600);
  fullScreen();
  printArray(Serial.list());
  String portname = Serial.list()[3];
  println(portname);
  myPort = new Serial(this, portname, 9600);
  // load images
  bedroomImg = loadImage("bedroom.png");
  balconyImg = loadImage("balcony.png");
  bathRoomImg = loadImage("bathroom.jpg");
  livingRoomImg = loadImage("livingRoom.jpg");
  diningRoomImg = loadImage("diningRoom_old.png");

  //load sounds
  flushingSound = new SoundFile(this, "flush.mp3");
  balconyMusic = new SoundFile(this, "BalconyMusic.mp3");

  //load video
  diningRoomVideo = new Movie(this, "diningRoom.mp4");
  livingRoomVideo = new Movie(this, "livingroom.mov");
  bedroomVideo = new Movie(this, "bedroomScenery.mp4");
  balconyVideo = new Movie(this, "BalconyScenery.mp4");
  //flushingSound.play();
}

void draw() {
  background(0);
  //println(currentRoom);
  drawRoom();
}

void serialEvent(Serial myPort) {
  input = myPort.read();
  //println(input);
  if (input==2) {
    currentRoom = 2;
    myPort.write(2);
  } else if (input==3) {
    currentRoom = 3;
    myPort.write(3);
  } else if (input==4) {
    currentRoom = 4;
    myPort.write(4);
  } else if (input==5) {
    currentRoom = 5;
    myPort.write(5);
  } else if (input==6) {
    currentRoom = 6;
    myPort.write(6);
  }
}

void movieEvent(Movie m) {
  m.read();
}

void drawRoom() {
  drawOutlines();
  if (currentRoom!=2 && balconyVideo.isPlaying()) { //stop balcony vidoe
    balconyVideo.stop();
    println("balconyVideo stopped");
  }
  if (currentRoom!=2 && balconyMusic.isPlaying()) { //stop balcony music
    balconyMusic.stop();
  }
  if (currentRoom !=3) {
    playOnce = -1;
  }
  if (currentRoom!=4 && bedroomVideo.isPlaying()) { //stop bedroom video
    bedroomVideo.stop();
  }
  if (currentRoom!=6 && livingRoomVideo.isPlaying()) { //stop livingroom video
    livingRoomVideo.stop();
    println("living room video stopped);");
  }

  //draw the rooms
  if (currentRoom==2) {
    pushStyle();
    imageMode(CENTER);
    float scaleFactor = 1.3;
    image(balconyVideo, (width/4-balconyVideo.width/3)-60, height/2-4*balconyVideo.height/6, (balconyVideo.width*scaleFactor), (balconyVideo.height*scaleFactor));
    popStyle();
    drawbalcony();
    if (balconyVideo.isPlaying()) {
      //balconyVideo.volume(0);
    }
    //println("bedroom");
  } else if (currentRoom==3) {
    drawbathroom();
  } else if (currentRoom==4) {
    pushStyle();
    imageMode(CENTER);
    float scaleFactor = 0.6;
    image(bedroomVideo, 5*width/6, height/4-90, bedroomVideo.width*scaleFactor, bedroomVideo.height*scaleFactor);
    popStyle();
    drawbedRoom();
  } else if (currentRoom==5) {
    pushStyle();
    //imageMode(CENTER);
    //float scaleFactor = 0.6;
    image(diningRoomVideo, 0, height/2, width/2, height/2);
    popStyle();
    drawdiningRoom();
  } else if (currentRoom==6) {
    drawlivingRoom();
    pushStyle();
    imageMode(CENTER);
    float scaleFactor = 0.5;
    image(livingRoomVideo, (3*width/4), height/2+livingRoomVideo.height/3, livingRoomVideo.width*scaleFactor, livingRoomVideo.height*scaleFactor);
    popStyle();
    //if (livingRoomVideo.isPlaying()){
    //  livingRoomVideo.volume(1);
    //}
  }
}

void drawOutlines() {
  fill(0);
  rect(0, 0, width/3, height/2); //bedroom
  rect(width/3, 0, width/3, height/2); //balcony
  rect(2*width/3, 0, width/3, height/2); //game room
  rect(0, height/2, width/2, height/2); //living room
  rect(width/2, height/2, width/2, height/2); // dining room
}

void drawbalcony() {
  if (!balconyVideo.isPlaying()) {
    balconyVideo.loop();
    balconyVideo.jump(30);
  }
  if (!balconyMusic.isPlaying()) {
    balconyMusic.cue(2.8);
    balconyMusic.loop();
  };
  pushStyle();
  image(balconyImg, 0, 0, width/3, height/2);
  popStyle();
}

void drawbathroom() {
  //println("bathroom");
  //if (frameCount == playFR + 180) {
  //  flushingSound.pause();
  //}
  pushStyle();
  if (!flushingSound.isPlaying() && playOnce == -1) {
    flushingSound.play();
    playOnce = 1;
    //playFR = frameCount;
  }
  image(bathRoomImg, width/3, 0, width/3, height/2);
  popStyle();
}

void drawbedRoom() {
  if (!bedroomVideo.isPlaying()) {
    bedroomVideo.loop();
    bedroomVideo.jump(30);
  }
  if (!bedroomVideo.isPlaying()) {
    bedroomVideo.loop();
  };
  pushStyle();
  image(bedroomImg, (width/3)*2, 0, width/3, height/2);
  popStyle();
}

void drawdiningRoom() {
  pushStyle();
  //image(diningRoomImg, 0, height/2, width/2, height/2);
  if (!diningRoomVideo.isPlaying()) {
    diningRoomVideo.loop();
    //livingRoomVideo.volume(100);
  }
  popStyle();
}

void drawlivingRoom() {
  if (!livingRoomVideo.isPlaying()) {
    livingRoomVideo.loop();
    //livingRoomVideo.volume(100);
  }
  //println("living room");
  pushStyle();
  //fill(0,255,0);
  //rect(0,800,1280,800);
  image(livingRoomImg, width/2, height/2);
  popStyle();
  //println("dining room called");
}

/*
todo
 add media to bedroom
 
 balcony = 2
 bathroom = 3
 bedroom = 4
 diningroom = 5
 livingroom = 6
 */
