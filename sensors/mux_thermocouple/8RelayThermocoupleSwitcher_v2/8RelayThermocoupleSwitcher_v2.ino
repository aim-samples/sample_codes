#include "max6675.h"
#include "ArduinoJson.h"
DynamicJsonDocument document(1024);

#define thermoDO  12
#define thermoCS  10
#define thermoCLK 13
MAX6675 thermocouple(thermoCLK, thermoCS, thermoDO);
int     relay[8] = {2, 3, 4, 5, 6, 7, 8, 9};
float   m[10][8];                                       //  m[attempt][channel]
bool    stable = false;

void setup() {
  Serial.begin(115200);
  Serial.println("MAX6675 test");
  for (int i = 0; i < 8; i++) pinMode(relay[i], OUTPUT);
  delay(500);                                           //  wait for MAX chip to stabilize
}

void loop() {
  float diff[8];                                        //  to store the result temperory
  if (!stable) {
    measure();
    subArray(8, m[9], m[0], diff);
    isArrayValid(8, diff, 4, &stable);
  }
}
void subArray(int len, float arr1[], float arr2[], float result[]) {
  for (int i = 0; i < len; i++) result[i] = arr1[i] - arr2[i];
}
void isArrayValid(int len, float array[], float val, bool *result) {
  for (int i = 0; i < len; i++) if (array[i] > val) { *result = false; return; } *result = true;
}

void measure() {
  for (int i = 0; i < 10; i++) averageReadingsOfAll(m[i]); //attempts
}
void averageReadingsOfAll(float array[]) {
  for (int k = 0; k < 8; k++) {
    closeAll();
    digitalWrite(relay[k], HIGH);
    array[k] = 0;
    for (int j = 0; j < 10 ; j++) {
      double n = 0;
      for (int i = 0; i < 10 ; i++) {
        n += thermocouple.readCelsius();
        delay(10);
      }
      array[k] += n / 10;
    }
    array[k] /= 10;
  }
}
void closeAll() {
  for (int i = 0; i < 8; i++) digitalWrite(relay[i], LOW);
}
