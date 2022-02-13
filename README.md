# avr sample codes

# avr programming on vscode
- install required packages
    - sudo apt install gcc-avr avr-libc binutils-avr avrdude
- install vscode
- install vscode extension: avr helper
- install vscode extension: c++ from microsoft
- create a folder and open it in vscode
- press "ctrl + shift + p" for options
- select "AVR Helper: Perform Initial Setup"
    - "compiler executable path: /usr/bin/avr-c++" or select with "+" button then enter
    - "programmer executable: /usr/bin/avrdude" or select with "+" button then enter
    - "programmer definitions: " or select with "+" button then enter
    - "source libraries:" or select with "+" button press enter
- press "ctrl + shift + p" for options
- select "AVR Helper: Select device"
    - "Device type: ATMEGA328" or other then enter
    - "Device frequency: 16000000" or other then enter
- press "ctrl + shift + p" for options
- select "AVR Helper: Select programmer"
    - "Programmer type: Arduino " or whatever you have
    - "Upload port: " whatever you have then enter
    - "Upload rate:" whatever you have then enter
- create "main.cpp" or "main.c" file outside and enter your program
- press "ctrl + shift + p" for options
- select "AVR Helper: Build"
    - "Select build goal: "
        - "build" : to build
        - "clean" : to clean previous build
        - "scan"  : scan for source file

 
