#include "max6675.h"
#include "ArduinoJson.h"
#define thermoDO  12
#define thermoCS  10
#define thermoCLK 13
#define relay1    2
#define relay2    3
#define relay3    4
#define relay4    5
#define relay5    6
#define relay6    7
#define relay7    8
#define relay8    9

MAX6675 thermocouple(thermoCLK, thermoCS, thermoDO);
DynamicJsonDocument document(1024);

int xtr = 0;
float vl = 102;
float ct = 0.78;
float t1 = 0;
float t2 = 0;
float t3 = 0;
float t4 = 0;
float t5 = 0;
float t6 = 0;
float t7 = 0;
float t8 = 0;

void setup() {
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);
  pinMode(relay5, OUTPUT);
  pinMode(relay6, OUTPUT);
  pinMode(relay7, OUTPUT);
  pinMode(relay8, OUTPUT);
  Serial.begin(115200);
//  Serial.println("MAX6675 test");
  // wait for MAX chip to stabilize
  delay(500);
}

void loop() {
  readTemp1();
  readTemp2();
  readTemp3();
  readTemp4();
  readTemp5();
  readTemp6();
  readTemp7();
  readTemp8();
  generate();
  String output = "";
  serializeJson(document, output);
  Serial.println(output);
  delay(1000);
}

void generate(){
  document.clear();
  document["xtr"] = String(xtr);
  document["vl"]  = String(vl);
  document["ct"]  = String(ct);
  document["t1"]  = String(t1);
  document["t2"]  = String(t2);
  document["t3"]  = String(t3);
  document["t4"]  = String(t4);
  document["t5"]  = String(t5);
  document["t6"]  = String(t6);
  document["t7"]  = String(t7);
  document["t8"]  = String(t8);
}
void readTemp1(){
  closeAll();
  delay(20);
  digitalWrite(relay1, HIGH);
  delay(1000);
  t1 = thermocouple.readCelsius();
//  t2 = t1;
}
void readTemp2(){
  closeAll();
  delay(20);
  digitalWrite(relay2, HIGH);
  delay(1000);
  t2 = thermocouple.readCelsius();
}
void readTemp3(){
  closeAll();
  delay(20);
  digitalWrite(relay3, HIGH);
  delay(1000);
  t3 = thermocouple.readCelsius();
}
void readTemp4(){
  closeAll();
  delay(20);
  digitalWrite(relay4, HIGH);
  delay(1000);
  t4 = thermocouple.readCelsius();
}
void readTemp5(){
  closeAll();
  delay(20);
  digitalWrite(relay5, HIGH);
  delay(1000);
  t5 = thermocouple.readCelsius();
}
void readTemp6(){
  closeAll();
  delay(20);
  digitalWrite(relay6, HIGH);
  delay(1000);
  t6 = thermocouple.readCelsius();
//  t7 = t6;
}
void readTemp7(){
  closeAll();
  delay(20);
  digitalWrite(relay7, HIGH);
  delay(1000);
  t7 = thermocouple.readCelsius();
}
void readTemp8(){
  closeAll();
  delay(20);
  digitalWrite(relay8, HIGH);
  delay(1000);
  t8 = thermocouple.readCelsius();
}
void closeAll(){
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
  digitalWrite(relay3, LOW);
  digitalWrite(relay4, LOW);
  digitalWrite(relay5, LOW);
  digitalWrite(relay6, LOW);
  digitalWrite(relay7, LOW);
  digitalWrite(relay8, LOW);
}
