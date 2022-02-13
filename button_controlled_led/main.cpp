/*
 * blink.cpp
 * blink single pin of atmega328 means pin PB4 and PB5
 *
 * Created: 2/13/2022 11:21:30 AM
 * Author : HP
 */ 
#ifndef F_CPU
	#define F_CPU 16000000UL
#endif

#include <avr/io.h>
#include <util/delay.h>

#define output_low(port,pin) port &= ~(1<<pin)				// use PORTx registers, like for b port: PORTB
#define output_high(port,pin) port |= (1<<pin)				// use PORTx registers, like for b port: PORTB
#define is_input_high(pin_port, pin) (pin_port & (1 << pin)) 	// use PINx registers, like for b port: PINB, output : 1 or 0
#define is_input_high2(pin_port, pin) (pin_port & (1 << pin)) >> pin 	// use PINx registers, like for b port: PINB, output : 16 or 0
#define set_input(portdir,pin) portdir &= ~(1<<pin)			// use DDRx registers, like for b port: DDRB
#define set_output(portdir,pin) portdir |= (1<<pin)			// use DDRx registers, like for b port: DDRB

#define led_pin 5
#define led_port PORTB
#define button_pin 4
#define button_port PINB
#define led_button_port DDRB

int main(void) {
	set_output(led_button_port, led_pin);  
	set_input(led_button_port, button_pin); // not compulsary by default in input mode on start
    while (1)  {
		uint8_t status = bit_is_set(button_port, button_pin);
		if(status) {
			output_high(led_port, led_pin);
		} else {
			output_low(led_port, led_pin);
		}
		
		_delay_ms(100);
    }
}

