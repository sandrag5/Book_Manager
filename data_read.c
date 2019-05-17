#include "data_read.h"

long int_read(){
    long data;
    ssize_t bytes_leidos;
    size_t numero_bytes;
    char *string;
 
    numero_bytes = 0;
    string = NULL;
    bytes_leidos = getline(&string, &numero_bytes, stdin);
     
    if (bytes_leidos == -1)
    {
        puts("\n\t\tERROR: Vuelva a intentarlo.");
    } 
    else
    {
        string[strlen(string)-1]= '\0';
        data = strtol(string, NULL, 10);
    }

    free(string);
    return data;
}

float float_read()
{
    float data;
    ssize_t bytes_leidos;
    size_t numero_bytes;
    char *string;   
     
    numero_bytes = 0;
    string = NULL;
    bytes_leidos = getline(&string, &numero_bytes, stdin);
     
    if (bytes_leidos == -1)
    {
        puts("\n\t\tERROR: Vuelva a intentarlo.");
    } 
    else
    {
        string[strlen(string)-1]= '\0';
        data = strtof(string, NULL); 
    }
        
    free(string);
    return data;
}

char* string_read()
{
    ssize_t bytes_leidos;
    size_t numero_bytes;
    char *string;
 
    numero_bytes = 0;
    string = NULL;
    bytes_leidos = getline(&string, &numero_bytes, stdin);
     
    if (bytes_leidos == -1)
    {
        puts("\n\t\tERROR: Vuelva a intentarlo.");
    } 
    else
    {
        string[strlen(string)-1]= '\0';
    }
    
    return string;
}
