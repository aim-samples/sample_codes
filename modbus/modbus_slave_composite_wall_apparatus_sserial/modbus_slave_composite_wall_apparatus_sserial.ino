float Vl = 98, Ct = 0.72, T1 = 46, T2 = 46, T3 = 45, T4 = 45, T5 = 37, T6 = 37, T7 = 33, T8 = 32;
float Q = 70.56, Ta = 46, Tb = 45, Tc = 37, Td = 32.5;
float Ksl = 4.1457, Rsl = 0.19132, Kms = 24.98, Rms = 0.01417, Kbl = 2.3736, Rbl = 0.1133, Kpw = 2.665, Rpw = 0.0637;

//slave
//https://circuitdigest.com/microcontroller-projects/rs485-modbus-serial-communication-using-arduino-uno-as-slave
//download library from
//https://github.com/smarmengol/Modbus-Master-Slave-for-Arduino
//RS-485 Modbus Slave (Arduino UNO)
//Circuit Digest
#include "SoftwareSerial.h"
#include "TimerOne.h"
#include "ModbusRtu.h"                 //Library for using Modbus in Arduino
uint16_t modbus_array[] = {
  Vl * 100, Ct * 100, T1 * 100, T2 * 100, T3 * 100, T4 * 100, T5 * 100, T6 * 100, T7 * 100, T8 * 100,
  Q * 100, Ta * 100, Tb * 100, Tc * 100, Td * 100,
  Ksl * 1000, Rsl * 10000, Kms * 1000, Rms * 10000, Kbl * 1000, Rbl * 10000, Kpw * 1000, Rpw * 10000
};  //Array initilized with three 0 values

SoftwareSerial modbusSerial(A1, A2);          // RX, TX // Software Serial Object for Modbus
#define modbusSlaveId 1
#define modbusDeRePin A3
Modbus bus = Modbus(modbusSlaveId, modbusSerial, modbusDeRePin);

void setup(){
  modbusSerial.begin(9600);                                          // Modbus slave baudrate at 9600
  bus.start();
  Timer1.initialize(500000);                    //overflow timer after = 500000us = 500ms // modbus poll need max 500ms
  Timer1.attachInterrupt(modbusPoll);           //after timer2 overflow call modbusPoll function// 
}
void loop(){}

void modbusPoll(){
  bus.poll(modbus_array, sizeof(modbus_array) / sizeof(modbus_array[0]));     //Used to receive or write value from Master
}
//void setup() {
//  modbusSerial.begin(9600);                                          // Modbus slave baudrate at 9600
//  bus.start();
//}

//void loop() {
//  bus.poll(modbus_array, sizeof(modbus_array) / sizeof(modbus_array[0]));     //Used to receive or write value from Master
//}
