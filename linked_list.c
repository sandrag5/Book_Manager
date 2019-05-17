#include "linked_list.h"

nodo_ptr *crear_lista(nodo_ptr *ptr)
{
	return(ptr = NULL);
}

int num_elementos(nodo_ptr *head){
  int cuenta = 0;
  nodo_ptr *aux;
  
  if (head == NULL) {
    return 0;
  } else {
    
    for(aux = head; aux->siguiente != NULL; aux = aux->siguiente) {
      cuenta++;
    }
    return cuenta;
  }
}

void borrar_lista(nodo_ptr *head){
 
  if(head == NULL){
    free(head);
  } else if (head->siguiente == NULL){
    free(head);
  } else {
    borrar_lista(head->siguiente);
    free(head);
  } 
}

nodo_ptr *insertar_lista(struct book_info *data, nodo_ptr *ptr)
{
	nodo_ptr *new_node, *aux_node;
	new_node = (nodo_ptr *)malloc(sizeof(nodo_ptr));
	new_node->datos = data;
	new_node->siguiente = NULL;
	
	if(ptr == NULL)
	{
		ptr = new_node;
	} 
	else
	{
		aux_node = ptr;
		while(aux_node->siguiente != NULL){
			aux_node = aux_node->siguiente;
		}
		aux_node->siguiente = new_node;
	}
	
	return ptr;
}

void print_summary(nodo_ptr *head){
  nodo_ptr *aux_node;
  aux_node = head;
  
  while(aux_node != NULL){
    show_summary(aux_node->datos);
    aux_node = aux_node->siguiente;
  }
  
}

void show_book_info(long book_id, nodo_ptr *head){
  	nodo_ptr *aux_node;
	
	if(head == NULL)
	{
		printf(NOTFOUND, book_id);
	} 
	else
	{
		aux_node = head;
		while((aux_node != NULL) && (aux_node->datos->l_book_id != book_id)){
			aux_node = aux_node->siguiente;
		}
		
		if(aux_node->datos->l_book_id == book_id){
		    show_info(aux_node->datos);
		} else {
		    printf(NOTFOUND, book_id);
		}
	}
}


/*
int main(){
  int i;
  struct book_info *aux;
  aux = (struct book_info *)malloc(sizeof(struct book_info));
  struct book_info *aux2;
  aux2 = (struct book_info *)malloc(sizeof(struct book_info));
  aux->l_book_id = 20001;
  aux->ptr_title = "El Quijote";
  aux->i_year = 1605;
  aux->i_num_pages = 1376;
  aux->f_quality = 100;
  aux->l_author_id = 10001;
  aux->ptr_name = "Miguel";
  aux->ptr_surname = "de Cervantes Saavedra";
  
  aux2->l_book_id = 20002;
  aux2->ptr_title = "Novelas Ejemplares";
  aux2->i_year = 2000;
  aux2->i_num_pages = 1346;
  aux2->f_quality = 99;
  aux2->l_author_id = 10001;
  aux2->ptr_name = "Juan";
  aux2->ptr_surname = "Palomino";
  printf("%s\n", "------------------------------INFORMACION");
  show_info(aux);
  show_info(aux2);
  printf("%s\n", "------------------------------COMO TIENE QUE QUEDAR");
  printf("%s\n", "=====================================================================================================");
  printf("%s\n", "== \"Libro id\" |\" Título(20 caract.)\"| \"Autor id\" ====================================================");
  printf("%s\n", "=====================================================================================================");
  show_summary(aux);
  show_summary(aux2);
  printf("%s\n", "=====================================================================================================");
  printf("%s\n", "");
  printf("%s\n", "------------------------------COMO QUEDA");
  
   nodo_ptr *head = (nodo_ptr *)malloc(sizeof(nodo_ptr));
   head = crear_lista(head);
   
   head = insertar_lista(aux, head);
   head = insertar_lista(aux2, head);
   
   print_summary(head);
   
   i = num_elementos(head);
   printf("%d", i);
  
  return 0;
  
  diff /tmp/salida2OK.100317575 /tmp/salida2PROG.100317575
  
}*/