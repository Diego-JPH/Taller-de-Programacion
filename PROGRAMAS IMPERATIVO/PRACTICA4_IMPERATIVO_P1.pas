{
   PRACTICA4_IMPERATIVO_P1.pas
   
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
program libreria;
Type
	arbol=^nodo_arbol;
	
	producto = record
		cod_venta:integer;
		cod_producto:integer;
		unidades_vendidas:integer;
		monto:real;
	end;

	nodo_arbol = record
		dato:producto;
		HI:arbol;
		HD:arbol;
	end;
		
procedure leer (var P:producto);
begin
	writeln ('Ingrese el codigo de venta: '); readln(P.cod_venta);
	if (P.cod_venta <> -1) then begin
		writeln ('Ingrese el codigo de producto: '); readln (P.cod_producto);
		writeln ('Ingrese las unidades vendidas: '); readln (P.unidades_vendidas);
		writeln ('Ingrese el monto: '); readln (P.monto);
	end;
end;

procedure agregar (var A:arbol; P:producto);
begin
	if (A = nil) then begin
		new (A); A^.dato:=P; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (A^.dato.cod_producto <> P.cod_producto) then begin
			if (P.cod_producto <= A^.dato.cod_producto) then
				agregar (A^.HI,P)
			else 
				agregar (A^.HD,P);
		end
		else begin
			A^.dato.unidades_vendidas:=A^.dato.unidades_vendidas+P.unidades_vendidas;
			A^.dato.monto:=A^.dato.monto+P.monto;
		end;
	end;
end;
		

procedure cargarArbol (var A:arbol);
var
	P:producto;
begin
	leer (P);
	while (P.cod_venta <> -1) do begin
		agregar (A,P);
		leer (P);
	end;
end;

procedure imprimir_arbol (A:arbol);
begin
	if (A <> nil) then begin
		if (A^.HI <> nil) then
			imprimir_arbol (A^.HI);
		writeln ('El codigo de producto: ',A^.dato.cod_producto,' tiene los siguientes datos: ');
		writeln ('Total de unidades vendidas: ',A^.dato.unidades_vendidas);
		writeln ('El monto total es: ',A^.dato.monto:0:2);
		if (A^.HD <> nil) then
			imprimir_arbol (A^.HD);
	end;
end;

procedure buscar_max (A:arbol; var cod_max,max:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.unidades_vendidas > max) then begin
			max:=A^.dato.unidades_vendidas;
			cod_max:=A^.dato.cod_producto;
		end;
		if (A^.HD <> nil) then
			buscar_max (A^.HD,cod_max,max);
	end;
end;

procedure buscar_min (A:arbol; cod:integer; var cant:integer); {revisar}
begin
	if (A <> nil) then begin
		if (A^.dato.cod_producto < cod) then begin
			cant:=cant+1;
			if (A^.HI <> nil) then
				buscar_min (A^.HI,cod,cant);
			if (A^.HD <> nil) then
				buscar_min (A^.HD,cod,cant);
		end;
	end;
end;

procedure buscar_medio (A:arbol; cod_1,cod_2:integer; var cant:integer); {revisar}
begin
	if (A <> nil) then begin
		if (A^.dato.cod_producto > cod_1) and (A^.dato.cod_producto < cod_2) then begin
			cant:=cant+1;
			if (A^.HI <> nil) then
				buscar_medio (A^.HI,cod_1,cod_2,cant)
			else
				if (A^.HD <> nil) then
					buscar_medio (A^.HD,cod_1,cod_2,cant);
		end
		else begin
			if (A^.HI <> nil) then
				buscar_medio (A^.HI,cod_1,cod_2,cant)
			else
				if (A^.HD <> nil) then
					buscar_medio (A^.HD,cod_1,cod_2,cant);
		end;
	end;
end;
					
var {PP}
	A:arbol;
	cod_max,max,cod,cod_2,cod_3,cant,cant_2:integer;
begin
	max:=-999; cod_max:=0; cant:=0; cant_2:=0;
	cargarArbol (A);
	imprimir_arbol (A);
	buscar_max (A,cod_max,max);
	writeln ('El producto que mas se vendio es: ',cod_max);
	writeln ('');
	writeln ('Ingrese el codigo del que quiere conocer cuantos codigos menores hay: '); readln (cod);
	buscar_min (A,cod,cant);
	writeln ('La cantidad es: ',cant);
	writeln ('Ingrese los 2 codigos entre los que quiera buscar cuantos codigos hay en el medio: '); readln (cod_2); readln (cod_3);
	buscar_medio (A,cod_2,cod_3,cant_2);
	writeln ('La cantidad es: ',cant_2);
end.
