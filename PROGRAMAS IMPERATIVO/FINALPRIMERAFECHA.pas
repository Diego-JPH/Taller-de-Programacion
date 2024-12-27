{
   FINALPRIMERAFECHA.pas
   
   Copyright 2024 Diego <Diego@DESKTOP-B4BHKKN>
   
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
program FINALPRIMERAFECHA;
Type
	alumno = record
		nombre:string;
		dni:integer;
		tiempo:real;
	end;
	arbol = ^nodo;
	nodo = record
		dato:alumno;
		HI:arbol;
		HD:arbol;
	end;
	lista = ^nodo_lista;
	nodo_lista = record
		dato:alumno;
		sig:lista;
	end;

procedure leer (var D:alumno);
begin
	writeln ('Ingrese el dni del alumno: '); readln (D.dni);
	if (D.dni <> 0) then begin
		writeln ('Ingrese el nombre del alumno: '); readln (D.nombre);
		writeln ('Ingrese el tiempo del alumno: '); readln (D.tiempo);
	end;
end;
procedure agregarAlArbol(var A:arbol; D:alumno);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.tiempo <= A^.dato.tiempo) then begin
			agregarAlArbol (A^.HI,D);
		end
		else begin
			agregarAlArbol (A^.HD,D);
		end;
	end;
end;
procedure cargarArbol (var A:arbol);
var
	D:alumno;
begin
	leer (D);
	while (D.dni <> 0) do begin
		agregarAlArbol (A,D);
		leer (D);
	end;
end;
procedure agregarALaLista (var L:lista; D:alumno);
var
	aux:lista;
begin
	if (L = nil) then begin
		new (L); L^.dato:=D; L^.sig:=nil;
	end
	else begin
		new (aux); aux^.dato:=D; aux^.sig:=L;
		L:=aux;
	end;
end;
procedure busqueda (var L:lista; A:arbol; V1,V2:real);
begin
	if (A <> nil) then begin
		if (A^.dato.tiempo >= V1) then begin
			busqueda (L,A^.HI,V1,V2);
		end;
		if ((A^.dato.tiempo >= V1) and (A^.dato.tiempo <= V2)) then begin
			agregarALaLista (L,A^.dato);
		end;
		if (A^.dato.tiempo <= V2) then begin
			busqueda (L,A^.HD,V1,V2);
		end;
	end;
end;
procedure ganador (L:lista; var nombre:string; var dni:integer; var tiempo:real);
begin
	if (L <> nil) then begin
		if (L^.dato.tiempo < tiempo) then begin
			nombre:=L^.dato.nombre; dni:=L^.dato.dni; tiempo:=L^.dato.tiempo;
		end;
		ganador (L^.sig,nombre,dni,tiempo);
	end;
end;
procedure imprimirLista (L:lista);
begin
	while (L <> nil) do begin
		writeln (L^.dato.tiempo:0:2);
		writeln (L^.dato.nombre);
		L:=L^.sig;
	end;
end;

{PP}
var
	L:lista; A:arbol; nombre:string; dni:integer; tiempo,V1,V2:real;
begin
	L:=nil; A:=nil; tiempo:=9999;
	cargarArbol (A);
	writeln ('Ingrese los dos valores entre los que quiere crear una lista: '); readln (V1); readln (V2);
	busqueda (L,A,V1,V2);
	imprimirLista (L);
	writeln ('-------------------------------');
	ganador (L,nombre,dni,tiempo);
	writeln ('El ganador es: ',nombre,' - ',dni);
end.
