#ifndef BOOK_H_
#define BOOK_H_

#include <stdio.h>
#include <stdlib.h>
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
#define INTRODUZCASIG "\n\t\tIntroduzca la siguiente información:\n"
#define QIDLIBRO "\t\t\tel ID del libro: "
#define QTITLIBRO "\t\t\tel título del libro: "
#define QNUMPAGINAS "\t\t\tel número de páginas: "
#define QANYO "\t\t\tel año de publicación: "
#define QCALIDAD "\t\t\tla calidad: "
#define QAUTORID "\t\t\tel identificador de autor: "
#define QAUTORN "\t\t\tel nombre del autor: "
#define QAUTORA "\t\t\tel apellido del autor: "
#define LIBROCREADO "\n\t\tLibro creado con id: %ld y título: %.20s."
#define DETALLADA "\n\t\tInformación detallada para ==(%ld)=="
#define IDLIBROF "\n\t\t=%ld= Identificador:            \t %ld"
#define TITLIBROF "\n\t\t=%ld= Título del libro:               \t \"%.40s\""
#define ANYOF "\n\t\t=%ld= Año de publicación:         \t %d "
#define NUMPAGINASF "\n\t\t=%ld= Número de páginas:            \t %d "
#define CALIDADF "\n\t\t=%ld= Calidad:                    \t %.2f "
#define AUTIDF "\n\t\t=%ld= Identificador de autor:        \t %ld "
#define AUTORNF "\n\t\t=%ld= Nombre del autor:              \t \"%.40s\""
#define AUTORAF "\n\t\t=%ld= Apellidos del autor:       \t \"%.40s\""
#endif

#define LISTALIBRO(libroid, titulo, autorid) {printf("\t\t==|  %7ld | %20.20s | %10ld |\n", libroid, titulo,autorid);}
#define LISTALIBROCALIDAD(libroid, titulo, autorid, calidad) {printf("\t\t==|  %7ld | %20.20s | %10ld | %6.2f |\n", libroid, titulo, autorid, calidad);}

struct book_info
{
    long l_book_id;
    char *ptr_title;
    int i_num_pages;
    int i_year;
    float f_quality;
    long l_author_id;
    char *ptr_name;
    char *ptr_surname;
};

struct book_info *add_book(struct book_info *ptr_book);
void show_summary(struct book_info *ptr_book);
void show_info(struct book_info *ptr_book);
 
#endif