
#include "Servo.h"
int sensor1Pin = 2; //start
int sensor2Pin = 3; //stop
Servo servo1;
Servo servo2;
int servo1Pin = 10;
int servo2Pin = 11;

int preGate = 0;
bool trainEnterred = false;
void setup() {
  pinMode(sensor1Pin, INPUT);
  pinMode(sensor2Pin, INPUT);
  Serial.begin(9600);
  servo1.attach(servo1Pin);
  servo2.attach(servo2Pin);
  openGate();
}

void loop() {
  if(digitalRead(sensor1Pin) == 0){
    if(preGate == 0 || preGate == 1){
      trainEnterred = true;
    } else if(preGate == 2){
      Serial.println("train about to leave");
      while(digitalRead(sensor1Pin) == 0);
      trainEnterred = false;
    }
      preGate = 1;
  }else if(digitalRead(sensor2Pin) == 0){
    if(preGate == 0 || preGate == 2){
      trainEnterred = true;
    }else if(preGate == 1){
      Serial.println("train about to leave");
      while(digitalRead(sensor2Pin) == 0);
      trainEnterred = false;
    }
      preGate = 2;
  }else{}

  if (trainEnterred) {closeGate();}
  else{openGate();}
}

void closeGate(){
  servo1.write(0);
  servo2.write(0);
  delay(15);
  Serial.println("Gate closed");
}
void openGate(){
  servo1.write(180);
  servo2.write(180);
  delay(15);
  trainEnterred = false;
  preGate = 0;
  Serial.println("Gate opened");
}
