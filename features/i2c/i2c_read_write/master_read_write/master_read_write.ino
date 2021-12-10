//master //master->slave
#include "ArduinoJson.h"
#include "Wire.h"
DynamicJsonDocument doc(1024);
int counter = 0;
String data="";
void setup() {
  Serial.begin(115200);
  Wire.begin();
  Serial.println("master");
  
}

void loop() {
  Wire.requestFrom(8,100);
  String data = "";
  while(Wire.available()){
    char c = Wire.read();
    data += c;
  }
  Serial.print("data");
  Serial.println(data);
  delay(500);
  
  Wire.beginTransmission(8);
  createJson();
  for(int i=0;i<data.length();i++)
    Wire.write(data[i]);
  Wire.endTransmission();
}

void createJson(){
  doc.clear();
  doc["up"] = "111";
  doc["dn"] = "888";
  doc["AC"] = "555";
  doc["DC"] = "29.35";
  doc["St"] = "4";
  serializeJson(doc, data);
//  document["pass"] = true;
}
void parseJson(){
}
