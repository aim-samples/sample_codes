#include "ArduinoJson.h"
DynamicJsonDocument document(1024);
int counter = 0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  counter++;
  generate();
  String output = "";
  serializeJson(document, output);
  Serial.println(output);
  delay(1000);
}
void generate(){
  document.clear();
  document["xtr"] = "0";
  document["vl"]  = "98";
  document["ct"]  = "0.72";
  document["t1"]  = "46";
  document["t2"]  = "46";
  document["t3"]  = "45";
  document["t4"]  = "45";
  document["t5"]  = "37";
  document["t6"]  = "37";
  document["t7"]  = "33";
  document["t8"]  = "32";
}
//avrdude -Cavrdude.conf -v -patmega328p -carduino -PCOM7 -b115200 -D -Uflash:w:blink.ino
