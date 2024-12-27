{
   PRACTICA_IMPERATIVO_P3.pas
   
   Copyright 2023 diego <diego@DESKTOP-RC8UHU5>
   
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


program netflix;
Type
	codigos=-1..8;
	
	lista=^nodo;
	
	datos = record
		cod_peli:integer;
		cod_genero:codigos;
		promedio:real;
	end;
	
	nodo = record
		dato:datos;
		sig:lista;
	end;
	
	Vcontador = array [codigos] of datos;
	
procedure leer(var D:datos);
begin
	writeln ('Ingrese el codigo de pelicula: '); readln (D.cod_peli);
	if (D.cod_peli <> -1) then begin
		writeln ('Ingrese el codigo de genero: '); readln(D.cod_genero);
		writeln('Ingrese el promedio '); readln (D.promedio);
	end;
end;

procedure cargarLista (var L:lista);
var
	D:datos;
	aux:lista;
begin
	leer(D);
	while (D.cod_peli <> -1) do begin
		new (aux); aux^.dato:=D; aux^.sig:=nil;
		if (L = nil) then begin
			L:=aux;
		end
		else begin
			aux^.sig:=L;
			L:=aux;
		end;
		leer (D);
	end;
end;

procedure mejores_promedios (var V:Vcontador; L:lista);
begin
	while (L <> nil) do begin
		if (V[L^.dato.cod_genero].promedio < L^.dato.promedio) then begin
			V[L^.dato.cod_genero].promedio:= L^.dato.promedio;
			V[L^.dato.cod_genero].cod_peli:=L^.dato.cod_peli;
		end;
		L:=L^.sig;
	end;
end;

procedure muestra_vector (V:Vcontador);
var
	i:integer;
begin
	for i:=1 to 8 do begin
		writeln ('El codigo de genero: ',i,' contiene el siguiente mejor promedio: ',V[i].promedio:0:2,' con el codigo de pelicula: ',V[i].cod_peli);
	end;
end;

procedure seleccion (var V:Vcontador);
var
	pos,i,j:integer;
	minimo:datos;
begin
	for i:=1 to 7 do begin
		pos:=i;
		for j:=i+1 to 8 do begin
			if (V[j].promedio < V[i].promedio) then 
				pos:=j
		end;
		minimo:=V[pos];
		V[pos]:=V[i];
		V[i]:=minimo;
	end;
end;

procedure cargar_vector (var V:Vcontador);
var
	i:integer;
	D:datos;
begin
	for i:=1 to 8 do begin
		V[i]:=D;
	end;
end;

var
	L:lista;
	V:Vcontador;
BEGIN
	L:=nil;
	cargar_vector (V);
	cargarLista (L);
	mejores_promedios (V,L);
	muestra_vector (V);
	seleccion(V);
	muestra_vector (V);
END.

