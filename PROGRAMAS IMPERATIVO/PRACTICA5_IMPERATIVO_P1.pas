{
   PRACTICA5_IMPERATIVO_P1.pas
   
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
program edificio;
Type
	datos = record
		cod_identidad:integer;
		DNI:integer;
		valor:real;
	end;
	
	Vector = array [1..300] of datos;
	
procedure leer (var D:datos);
begin
	writeln ('Ingrese el codigo de identidad: '); readln (D.cod_identidad);
	if (D.cod_identidad <> -1) then begin
		writeln ('Ingrese el DNI: '); readln (D.DNI);
		writeln ('Ingrese el valor: '); readln (D.valor);
	end;
end;

procedure cargarVector (var V:Vector; var dimL:integer);
var
	D:datos;
begin
	leer (D);
	while (D.cod_identidad <> -1) do begin
		dimL:=dimL+1;
		V[dimL]:=D;
		leer (D);
	end;
end;

procedure ordenarVector (var V:vector; dimL:integer);
var
	i,k,pos:integer;
	item:datos;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for k:=i+1 to dimL do begin
			if (V[k].cod_identidad < V[pos].cod_identidad) then
				pos:=k;
		end;
		item:=V[pos];
		V[pos]:=V[i];
		V[i]:=item;
	end;
end;

procedure dicotomia (V:vector; dimL:integer; cod:integer; var pos:integer);
var
	pri,ult,med:integer;
begin
	pri:=1; ult:=dimL; med:=(pri+ult) div 2;
	while (V[med].cod_identidad <> cod) and (med < ult) do begin
		if (V[med].cod_identidad < cod) then begin
			pri:=med+1;
			med:=(pri+ult) div 2;
		end
		else begin
			ult:=med-1;
			med:=(pri+ult) div 2;
		end;
	end;
	if (V[med].cod_identidad = cod) then
		pos:=med;
end;

procedure total_expensas (V:vector; dimL:integer; var total:real; i:integer);
begin
	if (i <> dimL) then begin
		i:=i+1;
		total:=total+V[i].valor;
		total_expensas (V,dimL,total,i);
	end;
end;

var
	V:Vector;
	dimL,cod,pos,i:integer;
	total:real;
begin
	dimL:=0; pos:=0; i:=0; total:=0;
	cargarVector (V,dimL);
	ordenarVector (V,dimL);
	writeln ('Ingrese el codigo de identidad a buscar: '); readln (cod);
	dicotomia (V,dimL,cod,pos);
	if (pos <> 0) then
		writeln ('El DNI es: ',V[pos].DNI)
	else
		writeln ('No se encontro la oficina');
	total_expensas (V,dimL,total,i);
	writeln ('El total de expensas es: ',total:0:2);
end.	
