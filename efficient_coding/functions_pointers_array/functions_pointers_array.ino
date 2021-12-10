void printName(String, int);
void printAge(String, int);
int counter = 0;

void (*printFunctions[])(String, int) = {printName, printAge};
void setup() {
  Serial.begin(115200);
  // (printFunctions[0])("wonder", 25);
  // printFunctions[1]("super", 30);    // or // (printFunctions[1])("super", 30); // or // (*printFunctions[1])("super", 30);
}

void loop() {
  printHandler(printFunctions, "super", counter++);
  delay(1000);
}
void printName(String name, int age){
  Serial.print("name: ");
  Serial.print(name);
}
void printAge(String name, int age){
  Serial.print(" age: ");
  Serial.println(age);  
}
void printHandler(void (*printFuns[])(), String name, int age){
  printFunctions[0](name, age);
  printFunctions[1](name, age); // or // (*printFunctions[1])("super", 30);
}
