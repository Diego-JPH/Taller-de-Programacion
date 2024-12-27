{
   PRACTICA_IMPERATIVO_P1.pas
   
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
program PRACTICA_1_PUNTO_1;
Type
	dias=0..31; codigos=1..15; cantidad_max=1..99;
	
	datos = record
		dia:dias;
		cod:codigos;
		cant:cantidad_max;
	end;
	
	Ventas = array [1..50] of datos;
	
	contador = array [1..15] of integer;
	
procedure leer (var D:datos);
begin
	writeln ('Ingrese el dia: '); readln (D.dia);
	if (D.dia <> 0) then begin
		writeln ('Ingrese el codigo: '); readln (D.cod);
		writeln ('Ingrese la cantidad vendida del producto: '); readln (D.cant);
	end;
end;

procedure cargarVector (var V:Ventas; var dimL:integer);
var
	D:datos;
begin
	leer (D);
	while (dimL <= 50) and (D.dia <> 0) do begin
		dimL:=dimL+1;
		V[dimL]:=D;
		leer (D);
	end;
end;

procedure muestra (V:Ventas; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln ('La venta numero: ',i,' tiene la siguient informacion: ');
		writeln (V[i].dia); writeln (V[i].cod); writeln (V[i].cant);
	end;
end;

procedure ordenar (var V:Ventas; dimL:integer);
var
	pos,j,i:integer;
	minimo:datos;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if (V[j].cod < V[pos].cod) then
				pos:=J
		end;
		minimo:=V[pos];
		V[pos]:=V[i];
		V[i]:=minimo;
	end;
end;

procedure eliminar (var V:Ventas; var dimL:integer; cod_1,cod_2:integer);
var
	pos_1,pos_2,i:integer;
begin
	pos_2:=0;
	for i:=1 to dimL do begin
		if V[i].cod = cod_1 then
			pos_1:=i;
		if (V[i].cod = cod_2) and (cod_2 <> 0) then
			pos_2:=i;
	end;
	while ((pos_1+1) <> pos_2) do begin {allar la manera de q borre bien}
		V[pos_2-1]:=V[pos_2];
		pos_2:=pos_2-1;
		dimL:=dimL-1
	end;
	
end;

procedure inicializar_vector (var C:contador);
var
	i:integer;
begin
	for i:=1 to 15 do begin
		C[i]:=0;
	end;
end;

procedure muestra_2 (C:contador);
var
	i:integer;
begin
	for i:=1 to 15 do begin
		if (i mod 2 = 0) then
			writeln ('El producto de codigo: ',i, ' tiene una venta total de: ',C[i],' productos');
	end;
end;

procedure codigos_pares (V:Ventas; dimL:integer; var C:contador);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		if (V[i].cod mod 2 = 0) then
			C[V[i].cod]:=C[V[i].cod]+V[i].cant;
	end;
	muestra_2 (C);
end;

	
var
	dimL,cod_1,cod_2:integer;
	V:Ventas;
	C:contador;
begin
	dimL:=0;
	inicializar_vector (C);
	cargarVector (V,dimL);
	muestra (V,dimL);
	ordenar (V,dimL);
	muestra (V,dimL);
	writeln ('Ingrese los 2 codigos entre los que estan los codigos a borrar: '); readln (cod_1); readln (cod_2);
	eliminar (V,dimL,cod_1,cod_2);
	muestra (V,dimL);
	codigos_pares (V,dimL,C);
end.
