// ArduinoJson - arduinojson.org
// Copyright Benoit Blanchon 2014-2020
// MIT License
//
// This example shows how to generate a JSON document with ArduinoJson.
//
// https://arduinojson.org/v6/example/generator/

//#define BUFFER_LENGTH 180
#include <ArduinoJson.h>
#include "Wire.h"
#include "EEPROM.h"
DynamicJsonDocument  doc(200);

#define MODEL 11 //see list above
#define SENSOR_PIN A2 //pin for reading sensor

#define ZERO_CURRENT_WAIT_TIME 5000 //wait for 5 seconds to allow zero current measurement
#define CORRECTION_VLALUE 164 //mA
#define VOLTAGE_REFERENCE  5000.0 //5000mv is for 5V
#define Curr_Trans          A1

float nVPP;   // Voltage measured across resistor
float nCurrThruResistorPP; // Peak Current Measured Through Resistor
float nCurrThruResistorRMS; // RMS current through Resistor
float nCurrentThruWire,power;     // Actual RMS current in Wire
float DrillCurrent;

int SensorVal,i=0;
float mV,mC,avgC=0,setZero=0,Zero=0;;
float Current;

int k=0,Stat=0;
int w,Drill_Time;
String unit1 = "";

void setup() {
  // Initialize Serial port
  Serial.begin(115200);
  Wire.begin(8);                          
  Wire.setClock(400000);
  Wire.onReceive(receiveEvent); 
              
  Wire.onRequest(requestEvent);
  
  doc.clear();
  doc["up"] = "100";
  doc["dn"] = "900";
  doc["AC"] = "20.00";
  doc["DC"] = "20.00";
  doc["St"] = "0";
  
  pinMode(A3,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  digitalWrite(10, LOW);  
  digitalWrite(9, LOW); 
  setZero = GetDCCurrent();
  Zero=setZero;
  w=EEPROM.read(10);
  Drill_Time=EEPROM.read(11);
  
}

void loop() {
 // Serial.println(i++);
  if( unit1 == "0") // Start
  {      
      Serial.println("Start");
      digitalWrite(A3,HIGH);
      unit1="";
      digitalWrite(9,HIGH);
      digitalWrite(10,LOW);
      float leak = GetDCCurrent();
      Zero = leak;
      
  }
  else if( unit1 == "1") // Pause
  {
      Serial.println("Pause");
      digitalWrite(A3,LOW);
      delay(3000);
      digitalWrite(A3,HIGH);
      unit1="";
      digitalWrite(10,HIGH);
      digitalWrite(9,LOW);
              
  }
  else if( unit1 == "2") // Stop
  {
      Serial.println("Stop");
      digitalWrite(A3,LOW);
      unit1="";
      digitalWrite(9,LOW);
      digitalWrite(10,LOW);
      Zero=setZero;
  }
  
 Current = GetDCCurrent();
 Current -= Zero;
 Current = abs(Current);
 if(Current<0.1)
  Current=0;
 Serial.print("DC Current = ");
 Serial.println(Current);
 delay(100);
 Read_current();
 if(Serial.available())
 {
      char x = Serial.read();
      if(x=='1')
      {
        doc["St"] = "1";
      }
      else if(x=='2')
      {
        doc["St"] = "2";
      }
      else if(x=='3')
      {
        doc["St"] = "3";
      }
      else if(x=='4')
      {
        doc["St"] = "4";
      }
 }
 
 
}


void requestEvent() {
  if(Stat>12)
  Stat=0;
 
 Stat++;
  doc.clear();
  doc["Up"] = w;
  doc["Dn"] = Drill_Time;
  doc["AC"] = nCurrThruResistorPP;
  doc["DC"] = Current;
  doc["St"] = Stat;
  serializeJson(doc, Wire);
  //serializeJson(doc, Serial);
  Serial.print(i++);
  Serial.println("Data Sending to Master");
  
//  doc.clear();
//  delay(2000);
//  Wire.write("H");
//  Serial.println("Hello");
//  delay(1000);

 
}

void receiveEvent (int howMany) {
  doc.clear();
  char slaveReceived[]="";
  String Slavedata="";
  String str = "";
    if(Wire.available()) {
        int i=0,s=0,Read=0;
        while(Wire.available()) { 
            //Used to read value received from master and store in variable slaveReceived
            
            slaveReceived[i] = Wire.read(); 
            str+=slaveReceived[i];
            //Serial.println(slaveReceived[i]); 
            i++;  
            //Serial.println(i);               
        }
        Serial.print("slaveReceived[i] = "); 
        Serial.print(slaveReceived[1]); 
        Serial.print(slaveReceived[2]); 
        Serial.println(slaveReceived[3]); 
        //String str = String(slaveReceived);
        
//        int j=0;
//        while(j<i)
//        {
//          //str+=slaveReceived[j];
//          j++;
//        }
        Serial.print("Slave Received From Master:");    
        Serial.println(str);
        int First = str.indexOf('{');
        int Last  = str.indexOf('}');
        Serial.println(First);
        Serial.println(Last);
        
        for(int i=First;i<=Last;i++)
        {
          Slavedata+=str[i];
          //Serial.println(Slavedata);
          
        }
       
         
    }
    Serial.println(Slavedata);
    delay(2000);
    i=0;
    
    if (!deserializeJson(doc, Slavedata))
   {
        Serial.println("In");
        if (doc.containsKey("Up"))
        {
            String unit0 = doc["Up"];
            w = unit0.toInt();
            EEPROM.write(10,w);
            Serial.print("Up time");
            Serial.println(w);
           
        }
        if (doc.containsKey("Dn"))
        {
            String unit0 = doc["Dn"];
            Drill_Time = unit0.toInt();
            EEPROM.write(11,Drill_Time);
            Serial.print("Dn time");
            Serial.println(Drill_Time);
            
        }
        if (doc.containsKey("St"))
        {
            String unit0 = doc["St"];
            unit1 = unit0;
            
        }
        //delay(1000);
        //Serial.println(STATUS[13]);
        //Status = 13;
  }

}
float Read_current()
{
  nVPP = getVPP();
  nVPP=(nVPP/2)*0.707*1000.0;            //(Vpp/2)*RMS*No. of CT windings 
  nCurrThruResistorPP = ((nVPP)/56.0)*1.77;     //  56.0 ohm is R across CT
   
  //Serial.print("nVPP :: ");
  //Serial.println(nVPP);
  //nVPP=nVPP*0.707;
                 //(nVpp/CT Load Resistor)* CT Turns ratio
  nCurrThruResistorRMS = (nCurrThruResistorPP); //-8.06     //minus Calibration Factor if needed
  nCurrentThruWire = nCurrThruResistorRMS * 1000;
  
  if(nCurrThruResistorPP<1.0)
  {
        nCurrThruResistorPP=0;
  }
  Serial.print("AC Current = ");
  Serial.print(nCurrThruResistorPP,3);
  Serial.println(" A ");
  
 
  return(nCurrThruResistorPP);
}

float getVPP()
{
  float result;
  int readValue;             //value read from the sensor
  int maxValue = 0;          // store max value here
  long int avgVal=0;
  uint32_t start_time = millis();
  int i=0;
  while((millis()-start_time) < 100) //sample for 100 miliSec
  {
         readValue = analogRead(Curr_Trans);
         avgVal=avgVal+readValue;
         // see if you have a new maxValue
         if (readValue > maxValue) 
         {
               /*record the maximum sensor value*/
               maxValue = readValue;
            
         }
         i++;
        
  }
   //delay(900);
   
  maxValue=(maxValue-(avgVal/i));
  //Serial.print("maxValue ::");
  //Serial.println(maxValue);
       
  // Convert the digital data to a voltage
  result = (maxValue * 5.0)/1024.0;
  
  return result;
}

float GetDCCurrent()
{
  avgC=0;
  for(k=0;k<100;k++)
  {
    SensorVal=analogRead(SENSOR_PIN);
    
    avgC += SensorVal;
  }
  mC = avgC / k;
  mV = (mC*(VOLTAGE_REFERENCE/1023))-(0.5*VOLTAGE_REFERENCE)+CORRECTION_VLALUE;
  mC = mV/33.0;
  return mC;
}
