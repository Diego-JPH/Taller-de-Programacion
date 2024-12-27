{
   PRACTICA_IMPERATIVO_P2.pas
   
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
program oficinas;
Type
	datos = record
		cod:integer;
		DNI:integer;
		valor:real;
	end;
	
	Voficinas = array [1..300] of datos;
	
procedure leer (var D:datos);
begin
	writeln ('Ingrese el codigo de identificacion: '); readln (D.cod);
	if (D.cod <> -1) then begin
		writeln ('Ingrese el DNI: '); readln (D.DNI);
		writeln ('Ingrese el valor de la expensa: '); readln (D.valor);
	end;
end;

procedure cargarVector_vacio (var V:Voficinas); {es necesario cargar un vector de registros?}
var
	i:integer;
	D:datos;
begin
	for i:=1 to 300 do begin
		V[i]:=D;
	end;
end;

procedure cargarVector (var V:Voficinas; var dimL:integer);
var
	D:datos;
begin
	leer (D);
	while (D.cod <> -1) and (dimL <= 300) do begin
		dimL:=dimL+1;
		V[dimL]:=D;
		leer (D);
	end;
end;

procedure seleccion (var V:Voficinas; dimL:integer);
var
	minimo:datos;
	i,j,pos:integer;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if (V[j].cod < V[i].cod) then
				pos:=j
		end;
		minimo:=V[pos];
		V[pos]:=V[i];
		V[i]:=minimo;
	end;
end;

procedure insercion (var V:Voficinas; dimL:integer);
var
	i,j,actual:integer;
	registro:datos;
begin
	for i:=2 to dimL do begin
		registro:=V[i];
		actual:=V[i].cod;
		j:=i-1;
		while (V[j].cod > actual) do begin
			V[j+1]:=V[j];
			j:=j-1;
		end;
		V[j+1]:=registro;
	end;
end;

procedure muestra (V:Voficinas; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln (V[i].cod); writeln (V[i].DNI); writeln (V[i].valor:0:2);
	end;
end;
		
var {PP}
	dimL:integer;
	V:Voficinas;
begin
	dimL:=0;
	cargarVector_vacio (V);
	cargarVector (V,dimL);
	insercion (V,dimL);
	muestra (V,dimL);
end.
	
	
	

