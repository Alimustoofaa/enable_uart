#include <mraa/uart.h>

int main()
{
    mraa_init();
    mraa_uart_init(0);
    return 0;
}
