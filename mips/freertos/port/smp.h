#ifndef SMP_H_
#define SMP_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	BaseType_t xTaskCreateSMP(TaskFunction_t pvTaskCode,const char * const pcName,unsigned short usStackDepth,
		void *pvParameters,UBaseType_t uxPriority,TaskHandle_t *pxCreatedTask,portUBASE_TYPE affinity);
	

#ifdef __cplusplus
}
#endif


#endif
