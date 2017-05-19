#ifndef PORT_LAYER_H_
#define PORT_LAYER_H_

#include "koc_cpu.h"
#include "printf.h"

#ifdef __cplusplus
extern "C" 
{
#endif

	typedef void (Handler)(void);

	/**
	 * @brief Initializes and configures the necessary hardware.
	 */
	void initialize();
	
	void slaveinit();
	
	/**
	 * @brief Writes a byte.
	 * @param byte The output data. The data should be the least significant byte.
	 */
	void setbyte(unsigned byte);

	/**
	 * @brief Receives a byte.
	 * @return The input data. The data should be the least significant byte.
	 */
	unsigned getbyte();

	/**
	 * @brief Writes a word.
	 * @param The output data.
	 */
	void setword(unsigned word);

	/**
	 * @brief Receives a word.
	 * @return The input data. */
	unsigned getword();

	void setout(unsigned value);
	
	unsigned getout();
	
	unsigned getin();
	
	void blocklock();
	
	void givelock();
	
	void waituntil(unsigned tick);
	
	unsigned gettick();
	
	void setsignalhandler(Handler* func_ptr);
	void setgpiohandler(Handler* func_ptr);
	
#ifdef __cplusplus
}
#endif

#endif /* PORT_LAYER_H_ */