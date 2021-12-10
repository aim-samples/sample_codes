//arduino AC Voltage measurement using zmpt101b module
//below code is only pure AC waveform not for chopped AC voltage

void setup() {
  Serial.begin(115200);
}

void loop() {
  //while adjusting module's gain pot print min value = 400 and max value = 800
  //sensorGain();
  //while taking readings from above adjustment ratio is calculated
  float voltage = getVoltage();
  Serial.print("Voltage: ");
  Serial.println(voltage);
  delay(100);
}
void sensorGain(){
  uint32_t period = 1000000/50; //20ms
  uint32_t start = micros();
  float maxADC = 600, minADC = 600;
  while(micros() - start < period) {
    float voltage = analogRead(A7);
    maxADC = maxADC > voltage ? maxADC : voltage;
    minADC = minADC < voltage ? minADC : voltage;
  }
  Serial.print("max: ");
  Serial.print(maxADC);
  Serial.print(" min: ");
  Serial.println(minADC);
}
float getVoltage(){
  uint32_t period = 1000000/50, start = micros(); //20ms
  //uint32_t ;
  float ratio = 1.704125;  //ratio = VACpp/ADCpp; by adjusting gain ratio = 681.65/400 = 1.704125
  float maxADC = 600, minADC = 600, ADCpp, VACpp, Vrms;  //ADCpp : ADC pick2pick // VACpp : AC Voltage pick2pick
  while(micros() - start < period) {
    float voltage = analogRead(A7);
    maxADC = maxADC > voltage ? maxADC : voltage;
    minADC = minADC < voltage ? minADC : voltage;
  }
  ADCpp = maxADC - minADC;
  VACpp = ratio * ADCpp;
  Vrms = VACpp / (2 * sqrt(2));
  return Vrms;
}
