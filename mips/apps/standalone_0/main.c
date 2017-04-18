#include "koc_cpu.h"
#include "koc_lock.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"

#define HW_LOCK_BASE_ADDRESS		(0x20000000)
#define HW_INT_BASE_ADDRESS		(0x20010000)
#define HW_TIMER_BASE_ADDRESS		(0x20020000)
#define HW_GPIO_BASE_ADDRESS		(0x20030000)
#define HW_UART_BASE_ADDRESS		(0x20040000)

#define INT_TIMER_ID			(0)
#define INT_GPIO_ID			(1)
#define INT_UART_ID			(2)

plasoc_int int_obj;
plasoc_timer timer_obj;
plasoc_gpio gpio_obj;

int main()
{

	return 0;
}
