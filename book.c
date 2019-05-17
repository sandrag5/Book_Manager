#include "book.h"


struct book_info *add_book(struct book_info *ptr_book){
  printf(INTRODUZCASIG);
  printf(QIDLIBRO);
  ptr_book->l_book_id = int_read();
  printf(QTITLIBRO);
  ptr_book->ptr_title = string_read();
  printf(QNUMPAGINAS);
  ptr_book->i_num_pages = int_read();
  printf(QANYO);
  ptr_book->i_year = int_read();
  printf(QCALIDAD);
  ptr_book->f_quality = float_read();
  printf(QAUTORID);
  ptr_book->l_author_id = int_read();
  printf(QAUTORN);
  ptr_book->ptr_name = string_read();
  printf(QAUTORA);
  ptr_book->ptr_surname = string_read();
  printf(LIBROCREADO, ptr_book->l_book_id, ptr_book->ptr_title);
  return ptr_book;
}

void show_summary(struct book_info *ptr_book){
  LISTALIBRO(ptr_book->l_book_id, ptr_book->ptr_title, ptr_book->l_author_id);
}

void show_info(struct book_info *ptr_book){
    printf(DETALLADA, ptr_book->l_book_id);
    printf(IDLIBROF, ptr_book->l_book_id, ptr_book->l_book_id);
    printf(TITLIBROF, ptr_book->l_book_id, ptr_book->ptr_title);
    printf(ANYOF, ptr_book->l_book_id, ptr_book->i_year);
    printf(NUMPAGINASF, ptr_book->l_book_id, ptr_book->i_num_pages);
    printf(CALIDADF, ptr_book->l_book_id, ptr_book->f_quality);
    printf(AUTIDF, ptr_book->l_book_id, ptr_book->l_author_id);
    printf(AUTORNF, ptr_book->l_book_id, ptr_book->ptr_name);
    printf(AUTORAF, ptr_book->l_book_id, ptr_book->ptr_surname);
}

/*int main(){
  struct book_info *aux;
  aux = (struct book_info *)malloc(sizeof(struct book_info));
  aux = add_book(aux);
  
  show_info_book(aux);
  
  show_summary(aux);
  
  return 0;
  
}*/