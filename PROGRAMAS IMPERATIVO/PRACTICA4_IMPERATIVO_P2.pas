{
   PRACTICA4_IMPERATIVO_P2.pas
   
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
program biblioteca;
Type
	{ARBOL DE REGISTROS}
	
	dias=1..31;

	arbol=^nodo_arbol;
	
	datos = record
		ISBN:integer;
		nro_socio:integer;
		fecha:string;
		dias:dias;
	end;
	
	nodo_arbol = record
		dato:datos;
		HI:arbol;
		HD:arbol;
	end;
	
	{ARBOL DE LISTAS}
	
	arbol_listas=^nodo_arbol_listas;
	
	lista=^nodo_lista;
	
	nodo_lista = record
		dato:datos;
		sig:lista;
	end;
	
	nodo_arbol_listas = record
		dato:lista;
		HI:arbol_listas;
		HD:arbol_listas;
	end;

procedure leer (var D:datos);
begin
	writeln ('Ingrese el ISBN: '); readln (D.ISBN);
	if (D.ISBN <> -1) then begin
		writeln ('Ingrese el numero de socio: '); readln (D.nro_socio);
		writeln ('Ingrese la fecha del prestamo: '); readln (D.fecha);
		writeln ('Ingrese los dias prestados: '); readln (D.dias);
	end;
end;

procedure agregarLista (var L:lista; D:datos);
var
	aux:lista;
begin
	new (aux); aux^.dato:=D; aux^.sig:=nil;
	if (L = nil) then
		L:=aux
	else begin
		aux^.sig:=L;
		L:=aux;
	end;
end;


procedure agregarArbol_acumulativo (var A:arbol_listas; D:datos);
var
	aux:lista;
begin
	if (A = nil) then begin
		new (aux); aux^.dato:=D;
		new (A); A^.dato:=aux; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (A^.dato^.dato.ISBN = D.ISBN) then begin
			agregarLista (A^.dato,D)
		end
		else begin
			if (D.ISBN <= A^.dato^.dato.ISBN) then
				agregarArbol_acumulativo (A^.HI,D)
			else
				agregarArbol_acumulativo (A^.HD,D);
		end;
	end;
end;

procedure agregarArbol (var A:arbol; D:datos);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.ISBN <= A^.dato.ISBN) then
			agregarArbol (A^.HI,D)
		else
			agregarArbol (A^.HD,D);
	end;
end;

procedure cargarArboles (var A:arbol_listas; var A2:arbol);
var
	D:datos;
begin
	leer (D);
	while (D.ISBN <> -1) do begin
		agregarArbol_acumulativo (A,D);
		agregarArbol (A2,D);
		leer (D);
	end;
end;

procedure buscar_max (A:arbol; var max:integer);
begin
	if (A <> nil) then begin
		if (A^.HD <> nil) then
			buscar_max (A^.HD,max);
		if (A^.dato.ISBN > max) then
			max:=A^.dato.ISBN;
	end;
end;

procedure buscar_min (A:arbol_listas; var min:integer);
begin
	if (A <> nil) then begin
		if (A^.dato^.dato.ISBN <= min) then begin
			while (A^.dato <> nil) do begin
				if (A^.dato^.dato.ISBN < min) then 
					min:=A^.dato^.dato.ISBN;
				A^.dato:=A^.dato^.sig;
			end;
			buscar_min (A^.HI,min);
		end
		else begin
			min:=999;
		end;
	end;
end;

var {PP}
	A:arbol_listas; {listas dentro de los ISBN}
	A2:arbol; {comun}
	min,max:integer;
begin
	A:=nil; A2:=nil; min:=999; max:=-99;
	cargarArboles (A,A2);
	buscar_max (A2,max);
	writeln ('El ISBN mas grande del arbol comun es: ',max);
	buscar_min (A,min);
	writeln ('El ISBN mas pequenio del arbol con listas es: ',min);
end.
