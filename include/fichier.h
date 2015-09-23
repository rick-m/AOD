#ifndef PARSER_H
#define PARSER_H
#include <stdint.h>

/* */
typedef struct file{
	uint32_t num;
	char* line;	
} file;

/**/
extern void insertQueue(struct file **l,char *line);

/* funtion return the number of lines of the file
*
*	param : struct line*
*
*	return  : number of lines
* */
extern uint32_t getSize(struct file *l);

/* function delete in memory the list
 *
 */
extern void deletefile(struct file **l);

/* function return the line of 
 *
 */
extern struct line getLine(struct file *l, uint32_t num);


#endif
