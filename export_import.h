#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "linked_list.h"
#include "book.h"
#include "data_read.h"

#if defined(DEBUG)
#define BEGINF(a,b,c,d,e)  fprintf(stderr, "beginf %s creator=%s tester=%s integrator=%s systemtester=%s (%d)\n", #a, #b, #c, #d, #e __LINE__);
#define ENDF(a)  fprintf(stderr, "endf %s (%d)\n", #a, __LINE__);
#else
#define BEGINF(a,b,c,d,e) 
#define ENDF(a)
#endif

#ifndef LANG_EN
  #ifndef LANG_ES
  #define LANG_ES
  #endif
#endif

#ifdef LANG_ES  
#define CARGA "\n\t\tCargando..."
#define ERROR "\n\t\tERROR. El archivo no se ha podido escribir."
#define LISTAEXP "\n\t\tLista exportada."
#endif

#define NOMBREFICHERO	"data_demo.sbm"

int export_file(nodo_ptr *);
int import_file(nodo_ptr *);
