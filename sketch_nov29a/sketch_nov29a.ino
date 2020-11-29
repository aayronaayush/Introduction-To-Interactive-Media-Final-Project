int bedroom = 2; //
int balcony = 3; 
int gameroom = 4;
int livingRoom = 5;
int diningRoom = 6;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(bedroom, INPUT);
  pinMode(balcony, INPUT);
  pinMode(gameroom, INPUT);
  pinMode(livingRoom, INPUT);
  pinMode(diningRoom, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(livingRoom));
  detectRoom();

}

void detectRoom(){
  if (digitalRead(bedroom)==1){
    Serial.write(2);
  } else if(digitalRead(balcony)==1){
    Serial.write(3);
  } else if(digitalRead(gameroom)==1){
    Serial.write(4);
  } else if(digitalRead(livingRoom)==1){
    Serial.write(5);
  } else if(digitalRead(diningRoom)==1){
    Serial.write(6);
  }
}
