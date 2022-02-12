# install raspberry pi gpio package
import RPi.GPIO as GPIO
from time import sleep

ledPin = 8
GPIO.setwarnings(False)         # disable gpio warnings
GPIO.setMode(GPIO.BOARD)        # set hardware pins numbering
GPIO.setup(ledPin, GPIO.OUT)    # set gpio pin direction

try :
    while True :
        GPIO.output(ledPin, GPIO.HIGH)  # GPIO.HIGH or True
        sleep(1)
        GPIO.output(ledPin, GPIO.LOW)   # GPIO.HIGH or False
        sleep(1)
except KeyboardInterrupt :
    GPIO.cleanup()