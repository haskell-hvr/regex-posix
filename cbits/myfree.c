#include <regex.h>
#include <stdlib.h>

#include "myfree.h"

/* 
void free(void *ptr);
void regfree(regex_t *preg);
*/

void hs_regex_freereq(void *preg) {
  regfree(preg);
  free(preg);
}
