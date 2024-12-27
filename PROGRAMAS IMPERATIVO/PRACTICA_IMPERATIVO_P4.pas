{
   PRACTICA_IMPERATIVO_P4.pas
   
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
program libreria;
Type
	rubros=1..8;
	
	lista=^nodo;
	
	productos = record
		cod_producto:integer;
		cod_rubro:rubros;
		precio:real;
	end;
	
	nodo = record
		dato:productos;
		sig:lista;
	end;
	
	Vlistas = array [rubros] of lista;
	
	Vrubro = array [1..30] of productos;
	
procedure leer (var P:productos);
begin
	writeln ('Ingrese el precio del producto: '); readln (P.precio);
	if (P.precio <> 0) then begin
		writeln ('Ingrese el codigo de rubro: '); readln (P.cod_rubro);
		writeln ('Ingrese el codigo de producto: '); readln (P.cod_producto);
	end;
end;

procedure inicializar_vector (var V:Vlistas);
var
	i:integer;
begin
	for i:=1 to 8 do begin
		V[i]:=nil;
	end;
end;

procedure insertar_ordenado (P:productos; var V:Vlistas);
var
	aux,ant,act:lista;
begin
	new (aux); aux^.dato:=P; aux^.sig:=nil;
		if (V[P.cod_rubro] = nil) then begin
			V[P.cod_rubro]:=aux;
		end
		else begin
			act:=V[P.cod_rubro]; ant:=V[P.cod_rubro];
			while (act <> nil) and (act^.dato.cod_producto < aux^.dato.cod_producto) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if (act = V[P.cod_rubro]) then begin
				aux^.sig:=V[P.cod_rubro];
				V[P.cod_rubro]:=aux;
			end
			else begin
				if (act <> nil) then begin
					aux^.sig:=act;
					ant^.sig:=aux;
				end
				else begin
					ant^.sig:=aux;
				end;
			end;
		end;
end;
			

procedure cargarVector (var V:Vlistas);
var
	P:productos;
begin
	leer (P);
	while (P.precio <> 0) do begin
		insertar_ordenado (P,V);
		leer (P);
	end;
end;

procedure imprimir_rubros (v:Vlistas);
var
	pos,i:integer;
begin
	for i:=1 to 8 do begin
		pos:=1;
		while (V[i] <> nil) do begin
			writeln ('El codigo del producto numero: ',pos,' dentro del rubro numero: ',i,' es: ',V[i]^.dato.cod_producto);
			V[i]:=V[i]^.sig;
			pos:=pos+1;
		end;
	end;
end;

procedure tomar_rubro (rubro:integer; V:Vlistas; var VR:Vrubro; var dimL:integer);
var
	fin_lista:boolean;
begin
	fin_lista:=false;
	while (dimL <= 30) and (fin_lista = false) do begin
		dimL:=dimL+1;
		VR[dimL]:=V[rubro]^.dato;
		V[rubro]:=V[rubro]^.sig;
		if (V[rubro] = nil) then
			fin_lista:=true;
	end;
end;

procedure ordenar_rubro (var VR:Vrubro; dimL:integer);
var
	minimo:productos;
	i,j,pos:integer;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if (VR[j].precio < VR[pos].precio) then
				pos:=j;
		end;
		minimo:=VR[pos];
		VR[pos]:=VR[i];
		VR[i]:=minimo;
	end;
end;

procedure imprimir_rubro_ordenado (VR:Vrubro; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln ('El producto numero: ',i,' tiene el precio de: ',VR[i].precio:0:2);
	end;
end;

procedure promedio_rubro_ordenado (VR:Vrubro; dimL:integer);
var
	promedio:real;
	i:integer;
begin
	promedio:=0;
	for i:=1 to dimL do begin
		promedio:=promedio+VR[i].precio;
	end;
	writeln ('Tiene un precio promedio de: ',promedio / dimL:0:2);
end;



var {pp}
	dimL:integer;
	R:rubros;
	V:Vlistas;
	VR:Vrubro;
begin
	dimL:=0;
	inicializar_vector (V);
	cargarVector (V);
	imprimir_rubros (V);
	writeln ('Ingrese el rubro del que quire crear un vector de maximo 30 productos: '); readln (R);
	tomar_rubro (R,V,VR,dimL);
	ordenar_rubro (VR,dimL);
	imprimir_rubro_ordenado (VR,dimL);
	promedio_rubro_ordenado (VR,dimL);
end.
