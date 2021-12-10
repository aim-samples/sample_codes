#include "constants.h"
#include "EEPROM.h"
#include "LiquidCrystal.h"

Screen screen = screen_intro;
LiquidCrystal lcd(7, 6, 5, 4, 3, 2);
//working variable
//config
byte editIndex = 0;
long start_time = 0;
//lcd
char row1[21];
char row2[21];
char row3[21];
char row4[21];
//counter
int fog_counter   = 0; // working variable // max 5 min: 300 sec//display time as min:sec
int oven_counter  = 0; // working variable // max 8 min: 480 sec//display time as min:sec
int cycle_counter = 0; // machine cycles counter increase after each complete cycle //save in eeprom
//
int temperature = 0;

void setup() {
  Serial.begin(115200);
  lcd.begin(20, 4);
  pinMode(fogRelay, OUTPUT);
  pinMode(ovenRelay, OUTPUT);
}

void loop() {
  screen_handle();
  lcd_print();
}

void screen_handle() {
  switch (screen) {
    case screen_intro : {
        if (onSetButton())  screen = screen_timer_fog_display;
        else if (onBackButton()) screen = screen_config;

        sprintf(row1, " Unique Technology  ");
        sprintf(row2, "       Sangli       ");
        sprintf(row3, blankRow);
        sprintf(row4, "Start         Config");
        break;
      }
    case screen_timer_fog_display : {
        fog_counter = config_fog_counter;
        if (onSetButton())  {
          screen = screen_timer_fog_start;
          start_time = millis();
          fogRelayOn();
        }
        else if (onBackButton()) screen = screen_intro;

        sprintf(row1, "     Fog timer      ");
        sprintf(row2, "Timer: %.2d:%.2d        ", (int) fog_counter / 60, (int) fog_counter % 60);
        sprintf(row3, "Temp.: %5d         ", temperature);
        sprintf(row4, "Start          Abort");
        break;
      }
    case screen_timer_fog_start : {
        if (millis() > start_time + 1000) {
          start_time = millis();
          if (fog_counter > 0) --fog_counter;
          else {
            fogRelayOff();
            screen = screen_timer_oven_display;
          }
        }
        if (onBackButton()) {
          fogRelayOff();
          screen = screen_intro;
        }

        sprintf(row1, "     Fog timer      ");
        sprintf(row2, "Timer: %.2d:%.2d        ", (int) fog_counter / 60, (int) fog_counter % 60);
        sprintf(row3, "Temp.: %5d         ", temperature);
        sprintf(row4, "               Abort");
        break;
      }
    case screen_timer_oven_display : {
        oven_counter = config_oven_counter;
        if (onSetButton())  {
          screen = screen_timer_oven_start;
          start_time = millis();
          ovenRelayOn();
        }
        else if (onBackButton()) screen = screen_intro;

        sprintf(row1, "     Oven timer     ");
        sprintf(row2, "Timer: %.2d:%.2d        ", (int) oven_counter / 60, (int) oven_counter % 60);
        sprintf(row3, "Temp.: %5d         ", temperature);
        sprintf(row4, "Start          Abort");
        break;
      }
    case screen_timer_oven_start : {
        if (millis() > start_time + 1000) {
          if (oven_counter > 0) {
            --oven_counter;
          }
          else {
            ++cycle_counter;
            ovenRelayOff();
            screen = screen_complete;
          }
          start_time = millis();
        }
        if (onBackButton()) {
          ovenRelayOff();
          screen = screen_intro;
        }

        sprintf(row1, "     Oven timer     ");
        sprintf(row2, "Timer: %.2d:%.2d        ", (int) oven_counter / 60, (int) oven_counter % 60);
        sprintf(row3, "Temp.: %5d         ", temperature);
        sprintf(row4, "               Abort");
        break;
      }
    case screen_complete : {
        if (onSetButton())  screen = screen_intro;

        sprintf(row1, "   Cycle complete   ");
        sprintf(row2, blankRow);
        sprintf(row3, blankRow);
        sprintf(row4, "Restart             ");
        break;
      }
    case screen_config : {
        if (onSetButton()) {
          if (editIndex < 2) ++editIndex;
          else {
            screen = screen_intro;
            editIndex = 0;
          }
        }
        else if (onDecButton()) {
          delay(200);
          do {
            if (editIndex == 0) config_fog_counter = config_fog_counter > 0 ? config_fog_counter - 1 : max_fog_counter;
            else if (editIndex == 1) config_oven_counter = config_oven_counter > 0 ? config_oven_counter - 1 : max_oven_counter;
            delay(20);

            sprintf(row1, " Configuration Mode ");
            sprintf(row2, editIndex == 0 ? ">Fog Timer   : %.2d:%.2d" : "Fog Timer    : %.2d:%.2d", (int) config_fog_counter / 60, (int) config_fog_counter % 60);
            sprintf(row3, editIndex == 1 ? ">Oven Timer  : %.2d:%.2d" : "Oven Timer   : %.2d:%.2d", (int) config_oven_counter / 60, (int) config_oven_counter % 60);
            sprintf(row4, "Machine cycle: %5d", cycle_counter);
            lcd_print();
          }
          while (digitalRead(decButtonPin));
        }
        else if (onIncButton()) {
          delay(200);
          do {
            if (editIndex == 0) config_fog_counter = config_fog_counter < max_fog_counter  ? config_fog_counter + 1 : 0;
            else if (editIndex == 1) config_oven_counter = config_oven_counter < max_oven_counter ? config_oven_counter + 1 : 0;
            delay(20);

            sprintf(row1, " Configuration Mode ");
            sprintf(row2, editIndex == 0 ? ">Fog Timer   : %.2d:%.2d" : "Fog Timer    : %.2d:%.2d", (int) config_fog_counter / 60, (int) config_fog_counter % 60);
            sprintf(row3, editIndex == 1 ? ">Oven Timer  : %.2d:%.2d" : "Oven Timer   : %.2d:%.2d", (int) config_oven_counter / 60, (int) config_oven_counter % 60);
            sprintf(row4, "Machine cycle: %5d", cycle_counter);
            lcd_print();
          }
          while (digitalRead(incButtonPin));
        }
        else if (onBackButton()) {
          screen = screen_intro;
          editIndex = 0;
        }

        sprintf(row1, " Configuration Mode ");
        sprintf(row2, editIndex == 0 ? ">Fog Timer   : %.2d:%.2d" : "Fog Timer    : %.2d:%.2d", (int) config_fog_counter / 60, (int) config_fog_counter % 60);
        sprintf(row3, editIndex == 1 ? ">Oven Timer  : %.2d:%.2d" : "Oven Timer   : %.2d:%.2d", (int) config_oven_counter / 60, (int) config_oven_counter % 60);
        sprintf(row4, "Machine cycle: %5d", cycle_counter);
        break;
      }
    default: break;
  }
}

void lcd_print() {
  lcd.setCursor(0, 0);
  lcd.print(row1);
  lcd.setCursor(0, 1);
  lcd.print(row2);
  lcd.setCursor(0, 2);
  lcd.print(row3);
  lcd.setCursor(0, 3);
  lcd.print(row4);
}

// user input
bool onBackButton() {
  if (digitalRead(backButtonPin)) {
    delay(10);
    while (digitalRead(backButtonPin));
    return true;
  }
  else return false;
}

bool onSetButton() {
  if (digitalRead(setButtonPin)) {
    delay(10);
    while (digitalRead(setButtonPin));
    return true;
  }
  else return false;
}

bool onDecButton() {
  if (digitalRead(decButtonPin)) {
    delay(10);
    return true;
  }
  else return false;
}

bool onIncButton() {
  if (digitalRead(incButtonPin)) {
    delay(10);
    return true;
  }
  else return false;
}
//fogrelay
void fogRelayOn() {
  digitalWrite(fogRelay, HIGH);
}
void fogRelayOff() {
  digitalWrite(fogRelay, LOW);
}
void ovenRelayOn() {
  digitalWrite(ovenRelay, HIGH);
}
void ovenRelayOff() {
  digitalWrite(ovenRelay, LOW);
}
