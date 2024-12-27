{
   PRACTICA4_IMPERATIVO_P3.pas
   
   Copyright 2023 Diego <Diego@DESKTOP-B4BHKKN>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}
program facultad;
Type
	lista=^nodo_lista; {LISTA DE FINALES APROBADOS}
	
	datos_lista = record {almacernar solo las notas de 4 a 10}
		cod_mat:integer;
		nota:real;
	end;
		 
	nodo_lista = record
		dato:datos_lista;
		sig:lista;
	end;
	
	arbol=^nodo_arbol; {ARBOL CON TODA LA INFO Y DENTRO UNA LISTA}
	
	datos_arbol = record
		cod_alu:integer;
		dato:lista;
	end;
	
	nodo_arbol = record
		dato:datos_arbol;
		HI:arbol;
		HD:arbol;
	end;
	
	lista_vector=^nodo_vector; {LISTA VECTOR}
	
	datos_vector = record {VECTOR CONTADOR CON INFO DE TODOS LOS ALUMNOS QUE RINDIERON UN FINAL}
		cod_alu:integer;
		nota:real;
	end;
	
	nodo_vector = record
		dato:datos_vector;
		sig:lista_vector;
	end;
	
	Vlistas = array [1..30] of lista_vector;
	
	lista_promedio=^nodo_promedio;
	
	datos_promedio = record
		cod_alu:integer;
		promedio:real;
	end;
	
	nodo_promedio = record
		dato:datos_promedio;
		sig:lista_promedio;
	end;
	
procedure inicializar_vector (var V:Vlistas);
var
	i:integer;
begin
	for i:=1 to 30 do begin
		V[i]:=nil;
	end;
end;
			
procedure leer (var D:datos_arbol);
begin
	new (D.dato);
	writeln ('Ingrese la nota: '); readln (D.dato^.dato.nota);
	if (D.dato^.dato.nota <> -1) then begin
		writeln ('Ingrese el codigo de alumno: '); readln (D.cod_alu);
		writeln ('Ingrese el codigo de la materia: '); readln (D.dato^.dato.cod_mat);
	end;
end;

procedure agregar (var A:arbol; D:datos_arbol);
var
	aux:lista;
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (A^.dato.cod_alu = D.cod_alu) then begin
			new (aux); aux^.dato.cod_mat:=D.dato^.dato.cod_mat; aux^.dato.nota:=D.dato^.dato.nota; aux^.sig:=nil;
			if (A^.dato.dato = nil) then
				A^.dato.dato:=aux
			else begin
				aux^.sig:=A^.dato.dato;
				A^.dato.dato:=aux;
			end;
		end
		else begin
			if (D.cod_alu < A^.dato.cod_alu) then
				agregar (A^.HI,D)
			else
				agregar (A^.HD,D);
		end;
	end;
end;

procedure agregar_vector (var V:Vlistas; D:datos_arbol);
var
	aux,L2:lista_vector;
begin
	new (aux); aux^.dato.cod_alu:=D.cod_alu; aux^.dato.nota:=D.dato^.dato.nota; aux^.sig:=nil;
	if (V[D.dato^.dato.cod_mat] = nil) then
		V[D.dato^.dato.cod_mat]:=aux
	else begin
		L2:=V[D.dato^.dato.cod_mat];
		while (L2^.sig <> nil) do begin
			L2:=L2^.sig;
		end;
		aux^.sig:=V[D.dato^.dato.cod_mat];
		V[D.dato^.dato.cod_mat]:=aux;
	end;
end;

procedure cargarArbol_Vector (var A:arbol; var V:Vlistas);
var
	D:datos_arbol;
begin
	leer (D);
	while (D.dato^.dato.nota <> -1) do begin
		if (D.dato^.dato.nota >= 4) then {ESTRUCTURA 1}
			agregar (A,D);
		agregar_vector (V,D); {ESTRUCTURA 2}
		leer (D);
	end;
end;

procedure busqueda (A:arbol; cod:integer; var L:lista_promedio; cant:integer);
var
	aux:lista_promedio;
	L2:lista;
begin
	if (A <> nil) then begin
		if (A^.dato.cod_alu > cod) then begin
			new (aux); aux^.dato.cod_alu:=A^.dato.cod_alu; aux^.dato.promedio:=0; aux^.sig:=nil; cant:=0;
			L2:=A^.dato.dato;
			while (L2 <> nil) do begin
				aux^.dato.promedio:=aux^.dato.promedio+L2^.dato.nota;
				cant:=cant+1;
				L2:=L2^.sig;
			end;
			if (cant <> 0) then
				aux^.dato.promedio:=aux^.dato.promedio / cant;
			if (L = nil) then
				L:=aux
			else begin
				aux^.sig:=L;
				L:=aux;
			end;
			if (A^.HI <> nil) then
				busqueda (A^.HI,cod,L,cant);
			if (A^.HD <> nil) then
				busqueda (A^.HD,cod,L,cant);
		end
		else begin
			if (A^.HD <> nil) then
				busqueda (A^.HD,cod,L,cant);
		end;
	end;
end;

procedure seleccion (A:arbol; cod_1,cod_2,valor:integer; var cant_finales,cant_alu:integer);
var
	L2:lista;
begin
	if (A <> nil) then begin
		if (A^.dato.cod_alu > cod_1) and (A^.dato.cod_alu < cod_2) then begin
			if (A^.dato.dato <> nil) then begin
				L2:=A^.dato.dato; cant_finales:=0;
				while (L2 <> nil) do begin
					cant_finales:=cant_finales+1;
					L2:=L2^.sig;
				end;
				if (cant_finales = valor) then
					cant_alu:=cant_alu+1;
			end;
		end
		else begin
			if (A^.dato.cod_alu < cod_1) then
				seleccion (A^.HD,cod_1,cod_2,valor,cant_finales,cant_alu)
			else begin
				if (A^.dato.cod_alu > cod_2) then
					seleccion (A^.HI,cod_1,cod_2,valor,cant_finales,cant_alu);
			end;
		end;
	end;
end;
				
var	
	A:arbol;
	V:Vlistas;
	L_busqueda:lista_promedio;
	cod,cod_1,cod_2,cant,cant_finales,cant_alu,valor:integer;
	D:datos_arbol;
begin
	A:=nil; L_busqueda:=nil; cant_finales:=0; cant_alu:=0;
	cant:=0;
	leer (D);
	inicializar_vector (V);
	cargarArbol_Vector (A,V);
	writeln ('Ingrese el codigo del que quiera tomar los mayores: '); readln (cod);
	busqueda (A,cod,L_busqueda,cant);
	writeln ('Ingrese los alumnos entre los que los que analizar: '); readln (cod_1); readln (cod_2);
	writeln ('Ingrese la cantidad de finales que deben cumplir: '); readln (valor);
	seleccion (A,cod_1,cod_2,valor,cant_finales,cant_alu);
	writeln ('La cantidad de alumnos que lo cumplen es: ',cant_alu);
end.
