{
   PRACTICA2ARBOLES.pas
   
   Copyright 2023 Alumno <Alumno@DESKTOP-8L9LI50>
   
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
program  comercio;
Type
	arbol_1=^nodo_1;
	
	arbol_2=^nodo_2;

	datos = record
		cod:integer;
		fecha:string;
		unidades:integer;
	end;
	
	A2 = record
		cod:integer;
		unidades:integer;
	end;
	
	nodo_2= record
		dato:A2;
		HI:arbol_2;
		HD:arbol_2;
	end;
	
	nodo_1=record
		dato:datos;
		HI:arbol_1;
		HD:arbol_1;
	end;

procedure leer (var D:datos);
begin
	writeln ('Ingrese el codigo de producto: '); readln (D.cod);
	if (D.cod <> 0) then begin
		writeln ('Ingrese la fecha de venta: '); readln (D.fecha);
		writeln ('Ingrese la unidades vendidas: '); readln (D.unidades);
	end;
end;

procedure agregar (var A:arbol_1; D:datos);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.cod <= A^.dato.cod) then
			agregar (A^.HI,D);
		if (D.cod > A^.dato.cod) then
			agregar (A^.HD,D);
	end;
end;

procedure agregar_2 (var A2:arbol_2; D:datos);
begin
	if (A2 = nil) then begin
		new (A2); A2^.dato.cod:=D.cod; A2^.dato.unidades:=D.unidades; A2^.HI:=nil; A2^.HD:=nil;
	end
	else begin
		if (D.cod = A2^.dato.cod) then begin
			A2^.dato.unidades:=A2^.dato.unidades+D.unidades;
		end
		else begin
			if (D.cod < A2^.dato.cod) then 
				agregar_2 (A2^.HI,D);
			if (D.cod > A2^.dato.cod) then
				agregar_2 (A2^.HD,D);
		end;
	end;
end;

procedure cargarArbol (var A:arbol_1; var A2:arbol_2);
var
	D:datos;
begin
	leer (D);
	while (D.cod <> 0) do begin
		agregar (A,D);
		agregar_2 (A2,D);
		leer (D);
	end;
end;

procedure busqueda_unidades_arbol_1 (A:arbol_1; cod_busqueda:integer; var unidades_busqueda:integer); {arbol 1}
begin
	if (A <> nil) and (unidades_busqueda = -1) then begin
		if (A^.dato.cod < cod_busqueda) then
			busqueda_unidades_arbol_1 (A^.HD,cod_busqueda,unidades_busqueda)
		else
			busqueda_unidades_arbol_1 (A^.HI,cod_busqueda,unidades_busqueda);
		if  (A^.dato.cod = cod_busqueda) then
			unidades_busqueda:=A^.dato.unidades;
	end;
end;

procedure busqueda_unidades_arbol_2 (A2:arbol_2; cod_busqueda:integer; var unidades_busqueda:integer); {arbol 2}
begin
	if (A2 <> nil) and (unidades_busqueda = -1) then begin
		if (A2^.dato.cod < cod_busqueda) then
			busqueda_unidades_arbol_2 (A2^.HD,cod_busqueda,unidades_busqueda)
		else
			busqueda_unidades_arbol_2 (A2^.HI,cod_busqueda,unidades_busqueda);
		if (A2^.dato.cod = cod_busqueda) then
			unidades_busqueda:=A2^.dato.unidades;
	end;
end;
		

var
	A:arbol_1;
	A22:arbol_2;
	cod_busqueda_1,cod_busqueda_2,unidades_busqueda_1,unidades_busqueda_2:integer;
begin
	A:=nil; A22:=nil; unidades_busqueda_1:=-1; unidades_busqueda_2:=-1;
	cargarArbol (A,A22);
	writeln ('Ingrese el codigo del que quiera saber las unidades vendidas (arbol 1): '); readln (cod_busqueda_1);
	busqueda_unidades_arbol_1 (A,cod_busqueda_1,unidades_busqueda_1);
	writeln ('Se vendieron: (si da como resultado -1, el codigo no existe: ',unidades_busqueda_1);
	
	writeln ('Ingrese el codigo del que quiera saber las unidades vendidas: '); readln (cod_busqueda_2);
	busqueda_unidades_arbol_2 (A22,cod_busqueda_2,unidades_busqueda_2);
	writeln ('Se vendieron: (si da como resultado -1, el codigo no existe: ',unidades_busqueda_2);
end.
