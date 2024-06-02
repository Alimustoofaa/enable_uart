#include <mraa/uart.h>
#include <mraa/gpio.h>

int main()
{
    // Initialize the MRAA library
    mraa_init();

    // Initialize UART on port 0
    mraa_uart_context uart = mraa_uart_init(0);

    // Initialize GPIO pin D03
    mraa_gpio_context gpio = mraa_gpio_init(3); // Assuming D03 corresponds to GPIO pin 3
    if (gpio == NULL) {
        fprintf(stderr, "Failed to initialize GPIO pin D03\n");
        return 1;
    }

    // Set the direction of the GPIO pin to output
    if (mraa_gpio_dir(gpio, MRAA_GPIO_OUT) != MRAA_SUCCESS) {
        fprintf(stderr, "Failed to set GPIO pin D03 direction\n");
        return 1;
    }

    // Set the GPIO pin to low
    if (mraa_gpio_write(gpio, 0) != MRAA_SUCCESS) {
        fprintf(stderr, "Failed to write low to GPIO pin D03\n");
        return 1;
    }

    // Clean up
    mraa_gpio_close(gpio);
    mraa_uart_stop(uart);
    mraa_deinit();

    return 0;
}
