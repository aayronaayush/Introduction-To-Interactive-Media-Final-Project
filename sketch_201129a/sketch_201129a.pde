import processing.serial.*;
import processing.sound.*;
import processing.video.*;
Movie livingRoomVideo;
SoundFile flushingSound;
PImage bedroomImg;
PImage balconyImg;
PImage bathRoomImg;
PImage livingRoomImg;
PImage diningRoomImg;

Serial myPort;
int input;
int currentRoom = -1;
int count = 0;

void setup(){
  //size(2560,1600);
  fullScreen();
  printArray(Serial.list());
  String portname = Serial.list()[0];
  println(portname);
  myPort = new Serial(this, portname,9600);
  // load images
  bedroomImg = loadImage("bedroom.jpg");
  balconyImg = loadImage("balcony.jpg");
  bathRoomImg = loadImage("gameRoom.jpg");
  livingRoomImg = loadImage("livingRoom.jpg");
  diningRoomImg = loadImage("diningRoom.jpg");
  
  //load sounds
  flushingSound = new SoundFile(this,"flush.mp3");
  
  //load video
  livingRoomVideo = new Movie(this,"livingroom.mov");
  livingRoomVideo.loop();
  //flushingSound.play();
}

void draw(){
  background(0);
  drawRoom();  
}

void serialEvent(Serial myPort){
  input = myPort.read();
  println(input);
  if (input==2){
    currentRoom = 2;
    myPort.write(2);
  }
  else if (input==3){
    currentRoom = 3;
    myPort.write(3);
  }
  else if (input==4) {
    currentRoom = 4;
    myPort.write(4);
  }
  else if (input==5) {
    currentRoom = 5;
    myPort.write(5);
  } 
  else if(input==6){
    currentRoom = 6;
    myPort.write(6);
  }
}

void movieEvent(Movie m){
  m.read();
}

void drawRoom(){
  drawOutlines();
  if (currentRoom!=6 && livingRoomVideo.isPlaying()){
    livingRoomVideo.stop();
  }
  if (currentRoom==2){
    drawbalcony();
    //println("bedroom");
  } else if (currentRoom==3){
    drawbathroom();
  } else if(currentRoom==4){
    drawbedRoom();
  } else if(currentRoom==5){
    drawdiningRoom();
  } else if(currentRoom==6){
    drawlivingRoom();
    pushStyle();
    imageMode(CENTER);
    float scaleFactor = 0.5;
    image(livingRoomVideo,3*width/4,height/2+livingRoomVideo.height/3,livingRoomVideo.width*scaleFactor,livingRoomVideo.height*scaleFactor);
    popStyle();
  }
}

void drawOutlines(){
  fill(0);
  rect(0,0,width/3,height/2); //bedroom
  rect(width/3,0,width/3,height/2); //balcony
  rect(2*width/3,0,width/3,height/2); //game room
  rect(0,height/2,width/2,height/2); //living room
  rect(width/2,height/2,width/2,height/2); // dining room
}

void drawbalcony(){
  //println("balcony");
  pushStyle();
  //fill(0,255,0);
  //rect(0,0,853,800);
  image(bedroomImg,0,0, width/3, height/2);
  popStyle();
}

void drawbathroom(){
  //println("bathroom");
  pushStyle();
  if (!flushingSound.isPlaying()){
    flushingSound.play();
  }
  image(balconyImg,width/3 ,0, width/3, height/2);
  popStyle();
}

void drawbedRoom(){
  pushStyle();
  count++;
  println(count);
  //println("bedroom");
  //fill(0,255,0);
  //rect(1706,0,853,800);
  image(bathRoomImg,(width/3)*2 ,0, width/3, height/2);
  popStyle();
}

void drawdiningRoom(){
  pushStyle();
  //println("dining room");
  //fill(0,255,0);
  //rect(0,800,1280,800);
  image(diningRoomImg,0,height/2, width/2, height/2);
  popStyle();
}

void drawlivingRoom(){
  image(livingRoomVideo,width/2,height/2);
  if(!livingRoomVideo.isPlaying()){
    livingRoomVideo.loop();
  }
  //println("living room");
  pushStyle();
  //fill(0,255,0);
  //rect(0,800,1280,800);
  image(livingRoomImg,width/2,height/2);
  popStyle();
  //println("dining room called");
}
