#define lengthOf(t) sizeof(t) / sizeof(t[0])              // to find length of array use lengthOf(array)
#define forEach(COL1, func) for(auto& _item : COL1) func(_item, (&_item - &COL1[0]))
#define forEach2(COL1, COL2, func) for(auto& _item : COL1) func(_item, COL2 [&_item - &COL1[0]])
//under process
#define sPrint Serial.print
#define sPrintln Serial.println
//#define forEach(x, n) for(int x = 0; x < n; ++ x)
//#define forEach1(item, COL1) for(item : COL1)
//#define forEach12(item, index, COL1) for(item : COL1)

void setup() {
  //StringVector<3> namess = {"one", "two", "three"};
  Serial.begin(115200);
  int ages[] = {2, 3, 4, 5, 6, 7}, agess[] = {2, 3, 4, 5, 6, 9};
  String names[] = {"two", "three", "four", "five", "six", "seven"};
  //ex1
  forEach(names, [ages](String item, int i) {
    Serial.print("Age of ");
    Serial.print(item);
    Serial.print(" is ");
    Serial.print(ages[i]);
    Serial.println("!");
  });
//ex2
//  forEach2(names, ages, [](String &name, int &age){
//    Serial.print("Age of ");
//    age -= 1;
//    name+=String(age);
//    Serial.print(name);
//    Serial.print(" is ");
//    Serial.print(age);
//    Serial.println("!");
// });
//forEach1(auto name , names) name = "name is " + name, Serial.print(name), Serial.println();
}
void loop() {
}
