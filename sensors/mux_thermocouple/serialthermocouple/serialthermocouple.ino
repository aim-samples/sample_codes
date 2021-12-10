// this example is public domain. enjoy!
// www.ladyada.net/learn/sensors/thermocouple

#include "max6675.h"

int thermoDO = 4;
int thermoCS = 5;
int thermoCLK = 6;

const byte demuxSelectPinsArray[] = {4, 5, 6, 7}; // demux/decoder select pins s0, s1, s2, s3/E
MAX6675 thermocouple(13,12,11);
//MAX6675 thermocouple(thermoCLK, thermoCS, thermoDO);
int vccPin = 3;
int gndPin = 2;
  
void setup() {
  for(auto pin : demuxSelectPinsArray) pinMode(pin, OUTPUT), digitalWrite(pin, LOW);
  Serial.begin(115200);
  // use Arduino pins 
  pinMode(vccPin, OUTPUT); digitalWrite(vccPin, HIGH);
  pinMode(gndPin, OUTPUT); digitalWrite(gndPin, LOW);
  
  Serial.println("MAX6675 test");
  // wait for MAX chip to stabilize
  delay(500);
}

void loop() {
  // basic readout test, just print the current temp
  
   Serial.print("C = "); 
   Serial.println(thermocouple.readCelsius());
   Serial.print("F = ");
   Serial.println(thermocouple.readFahrenheit());
 
   delay(1000);
}
