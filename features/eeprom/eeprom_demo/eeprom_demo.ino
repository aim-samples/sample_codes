#include "EEPROM.h"
#include "ArduinoJson.h"
DynamicJsonDocument doc(500);
struct Constants {
  float Lsl;
  float Lms;
  float Lbl;
  float Lpw;
  float Ah;
};
Constants constants;

void setup() {
  float f = 6.35e-3;
//  constants = {
//    0.056,
//    0.025,
//    0.019,
//    0.012,
//    0.0706,
//  };
//  EEPROM.put(120, constants);
  Serial.begin(115200);
}
void loop() {
  Constants c;
  EEPROM.get(120, c);
  doc["c"] = c.Ah;
  serializeJson(doc, Serial);
  Serial.println();
  delay(1000);
}
