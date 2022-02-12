# install raspberry pi gpio package
import RPi.GPIO as GPIO
from time import sleep

ledPin = 8

GPIO.setwarnings(False)
GPIO.setMode(GPIO.BOARD)
GPIO.setup(ledPin, GPIO.OUTPUT)

try:
    for i in range(10) :
        GPIO.output(ledPin, GPIO.HIGH)  # GPIO.HIGH or True
        sleep(1)
        GPIO.output(ledPin, GPIO.LOW)   # GPIO.LOW or False
        sleep(1)

except KeyboardInterrupt:
    GPIO.cleanup()