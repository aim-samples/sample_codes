/*
 * blink.cpp
 * blink portb of arduino means pin PB4 and PB5
 *
 * Created: 2/13/2022 11:21:30 AM
 * Author : HP
 */ 
#ifndef F_CPU
	#define F_CPU 16000000UL
#endif

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	//DDRB |= ((1 << PB4) & (1 << PB5));	// PB4 and PB5 as output without affecting other pins
	DDRB = 0xFF;
    while (1) 
    {
		PORTB = 0xFF;
		//PORTB |= ((1 << PB4) & (1 << PB5));	// PB4 and PB5 as output high without affecting other pins
		_delay_ms(1000);
		PORTB = 0x00;
		//PORTB &= ~((1 << PB4) & (1 << PB5));	// PB4 and PB5 as output low without affecting other pins
		_delay_ms(1000);
    }
}

