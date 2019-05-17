#include "my_book_manager.h"

int salir(){
  
    printf(SALIRSEGURO);
    char *respuesta = string_read();
    
    if(strcmp(respuesta, "s") == 0){
      free(respuesta);
      return 0;
    }else if(strcmp(respuesta, "N") == 0){
      free(respuesta);
      return 1;
    } else {
      printf(ERROR);
      free(respuesta);
      return salir();
    }
     
}

int main(int arg_count, char *arg_strings[]) 
{
    long int option;
    int continuar = 1;
    int counter = 0;
    
    struct book_info *ptr_book;
    /*nodo_ptr *head = (nodo_ptr *)malloc(sizeof(nodo_ptr));*/
    nodo_ptr *head = NULL;
    head = crear_lista(head);
    
    do
    {
        CABECERAMENU();
	OPCIONESMENU();
#if defined(AVANZADAS)
	OPCIONESAVANZADAS();
#endif
	if(counter == 1){
	  printf(EJECUTADO, counter);
	} else {
	  printf(EJECUTADOS, counter);
	}
        option = int_read();
	if(option > -1 && option < 11) {
	  counter++;
	}
	
         switch(option)
        {
            case 0:		//Con el malloc hay fuga del head creado aquí arriba
		continuar = salir();	
		borrar_lista(head);
		free(head);
                break;
            case 1:
		ptr_book = (struct book_info *)calloc(1, sizeof(struct book_info));
		add_book(ptr_book);
		head = insertar_lista(ptr_book, head);
		free(ptr_book);
                break;
            case 2:
		CABECERALISTADO();
		print_summary(head);
		PIELISTADO();
                break;
            case 3:
		printf(DAMEIDLIBRO);
		option = int_read();
		show_book_info(option, head);
                break;
            case 4:
                break;
            case 5:
                break;
            case 6: //EXPORTAR
                break;
            case 7: //IMPORTAR
                break;
            case 8:
                break;
            case 9:
                break;
#if defined(AVANZADAS)
            case 10:
                break;
#endif
	    default:
	      printf(ERROR);
        }
        
    } while (continuar);
    
    return 0;
}