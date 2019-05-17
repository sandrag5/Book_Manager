#ifndef MY_BOOK_MANAGER_H_
#define MY_BOOK_MANAGER_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <assert.h>
#include "data_read.h"
#include "linked_list.h"
#include "book.h"

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
#define OPCIONESMENU() {    printf("\n\t[0] \tSalir"); printf("\n\t[1] \tInsertar libro"); printf("\n\t[2] \tMostrar todos los libros"); printf("\n\t[3] \tMostrar un libro por ID"); printf("\n\t[4] \tModificar un libro por ID"); printf("\n\t[5] \tBorrar un libro por ID"); printf("\n\t[6] \tExportar catálago"); printf("\n\t[7] \tImportar catálago"); printf("\n\t[8] \tMostrar registros corruptos"); printf("\n\t[9] \tActivar autosalvado (cada 10 segundos)");    }
#define OPCIONESAVANZADAS() { printf("\n\t[10] \tMostrar todos los libros (ordenados por calidad)"); }
#define EJECUTADOS "\n\n\t\t#INFO: %4d comandos ejecutados.\n\t\tTeclee su opción [0-9]:  "
#define EJECUTADO "\n\n\t\t#INFO: %4d comando ejecutado.\n\t\tTeclee su opción [0-9]:  "
#define SALIRSEGURO "\n\t\tSeguro de que desea salir (s/N): "
#define DAMEIDLIBRO "\t\t\tDame el ID del libro: "
#define ERROR "\n\t\tERROR. Opción incorrecta."
#endif

#define CABECERAMENU() {printf("\n\n\t=================================================="); printf("\n\t[*][2015][SAUCEM APPS][My_Book_Manager] =========="); printf("\n\t==================================================");}
#define CABECERALISTADO() { printf("\n\t\t=====================================================================================================\n"); printf("\t\t== \"%5s\" |\"%20s\"| \"%s\" ===================================================\n", LIBROID, TIT20, AUTID); printf("\t\t=====================================================================================================\n"); }
#define PIELISTADO() { printf("\t\t=====================================================================================================\n");}
#define NOMBREFICHERO	"data_demo.sbm"
#define THREADAUTOSAVE	"\n\t\t[THREAD_AUTOSAVE] %d"
#define THREADAUTOSAVEEXIT	"\n\t\t[TREAD_AUTOSAVE] Exiting\n"

int salir();
int main(int argc, char *argv[]);
 
#endif