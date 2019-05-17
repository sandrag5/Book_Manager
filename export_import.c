#include "export_import.h"

int export_file(nodo_ptr *puntero)
{
	FILE *new_file; 
	int i, err_dev = 0;
	struct book_info *ptr;
	int offset=0;
	void *str_book;
	int size_info_book;
	
	//array con id libros y ptr loop_files tamanyo_lista

	printf(CARGA);
	
	if ((new_file = fopen(NOMBREFICHERO, "wb")) == NULL)
        { 
		fprintf (stderr, ERROR);
		perror("fopen"); 
		err_dev = -1;
	} 
	else
	{
		/*Indica que es un fichero de publicaciones*/
		fwrite(key, sizeof(key)-1, 1, new_file);

	  
		n = hashtbl_nitems(hashtbl);
		
		for (i = 0; i < n; i++)
		{
		  p = hashtbl_get(hashtbl,doi_array[i]);  
		 
		  show_publication(p);
		  size_pub = size_publication(p);
		  str_publication = (void *)malloc(size_pub);
		  
		  memcpy(str_publication+offset, p->doi, strlen(p->doi)+1);
		  offset = offset+strlen(p->doi)+1;
		  
		  memcpy(str_publication+offset, p->title, strlen(p->title)+1);
		  offset = offset+strlen(p->title)+1;
		  
		  memcpy(str_publication+offset, p->isbn_issn, strlen(p->isbn_issn)+1);
		  offset = offset+strlen(p->isbn_issn)+1;
		  
		  memcpy(str_publication+offset, p->source, strlen(p->source)+1);
		  offset = offset+strlen(p->source)+1;
		  
		  memcpy(str_publication+offset, p->authors, strlen(p->authors)+1);
		  offset = offset+strlen(p->authors)+1;
		  
		  memcpy(str_publication+offset, &(p->year), sizeof(p->year));
		  offset = offset+sizeof(p->year);
		  
		  memcpy(str_publication+offset, &(p->impact_factor), sizeof(p->impact_factor));
		  offset = offset+sizeof(p->impact_factor);
		  
		  memcpy(str_publication+offset, &(p->publication_type), sizeof(p->publication_type));
		  offset = offset+sizeof(p->publication_type);
		  
		  memcpy(str_publication+offset, p->conference_or_magazine, strlen(p->conference_or_magazine)+1);
		  offset = offset+strlen(p->conference_or_magazine)+1;
		  
		  /*size_escrito = fwrite(&size_pub, sizeof(size_pub),1 , new_file);
		  printf ("Escrito Tamaño publicacion: Bloques: %d, Size: %d\n", size_escrito,sizeof(size_pub));
		  size_escrito = fwrite(str_publication, size_pub, 1, new_file);
		  printf ("Escrito publicacion: Bloques: %d, Size: %d\n", size_escrito,size_pub);*/
		  
		  free(str_publication);
		  
		}
		printf(LISTAEXP);
		fclose (new_file);
	}	

	return err_dev;

}
 
/**Función: import_file().********************************************************************
 
  Resumen      [Importa las publicaciones de un fichero a la tabla hash]
 
  Parámetros   [Puntero a la tabla hash] 
 
  Efec. Colat. [Que no haya leído bien los datos del fichero, o que intente leer un fichero vacío]
 
******************************************************************************/

int import_file(HASHTBL *hashtbl)
{
	FILE *ptr_file;
	int err_dev = 0;
	int size_pub;
	int offset =0;
	void *str_publication;
	char key[] = "PUBLICATION";
	char key_file[11];
	char *doi;
	char *title;
	char *isbn_issn;
	char *source;
	char *authors;
	int year;
	float impact_factor;
	int publication_type;
	char *conference_or_magazine;
	struct publication *ptr_publication;
	int	cont_publicacion =0;
	size_t size_leido;
		
	printf("****  IMPORT : \n");
	printf("Enter the file path: \n");
	
	if((ptr_file = fopen(string_read(), "rb")) == NULL)
    {
        printf("Error. File could not be opened or empty file.\n");
	perror("fopen");
	err_dev = -1;
    }
    else 
    {
		/*Comprueba si es un fichero de publicaciones*/
		size_leido = fread(key_file,sizeof(key_file),1,ptr_file);
		
		if((memcmp(key_file,key,sizeof(key_file)))!=0)
		{
			printf("Error. No publication file.\n");
			perror("fopen");
			err_dev = -1;
		} 
		else 
		{	
			size_leido = fread(&size_pub,sizeof(size_pub),1,ptr_file);
			/*printf("Leido tamaño publicacion; Bloques: : %d, Size: %d\n", size_leido,sizeof(size_pub));*/

			while (size_leido) 
			{ 
			cont_publicacion++;
			printf(">>  Start publication importation: %d<<\n", cont_publicacion);
			if( ferror(ptr_file) || feof(ptr_file) )
			{
			printf("Error reading file\n");
			}

			str_publication = (void *)malloc(size_pub);
			size_leido = fread(str_publication,size_pub,1,ptr_file);
			/*printf("Leida publicacion; Bloques: : %d; Size: %d\n",size_leido, size_pub);*/
			if( ferror(ptr_file) )
			{
			printf("Error in reading from file : file.txt\n");
			}
	
			doi = (char *)malloc(strlen(str_publication)+1);
			strcpy(doi, str_publication);
			offset =(strlen(doi)+1);

			title = (char *)malloc(strlen(str_publication+offset)+1);
			strcpy(title, str_publication+offset);
			offset = offset +(strlen(title)+1);


			isbn_issn = (char *)malloc(strlen(str_publication+offset)+1);
			strcpy(isbn_issn, str_publication+offset);      
			offset = offset + strlen(isbn_issn)+1;

			
			source = (char *)malloc(strlen(str_publication+offset)+1);
			strcpy(source, str_publication+offset);
			offset = offset + strlen(source)+1;

			authors = (char *)malloc(strlen(str_publication+offset)+1);
			strcpy(authors, str_publication+offset);
			offset = offset + strlen(authors)+1;

			memcpy(&year, str_publication+offset, sizeof(year)); 
			offset = offset + sizeof(year);

			memcpy(&impact_factor, str_publication+offset, sizeof(impact_factor)); 
			offset = offset + sizeof(impact_factor);
			
			memcpy(&publication_type, str_publication+offset, sizeof(publication_type)); 
			offset = offset + sizeof(publication_type);
			
			conference_or_magazine = (char *)malloc(strlen(str_publication+offset)+1);
			strcpy(conference_or_magazine, str_publication+offset);

			/*Creamos publicación y la rellenamos con lo leido*/
			ptr_publication = (struct publication *)calloc(1,sizeof(struct publication));
			ptr_publication->doi = doi;
			ptr_publication->title = title;
			ptr_publication->isbn_issn = isbn_issn;
			ptr_publication->source = source;
			ptr_publication->authors = authors;
			ptr_publication->year = year;
			ptr_publication->impact_factor = impact_factor;
			ptr_publication->publication_type = publication_type;
			ptr_publication->conference_or_magazine = conference_or_magazine;

			show_publication(ptr_publication);
			hashtbl_insert(hashtbl, ptr_publication->doi, ptr_publication);

			free(str_publication);
			
			/*Lectura tamaño publicación.*/
			size_leido = fread(&size_pub,sizeof(size_pub),1,ptr_file);
			/*printf("Leido tamaño publicacion; Bloques: : %d, Size: %d\n", size_leido,sizeof(size_pub));*/

			}
			printf("File imported.\n");
			fclose(ptr_file);
		}
   }
   
   return err_dev;
 
}

