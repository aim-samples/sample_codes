#include "lcd_controller.h"
void setup() {
  LCDController::begin();
}

void loop() {
  LCDController::render();
}
