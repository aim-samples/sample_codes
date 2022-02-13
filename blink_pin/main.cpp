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
#define is_input_high(pin_port, pin) pin_port & (1 << pin)	// use PINx registers, like for b port: PINB
#define set_input(portdir,pin) portdir &= ~(1<<pin)			// use DDRx registers, like for b port: DDRB
#define set_output(portdir,pin) portdir |= (1<<pin)			// use DDRx registers, like for b port: DDRB

#define led_dir DDRB
#define led_port PORTB
#define led_pin PB5

int main(void) {
	set_output(led_dir, led_pin);  
    while (1) {
		output_high(led_port, led_pin);
		_delay_ms(1000);
		output_low(led_port, led_pin);
		_delay_ms(1000);
    }
}

