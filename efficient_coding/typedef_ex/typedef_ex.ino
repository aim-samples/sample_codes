
template <size_t N>
using string_list = String (&)[N];
//template <size_t N>
//using action_list = void (&*[N])();

//  same name methods
//  void printt(String g) { Serial.print(g + 'g'); }
//  void printt(int g)    { Serial.print(g + 9);   }
//  printt("parle");
//  printt(5);

#define empty_fun []{}                                      // empty function
typedef void action(void);
typedef void (*action_pointer)();
typedef void (&action_ref)(void);
typedef void (*action_pointers[])();


String keys[] = {"one", "two", "three"};


void setup() {
  Serial.begin(115200);
  printkeys(keys);
}

void loop() {}

template <size_t N>
void printkeys(string_list<N> _keys){
  for(auto key : _keys) Serial.println(key);
}
