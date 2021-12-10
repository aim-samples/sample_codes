#define current_sensor_pin A0 //pin for reading current sensor
#define current_sensor_current_correction_value 164 //mA
#define current_sensor_voltage_reference  5000.0 //5000mv is for 5V

float Current;
void setup() {
  Serial.begin(9600);
}

void loop() {
  Current = GetCurrent();
  Serial.println(Current);
  delay(100);
}

float GetCurrent() {
  int SensorVal;
  float mV, mC;
  int i = 0;
  for (i = 0; i < 100; i++) SensorVal = analogRead(current_sensor_pin);
  SensorVal /= i;
  mV = (SensorVal * (current_sensor_voltage_reference / 1023)) - (0.5 * current_sensor_voltage_reference) + current_sensor_current_correction_value;
  mC = mV / 33.0;
  return mC;
}

//#define MODEL 11 //see list above
//#define current_sensor_pin A0 //pin for reading sensor
//
//#define ZERO_CURRENT_WAIT_TIME 5000 //wait for 5 seconds to allow zero current measurement
//#define current_sensor_current_correction_value 164 //mA
//#define current_sensor_voltage_reference  5000.0 //5000mv is for 5V
//#define DEBUT_ONCE true
//
//int SensorVal,i=0;
//float mV,mC,avgC=0,setZero=0;
//float Current;
//void setup() {
//  Serial.begin(9600);
//  delay(2000);
// setZero = GetCurrent();
//}
//
//void loop() {
//  Current = GetCurrent();
//  Current -= setZero;
//  Serial.println(Current);
//  delay(100);
//}
//
//float GetCurrent()
//{
//  avgC=0;
//  for(i=0;i<100;i++)
//  {
//    SensorVal=analogRead(current_sensor_pin);
//    mV = (SensorVal*(current_sensor_voltage_reference/1023))-(0.5*current_sensor_voltage_reference)+current_sensor_current_correction_value;
//    mC = mV/33.0;
//    avgC += mC;
//  }
//  mC = avgC / i;
//  return mC;
//}
