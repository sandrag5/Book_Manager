#ifndef __MY_BOOK_MANAGER__
#define __MY_BOOK_MANAGER__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <assert.h>

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
#define INTRODUZCASIG "\n\t\tIntroduzca la siguiente información:\n"
#define DAMEIDLIBRO "\t\t\tDame el ID del libro: "
#define QIDLIBRO "\t\t\tel ID del libro: "
#define QTITLIBRO "\t\t\tel título del libro: "
#define QNUMPAGINAS "\t\t\tel número de páginas: "
#define QANYO "\t\t\tel año de publicación: "
#define QCALIDAD "\t\t\tla calidad: "
#define QAUTORID "\t\t\tel identificador de autor: "
#define QAUTORN "\t\t\tel nombre del autor: "
#define QAUTORA "\t\t\tel apellido del autor: "
#define LIBROCREADO "\n\t\tLibro creado con id: %ld y título: %.20s."
#define NOHAY "\n\t\tNo hay ningún libro.\n"
#define LIBROID "Libro id"
#define TIT20 "Título(20 caract.)"
#define AUTID "Autor id"
#define DETALLADA "\n\t\tInformación detallada para ==(%ld)=="
#define IDLIBROF "\n\t\t=%ld= Identificador:            \t %ld"
#define TITLIBROF "\n\t\t=%ld= Título del libro:               \t \"%.40s\""
#define ANYOF "\n\t\t=%ld= Año de publicación:         \t %d "
#define NUMPAGINASF "\n\t\t=%ld= Número de páginas:            \t %d "
#define CALIDADF "\n\t\t=%ld= Calidad:                    \t %.2f "
#define AUTIDF "\n\t\t=%ld= Identificador de autor:        \t %ld "
#define AUTORNF "\n\t\t=%ld= Nombre del autor:              \t \"%.40s\""
#define AUTORAF "\n\t\t=%ld= Apellidos del autor:       \t \"%.40s\""
#define NOTFOUND "\n\t\tEl libro con id: %ld no ha sido encontrado."
#define ESCRITOS "\n\t\tEscritos %d libros en \"\%.20s\""
#define LEIDOS "\n\t\tLeídos %d libros en \"\%.20s\""
#define IMPORTSEGURO "\n\t\t\tVa a borrar todos los datos en memoria. ¿Desea continuar (s/N)?"
#define RUNNING "\n\t\t Autosave corriendo"
#define YARUNNING "\n\t\tAutosave ya estaba corriendo\n"
#define WRONG_SHAREDM "\n\t\t\[WRONG_SHARED ID] Dos libros con mismo ID: %ld"
#define WRONG_DUALM "\n\t\t[WRONG_DUAL_ID] Dos autores con mismo ID: %ld, pero distintos datos"
#define NOWRONG "\n\t\tNo hay entradas corruptas"
#define CARGANDO "\n\t\tCargando ID: id %ld"
#endif
#ifdef LANG_EN  
#define OPCIONESMENU() {    printf("\n\t[0] \tExit"); printf("\n\t[1] \tInsert a book"); printf("\n\t[2] \tShow all books"); printf("\n\t[3] \tShow a book by ID"); printf("\n\t[4] \tModify a book by ID"); printf("\n\t[5] \tRemove a book by ID"); printf("\n\t[6] \tExport catalogue"); printf("\n\t[7] \tImport catalogue"); printf("\n\t[8] \tShow corrupt records"); printf("\n\t[9] \tActivate autosave (every 10 seconds)"); }
#define OPCIONESAVANZADAS() { printf("\n\t[10] \tShow all books (ordered by quality)"); }
#define EJECUTADOS "\n\n\t\t#INFO: %4d commands executed.\n\t\tType your option [0-10]:  "
#define EJECUTADO "\n\n\t\t#INFO: %4d command executed.\n\t\tType your option [0-10]:  "
#define SALIRSEGURO "\n\t\tReady to exit (y/N): "
#define INTRODUZCASIG "\n\t\tIntroduce the following information:\n"
#define DAMEIDLIBRO "\t\t\tGive me the ID of the book: "
#define QIDLIBRO "\t\t\tthe ID of the book: "
#define QTITLIBRO "\t\t\tthe title of the book: "
#define QNUMPAGINAS "\t\t\tthe number of pages: "
#define QANYO "\t\t\tthe publication year: "
#define QCALIDAD "\t\t\tthe quality: "
#define QAUTORID "\t\t\tthe ID of the author: "
#define QAUTORN "\t\t\tthe name of the author: "
#define QAUTORA "\t\t\tthe surname of the author: "
#define LIBROCREADO "\n\t\tAllocated book with id: %ld  and title: %.20s."
#define NOHAY "\n\t\tThere are no books.\n"
#define LIBROID "Book id"
#define TIT20 "Title (20 chars)"
#define AUTID "Author id"
#define DETALLADA "\n\t\tDetailed information for ==(%ld)=="
#define IDLIBROF "\n\t\t=%ld= Identifier:            \t %ld"
#define TITLIBROF "\n\t\t=%ld= Title of the book:       \t \"%.40s\""
#define ANYOF "\n\t\t=%ld= Publication year:           \t %d "
#define NUMPAGINASF "\n\t\t=%ld= Number of pages:            \t %d "
#define CALIDADF "\n\t\t=%ld= Quality:                    \t %.2f "
#define AUTIDF "\n\t\t=%ld= Authors' ID:                \t %ld "
#define AUTORNF "\n\t\t=%ld= Authors' name:              \t \"%.40s\""
#define AUTORAF "\n\t\t=%ld= Surname of the author:       \t \"%.40s\""
#define NOTFOUND "\n\t\tThe book with id: %ld has not been found."
#define ESCRITOS "\n\t\tWritten %d books in \"\%.20s\""
#define LEIDOS "\n\t\tRead %d books in \"\%.20s\""
#define IMPORTSEGURO "\n\t\t\tYou are going to remove all in memory data.Do you want to follow (y/N)?"
#define RUNNING "\n\t\t Autosave running "
#define YARUNNING "\n\t\tAutosave already running\n"
#define WRONG_SHAREDM "\n\t\t\[WRONG_SHARED ID] Two books with the same ID: %ld"
#define WRONG_DUALM "\n\t\t[WRONG_DUAL_ID] Two authors with the same ID: %ld, but different data"
#define NOWRONG "\n\t\tThere are not any corrupt records"
#define CARGANDO "\n\t\tLoading ID: id %ld"

#endif

#define CABECERAMENU() {printf("\n\n\t=================================================="); printf("\n\t[*][2015][SAUCEM APPS][My_Book_Manager] =========="); printf("\n\t==================================================");}
#define NOMBREFICHERO	"data_demo.sbm"
#define THREADAUTOSAVE	"\n\t\t[THREAD_AUTOSAVE] %d"
#define THREADAUTOSAVEEXIT	"\n\t\t[TREAD_AUTOSAVE] Exiting\n"
#define CABECERALISTADO() { printf("\n\t\t=====================================================================================================\n"); printf("\t\t== \"%5s\" |\"%20s\"| \"%s\" ===================================================\n", LIBROID, TIT20, AUTID); printf("\t\t=====================================================================================================\n"); }
#define LISTALIBRO(libroid, titulo, autorid) {printf("\t\t==|  %7ld | %20.20s | %10ld |\n", libroid, titulo,autorid);}
#define LISTALIBROCALIDAD(libroid, titulo, autorid, calidad) {printf("\t\t==|  %7ld | %20.20s | %10ld | %6.2f |\n", libroid, titulo, autorid, calidad);}
#define PIELISTADO() { printf("\t\t=====================================================================================================\n");}

/*
 * Añadir a partir de aquí las macros, tipos o cabeceras desarrolladas para el proyecto
 */


#endif
