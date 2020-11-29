import processing.serial.*;
PImage bedroomImg;
PImage balconyImg;
PImage gameRoomImg;
PImage livingRoomImg;
PImage diningRoomImg;

Serial myPort;
int input;
int currentRoom = -1;

void setup(){
  size(2560,1600);
  printArray(Serial.list());
  String portname = Serial.list()[0];
  println(portname);
  myPort = new Serial(this, portname,9600);
  // load images
  bedroomImg = loadImage("bedroom.jpg");
  balconyImg = loadImage("balcony.jpg");
  gameRoomImg = loadImage("gameRoom.jpg");
  livingRoomImg = loadImage("livingRoom.jpg");
  diningRoomImg = loadImage("diningRoom.jpg");
}

void draw(){
  background(255);
  drawRoom();
}

void serialEvent(Serial myPort){
  input = myPort.read();
  if (input==2){
    currentRoom = 2;
  }
  else if (input==3){
    currentRoom = 3;
  }
  else if (input==4) {
    currentRoom = 4;
  }
  else if (input==5) {
    currentRoom = 5;
  } else if(input==6){
    currentRoom = 6;
  }
}

void drawRoom(){
  drawOutlines();
  if (currentRoom==2){
    drawBedroom();
  } else if (currentRoom==3){
    drawBalcony();
  } else if(currentRoom==4){
    drawGameroom();
  } else if(currentRoom==5){
    drawLivingroom();
  } else if(currentRoom==6){
    drawDiningRoom();
  }
}

void drawOutlines(){
  rect(0,0,853,800); //bedroom
  rect(853,0,853,800); //balcony
  rect(1706,0,853,800); //game room
  rect(0,800,1280,800); //living room
  rect(800,1280,1280,800); // dining room
}

void drawBedroom(){
  pushStyle();
  //fill(0,255,0);
  //rect(0,0,853,800);
  image(bedroomImg,0,0);
  popStyle();
}

void drawBalcony(){
  pushStyle();
  //fill(0,255,0);
  //rect(853,0,853,800);
  image(balconyImg,853,0);
  popStyle();
}

void drawGameroom(){
  pushStyle();
  //fill(0,255,0);
  //rect(1706,0,853,800);
  image(gameRoomImg,1706,0);
  popStyle();
}

void drawLivingroom(){
  pushStyle();
  //fill(0,255,0);
  //rect(0,800,1280,800);
  image(livingRoomImg,0,800);
  popStyle();
}

void drawDiningRoom(){
  pushStyle();
  //fill(0,255,0);
  //rect(0,800,1280,800);
  image(diningRoomImg,1280,800);
  popStyle();
  println("dining room called");
}
