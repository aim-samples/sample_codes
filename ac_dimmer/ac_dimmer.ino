int load           = 8;
int stepsRemaining = 550;
int stepSize       = 16;
void setup() {
  pinMode(load, OUTPUT);
  Serial.begin(115200);
  attachInterrupt(0, zero_cross_int, RISING);
}

void loop() {
//  Serial.println(stepsRemaining);
}
void zero_cross_int() {
  //
  //  stepsRemaining--;
  //  if(stepsRemaining <= 0) stepsRemaining = 0;
  //  int firingAngleDelay = 16 * stepsRemaining;
  //  delayMicroseconds(firingAngleDelay);
  //  digitalWrite(load, HIGH);
  //  delayMicroseconds(20);
  //  digitalWrite(load, LOW);
  //  Serial.println(stepsRemaining);
  if (--stepsRemaining <= 0) {
    digitalWrite(load, HIGH);
    delayMicroseconds(20);
    stepsRemaining = 0;
  }
  else {
    int firingAngleDelay = stepSize * stepsRemaining;
    delayMicroseconds(firingAngleDelay);
    digitalWrite(load, HIGH);
    delayMicroseconds(20);
    digitalWrite(load, LOW);
  }
}
