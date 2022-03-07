#include "LiquidCrystal.h"
LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

enum ScreenKey {
  screen_intro,
  screen_home,
  screen_error,
};
ScreenKey screenKey = screen_intro;
struct Screen {
  /*Since c++17 you can declare static members inline and
    instantiate them inside the body of class without the need of an out-of-class definition:

    class Helloworld{
    public:
     inline static int x = 10;
     void foo();
    };
  */
  inline static char row0[21];
  inline static char row1[21];
  inline static char row2[21];
  inline static char row3[21];
  void work() {}
  void display() {}
  void render() {
    work();
    display();
    lcd.setCursor(0, 0);
    lcd.print(row0);
    lcd.setCursor(0, 1);
    lcd.print(row1);
    lcd.setCursor(0, 2);
    lcd.print(row2);
    lcd.setCursor(0, 3);
    lcd.print(row3);
  }
};

struct : Screen {
  void work() {
  
  }
  void display() {
    sprintf(row0, "12345678901234567890");
    sprintf(row1, "12345678901234567891");
    sprintf(row2, "12345678901234567892");
    sprintf(row3, "12345678901234567893");
  }
} screenIntro;
struct : Screen {
  void work() {
    }
  void display() {
    sprintf(row0, "12345678901234567880");
    sprintf(row1, "12345678901234567881");
    sprintf(row2, "12345678901234567882");
    sprintf(row3, "12345678901234567883");
  }
} screenHome;
struct : Screen {
  void work() {
    }
  void display() {
    sprintf(row0, "12345678901234567870");
    sprintf(row1, "12345678901234567871");
    sprintf(row2, "12345678901234567872");
    sprintf(row3, "12345678901234567873");
  }
} screenError;

struct LCDController {
  static void begin() {
    lcd.begin(20, 4);
  }
  static void render() {
    switch (screenKey) {
      case screen_intro:
        screenIntro.render();
        break;
      case screen_home:
        screenHome.render();
        break;
      case screen_error:
        screenError.render();
        break;
      default:
        screenIntro.render();
        break;
    }
  }
};
