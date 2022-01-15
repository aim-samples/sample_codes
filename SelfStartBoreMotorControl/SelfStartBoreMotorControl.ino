int bottomLevel                   = 3;                        //with pulldown   //if bottom level reached input is low
int topLevel                      = 4;                        //with pulldown   //if top level reached input is high
int motorPin                      = 5;                        //motor connection through relay for on/off
int potPin                        = A0;                       //pot pin to select top level time delay in 1000 ms to 10000 ms
bool isMotorStart                 = false;                    //motor handler
unsigned long topLevelDelayTimer  = 0;                        //counts millis to mactch delayTime
unsigned long delayTime           = 0;                        //delayTime adjust using pot in 1000 ms to 10000 ms
bool startTimer                   = false;                    //start timer

void setup() {
  Serial.begin(9600);                                         //serial baudrate to 9600 bps
  Serial.println("Booting");                                  //booting message
  pinMode(bottomLevel, INPUT);                                //bottomlevel as input
  pinMode(topLevel,    INPUT);                                //toplevel as input
  pinMode(motorPin,   OUTPUT);                                //motor as ouput
  pinMode(potPin,      INPUT);                                //pot as intput
  Serial.println("On Start delay on 3 mins");                 //on start delay message
  delay(1000*60*3);                                           // on start delay of 3 minuts for smooth smooth power supply
}

void loop() {
  readDelayTime();                                            //check for delay time change with pot
  if(digitalRead(bottomLevel) == LOW && !isMotorStart){       //on bottom level start motor if motor not started
    isMotorStart = true;                                      //start motor
  }
  else if(digitalRead(topLevel) == HIGH && isMotorStart){     //on top level start timer and if motor not started
    if(!startTimer){                                          //if timer not started
      topLevelDelayTimer = millis();                          //register time
    }
    startTimer = true;                                        //timer started
  }else if(topLevelDelayTimer >= delayTime && isMotorStart){  //check if timer completed and if motor started
    startTimer = false;                                       //stop timer
    topLevelDelayTimer = 0;                                   //reset timer
    isMotorStart = false;                                     //stop motor
  }
  digitalWrite(motorPin, isMotorStart);                       //perform motor action
  delay(20);                                                  //wait for 20 millisec
}

void readDelayTime(){
  delayTime = map(analogRead(potPin), 0, 1024, 1, 10);        //delay time in 1 s to 10 s
  delayTime = delayTime * 1000;                               //convert delay time from seconds to milliseconds
  delay(20);                                                  //wait for 20 millisec
}
