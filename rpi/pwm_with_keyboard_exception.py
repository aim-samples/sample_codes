# install raspberry pi gpio package
# python has software pwm, pwm can be used on all pins
import RPi.GPIO as GPIO
from time import sleep

pwmPin = 8

GPIO.setwarnings(False)
GPIO.setMode(GPIO.BOARD)
GPIO.setup(pwmPin, GPIO.OUT)
pwm = GPIO.PWM(pwmPin, 1000)    # create pwm object with pin and frequency
pwm.start(0)                    # start pwm with duty cycle 0

try :
    while True :
        for duty in range(0, 101, 1) : # 0 to 100 with step 1
            pwm.ChangeDutyCycle(duty)
            sleep(0.01)
        sleep(1)
        for duty in range(100, -1, -1) : # 100 to 0 with -1
            pwm.ChangeDutyCycle(duty)
            sleep(0.01)
        sleep(1)
except KeyboardInterrupt:
    pwm.stop()
    GPIO.cleanup()