#include "EEPROM.h"
#include "LiquidCrystal.h"
#include "common.h"
#include "constants.h"

Screen screen = screen_home;
EditIndex editIndex = edit_cycle;
Button  setButton(setButtonPin), 
        decButton(decButtonPin), 
        incButton(incButtonPin), 
        backButton(backButtonPin);
Relay   fogRelay(fogRelayPin),
        ovenRelay(ovenRelayPin);
        
LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

//working variable
//lcd
char row1[21];
char row2[21];
char row3[21];
char row4[21];
//config screen
long start_time = 0;
//counter
unsigned int fog_counter   = 0; // working variable // max 5 min: 300 sec//display time as min:sec
unsigned int oven_counter  = 0; // working variable // max 8 min: 480 sec//display time as min:sec
unsigned int oven_temp     = 0; // working variable // max   cel:
//log delay timer
unsigned long last_logged_on = 0;

void setup() {
  Serial.begin(115200);
  Serial.println(">>> machine: booting");
  lcd.begin(20, 4);
  pinMode(fogRelayPin, OUTPUT);
  pinMode(ovenRelayPin, OUTPUT);
  read();
}

void loop() {
  read_temperature();
  screen_handle();
  screen_print();
}

void screen_handle() {
  switch (screen) {
    case screen_home : {
        if (setButton.onRelease()) {
          screen = screen_timer_select;
        } else if (backButton.onRelease()) {
          screen = screen_config;
        }
        break;
      }
    case screen_timer_select : {
        if (setButton.onRelease()) {
          screen = screen_home;
        } else if (decButton.onRelease()) {
          screen = screen_timer_fog_display;
        } else if (incButton.onRelease()) {
          screen = screen_timer_oven_display;
        } else if (backButton.onRelease()) {
          screen = screen_home;
        }
        break;
      }
    case screen_timer_fog_display : {
        fog_counter = config_fog_counter;
        if (setButton.onRelease()) {
          screen = screen_timer_fog_start;
          start_time = millis();
          fogRelay.on();
        } else if (backButton.onRelease()) {
          screen = screen_home;
        }
        break;
      }
    case screen_timer_oven_display : {
        oven_counter = config_oven_counter;
        if (setButton.onRelease())  {
          screen = screen_timer_oven_start;
          start_time = millis();
          ovenRelay.on();
        } else if (backButton.onRelease()) {
          screen = screen_home;
        }
        break;
      }
    case screen_timer_fog_start : {
        if (millis() > start_time + 1000) {
          start_time = millis();
          if (fog_counter > 0) {
            --fog_counter;
          } else {
            screen = screen_home;
            fogRelay.off();
          }
        }

        if (backButton.onRelease()) {
          fogRelay.off();
          screen = screen_home;
        }
        break;
      }
    case screen_timer_oven_start : {
        maintain_temperature();

        if (millis() > start_time + 1000) {
          start_time = millis();
          if (oven_counter > 0) {
            --oven_counter;
          } else {
            screen = screen_home;
            ovenRelay.off();
            increament_cycle();
          }
        }

        if (backButton.onRelease()) {
          ovenRelay.off();
          screen = screen_home;
        }
        break;
      }
    case screen_complete : {
        if (setButton.onRelease()) {
          screen = screen_home;
        }
        break;
      }
    case screen_config : {
        config();
        break;
      }
    default: break;
  }
}
void config() {
  switch (editIndex) {
    case edit_cycle: {
        if (setButton.onRelease()) {
          editIndex = edit_fog_timer;
        } else if (backButton.onRelease()) {
          back_from_config();
        } else if (incButton.onPress()) {
          delay(200);
          int counter = 0;
          while (incButton.onPress() && counter <= 20) {
            ++counter;
            delay(90); //10ms delay in onIncButton(), total: 100ms
          }
          if (counter >= 20) {
            reset_cycle();
          }
        }
        break;
      }
    case edit_fog_timer: {
        if (setButton.onRelease()) {
          editIndex = edit_oven_timer;
        } else if (backButton.onRelease()) {
          back_from_config();
        } else if (incButton.onPress()) {
          delay(200);
          do {
            config_fog_counter = config_fog_counter < max_fog_counter  ? config_fog_counter + 1 : 0;
            screen_print();
          } while (incButton.onPress());
        } else if (decButton.onPress()) {
          delay(200);
          do {
            config_fog_counter = config_fog_counter > 0 ? config_fog_counter - 1 : max_fog_counter;
            screen_print();
          } while (decButton.onPress());
        }
        break;
      }
    case edit_oven_timer: {
        if (setButton.onRelease()) {
          editIndex = edit_oven_temp;
        } else if (backButton.onRelease()) {
          back_from_config();
        } else if (incButton.onPress()) {
          delay(200);
          do {
            config_oven_counter = config_oven_counter < max_oven_counter ? config_oven_counter + 1 : 0;
            screen_print();
          } while (incButton.onPress());
        } else if (decButton.onPress()) {
          delay(200);
          do {
            config_oven_counter = config_oven_counter > 0 ? config_oven_counter - 1 : max_oven_counter;
            screen_print();
          } while (decButton.onPress());
        }
        break;
      }
    case edit_oven_temp: {
        if (setButton.onRelease()) {
          editIndex = edit_complete;
        } else if (backButton.onRelease()) {
          back_from_config();
        } else if (decButton.onPress()) {
          delay(200);
          do {
            config_oven_temp = config_oven_temp > 0 ? config_oven_temp - 1 : max_oven_temp;
            screen_print();
          } while (decButton.onPress());
        } else if (incButton.onPress()) {
          delay(200);
          do {
            config_oven_temp = config_oven_temp < max_oven_temp ? config_oven_temp + 1 : 0;
            screen_print();
          } while (incButton.onPress());
        }
        break;
      }
    default: {
        if (setButton.onRelease()) {
          save();
          back_from_config();
        } else if (backButton.onRelease()) {
          back_from_config();
        }
      }
  }
}
void back_from_config() {
  read();
  editIndex = edit_cycle;
  screen = screen_home;
}

void screen_print() {
  switch (screen) {
    case screen_home: {
        sprintf_P(row1, PSTR(" Unique Technology  "));
        sprintf_P(row2, PSTR("       Sangli       "));
        sprintf_P(row3, blankBuff);
        sprintf_P(row4, PSTR("Start         Config"));
        break;
      }
    case screen_timer_select: {
        sprintf_P(row1, PSTR("    Select timer    "));
        sprintf_P(row2, blankBuff);
        sprintf_P(row3, blankBuff);
        sprintf_P(row4, PSTR("Home Fog  Oven Abort"));
        break;
      }
    case screen_timer_fog_display:
    case screen_timer_fog_start:  {
        sprintf_P(row1, PSTR("     Fog timer      "));
        sprintf_P(row2, PSTR("Timer: %.2d:%.2d        "), (int) fog_counter / 60, (int) fog_counter % 60);
        sprintf_P(row3, blankBuff);
        sprintf_P(row4, PSTR("%.5s          Abort"), screen == screen_timer_fog_display ? "Start" : "     ");
        break;
      }
    case screen_timer_oven_display:
    case screen_timer_oven_start: {
        sprintf_P(row1, PSTR("     Oven timer     "));
        sprintf_P(row2, PSTR("Timer: %.2d:%.2d        "), (int) oven_counter / 60, (int) oven_counter % 60);
        sprintf_P(row3, PSTR("Temp.: %5d        "), oven_temp);
        sprintf_P(row4, PSTR("%.5s          Abort"), screen == screen_timer_oven_display ? "Start" : "     ");
        break;
      }
    case screen_complete: {
        sprintf_P(row1, PSTR("   Cycle complete   "));
        sprintf_P(row2, blankBuff);
        sprintf_P(row3, blankBuff);
        sprintf_P(row4, PSTR("Home                "));
        break;
      }
    case screen_config: {
        sprintf_P(row1,
                  editIndex == 0 ? PSTR(">Cycle: %.4d Reset:+") : PSTR("Cycle : %.4d Reset:+"),
                  cycle_counter);

        sprintf_P(row2,
                  editIndex == edit_fog_timer  ? PSTR(">Fog Timer   : %.2d:%.2d") : PSTR("Fog Timer    : %.2d:%.2d"),
                  (int) config_fog_counter / 60, (int) config_fog_counter % 60);

        sprintf_P(row3,
                  editIndex == edit_oven_timer ? PSTR(">Oven Timer  : %.2d:%.2d") : PSTR("Oven Timer   : %.2d:%.2d"),
                  (int) config_oven_counter / 60, (int) config_oven_counter % 60);

        sprintf_P(row4,
                  editIndex == edit_oven_temp  ? PSTR(">Oven Temp   : %.2d   ")   : PSTR("Oven Temp    : %.2d   "),
                  config_oven_temp);
        /*
          sprintf_P(row1,
                  PSTR("%.6S: %.4d Reset:+"),
                  editIndex == 0 ? PSTR(">Cycle") : PSTR("Cycle "),
                  cycle_counter);//9336/498

          sprintf_P(row2,
                  PSTR("%.10S   : %.2d:%.2d"),
                  editIndex == edit_fog_timer ? PSTR(">Fog Timer") : PSTR("Fog Timer "),
                  (int) config_fog_counter / 60, (int) config_fog_counter % 60);

          sprintf_P(row3,
                  PSTR("%.11S  : %.2d:%.2d"),
                  editIndex == edit_oven_timer ? PSTR(">Oven Timer") : PSTR("Oven Timer "),
                  (int) config_oven_counter / 60, (int) config_oven_counter % 60);

          sprintf_P(row4,
                  PSTR("%.10S   : %.2d   "),
                  editIndex == edit_oven_temp ? PSTR(">Oven Temp") : PSTR("Oven Temp "),
                  config_oven_temp);//9336/416
        */
        break;
      }
    default : {
        break;
      }
  }
  lcd.setCursor(0, 0);
  lcd.print(row1);
  lcd.setCursor(0, 1);
  lcd.print(row2);
  lcd.setCursor(0, 2);
  lcd.print(row3);
  lcd.setCursor(0, 3);
  lcd.print(row4);

  if (millis() > last_logged_on + 1000) {
    Serial.println(F("--------------------"));
    Serial.println(row1);
    Serial.println(row2);
    Serial.println(row3);
    Serial.println(row4);
    Serial.println(F("--------------------"));
    last_logged_on = millis();
  }
}

/*
//fog relay
void fogRelayOn() {
  digitalWrite(fogRelayPin, HIGH);
  Serial.println(F(">>> fogRelay: turning on"));
}
void fogRelayOff() {
  digitalWrite(fogRelayPin, LOW);
  Serial.println(F(">>> fogRelay: turning off"));
}

//oven relay
void ovenRelayOn() {
  digitalWrite(ovenRelayPin, HIGH);
  Serial.println(F(">>> ovenRelay: turning on"));
}
void ovenRelayOff() {
  digitalWrite(ovenRelayPin, LOW);
  Serial.println(F(">>> ovenRelay: turning off"));
}
*/

//lm35 temperature measurement
void read_temperature() {
  float value = analogRead(temperaturePin);
  value = value * 500 / 1024; // equavalent voltage in v
  oven_temp = (int) value;
}
void maintain_temperature() {
  int oven_start_temp = config_oven_temp - oven_temp_low_error;
  oven_start_temp = oven_start_temp >= 0 ? oven_start_temp : 0;

  if ( oven_temp > config_oven_temp) ovenRelay.off();
  else if (oven_temp < oven_start_temp) ovenRelay.on();
}

//eeprom and config
void save() {
  EEPROM.put(fog_address, config_fog_counter);
  EEPROM.put(oven_address, config_oven_counter);
  EEPROM.put(cycle_address, cycle_counter);
  EEPROM.put(oven_temp_address, config_oven_temp);
  Serial.println(">>> eeprom: saving config");
}
void read() {
  EEPROM.get(fog_address, config_fog_counter);
  EEPROM.get(oven_address, config_oven_counter);
  EEPROM.get(cycle_address, cycle_counter);
  EEPROM.get(oven_temp_address, config_oven_temp);
  Serial.println(">>> eeprom: reading config");
}
void reset_cycle() {
  cycle_counter = 0;
  save();// save reset counter to eeprom
}
void increament_cycle() {
  cycle_counter = cycle_counter < 10000 ? cycle_counter + 1 : 0;
  save();// save increased counter to eeprom
}
