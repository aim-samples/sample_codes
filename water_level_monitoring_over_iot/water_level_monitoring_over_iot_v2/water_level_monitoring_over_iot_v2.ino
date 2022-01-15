#include "SoftwareSerial.h"
SoftwareSerial esp8266(2,3);    //RX, TX, Connect rx of arduino to tx of esp8266 and tx of arduino to rx of esp8266
const int triggerPin = 5;
const int echoPin    = 6;
long duration;
int distanceInCM;
int waterLevel;
String msg = "GET https://api.thingspeak.com/update?api_key=1NFWFS3EG938OHTZ"; //change it with your key...

void setup(){
  pinMode(triggerPin, OUTPUT);
  pinMode(echoPin, INPUT);
  esp8266.begin(9600);
  Serial.begin(9600);
  esp8266.println("AT");                           //   Check ESP8266 Hardware 
  Serial.println(esp8266.readString());
  esp8266.println("AT+CIPMUX=0");                  //   Check ESP8266 Hardware 
  Serial.println(esp8266.readString());
}

void loop(){
  readWaterLevel();
  Serial.println(waterLevel);
  updateData();
  delay(5000);

}

void readWaterLevel(){
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distanceInCM = duration/29/2;
  waterLevel = map(distanceInCM, 20, 5, 0, 100);
//     0cm|sensor|
//     5cm| - - -|100%
//    10cm|- - - |50%
//    15cm| - - -|
//    20cm|______|0%
}
void updateData() {
  String cmd = "AT+CIPSTART=\"TCP\",\"184.106.153.149\",80";        
  esp8266.println(cmd);                                           //   Send Command to ESP8266 for connection with server of ThingSpeak
  Serial.println(esp8266.readString());
  cmd=msg;
  cmd += "&field1=";                                          //   Add Sensor data in the Send command
  cmd += distanceInCM;
  
  int cmdL=cmd.length();
  cmdL=cmdL+2;                                                //   length of Characters to send
  //Serial.println(msgL);
  
  esp8266.print("AT+CIPSEND=");
  esp8266.println(cmdL);                                          //   Command to intialize the ESP8266 to send data
  Serial.println(esp8266.readString());
  delay(500);
  
  esp8266.println(cmd);                                           //   Command to ESP8266 TO send data
  Serial.println(esp8266.readString());
 
}
