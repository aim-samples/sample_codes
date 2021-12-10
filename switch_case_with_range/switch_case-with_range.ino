const byte adcPin = A0;

void setup(){
  Serial.begin(115200);
}
void loop(){
  int value = analogRead(adcPin);  
  switch(value){
    case 0 ... 300:{
      Serial.println("low");
      break;
    }
    case 700 ... 1023 : {
      Serial.println("high");
      break;
    }
    default: {
      Serial.println("medium");
      break;
    }
  }
  delay(100);
}
