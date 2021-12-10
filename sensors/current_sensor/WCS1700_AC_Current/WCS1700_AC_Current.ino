/*
Measuring AC Current Using ACS712
*/
#define sensorIn  A1
int mVperAmp = 35; // use 100 for 20A Module and 66 for 30A Module


double InAmp = 0;
double VRMSm = 0;
double AmpsRMSM = 0;
double VRMSIn = 0;
float AmpsRMSIn = 0,readCurrent=0,setZero=0;



void setup(){ 
 Serial.begin(115200);
 //Serial.println("Hello");
 setZero = getVPP(sensorIn);
}

void loop(){
 

 readCurrent = getVPP(sensorIn);
 readCurrent = readCurrent-setZero;
 //Serial.print("   Input Reading = ");
 Serial.println(readCurrent);
 //Serial.println("A");//"Amps RMS");

}

float getVPP(const int Amp)
{
  float result;
  
  int readValue;             //value read from the sensor
  int maxValue = 0;          // store max value here
  int minValue = 1024;          // store min value here
  
   uint32_t start_time = millis();
   while((millis()-start_time) < 100) //sample for 1 Sec
   {
       readValue = analogRead(Amp);
       // see if you have a new maxValue
       if (readValue > maxValue) 
       {
           /*record the maximum sensor value*/
           maxValue = readValue;
       }
       if (readValue < minValue) 
       {
           /*record the maximum sensor value*/
           minValue = readValue;
       }
   }
   
   result = ((maxValue - minValue) * 5000.0)/1024.0;
   InAmp=result;
   VRMSIn = (InAmp/2.0) *0.707; 
   AmpsRMSIn = (VRMSIn)/mVperAmp;
   return AmpsRMSIn;
 }
//vl:curr:ratio
//20:0.15:133
//30:0.23:130
//40:0.31:129
//50:0.39:128
//60:0.46:130
//70:0.55:127
//80:0.62:129
//90:0.70:128

 
