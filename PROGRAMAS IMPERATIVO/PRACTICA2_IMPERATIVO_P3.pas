{
   PRACTICA2_IMPERATIVO_P3.pas
   
   Copyright 2023 alumnos <alumnos@LAB09-01>
   
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
program listas_recursivas;
Type
	lista=^nodo;
	
	nodo = record
		dato:integer;
		sig:lista;
	end;

procedure lista_recursiva (var L:lista);
var
	aux:lista;
begin
	new (aux); aux^.dato:=random (101); aux^.sig:=nil;
	writeln (aux^.dato);
	if (aux^.dato = 0) then begin
		aux^.sig:=L;
		L:=aux;
	end
	else begin
		if (L = nil) then begin
			L:=aux;
		end
		else begin
			aux^.sig:=L;
			L:=aux;
		end;
		lista_recursiva (L);
	end;
end;

procedure buscar_minimo (L:lista; var min:integer);
begin
	if (L^.sig = nil) then begin
		if (L^.dato < min) and (L^.dato <> 0) then {podria cambiarse si no guardo el 0 de finalizar la lista dentro de la lista}
			min:=L^.dato
	end
	else begin
		if (L^.dato < min) and (L^.dato <> 0) then {podria cambiarse si no guardo el 0 de finalizar la lista dentro de la lista}
			min:=L^.dato;
		buscar_minimo (L^.sig,min);
	end;
end;

procedure buscar_maximo (L:lista; var max:integer);
begin
	if (L^.sig = nil) then begin
		if (L^.dato > max) then {podria cambiarse si no guardo el 0 de finalizar la lista dentro de la lista}
			max:=L^.dato
	end
	else begin
		if (L^.dato > max) then {podria cambiarse si no guardo el 0 de finalizar la lista dentro de la lista}
			max:=L^.dato;
		buscar_maximo (L^.sig,max);
	end;
end;

procedure buscar_existencia (L:lista; var flag:boolean; valor:integer);
begin
	if (L^.sig = nil) then begin
		if (L^.dato = valor) then
			flag:=true;
	end
	else begin
		if (L^.dato = valor) then
			flag:=true;
		buscar_existencia (L^.sig,flag,valor);
	end;
end;

var
	L:lista;
	min,max,valor:integer;
	flag:boolean;
begin
	L:=nil; randomize; min:=1000; max:=0; flag:=false;
	lista_recursiva (L);
	buscar_minimo (L,min);
	buscar_maximo (L,max);
	writeln ('El minimo es: ',min);
	writeln ('El maximo es: ',max);
	writeln ('Ingrese el valor a buscar: '); readln (valor);
	buscar_existencia (L,flag,valor);
	writeln ('La flag esta: ',flag);
end.
