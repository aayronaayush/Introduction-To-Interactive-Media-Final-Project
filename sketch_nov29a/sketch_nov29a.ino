// input pins
int bedroom = A0; //
int balcony = A1; 
int gameroom = A5;
int livingRoom = A2;
int diningRoom = A3;

// output pins
int bedroomLed = 2;
int balconyLed = 3;
int gameroomLed = 4;
int livingRoomLed = 5;
int diningRoomLed = 6;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(bedroom, INPUT);
  pinMode(balcony, INPUT);
  pinMode(gameroom, INPUT);
  pinMode(livingRoom, INPUT);
  pinMode(diningRoom, INPUT);

  //setting output
  pinMode(bedroomLed,OUTPUT);
  pinMode(balconyLed,OUTPUT);
  pinMode(gameroomLed,OUTPUT);
  pinMode(livingRoomLed,OUTPUT);
  pinMode(diningRoomLed,OUTPUT);

}

void loop() {
//  Serial.println(digitalRead(livingRoom));
  detectRoom();
//  Serial.println(analogRead(diningRoom));

}

void detectRoom(){
  if (analogRead(bedroom)>100){
    Serial.write(2);
    bedroomOperation(2);
    Serial.println("analogRead(balcony)/");
  } else if(analogRead(balcony)>100){
    Serial.write(3);
    bedroomOperation(3);
    Serial.println("analogRead(bathroom)");
  } else if(analogRead(gameroom)>100){
    Serial.write(4);
    bedroomOperation(4);
    Serial.println("analogRead(bedroom)");
  } else if(analogRead(livingRoom)>100){
    Serial.write(5);
    bedroomOperation(5);
    Serial.println("analogRead(diningroom)");
  } else if(analogRead(diningRoom)>100){
    Serial.write(6);
    bedroomOperation(6);
    Serial.println("analogRead(livingRoom)");
  }
}

void bedroomOperation(int room){
  // get the input and the turn on the appropriate led and turn off the rest
  if (room==2){
    digitalWrite(bedroomLed,HIGH); 
    digitalWrite(balconyLed,LOW); 
    digitalWrite(gameroomLed,LOW); 
    digitalWrite(livingRoomLed,LOW); 
    digitalWrite(diningRoomLed,LOW); 
  } else if(room==3){
    digitalWrite(bedroomLed,LOW); 
    digitalWrite(balconyLed,HIGH); 
    digitalWrite(gameroomLed,LOW); 
    digitalWrite(livingRoomLed,LOW); 
    digitalWrite(diningRoomLed,LOW);
  } else if(room==4){
    digitalWrite(bedroomLed,LOW); 
    digitalWrite(balconyLed,LOW); 
    digitalWrite(gameroomLed,HIGH); 
    digitalWrite(livingRoomLed,LOW); 
    digitalWrite(diningRoomLed,LOW);
  } else if(room==5){
    digitalWrite(bedroomLed,LOW); 
    digitalWrite(balconyLed,LOW); 
    digitalWrite(gameroomLed,LOW); 
    digitalWrite(livingRoomLed,HIGH); 
    digitalWrite(diningRoomLed,LOW);
  } else if(room==6){
    digitalWrite(bedroomLed,LOW); 
    digitalWrite(balconyLed,LOW); 
    digitalWrite(gameroomLed,LOW); 
    digitalWrite(livingRoomLed,LOW); 
    digitalWrite(diningRoomLed,HIGH);
  }
}

/*
int bedroomLed = 2;
int balconyLed = 3;
int gameroomLed = 4;
int livingRoomLed = 5;
int diningRoomLed = 6;
 */
