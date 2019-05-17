#ifndef LINKED_LIST_H_
#define LINKED_LIST_H_

#include <stdio.h>
#include <stdlib.h>
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
#define LIBROID "Libro id"
#define TIT20 "Título(20 caract.)"
#define AUTID "Autor id"
#define NOTFOUND "\n\t\tEl libro con id: %ld no ha sido encontrado."
#endif

struct nodo 
{
  struct book_info *datos;
  struct nodo *siguiente;
};

typedef struct nodo nodo_ptr;

nodo_ptr *crear_lista(nodo_ptr *ptr);
int num_elementos(nodo_ptr *head);
void borrar_lista(nodo_ptr *head);
nodo_ptr *insertar_lista(struct book_info *data, nodo_ptr *ptr);
void print_summary(nodo_ptr *head);
void show_book_info(long book_id, nodo_ptr *head);

#endif