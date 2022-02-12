# install raspberry pi gpio package
from pickle import FALSE
import RPi.GPIO as GPIO
from time import sleep

ledPin = 8
buttonPin = 10

GPIO.setMode(GPIO.BOARD)        # set hardware pins numbering
GPIO.setup(ledPin, GPIO.OUT)    # set gpio pin direction
GPIO.setup(buttonPin, GPIO.IN)  # set gpio pin direction

try:
    while True:
        buttonState = GPIO.input(buttonPin) # pulled-down button : high on press
        if buttonState:
            GPIO.output(ledPin, GPIO.HIGH)  # GPIO.HIGH or True
            sleep(0.2)
        else:
            GPIO.output(ledPin, GPIO.LOW)   # GPIO.HIGH or False
except:
    GPIO.cleanup()
