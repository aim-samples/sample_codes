#include "max6675.h"
#include "ArduinoJson.h"
#define thermoDO  12
#define thermoCS  10
#define thermoCLK 13
int relay[8] = {2, 3, 4, 5, 6, 7, 8, 9};

MAX6675 thermocouple(thermoCLK, thermoCS, thermoDO);
DynamicJsonDocument document(1024);

//int xtr = 0;
//float vl = 230;
//float ct = 1;
//float t1 = 0;
//float t2 = 0;
//float t3 = 0;
//float t4 = 0;
//float t5 = 0;
//float t6 = 0;
//float t7 = 0;
//float t8 = 0;

float m1[8], m2[8], m3[8], m4[8], m5[8], m6[8], m7[8], m8[8], m9[8], m10[8];
bool stable = false;
void setup() {
  Serial.begin(115200); 
  Serial.println("MAX6675 test");
  delay(500);                     // wait for MAX chip to stabilize
  for(int i = 0; i < 8; i++) pinMode(relay[i], OUTPUT);
}
//void loop() {
//  readTemp1();
//  readTemp2();
//  readTemp3();
//  generate();
//  String output = "";
//  serializeJson(document, output);
//  Serial.println(output);
//  delay(1000);
//}

void loop(){
  float diff[8];
  if(!stable){
    measure();
    subArray(8, m10, m1, diff);
//    if(diff[0]<4 && diff[1]<4 && diff[2]<4 && diff[3]<4 && diff[4]<4 && diff[5]<4 && diff[6]<4 && diff[7]<4) stable = true;
    if(arrayValLessThan(8, diff, 4.0)) stable = true;
  }
}
void subArray(int len, float arr1[], float arr2[], float result[]){
  for(int i = 0; i < len; i++) result[i] = arr1[i] - arr2[i];
}
bool arrayValLessThan(int len, float array[], float val){
  for(int i = 0; i < len; i++) if(array[i] > val) return false;
  return true;
}

void measure(){
  averageReadingsOfAll(m1);
  averageReadingsOfAll(m2);
  averageReadingsOfAll(m3);
  averageReadingsOfAll(m4);
  averageReadingsOfAll(m5);
  averageReadingsOfAll(m6);
  averageReadingsOfAll(m7);
  averageReadingsOfAll(m8);
}
void averageReadingsOfAll(float array[]){
  for(int k = 0; k < 8; k++){
    closeAll();
    digitalWrite(relay[k], HIGH);
    array[k] = 0;
    for(int j = 0; j < 10 ; j++){
      double n = 0;
      for(int i = 0; i < 10 ; i++){ 
        n += thermocouple.readCelsius(); 
        delay(10); 
      } 
      array[k] += n/10;
    } 
    array[k] /= 10;
  }
}

//void generate(){
//  document.clear();
//  document["xtr"] = String(xtr);
//  document["vl"]  = String(vl);
//  document["ct"]  = String(ct);
//  document["t1"]  = String(t1);
//  document["t2"]  = String(t2);
//  document["t3"]  = String(t3);
//  document["t4"]  = String(t4);
//  document["t5"]  = String(t5);
//  document["t6"]  = String(t6);
//  document["t7"]  = String(t7);
//  document["t8"]  = String(t8);
//}
void closeAll(){
  for(int i = 0; i < 8; i++) digitalWrite(relay[i], LOW);
}
