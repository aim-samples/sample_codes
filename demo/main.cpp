#include <avr/io.h>
#include <util/delay.h>

#define BAUD_RATE_230400_BPS  2 // 230.4kps
 
int main()
{
    int i = 0;
    unsigned int ubrr = BAUD_RATE_230400_BPS;
    unsigned char data[] = "Hello from ATmega328p  ";
 
    /* Set Baudrate  */
    UBRR0H = (ubrr>>8);
    UBRR0L = (ubrr);
 
    UCSR0C = 0x06;       /* Set frame format: 8data, 1stop bit  */
    UCSR0B = (1<<TXEN0); /* Enable  transmitter                 */
 
    while(1) /* Loop the messsage continously */
    { 
        i = 0;
        while(data[i] != 0) /* print the String  "Hello from ATmega328p" */
        {
          while (!( UCSR0A & (1<<UDRE0))); /* Wait for empty transmit buffer*/
          UDR0 = data[i];            /* Put data into buffer, sends the data */
          i++;                             /* increment counter           */
        }
      }
}//end of main