#!/bin/sh

maxlibros=1000
fugas=0
disclaimer () {
        echo "(*) Maximum grade that can be achieved in the case of passing the final revisions"
}

crealibros () {
[ -d /tmp/libros$USER ] || mkdir /tmp/libros$USER
rm -f /tmp/libros$USER/*.txt

cat <<++ > /tmp/libros$USER/101.txt
1
101
El Quijote
1376
1605
100.00
10001
Miguel
de Cervantes Saavedra
++

i=102
while [ $i -lt $maxlibros ] ; do
anyo=$((900+$i))
autor=$((9900+$i))
calidad=`echo "scale=2; ($i * $i % 9999)" | bc`

cat <<++ > /tmp/libros$USER/$i.txt
1
$i
title$i
1376
$anyo
$calidad
$autor
nombre$autor
apellidos$autor
++
i=$(($i+1))
done

}

test () {
echo "Test $1" >&2
if [ "$4" = "helgrind" ] ; then
	VALOPTS="--tool=helgrind"
else
	VALOPTS="--tool=memcheck --leak-check=full"
fi
valgrind -q $VALOPTS ./runnable > /tmp/salida${1}PROG.$USER 2>&1
res=`diff -w /tmp/salida${1}OK.$USER /tmp/salida${1}PROG.$USER | wc -l`
grep leak /tmp/salida${1}PROG.$USER | tee -a /tmp/leaks.$USER >&2
[ $res -gt $3 ] && echo FAILED "$2" && return 1
return 0
}

test1 () {
# option: 1
rm -f /tmp/salida1OK.* /tmp/salida1PROG.*
cat <<++ > /tmp/salida1OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
test 1 "[0][s]" $1 <<++
0
s
++
}

test2 () {
# option: 1,2
rm -f /tmp/salida2OK.* /tmp/salida2PROG.*
cat <<++ > /tmp/salida2OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt - <<++ | test 2 "[1][2][0][s]" $1
2
0
s
++
}


test3 () {
# option: 1,3
rm -f /tmp/salida3OK.* /tmp/salida3PROG.*
cat <<++ > /tmp/salida3OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 
		El libro con id: 99 no ha sido encontrado.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt - <<++ | test 3 "[1][3][Noexiste][0][s]" $1
3
99
0
s
++
}

test4 () {
# option: 1,3
rm -f /tmp/salida4OK.* /tmp/salida4PROG.*
cat <<++ > /tmp/salida4OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 
		Información detallada para ==(101)==
		=101= Identificador:            	 101
		=101= Título del libro:               	 "El Quijote"
		=101= Año de publicación:         	 1605 
		=101= Número de páginas:            	 1376 
		=101= Calidad:                    	 100.00 
		=101= Identificador de autor:        	 10001 
		=101= Nombre del autor:              	 "Miguel"
		=101= Apellidos del autor:       	 "de Cervantes Saavedra"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt - <<++ | test 4 "[1][3][Quijote][0][s]" $1
3
101
0
s
++
}

test5 () {
# option: 1,4
rm -f /tmp/salida5OK.* /tmp/salida5PROG.*
cat <<++ > /tmp/salida5OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  			Dame el ID del libro: 
		Información detallada para ==(101)==
		=101= Identificador:            	 101
		=101= Título del libro:               	 "El Quijote"
		=101= Año de publicación:         	 1605 
		=101= Número de páginas:            	 1376 
		=101= Calidad:                    	 100.00 
		=101= Identificador de autor:        	 1000 
		=101= Nombre del autor:              	 "Miguel"
		=101= Apellidos del autor:       	 "de Cervantes Savedra"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 
		Introduzca la siguiente información:
			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 
		Información detallada para ==(101)==
		=101= Identificador:            	 101
		=101= Título del libro:               	 "El Quijote"
		=101= Año de publicación:         	 1605 
		=101= Número de páginas:            	 1376 
		=101= Calidad:                    	 100.00 
		=101= Identificador de autor:        	 1000 
		=101= Nombre del autor:              	 "Miguel"
		=101= Apellidos del autor:       	 "de Cervantes Saavedra"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
test 5 "[1][4][Quijote][3][0][s]" $1 <<++
1
101
El Quijote
1376
1605
100.00
1000
Miguel
de Cervantes Savedra
3
101
4
101
El Quijote
1376
1605
100.00
1000
Miguel
de Cervantes Saavedra
3
101
0
s
++
}

test6 () {
# option: 1,5
rm -f /tmp/salida6OK.* /tmp/salida6PROG.*
cat <<++ > /tmp/salida6OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      102 |             title102 |      10002 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    5 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt - <<++ | test 6 "[1][2][5][Quijote][2][0][s]" $1
2
5
101
2
0
s
++
}

test7 () {
# option: 1,5
rm -f /tmp/salida7OK.* /tmp/salida7PROG.*
cat <<++ > /tmp/salida7OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      101 |           El Quijote |      10001 |
		==|      102 |             title102 |      10002 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      102 |             title102 |      10002 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    5 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/102.txt /tmp/libros$USER/101.txt - <<++ | test 7 "[1][2][5][Quijote][2][0][s]" $1
2
5
101
2
0
s
++
}

test8 () {
# option: 1,5
rm -f /tmp/salida8OK.* /tmp/salida8PROG.*
cat <<++ > /tmp/salida8OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 103 y título: title103.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      103 |             title103 |      10003 |
		==|      101 |           El Quijote |      10001 |
		==|      102 |             title102 |      10002 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  			Dame el ID del libro: 

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    5 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      103 |             title103 |      10003 |
		==|      102 |             title102 |      10002 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    6 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/102.txt /tmp/libros$USER/101.txt /tmp/libros$USER/103.txt - <<++ | test 8 "[1][2][5][Quijote][2][0][s]" $1
2
5
101
2
0
s
++
}


test9 () {
# option: 1,6
rm -f /tmp/salida9OK.* /tmp/salida9PROG.*
cat <<++ > /tmp/salida9OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 103 y título: title103.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      103 |             title103 |      10003 |
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  
		Escritos 3 libros en "data_demo.sbm"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    5 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      103 |             title103 |      10003 |
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    6 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt /tmp/libros$USER/103.txt - <<++ | test 9 "[1][2][6][2][0][s]" $1
2
6
2
0
s
++
retval=$?
if [ ! -f data_demo.sbm ] ; then
        echo "data_demo.sbm not created" >&2
	retval=1
fi
return $retval
}


test10 () {
# option: 1,7
rm -f /tmp/salida10OK.* /tmp/salida10PROG.*
cat <<++ > /tmp/salida10OK.$USER
open file: Permission denied


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
			Va a borrar todos los datos en memoria. ¿Desea continuar (s/N)?

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		No hay ningún libro.


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
chmod 000 data_demo.sbm
test 10 "[7][s][2][0][s]" $1 <<++
7
s
2
0
s
++
}

test11 () {
# option: 1,7
rm -f /tmp/salida11OK.* /tmp/salida11PROG.*
cat <<++ > /tmp/salida11OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
			Va a borrar todos los datos en memoria. ¿Desea continuar (s/N)?
		Cargando ID: id 103
		Cargando ID: id 102
		Cargando ID: id 101
		Leídos 3 libros en "data_demo.sbm"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      103 |             title103 |      10003 |
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
chmod 644 data_demo.sbm
test 11 "[7][s][2][0][s]" $1 <<++
7
s
2
0
s
++
}

test12 () {
# option: 1,8
rm -f /tmp/salida12OK.* /tmp/salida12PROG.*
cat <<++ > /tmp/salida12OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
			Va a borrar todos los datos en memoria. ¿Desea continuar (s/N)?
		Cargando ID: id 103
		Cargando ID: id 102
		Cargando ID: id 101
		Leídos 3 libros en "data_demo.sbm"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		No hay entradas corruptas

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
test 12 "[7][s][8][0][s]" $1 <<++
7
s
8
0
s
++
}

test13 () {
# option: 1,8
rm -f /tmp/salida13OK.* /tmp/salida13PROG.*
cat <<++ > /tmp/salida13OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 104 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		[WRONG_DUAL_ID] Dos autores con mismo ID: 1000, pero distintos datos
		Información detallada para ==(101)==
		=101= Identificador:            	 101
		=101= Título del libro:               	 "El Quijote"
		=101= Año de publicación:         	 1605 
		=101= Número de páginas:            	 1376 
		=101= Calidad:                    	 100.00 
		=101= Identificador de autor:        	 1000 
		=101= Nombre del autor:              	 "Miguel"
		=101= Apellidos del autor:       	 "de Cervantes"
		Información detallada para ==(104)==
		=104= Identificador:            	 104
		=104= Título del libro:               	 "El Quijote"
		=104= Año de publicación:         	 1605 
		=104= Número de páginas:            	 1376 
		=104= Calidad:                    	 100.00 
		=104= Identificador de autor:        	 1000 
		=104= Nombre del autor:              	 "Miguel"
		=104= Apellidos del autor:       	 "de Cervantes Saavedra"

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
++
test 13 "[1][1][8][0][s]" $1 <<++
1
104
El Quijote
1376
1605
100.00
1000
Miguel
de Cervantes Saavedra
1
101
El Quijote
1376
1605
100.00
1000
Miguel
de Cervantes
8
0
s
++
}


test14 () {
# option: 1,9
rm -f /tmp/salida14OK.* /tmp/salida14PROG.*
cat <<++ > /tmp/salida14OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		 Autosave corriendo

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Seguro de que desea salir (s/N): 
		[TREAD_AUTOSAVE] Exiting
++
test 14 "[9][0][s]" $1 <<++
9
0
s
++
}


test15 () {
# option: 1,9
rm -f /tmp/salida15OK.* /tmp/salida15PROG.*
cat <<++ > /tmp/salida15OK.$USER


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    0 comandos ejecutados.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 101 y título: El Quijote.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    1 comando ejecutado.
		Teclee su opción [0-9]:  
		Introduzca la siguiente información:
			el ID del libro: 			el título del libro: 			el número de páginas: 			el año de publicación: 			la calidad: 			el identificador de autor: 			el nombre del autor: 			el apellido del autor: 
		Libro creado con id: 102 y título: title102.

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    2 comandos ejecutados.
		Teclee su opción [0-9]:  
		=====================================================================================================
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		=====================================================================================================
		==|      102 |             title102 |      10002 |
		==|      101 |           El Quijote |      10001 |
		=====================================================================================================


	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    3 comandos ejecutados.
		Teclee su opción [0-9]:  
		 Autosave corriendo

	==================================================
	[*][2015][SAUCEM APPS][My_Book_Manager] ==========
	==================================================
	[0] 	Salir
	[1] 	Insertar libro
	[2] 	Mostrar todos los libros
	[3] 	Mostrar un libro por ID
	[4] 	Modificar un libro por ID
	[5] 	Borrar un libro por ID
	[6] 	Exportar catálago
	[7] 	Importar catálago
	[8] 	Mostrar registros corruptos
	[9] 	Activar autosalvado (cada 10 segundos)

		#INFO:    4 comandos ejecutados.
		Teclee su opción [0-9]:  
		[THREAD_AUTOSAVE] 1
		Escritos 2 libros en "AUTOSAVE_demo.sbm"
		Seguro de que desea salir (s/N): 
		[TREAD_AUTOSAVE] Exiting
++
{ cat /tmp/libros$USER/101.txt /tmp/libros$USER/102.txt - <<++
2
9
++
sleep 14
cat <<++
0
s
++
} | test 15 "[1][9][0][s]" $1 helgrind && [ -f AUTOSAVE_demo.sbm ]
}

test16 () {
# prueba de carga
rm -f /tmp/salida16OK.* /tmp/salida16PROG.*
cat <<++ > /tmp/salida16OK.$USER
++
{

for i in /tmp/libros$USER/*.txt; do
        cat $i
done
cat <<++ 
2
6
0
s
++
} | test 16 "load" $1 > /dev/null

if [ ! -f data_demo.sbm ] ; then
        echo "data_demo.sbm not created" >&2
        return 999
elif  [ `grep title /tmp/salida16PROG.$USER | grep '|' | sort -u | wc -l` != $(($maxlibros - 102)) ] ; then
        echo "Error in titles" >&2
        return 999
else
        return 0
fi
}

test17 () {
# prueba ordenación
rm -f /tmp/salida17OK.* /tmp/salida17PROG.*
cat <<++ > /tmp/salida17OK.$USER
		== "Libro id" |" Título(20 caract.)"| "Autor id" ===================================================
		==|      101 |           El Quijote |      10001 | 100.00 |
		==|      953 |             title953 |      10853 |  99.82 |
		==|      865 |             title865 |      10765 |  99.82 |
		==|      186 |             title186 |      10086 |  99.45 |
		==|      868 |             title868 |      10768 |  99.34 |
		==|      619 |             title619 |      10519 |  99.31 |
		==|      794 |             title794 |      10694 |  99.04 |
		==|      592 |             title592 |      10492 |  99.04 |
		==|      317 |             title317 |      10217 |  99.04 |
		==|      707 |             title707 |      10607 |  98.98 |
		==|      947 |             title947 |      10847 |  98.68 |
		==|      164 |             title164 |      10064 |  98.68 |
		==|      476 |             title476 |      10376 |  98.65 |
		==|      738 |             title738 |      10638 |  98.46 |
		==|      474 |             title474 |      10374 |  98.46 |
		==|      378 |             title378 |      10278 |  98.28 |
		==|      855 |             title855 |      10755 |  98.10 |
		==|      990 |             title990 |      10890 |  98.01 |
		==|      136 |             title136 |      10036 |  97.84 |
		==|      537 |             title537 |      10437 |  97.83 |
		==|      372 |             title372 |      10272 |  97.83 |
		==|      904 |             title904 |      10804 |  97.72 |
		==|      409 |             title409 |      10309 |  97.72 |
		==|      827 |             title827 |      10727 |  97.39 |
		==|      114 |             title114 |      10014 |  97.29 |
		==|      693 |             title693 |      10593 |  97.02 |
		==|      283 |             title283 |      10183 |  97.00 |
		==|      823 |             title823 |      10723 |  96.73 |
		==|      845 |             title845 |      10745 |  96.40 |
		==|      896 |             title896 |      10796 |  96.28 |
		==|      391 |             title391 |      10291 |  96.28 |
		==|      634 |             title634 |      10534 |  96.19 |
		==|      267 |             title267 |      10167 |  96.12 |
		==|      980 |             title980 |      10880 |  96.04 |
		==|      513 |             title513 |      10413 |  95.31 |
		==|      861 |             title861 |      10761 |  95.13 |
		==|      558 |             title558 |      10458 |  95.13 |
		==|      581 |             title581 |      10481 |  94.75 |
		==|      328 |             title328 |      10228 |  94.75 |
		==|      835 |             title835 |      10735 |  94.72 |
		==|      712 |             title712 |      10612 |  94.69 |
		==|      952 |             title952 |      10852 |  94.63 |
		==|      233 |             title233 |      10133 |  94.42 |
		==|      322 |             title322 |      10222 |  94.36 |
		==|      729 |             title729 |      10629 |  94.14 |
		==|      426 |             title426 |      10326 |  94.14 |
		==|      970 |             title970 |      10870 |  94.09 |
		==|      424 |             title424 |      10324 |  93.97 |
		==|      616 |             title616 |      10516 |  93.94 |
		==|      359 |             title359 |      10259 |  93.88 |
		==|      948 |             title948 |      10848 |  93.87 |
		==|      217 |             title217 |      10117 |  93.70 |
		==|      569 |             title569 |      10469 |  93.37 |
		==|      542 |             title542 |      10442 |  93.37 |
		==|      986 |             title986 |      10886 |  93.22 |
		==|      832 |             title832 |      10732 |  93.22 |
		==|      756 |             title756 |      10656 |  93.15 |
		==|      825 |             title825 |      10725 |  93.06 |
		==|      721 |             title721 |      10621 |  92.98 |
		==|      487 |             title487 |      10387 |  92.71 |
		==|      341 |             title341 |      10241 |  92.62 |
		==|      183 |             title183 |      10083 |  92.34 |
		==|      960 |             title960 |      10860 |  92.16 |
		==|      657 |             title657 |      10557 |  92.16 |
		==|      167 |             title167 |      10067 |  91.78 |
		==|      278 |             title278 |      10178 |  91.72 |
		==|      951 |             title951 |      10851 |  91.44 |
		==|      815 |             title815 |      10715 |  91.42 |
		==|      839 |             title839 |      10739 |  91.39 |
		==|      272 |             title272 |      10172 |  91.39 |
		==|      744 |             title744 |      10644 |  91.35 |
		==|      688 |             title688 |      10588 |  91.33 |
		==|      949 |             title949 |      10849 |  91.06 |
		==|      818 |             title818 |      10718 |  90.91 |
		==|      133 |             title133 |      10033 |  90.76 |
		==|      903 |             title903 |      10803 |  90.54 |
		==|      309 |             title309 |      10209 |  90.54 |
		==|      463 |             title463 |      10363 |  90.43 |
		==|      117 |             title117 |      10017 |  90.36 |
		==|      643 |             title643 |      10543 |  90.34 |
		==|      950 |             title950 |      10850 |  90.25 |
		==|      376 |             title376 |      10276 |  90.13 |
		==|      584 |             title584 |      10484 |  90.10 |
		==|      374 |             title374 |      10274 |  89.98 |
		==|      805 |             title805 |      10705 |  89.80 |
		==|      508 |             title508 |      10408 |  89.80 |
		==|      897 |             title897 |      10797 |  89.46 |
		==|      291 |             title291 |      10191 |  89.46 |
		==|      777 |             title777 |      10677 |  89.37 |
		==|      531 |             title531 |      10431 |  89.19 |
		==|      228 |             title228 |      10128 |  89.19 |
		==|      964 |             title964 |      10864 |  88.93 |
		==|      854 |             title854 |      10754 |  88.93 |
		==|      222 |             title222 |      10122 |  88.92 |
		==|      773 |             title773 |      10673 |  88.75 |
		==|      940 |             title940 |      10840 |  88.36 |
		==|      795 |             title795 |      10695 |  88.20 |
		==|      492 |             title492 |      10392 |  88.20 |
		==|      437 |             title437 |      10337 |  88.09 |
		==|      566 |             title566 |      10466 |  88.03 |
		==|      519 |             title519 |      10419 |  87.93 |
		==|      662 |             title662 |      10562 |  87.82 |
		==|      259 |             title259 |      10159 |  87.70 |
		==|      846 |             title846 |      10746 |  87.57 |
		==|      178 |             title178 |      10078 |  87.16 |
		==|      679 |             title679 |      10579 |  87.10 |
		==|      172 |             title172 |      10072 |  86.95 |
		==|      241 |             title241 |      10141 |  86.80 |
		==|      811 |             title811 |      10711 |  86.77 |
		==|      785 |             title785 |      10685 |  86.62 |
		==|      326 |             title326 |      10226 |  86.62 |
		==|      930 |             title930 |      10830 |  86.49 |
		==|      324 |             title324 |      10224 |  86.49 |
		==|      413 |             title413 |      10313 |  86.05 |
		==|      671 |             title671 |      10571 |  86.02 |
		==|      706 |             title706 |      10606 |  85.84 |
		==|      607 |             title607 |      10507 |  85.84 |
		==|      983 |             title983 |      10883 |  85.63 |
		==|      128 |             title128 |      10028 |  85.63 |
		==|      122 |             title122 |      10022 |  85.48 |
		==|      902 |             title902 |      10802 |  85.36 |
		==|      209 |             title209 |      10109 |  85.36 |
		==|      782 |             title782 |      10682 |  85.15 |
		==|      775 |             title775 |      10675 |  85.06 |
		==|      458 |             title458 |      10358 |  84.97 |
		==|      638 |             title638 |      10538 |  84.70 |
		==|      920 |             title920 |      10820 |  84.64 |
		==|      898 |             title898 |      10798 |  84.64 |
		==|      191 |             title191 |      10091 |  84.64 |
		==|      534 |             title534 |      10434 |  84.51 |
		==|      694 |             title694 |      10594 |  84.16 |
		==|      593 |             title593 |      10493 |  84.16 |
		==|      481 |             title481 |      10381 |  84.13 |
		==|      387 |             title387 |      10287 |  83.97 |
		==|      936 |             title936 |      10836 |  83.61 |
		==|      276 |             title276 |      10176 |  83.61 |
		==|      442 |             title442 |      10342 |  83.53 |
		==|      765 |             title765 |      10665 |  83.52 |
		==|      159 |             title159 |      10059 |  83.52 |
		==|      274 |             title274 |      10174 |  83.50 |
		==|      789 |             title789 |      10689 |  83.25 |
		==|      469 |             title469 |      10369 |  82.99 |
		==|      768 |             title768 |      10668 |  82.98 |
		==|      141 |             title141 |      10041 |  82.98 |
		==|      910 |             title910 |      10810 |  82.81 |
		==|      516 |             title516 |      10416 |  82.62 |
		==|      967 |             title967 |      10867 |  82.51 |
		==|      901 |             title901 |      10801 |  82.18 |
		==|      109 |             title109 |      10009 |  82.18 |
		==|      363 |             title363 |      10263 |  82.17 |
		==|      755 |             title755 |      10655 |  82.00 |
		==|      727 |             title727 |      10627 |  81.85 |
		==|      899 |             title899 |      10799 |  81.82 |
		==|      853 |             title853 |      10753 |  81.76 |
		==|      612 |             title612 |      10512 |  81.45 |
		==|      723 |             title723 |      10623 |  81.27 |
		==|      226 |             title226 |      10126 |  81.10 |
		==|      224 |             title224 |      10124 |  81.01 |
		==|      900 |             title900 |      10800 |  81.00 |
		==|      847 |             title847 |      10747 |  80.74 |
		==|      804 |             title804 |      10704 |  80.64 |
		==|      408 |             title408 |      10308 |  80.64 |
		==|      629 |             title629 |      10529 |  80.56 |
		==|      745 |             title745 |      10645 |  80.50 |
		==|      337 |             title337 |      10237 |  80.35 |
		==|      557 |             title557 |      10457 |  80.02 |
		==|      978 |             title978 |      10878 |  79.65 |
		==|      431 |             title431 |      10331 |  79.57 |
		==|      621 |             title621 |      10521 |  79.56 |
		==|      914 |             title914 |      10814 |  79.54 |
		==|      484 |             title484 |      10384 |  79.42 |
		==|      796 |             title796 |      10696 |  79.36 |
		==|      392 |             title392 |      10292 |  79.36 |
		==|      991 |             title991 |      10891 |  79.21 |
		==|      890 |             title890 |      10790 |  79.21 |
		==|      176 |             title176 |      10076 |  79.09 |
		==|      656 |             title656 |      10556 |  79.03 |
		==|      735 |             title735 |      10635 |  79.02 |
		==|      174 |             title174 |      10074 |  79.02 |
		==|      761 |             title761 |      10661 |  78.91 |
		==|      313 |             title313 |      10213 |  78.79 |
		==|      588 |             title588 |      10488 |  78.57 |
		==|      419 |             title419 |      10319 |  78.55 |
		==|      972 |             title972 |      10872 |  78.48 |
		==|      543 |             title543 |      10443 |  78.48 |
		==|      466 |             title466 |      10366 |  77.71 |
		==|      732 |             title732 |      10632 |  77.58 |
		==|      126 |             title126 |      10026 |  77.58 |
		==|      725 |             title725 |      10625 |  77.56 |
		==|      124 |             title124 |      10024 |  77.53 |
		==|      644 |             title644 |      10544 |  77.47 |
		==|      880 |             title880 |      10780 |  77.44 |
		==|      287 |             title287 |      10187 |  77.23 |
		==|      358 |             title358 |      10258 |  76.81 |
		==|      852 |             title852 |      10752 |  76.59 |
		==|      715 |             title715 |      10615 |  76.12 |
		==|      933 |             title933 |      10833 |  76.05 |
		==|      848 |             title848 |      10748 |  75.91 |
		==|      263 |             title263 |      10163 |  75.91 |
		==|      870 |             title870 |      10770 |  75.69 |
		==|      342 |             title342 |      10242 |  75.69 |
		==|      739 |             title739 |      10639 |  75.61 |
		==|      562 |             title562 |      10462 |  75.58 |
		==|      718 |             title718 |      10618 |  75.55 |
		==|      381 |             title381 |      10281 |  75.51 |
		==|      677 |             title677 |      10577 |  74.83 |
		==|      434 |             title434 |      10334 |  74.83 |
		==|      705 |             title705 |      10605 |  74.70 |
		==|      507 |             title507 |      10407 |  74.70 |
		==|      369 |             title369 |      10269 |  74.61 |
		==|      237 |             title237 |      10137 |  74.61 |
		==|      579 |             title579 |      10479 |  74.52 |
		==|      886 |             title886 |      10786 |  74.50 |
		==|      673 |             title673 |      10573 |  74.29 |
		==|      860 |             title860 |      10760 |  73.96 |
		==|      571 |             title571 |      10471 |  73.60 |
		==|      213 |             title213 |      10113 |  73.53 |
		==|      803 |             title803 |      10703 |  73.48 |
		==|      308 |             title308 |      10208 |  73.48 |
		==|      851 |             title851 |      10751 |  73.42 |
		==|      695 |             title695 |      10595 |  73.30 |
		==|      493 |             title493 |      10393 |  73.30 |
		==|      416 |             title416 |      10316 |  73.30 |
		==|      917 |             title917 |      10817 |  73.09 |
		==|      849 |             title849 |      10749 |  73.08 |
		==|      959 |             title959 |      10859 |  72.97 |
		==|      538 |             title538 |      10438 |  72.94 |
		==|      754 |             title754 |      10654 |  72.85 |
		==|      606 |             title606 |      10506 |  72.72 |
		==|      797 |             title797 |      10697 |  72.52 |
		==|      292 |             title292 |      10192 |  72.52 |
		==|      187 |             title187 |      10087 |  72.49 |
		==|      850 |             title850 |      10750 |  72.25 |
		==|      331 |             title331 |      10231 |  71.95 |
		==|      685 |             title685 |      10585 |  71.92 |
		==|      746 |             title746 |      10646 |  71.65 |
		==|      163 |             title163 |      10063 |  71.65 |
		==|      711 |             title711 |      10611 |  71.55 |
		==|      594 |             title594 |      10494 |  71.28 |
		==|      976 |             title976 |      10876 |  71.26 |
		==|      319 |             title319 |      10219 |  71.17 |
		==|      974 |             title974 |      10874 |  70.87 |
		==|      137 |             title137 |      10037 |  70.87 |
		==|      384 |             title384 |      10284 |  70.74 |
		==|      864 |             title864 |      10764 |  70.65 |
		==|      258 |             title258 |      10158 |  70.65 |
		==|      840 |             title840 |      10740 |  70.56 |
		==|      675 |             title675 |      10575 |  70.56 |
		==|      682 |             title682 |      10582 |  70.51 |
		==|      113 |             title113 |      10013 |  70.27 |
		==|      512 |             title512 |      10412 |  70.21 |
		==|      928 |             title928 |      10828 |  70.12 |
		==|      457 |             title457 |      10357 |  69.88 |
		==|      242 |             title242 |      10142 |  69.85 |
		==|      941 |             title941 |      10841 |  69.55 |
		==|      366 |             title366 |      10266 |  69.39 |
		==|      665 |             title665 |      10565 |  69.22 |
		==|      922 |             title922 |      10822 |  69.01 |
		==|      529 |             title529 |      10429 |  68.98 |
		==|      830 |             title830 |      10730 |  68.89 |
		==|      281 |             title281 |      10181 |  68.89 |
		==|      668 |             title668 |      10568 |  68.62 |
		==|      443 |             title443 |      10343 |  68.62 |
		==|      689 |             title689 |      10589 |  68.47 |
		==|      802 |             title802 |      10702 |  68.32 |
		==|      208 |             title208 |      10108 |  68.32 |
		==|      627 |             title627 |      10527 |  68.31 |
		==|      269 |             title269 |      10169 |  68.23 |
		==|      521 |             title521 |      10421 |  68.14 |
		==|      655 |             title655 |      10555 |  67.90 |
		==|      623 |             title623 |      10523 |  67.81 |
		==|      488 |             title488 |      10388 |  67.81 |
		==|      798 |             title798 |      10698 |  67.68 |
		==|      192 |             title192 |      10092 |  67.68 |
		==|      820 |             title820 |      10720 |  67.24 |
		==|      334 |             title334 |      10234 |  67.15 |
		==|      883 |             title883 |      10783 |  66.97 |
		==|      556 |             title556 |      10456 |  66.91 |
		==|      645 |             title645 |      10545 |  66.60 |
		==|      158 |             title158 |      10058 |  66.49 |
		==|      987 |             title987 |      10887 |  66.42 |
		==|      231 |             title231 |      10131 |  66.33 |
		==|      142 |             title142 |      10042 |  66.01 |
		==|      316 |             title316 |      10216 |  65.98 |
		==|      836 |             title836 |      10736 |  65.89 |
		==|      219 |             title219 |      10119 |  65.79 |
		==|      753 |             title753 |      10653 |  65.70 |
		==|      810 |             title810 |      10710 |  65.61 |
		==|      544 |             title544 |      10444 |  65.59 |
		==|      704 |             title704 |      10604 |  65.56 |
		==|      407 |             title407 |      10307 |  65.56 |
		==|      462 |             title462 |      10362 |  65.34 |
		==|      635 |             title635 |      10535 |  65.32 |
		==|      801 |             title801 |      10701 |  65.16 |
		==|      108 |             title108 |      10008 |  65.16 |
		==|      799 |             title799 |      10699 |  64.84 |
		==|      747 |             title747 |      10647 |  64.80 |
		==|      661 |             title661 |      10561 |  64.69 |
		==|      696 |             title696 |      10596 |  64.44 |
		==|      393 |             title393 |      10293 |  64.44 |
		==|      181 |             title181 |      10081 |  64.27 |
		==|      867 |             title867 |      10767 |  64.17 |
		==|      625 |             title625 |      10525 |  64.06 |
		==|      284 |             title284 |      10184 |  64.06 |
		==|      800 |             title800 |      10700 |  64.00 |
		==|      632 |             title632 |      10532 |  63.94 |
		==|      479 |             title479 |      10379 |  63.94 |
		==|      169 |             title169 |      10069 |  63.85 |
		==|      909 |             title909 |      10809 |  63.63 |
		==|      471 |             title471 |      10371 |  63.18 |
		==|      438 |             title438 |      10338 |  63.18 |
		==|      266 |             title266 |      10166 |  63.07 |
		==|      615 |             title615 |      10515 |  62.82 |
		==|      131 |             title131 |      10031 |  62.71 |
		==|      992 |             title992 |      10892 |  62.41 |
		==|      790 |             title790 |      10690 |  62.41 |
		==|      119 |             title119 |      10019 |  62.41 |
		==|      577 |             title577 |      10477 |  62.29 |
		==|      814 |             title814 |      10714 |  62.26 |
		==|      618 |             title618 |      10518 |  62.19 |
		==|      639 |             title639 |      10539 |  61.83 |
		==|      573 |             title573 |      10473 |  61.83 |
		==|      926 |             title926 |      10826 |  61.75 |
		==|      963 |             title963 |      10863 |  61.74 |
		==|      357 |             title357 |      10257 |  61.74 |
		==|      605 |             title605 |      10505 |  61.60 |
		==|      506 |             title506 |      10406 |  61.60 |
		==|      234 |             title234 |      10134 |  61.47 |
		==|      924 |             title924 |      10824 |  61.38 |
		==|      878 |             title878 |      10778 |  61.09 |
		==|      412 |             title412 |      10312 |  60.97 |
		==|      780 |             title780 |      10680 |  60.84 |
		==|      343 |             title343 |      10243 |  60.76 |
		==|      216 |             title216 |      10116 |  60.66 |
		==|      752 |             title752 |      10652 |  60.55 |
		==|      595 |             title595 |      10495 |  60.40 |
		==|      494 |             title494 |      10394 |  60.40 |
		==|      891 |             title891 |      10791 |  60.39 |
		==|      872 |             title872 |      10772 |  60.04 |
		==|      748 |             title748 |      10648 |  59.95 |
		==|      429 |             title429 |      10329 |  59.40 |
		==|      184 |             title184 |      10084 |  59.38 |
		==|      770 |             title770 |      10670 |  59.29 |
		==|      585 |             title585 |      10485 |  59.22 |
		==|      388 |             title388 |      10288 |  59.05 |
		==|      654 |             title654 |      10554 |  58.77 |
		==|      166 |             title166 |      10066 |  58.75 |
		==|      421 |             title421 |      10321 |  58.72 |
		==|      703 |             title703 |      10603 |  58.42 |
		==|      307 |             title307 |      10207 |  58.42 |
		==|      833 |             title833 |      10733 |  58.39 |
		==|      611 |             title611 |      10511 |  58.33 |
		==|      575 |             title575 |      10475 |  58.06 |
		==|      582 |             title582 |      10482 |  57.87 |
		==|      134 |             title134 |      10034 |  57.79 |
		==|      786 |             title786 |      10686 |  57.78 |
		==|      760 |             title760 |      10660 |  57.76 |
		==|      646 |             title646 |      10546 |  57.73 |
		==|      697 |             title697 |      10597 |  57.58 |
		==|      293 |             title293 |      10193 |  57.58 |
		==|      751 |             title751 |      10651 |  57.40 |
		==|      116 |             title116 |      10016 |  57.34 |
		==|      981 |             title981 |      10881 |  57.24 |
		==|      749 |             title749 |      10649 |  57.10 |
		==|      362 |             title362 |      10262 |  57.10 |
		==|      565 |             title565 |      10465 |  56.92 |
		==|      937 |             title937 |      10837 |  56.80 |
		==|      456 |             title456 |      10356 |  56.79 |
		==|      527 |             title527 |      10427 |  56.77 |
		==|      523 |             title523 |      10423 |  56.35 |
		==|      568 |             title568 |      10468 |  56.26 |
		==|      750 |             title750 |      10650 |  56.25 |
		==|      555 |             title555 |      10455 |  55.80 |
		==|      958 |             title958 |      10858 |  55.78 |
		==|      817 |             title817 |      10717 |  55.75 |
		==|      444 |             title444 |      10344 |  55.71 |
		==|      589 |             title589 |      10489 |  55.69 |
		==|      257 |             title257 |      10157 |  55.60 |
		==|      338 |             title338 |      10238 |  55.42 |
		==|      379 |             title379 |      10279 |  55.36 |
		==|      969 |             title969 |      10869 |  54.90 |
		==|      243 |             title243 |      10143 |  54.90 |
		==|      859 |             title859 |      10759 |  54.79 |
		==|      740 |             title740 |      10640 |  54.76 |
		==|      371 |             title371 |      10271 |  54.76 |
		==|      545 |             title545 |      10445 |  54.70 |
		==|      764 |             title764 |      10664 |  54.37 |
		==|      312 |             title312 |      10212 |  53.73 |
		==|      535 |             title535 |      10435 |  53.62 |
		==|      730 |             title730 |      10630 |  53.29 |
		==|      702 |             title702 |      10602 |  53.28 |
		==|      207 |             title207 |      10107 |  53.28 |
		==|      984 |             title984 |      10884 |  52.83 |
		==|      942 |             title942 |      10842 |  52.74 |
		==|      876 |             title876 |      10776 |  52.74 |
		==|      698 |             title698 |      10598 |  52.72 |
		==|      193 |             title193 |      10093 |  52.72 |
		==|      828 |             title828 |      10728 |  52.56 |
		==|      525 |             title525 |      10425 |  52.56 |
		==|      604 |             title604 |      10504 |  52.48 |
		==|      406 |             title406 |      10306 |  52.48 |
		==|      561 |             title561 |      10461 |  52.47 |
		==|      874 |             title874 |      10774 |  52.39 |
		==|      913 |             title913 |      10813 |  52.36 |
		==|      532 |             title532 |      10432 |  52.30 |
		==|      288 |             title288 |      10188 |  52.29 |
		==|      720 |             title720 |      10620 |  51.84 |
		==|      329 |             title329 |      10229 |  51.82 |
		==|      477 |             title477 |      10377 |  51.75 |
		==|      841 |             title841 |      10741 |  51.73 |
		==|      653 |             title653 |      10553 |  51.64 |
		==|      822 |             title822 |      10722 |  51.57 |
		==|      596 |             title596 |      10496 |  51.52 |
		==|      515 |             title515 |      10415 |  51.52 |
		==|      394 |             title394 |      10294 |  51.52 |
		==|      157 |             title157 |      10057 |  51.46 |
		==|      473 |             title473 |      10373 |  51.37 |
		==|      321 |             title321 |      10221 |  51.30 |
		==|      143 |             title143 |      10043 |  51.04 |
		==|      647 |             title647 |      10547 |  50.86 |
		==|      262 |             title262 |      10162 |  50.86 |
		==|      518 |             title518 |      10418 |  50.83 |
		==|      505 |             title505 |      10405 |  50.50 |
		==|      710 |             title710 |      10610 |  50.41 |
		==|      783 |             title783 |      10683 |  50.31 |
		==|      736 |             title736 |      10636 |  50.17 |
		==|      701 |             title701 |      10601 |  50.14 |
		==|      107 |             title107 |      10007 |  50.14 |
		==|      539 |             title539 |      10439 |  50.05 |
		==|      699 |             title699 |      10599 |  49.86 |
		==|      238 |             title238 |      10138 |  49.66 |
		==|      495 |             title495 |      10395 |  49.50 |
		==|      966 |             title966 |      10866 |  49.32 |
		==|      700 |             title700 |      10600 |  49.00 |
		==|      279 |             title279 |      10179 |  48.78 |
		==|      356 |             title356 |      10256 |  48.67 |
		==|      485 |             title485 |      10385 |  48.52 |
		==|      212 |             title212 |      10112 |  48.49 |
		==|      271 |             title271 |      10171 |  48.34 |
		==|      767 |             title767 |      10667 |  47.83 |
		==|      344 |             title344 |      10244 |  47.83 |
		==|      931 |             title931 |      10831 |  47.68 |
		==|      887 |             title887 |      10787 |  47.68 |
		==|      993 |             title993 |      10893 |  47.61 |
		==|      690 |             title690 |      10590 |  47.61 |
		==|      475 |             title475 |      10375 |  47.56 |
		==|      188 |             title188 |      10088 |  47.53 |
		==|      482 |             title482 |      10382 |  47.23 |
		==|      427 |             title427 |      10327 |  47.23 |
		==|      511 |             title511 |      10411 |  47.11 |
		==|      714 |             title714 |      10614 |  46.98 |
		==|      423 |             title423 |      10323 |  46.89 |
		==|      554 |             title554 |      10454 |  46.69 |
		==|      465 |             title465 |      10365 |  46.62 |
		==|      162 |             title162 |      10062 |  46.62 |
		==|      652 |             title652 |      10552 |  46.51 |
		==|      908 |             title908 |      10808 |  46.45 |
		==|      809 |             title809 |      10709 |  46.45 |
		==|      680 |             title680 |      10580 |  46.24 |
		==|      229 |             title229 |      10129 |  46.24 |
		==|      648 |             title648 |      10548 |  45.99 |
		==|      468 |             title468 |      10368 |  45.90 |
		==|      138 |             title138 |      10038 |  45.90 |
		==|      221 |             title221 |      10121 |  45.88 |
		==|      546 |             title546 |      10446 |  45.81 |
		==|      455 |             title455 |      10355 |  45.70 |
		==|      919 |             title919 |      10819 |  45.46 |
		==|      603 |             title603 |      10503 |  45.36 |
		==|      306 |             title306 |      10206 |  45.36 |
		==|      112 |             title112 |      10012 |  45.25 |
		==|      489 |             title489 |      10389 |  44.91 |
		==|      670 |             title670 |      10570 |  44.89 |
		==|      445 |             title445 |      10345 |  44.80 |
		==|      597 |             title597 |      10497 |  44.64 |
		==|      294 |             title294 |      10194 |  44.64 |
		==|      778 |             title778 |      10678 |  44.53 |
		==|      826 |             title826 |      10726 |  44.23 |
		==|      179 |             title179 |      10079 |  44.20 |
		==|      435 |             title435 |      10335 |  43.92 |
		==|      171 |             title171 |      10071 |  43.92 |
		==|      824 |             title824 |      10724 |  43.90 |
		==|      772 |             title772 |      10672 |  43.60 |
		==|      892 |             title892 |      10792 |  43.57 |
		==|      791 |             title791 |      10691 |  43.57 |
		==|      660 |             title660 |      10560 |  43.56 |
		==|      863 |             title863 |      10763 |  43.48 |
		==|      651 |             title651 |      10551 |  43.38 |
		==|      934 |             title934 |      10834 |  43.24 |
		==|      377 |             title377 |      10277 |  43.21 |
		==|      649 |             title649 |      10549 |  43.12 |
		==|      686 |             title686 |      10586 |  43.06 |
		==|      425 |             title425 |      10325 |  43.06 |
		==|      373 |             title373 |      10273 |  42.91 |
		==|      733 |             title733 |      10633 |  42.73 |
		==|      432 |             title432 |      10332 |  42.66 |
		==|      129 |             title129 |      10029 |  42.66 |
		==|      256 |             title256 |      10156 |  42.55 |
		==|      121 |             title121 |      10021 |  42.46 |
		==|      650 |             title650 |      10550 |  42.25 |
		==|      461 |             title461 |      10361 |  42.25 |
		==|      415 |             title415 |      10315 |  42.22 |
		==|      244 |             title244 |      10144 |  41.95 |
		==|      988 |             title988 |      10888 |  41.62 |
		==|      418 |             title418 |      10318 |  41.47 |
		==|      504 |             title504 |      10404 |  41.40 |
		==|      405 |             title405 |      10305 |  41.40 |
		==|      640 |             title640 |      10540 |  40.96 |
		==|      496 |             title496 |      10396 |  40.60 |
		==|      395 |             title395 |      10295 |  40.60 |
		==|      957 |             title957 |      10857 |  40.59 |
		==|      717 |             title717 |      10617 |  40.41 |
		==|      439 |             title439 |      10339 |  40.27 |
		==|      602 |             title602 |      10502 |  40.24 |
		==|      206 |             title206 |      10106 |  40.24 |
		==|      664 |             title664 |      10564 |  40.09 |
		==|      916 |             title916 |      10816 |  39.91 |
		==|      385 |             title385 |      10285 |  39.82 |
		==|      598 |             title598 |      10498 |  39.76 |
		==|      194 |             title194 |      10094 |  39.76 |
		==|      630 |             title630 |      10530 |  39.69 |
		==|      327 |             title327 |      10227 |  39.69 |
		==|      553 |             title553 |      10453 |  39.58 |
		==|      323 |             title323 |      10223 |  39.43 |
		==|      837 |             title837 |      10737 |  39.06 |
		==|      375 |             title375 |      10275 |  39.06 |
		==|      547 |             title547 |      10447 |  38.92 |
		==|      881 |             title881 |      10781 |  38.62 |
		==|      759 |             title759 |      10659 |  38.61 |
		==|      382 |             title382 |      10282 |  38.59 |
		==|      620 |             title620 |      10520 |  38.44 |
		==|      156 |             title156 |      10056 |  38.43 |
		==|      365 |             title365 |      10265 |  38.32 |
		==|      144 |             title144 |      10044 |  38.07 |
		==|      943 |             title943 |      10843 |  37.93 |
		==|      411 |             title411 |      10311 |  37.89 |
		==|      858 |             title858 |      10758 |  37.62 |
		==|      355 |             title355 |      10255 |  37.60 |
		==|      368 |             title368 |      10268 |  37.54 |
		==|      610 |             title610 |      10510 |  37.21 |
		==|      601 |             title601 |      10501 |  37.12 |
		==|      106 |             title106 |      10006 |  37.12 |
		==|      728 |             title728 |      10628 |  37.00 |
		==|      345 |             title345 |      10245 |  36.90 |
		==|      599 |             title599 |      10499 |  36.88 |
		==|      979 |             title979 |      10879 |  36.85 |
		==|      277 |             title277 |      10177 |  36.67 |
		==|      454 |             title454 |      10354 |  36.61 |
		==|      962 |             title962 |      10862 |  36.55 |
		==|      869 |             title869 |      10769 |  36.52 |
		==|      636 |             title636 |      10536 |  36.45 |
		==|      273 |             title273 |      10173 |  36.45 |
		==|      776 |             title776 |      10676 |  36.22 |
		==|      335 |             title335 |      10235 |  36.22 |
		==|      722 |             title722 |      10622 |  36.13 |
		==|      389 |             title389 |      10289 |  36.13 |
		==|      600 |             title600 |      10500 |  36.00 |
		==|      774 |             title774 |      10674 |  35.91 |
		==|      741 |             title741 |      10641 |  35.91 |
		==|      446 |             title446 |      10346 |  35.89 |
		==|      683 |             title683 |      10583 |  35.65 |
		==|      325 |             title325 |      10225 |  35.56 |
		==|      971 |             title971 |      10871 |  35.29 |
		==|      813 |             title813 |      10713 |  35.10 |
		==|      332 |             title332 |      10232 |  35.02 |
		==|      315 |             title315 |      10215 |  34.92 |
		==|      842 |             title842 |      10742 |  34.90 |
		==|      994 |             title994 |      10894 |  34.81 |
		==|      590 |             title590 |      10490 |  34.81 |
		==|      552 |             title552 |      10452 |  34.47 |
		==|      503 |             title503 |      10403 |  34.30 |
		==|      305 |             title305 |      10205 |  34.30 |
		==|      884 |             title884 |      10784 |  34.15 |
		==|      227 |             title227 |      10127 |  34.15 |
		==|      318 |             title318 |      10218 |  34.11 |
		==|      548 |             title548 |      10448 |  34.03 |
		==|      361 |             title361 |      10261 |  34.03 |
		==|      223 |             title223 |      10123 |  33.97 |
		==|      614 |             title614 |      10514 |  33.70 |
		==|      497 |             title497 |      10397 |  33.70 |
		==|      295 |             title295 |      10195 |  33.70 |
		==|      580 |             title580 |      10480 |  33.64 |
		==|      667 |             title667 |      10567 |  33.49 |
		==|      285 |             title285 |      10185 |  33.12 |
		==|      275 |             title275 |      10175 |  32.56 |
		==|      570 |             title570 |      10470 |  32.49 |
		==|      339 |             title339 |      10239 |  32.49 |
		==|      404 |             title404 |      10304 |  32.32 |
		==|      177 |             title177 |      10077 |  32.13 |
		==|      265 |             title265 |      10165 |  32.02 |
		==|      938 |             title938 |      10838 |  31.99 |
		==|      173 |             title173 |      10073 |  31.99 |
		==|      282 |             title282 |      10182 |  31.95 |
		==|      396 |             title396 |      10296 |  31.68 |
		==|      255 |             title255 |      10155 |  31.50 |
		==|      560 |             title560 |      10460 |  31.36 |
		==|      551 |             title551 |      10451 |  31.36 |
		==|      907 |             title907 |      10807 |  31.27 |
		==|      709 |             title709 |      10609 |  31.27 |
		==|      268 |             title268 |      10168 |  31.18 |
		==|      549 |             title549 |      10449 |  31.14 |
		==|      866 |             title866 |      10766 |  31.00 |
		==|      245 |             title245 |      10145 |  31.00 |
		==|      787 |             title787 |      10687 |  30.94 |
		==|      311 |             title311 |      10211 |  30.67 |
		==|      127 |             title127 |      10027 |  30.61 |
		==|      235 |             title235 |      10135 |  30.52 |
		==|      123 |             title123 |      10023 |  30.51 |
		==|      586 |             title586 |      10486 |  30.34 |
		==|      550 |             title550 |      10450 |  30.25 |
		==|      831 |             title831 |      10731 |  30.06 |
		==|      225 |             title225 |      10125 |  30.06 |
		==|      678 |             title678 |      10578 |  29.97 |
		==|      215 |             title215 |      10115 |  29.62 |
		==|      453 |             title453 |      10353 |  29.52 |
		==|      232 |             title232 |      10132 |  29.38 |
		==|      289 |             title289 |      10189 |  29.35 |
		==|      808 |             title808 |      10708 |  29.29 |
		==|      502 |             title502 |      10402 |  29.20 |
		==|      205 |             title205 |      10105 |  29.20 |
		==|      672 |             title672 |      10572 |  29.16 |
		==|      540 |             title540 |      10440 |  29.16 |
		==|      633 |             title633 |      10533 |  29.07 |
		==|      447 |             title447 |      10347 |  28.98 |
		==|      498 |             title498 |      10398 |  28.80 |
		==|      195 |             title195 |      10095 |  28.80 |
		==|      893 |             title893 |      10793 |  28.75 |
		==|      691 |             title691 |      10591 |  28.75 |
		==|      218 |             title218 |      10118 |  28.75 |
		==|      726 |             title726 |      10626 |  28.71 |
		==|      354 |             title354 |      10254 |  28.53 |
		==|      724 |             title724 |      10624 |  28.42 |
		==|      185 |             title185 |      10085 |  28.42 |
		==|      530 |             title530 |      10430 |  28.09 |
		==|      819 |             title819 |      10719 |  28.08 |
		==|      175 |             title175 |      10075 |  28.06 |
		==|      346 |             title346 |      10246 |  27.97 |
		==|      564 |             title564 |      10464 |  27.81 |
		==|      261 |             title261 |      10161 |  27.81 |
		==|      165 |             title165 |      10065 |  27.72 |
		==|      956 |             title956 |      10856 |  27.40 |
		==|      155 |             title155 |      10055 |  27.40 |
		==|      929 |             title929 |      10829 |  27.31 |
		==|      182 |             title182 |      10082 |  27.31 |
		==|      763 |             title763 |      10663 |  27.22 |
		==|      912 |             title912 |      10812 |  27.18 |
		==|      145 |             title145 |      10045 |  27.10 |
		==|      617 |             title617 |      10517 |  27.07 |
		==|      520 |             title520 |      10420 |  27.04 |
		==|      168 |             title168 |      10068 |  26.82 |
		==|      135 |             title135 |      10035 |  26.82 |
		==|      792 |             title792 |      10692 |  26.73 |
		==|      239 |             title239 |      10139 |  26.71 |
		==|      125 |             title125 |      10025 |  26.56 |
		==|      115 |             title115 |      10015 |  26.32 |
		==|      501 |             title501 |      10401 |  26.10 |
		==|      105 |             title105 |      10005 |  26.10 |
		==|      510 |             title510 |      10410 |  26.01 |
		==|      499 |             title499 |      10399 |  25.90 |
		==|      921 |             title921 |      10821 |  25.83 |
		==|      132 |             title132 |      10032 |  25.74 |
		==|      834 |             title834 |      10734 |  25.56 |
		==|      211 |             title211 |      10111 |  25.45 |
		==|      118 |             title118 |      10018 |  25.39 |
		==|      403 |             title403 |      10303 |  25.24 |
		==|      304 |             title304 |      10204 |  25.24 |
		==|      944 |             title944 |      10844 |  25.12 |
		==|      500 |             title500 |      10400 |  25.00 |
		==|      397 |             title397 |      10297 |  24.76 |
		==|      296 |             title296 |      10196 |  24.76 |
		==|      536 |             title536 |      10436 |  24.73 |
		==|      189 |             title189 |      10089 |  24.57 |
		==|      977 |             title977 |      10877 |  24.46 |
		==|      659 |             title659 |      10559 |  24.43 |
		==|      452 |             title452 |      10352 |  24.43 |
		==|      448 |             title448 |      10348 |  24.07 |
		==|      995 |             title995 |      10895 |  24.01 |
		==|      490 |             title490 |      10390 |  24.01 |
		==|      973 |             title973 |      10873 |  23.68 |
		==|      161 |             title161 |      10061 |  23.59 |
		==|      628 |             title628 |      10528 |  23.44 |
		==|      737 |             title737 |      10637 |  23.32 |
		==|      480 |             title480 |      10380 |  23.04 |
		==|      583 |             title583 |      10483 |  22.99 |
		==|      139 |             title139 |      10039 |  22.93 |
		==|      888 |             title888 |      10788 |  22.86 |
		==|      622 |             title622 |      10522 |  22.69 |
		==|      816 |             title816 |      10716 |  22.59 |
		==|      857 |             title857 |      10757 |  22.45 |
		==|      254 |             title254 |      10154 |  22.45 |
		==|      514 |             title514 |      10414 |  22.42 |
		==|      111 |             title111 |      10011 |  22.23 |
		==|      641 |             title641 |      10541 |  22.09 |
		==|      470 |             title470 |      10370 |  22.09 |
		==|      246 |             title246 |      10146 |  22.05 |
		==|      985 |             title985 |      10885 |  22.03 |
		==|      781 |             title781 |      10681 |  22.00 |
		==|      676 |             title676 |      10576 |  21.70 |
		==|      758 |             title758 |      10658 |  21.46 |
		==|      353 |             title353 |      10253 |  21.46 |
		==|      674 |             title674 |      10574 |  21.43 |
		==|      451 |             title451 |      10351 |  21.34 |
		==|      460 |             title460 |      10360 |  21.16 |
		==|      449 |             title449 |      10349 |  21.16 |
		==|      567 |             title567 |      10467 |  21.15 |
		==|      347 |             title347 |      10247 |  21.04 |
		==|      982 |             title982 |      10882 |  20.44 |
		==|      450 |             title450 |      10350 |  20.25 |
		==|      402 |             title402 |      10302 |  20.16 |
		==|      204 |             title204 |      10104 |  20.16 |
		==|      769 |             title769 |      10669 |  20.14 |
		==|      975 |             title975 |      10875 |  20.07 |
		==|      843 |             title843 |      10743 |  20.07 |
		==|      713 |             title713 |      10613 |  19.84 |
		==|      398 |             title398 |      10298 |  19.84 |
		==|      196 |             title196 |      10096 |  19.84 |
		==|      486 |             title486 |      10386 |  19.62 |
		==|      440 |             title440 |      10340 |  19.36 |
		==|      742 |             title742 |      10642 |  19.06 |
		==|      989 |             title989 |      10889 |  18.82 |
		==|      430 |             title430 |      10330 |  18.49 |
		==|      154 |             title154 |      10054 |  18.37 |
		==|      862 |             title862 |      10762 |  18.31 |
		==|      879 |             title879 |      10779 |  18.27 |
		==|      303 |             title303 |      10203 |  18.18 |
		==|      965 |             title965 |      10865 |  18.13 |
		==|      146 |             title146 |      10046 |  18.13 |
		==|      906 |             title906 |      10806 |  18.09 |
		==|      609 |             title609 |      10509 |  18.09 |
		==|      297 |             title297 |      10197 |  17.82 |
		==|      968 |             title968 |      10868 |  17.71 |
		==|      420 |             title420 |      10320 |  17.64 |
		==|      464 |             title464 |      10364 |  17.53 |
		==|      784 |             title784 |      10684 |  17.47 |
		==|      578 |             title578 |      10478 |  17.41 |
		==|      533 |             title533 |      10433 |  17.41 |
		==|      401 |             title401 |      10301 |  17.08 |
		==|      104 |             title104 |      10004 |  17.08 |
		==|      399 |             title399 |      10299 |  16.92 |
		==|      871 |             title871 |      10771 |  16.87 |
		==|      410 |             title410 |      10310 |  16.81 |
		==|      572 |             title572 |      10472 |  16.72 |
		==|      352 |             title352 |      10252 |  16.39 |
		==|      955 |             title955 |      10855 |  16.21 |
		==|      687 |             title687 |      10587 |  16.20 |
		==|      348 |             title348 |      10248 |  16.11 |
		==|      400 |             title400 |      10300 |  16.00 |
		==|      894 |             title894 |      10794 |  15.93 |
		==|      591 |             title591 |      10491 |  15.93 |
		==|      517 |             title517 |      10417 |  15.73 |
		==|      253 |             title253 |      10153 |  15.40 |
		==|      996 |             title996 |      10896 |  15.21 |
		==|      390 |             title390 |      10290 |  15.21 |
		==|      626 |             title626 |      10526 |  15.19 |
		==|      247 |             title247 |      10147 |  15.10 |
		==|      436 |             title436 |      10336 |  15.01 |
		==|      927 |             title927 |      10827 |  14.94 |
		==|      624 |             title624 |      10524 |  14.94 |
		==|      766 |             title766 |      10666 |  14.68 |
		==|      731 |             title731 |      10631 |  14.44 |
		==|      380 |             title380 |      10280 |  14.44 |
		==|      945 |             title945 |      10845 |  14.31 |
		==|      838 |             title838 |      10738 |  14.23 |
		==|      923 |             title923 |      10823 |  14.20 |
		==|      807 |             title807 |      10707 |  14.13 |
		==|      708 |             title708 |      10608 |  14.13 |
		==|      370 |             title370 |      10270 |  13.69 |
		==|      961 |             title961 |      10861 |  13.36 |
		==|      351 |             title351 |      10251 |  13.32 |
		==|      349 |             title349 |      10249 |  13.18 |
		==|      414 |             title414 |      10314 |  13.14 |
		==|      302 |             title302 |      10202 |  13.12 |
		==|      203 |             title203 |      10103 |  13.12 |
		==|      663 |             title663 |      10563 |  12.96 |
		==|      360 |             title360 |      10260 |  12.96 |
		==|      298 |             title298 |      10198 |  12.88 |
		==|      197 |             title197 |      10097 |  12.88 |
		==|      719 |             title719 |      10619 |  12.70 |
		==|      935 |             title935 |      10835 |  12.43 |
		==|      483 |             title483 |      10383 |  12.33 |
		==|      559 |             title559 |      10459 |  12.25 |
		==|      350 |             title350 |      10250 |  12.25 |
		==|      793 |             title793 |      10693 |  11.89 |
		==|      692 |             title692 |      10592 |  11.89 |
		==|      528 |             title528 |      10428 |  11.88 |
		==|      340 |             title340 |      10240 |  11.56 |
		==|      153 |             title153 |      10053 |  11.34 |
		==|      522 |             title522 |      10422 |  11.25 |
		==|      147 |             title147 |      10047 |  11.16 |
		==|      386 |             title386 |      10286 |  10.90 |
		==|      330 |             title330 |      10230 |  10.89 |
		==|      932 |             title932 |      10832 |  10.87 |
		==|      467 |             title467 |      10367 |  10.81 |
		==|      925 |             title925 |      10825 |  10.57 |
		==|      252 |             title252 |      10152 |  10.35 |
		==|      541 |             title541 |      10441 |  10.27 |
		==|      320 |             title320 |      10220 |  10.24 |
		==|      248 |             title248 |      10148 |  10.15 |
		==|      301 |             title301 |      10201 |  10.06 |
		==|      103 |             title103 |      10003 |  10.06 |
		==|      812 |             title812 |      10712 |   9.94 |
		==|      299 |             title299 |      10199 |   9.94 |
		==|      734 |             title734 |      10634 |   9.88 |
		==|      829 |             title829 |      10729 |   9.73 |
		==|      310 |             title310 |      10210 |   9.61 |
		==|      637 |             title637 |      10537 |   9.58 |
		==|      856 |             title856 |      10756 |   9.28 |
		==|      364 |             title364 |      10264 |   9.25 |
		==|      939 |             title939 |      10839 |   9.18 |
		==|      576 |             title576 |      10476 |   9.18 |
		==|      300 |             title300 |      10200 |   9.00 |
		==|      574 |             title574 |      10474 |   8.95 |
		==|      915 |             title915 |      10815 |   8.73 |
		==|      997 |             title997 |      10897 |   8.41 |
		==|      821 |             title821 |      10721 |   8.41 |
		==|      290 |             title290 |      10190 |   8.41 |
		==|      918 |             title918 |      10818 |   8.28 |
		==|      202 |             title202 |      10102 |   8.08 |
		==|      198 |             title198 |      10098 |   7.92 |
		==|      280 |             title280 |      10180 |   7.84 |
		==|      433 |             title433 |      10333 |   7.75 |
		==|      681 |             title681 |      10581 |   7.38 |
		==|      658 |             title658 |      10558 |   7.30 |
		==|      251 |             title251 |      10151 |   7.30 |
		==|      336 |             title336 |      10236 |   7.29 |
		==|      270 |             title270 |      10170 |   7.29 |
		==|      716 |             title716 |      10616 |   7.27 |
		==|      844 |             title844 |      10744 |   7.24 |
		==|      249 |             title249 |      10149 |   7.20 |
		==|      954 |             title954 |      10854 |   7.02 |
		==|      905 |             title905 |      10805 |   6.91 |
		==|      509 |             title509 |      10409 |   6.91 |
		==|      478 |             title478 |      10378 |   6.85 |
		==|      260 |             title260 |      10160 |   6.76 |
		==|      613 |             title613 |      10513 |   6.58 |
		==|      417 |             title417 |      10317 |   6.39 |
		==|      757 |             title757 |      10657 |   6.31 |
		==|      152 |             title152 |      10052 |   6.31 |
		==|      472 |             title472 |      10372 |   6.28 |
		==|      250 |             title250 |      10150 |   6.25 |
		==|      148 |             title148 |      10048 |   6.19 |
		==|      788 |             title788 |      10688 |   6.10 |
		==|      877 |             title877 |      10777 |   5.92 |
		==|      314 |             title314 |      10214 |   5.86 |
		==|      669 |             title669 |      10569 |   5.76 |
		==|      240 |             title240 |      10140 |   5.76 |
		==|      946 |             title946 |      10846 |   5.50 |
		==|      230 |             title230 |      10130 |   5.29 |
		==|      873 |             title873 |      10773 |   5.22 |
		==|      642 |             title642 |      10542 |   5.22 |
		==|      895 |             title895 |      10795 |   5.11 |
		==|      491 |             title491 |      10391 |   5.11 |
		==|      201 |             title201 |      10101 |   5.04 |
		==|      102 |             title102 |      10002 |   5.04 |
		==|      199 |             title199 |      10099 |   4.96 |
		==|      220 |             title220 |      10120 |   4.84 |
		==|      210 |             title210 |      10110 |   4.41 |
		==|      743 |             title743 |      10643 |   4.21 |
		==|      286 |             title286 |      10186 |   4.18 |
		==|      911 |             title911 |      10811 |   4.00 |
		==|      200 |             title200 |      10100 |   4.00 |
		==|      526 |             title526 |      10426 |   3.67 |
		==|      383 |             title383 |      10283 |   3.67 |
		==|      998 |             title998 |      10898 |   3.61 |
		==|      190 |             title190 |      10090 |   3.61 |
		==|      587 |             title587 |      10487 |   3.46 |
		==|      524 |             title524 |      10424 |   3.46 |
		==|      885 |             title885 |      10785 |   3.33 |
		==|      151 |             title151 |      10051 |   3.28 |
		==|      180 |             title180 |      10080 |   3.24 |
		==|      149 |             title149 |      10049 |   3.22 |
		==|      264 |             title264 |      10164 |   2.97 |
		==|      170 |             title170 |      10070 |   2.89 |
		==|      684 |             title684 |      10584 |   2.79 |
		==|      160 |             title160 |      10060 |   2.56 |
		==|      367 |             title367 |      10267 |   2.47 |
		==|      428 |             title428 |      10328 |   2.32 |
		==|      150 |             title150 |      10050 |   2.25 |
		==|      762 |             title762 |      10662 |   2.07 |
		==|      459 |             title459 |      10359 |   2.07 |
		==|      140 |             title140 |      10040 |   1.96 |
		==|      422 |             title422 |      10322 |   1.81 |
		==|      882 |             title882 |      10782 |   1.80 |
		==|      779 |             title779 |      10679 |   1.69 |
		==|      130 |             title130 |      10030 |   1.69 |
		==|      875 |             title875 |      10775 |   1.57 |
		==|      236 |             title236 |      10136 |   1.57 |
		==|      120 |             title120 |      10020 |   1.44 |
		==|      110 |             title110 |      10010 |   1.21 |
		==|      806 |             title806 |      10706 |   0.97 |
		==|      608 |             title608 |      10508 |   0.97 |
		==|      631 |             title631 |      10531 |   0.82 |
		==|      999 |             title999 |      10899 |   0.81 |
		==|      563 |             title563 |      10463 |   0.70 |
		==|      214 |             title214 |      10114 |   0.58 |
		==|      771 |             title771 |      10671 |   0.45 |
		==|      441 |             title441 |      10341 |   0.45 |
		==|      666 |             title666 |      10566 |   0.36 |
		==|      333 |             title333 |      10233 |   0.09 |
		==|      889 |             title889 |      10789 |   0.04 |
++
{

for i in /tmp/libros$USER/*.txt; do
        cat $i
done
cat <<++ 
10
0
s
++
} | test 17 "ordenacion" $1 > /dev/null

grep '|' /tmp/salida17PROG.$USER > /tmp/salida17PROGAUX.$USER
res=`diff -w /tmp/salida17OK.$USER /tmp/salida17PROGAUX.$USER | wc -l`
[ $res -gt $1 ] && echo FAILED ordenacion && return 1
return 0

}


crealibros
! gcc -g -Wall -pipe -pthread *.c -o runnable && echo "FAILED: grade == 0 (gcc failed)" && exit 1
test1 0 || echo "FAILED: grade <= 1 (*)"
test2 0 || echo "FAILED: grade <= 3 (*)"
test3 0 || echo "FAILED: grade <= 5 (*)"
test4 0 || echo "FAILED: grade <= 5 (*)"
test5 0 || echo "FAILED: grade <= 5 (*)"
test6 0 || echo "FAILED: grade <= 5 (*)"
test7 0 || echo "FAILED: grade <= 5 (*)"
test8 0 || echo "FAILED: grade <= 5 (*)"
test9 0 || echo "FAILED: grade <= 5 (*)"
test10 0 || echo "FAILED: grade <= 6 (*)"
test11 0 || echo "FAILED: grade <= 6 (*)"
test12 0 || echo "FAILED: grade <= 7 (*)"
test13 0 || echo "FAILED: grade <= 7 (*)"
test14 0 || echo "FAILED: grade <= 9 (*)"
test15 0 || echo "FAILED: grade <= 9 (*)"
test16 0 || echo "FAILED: grade <= 9 (*)"

if [ "$1" = "--avanzada" ]; then
	! gcc -g -DAVANZADAS -Wall -pipe -pthread *.c -o runnable && echo "FAILED: grade == 0 (gcc failed)" && exit 1
	test17 0 || echo "FAILED: grade <= 9 (*)"
fi

disclaimer

