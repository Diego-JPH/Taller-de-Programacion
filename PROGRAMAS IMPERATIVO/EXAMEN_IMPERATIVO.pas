{
   EXAMEN_IMPERATIVO.pas
   
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
program casa_de_comidas;
Type
	dias=1..31;
	
	{LISTA}
	
	datos_lista = record
		dia:dias;
		cant_combos:integer;
		monto:real;
	end;
	
	lista=^nodo_lista;
	
	nodo_lista = record
		dato:datos_lista;
		sig:lista;
	end;
	
	{ARBOL}
	
	datos_arbol = record
		nro_cliente:integer;
		dato:lista;
	end; 
	
	arbol=^nodo_arbol;
	
	nodo_arbol = record
		dato:datos_arbol;
		HI:arbol;
		HD:arbol;
	end;
	
procedure agregar_nodo (var L:lista; D:datos_lista);
var
	L2,aux:lista;
begin
	new (aux); aux^.dato:=D; aux^.sig:=nil;
	if (L = nil) then begin
		L:=aux;
	end
	else begin
		L2:=L;
		while (L2^.sig <> nil) do begin
			L2:=L2^.sig;
		end;
		L2^.sig:=aux;
	end;
end;

procedure agregar_arbol (var A:arbol; D:datos_arbol);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.nro_cliente = A^.dato.nro_cliente) then begin
			agregar_nodo (A^.dato.dato,D.dato^.dato);
		end
		else begin
			if (D.nro_cliente < A^.dato.nro_cliente) then
				agregar_arbol (A^.HI,D)
			else
				agregar_arbol (A^.HD,D);
		end;
	end;
end;
	
procedure leer (var D:datos_arbol);
begin
	writeln ('Ingrese el nro_cliente: '); readln (D.nro_cliente);
	if (D.nro_cliente <> 0) then begin
		new (D.dato);
		writeln ('Ingrese el dia: '); readln (D.dato^.dato.dia);
		writeln ('Ingrese la cantidad de combos comprados: '); readln (D.dato^.dato.cant_combos);
		writeln ('Ingrese el monto total: '); readln (D.dato^.dato.monto);
	end;
end;

procedure cargarArbol (var A:arbol);
var
	D:datos_arbol;
begin
	leer (D);
	while (D.nro_cliente <> 0) do begin
		agregar_arbol (A,D);
		leer (D);
	end;
end;

procedure buscar_cliente (A:arbol; nro:integer; var L:lista);
var
	aux:lista;
begin
	if (A <> nil) then begin
		if (A^.dato.nro_cliente = nro) then begin
			while (A^.dato.dato <> nil) do begin
				new (aux); aux^.dato:=A^.dato.dato^.dato; aux^.sig:=nil;
				if (L = nil) then begin
					L:=aux;
				end
				else begin
					aux^.sig:=L;
					L:=aux;
				end;
				A^.dato.dato:=A^.dato.dato^.sig;
			end;
		end
		else begin
			if (A^.dato.nro_cliente < nro) then
				buscar_cliente (A^.HI,nro,L)
			else
				buscar_cliente (A^.HD,nro,L);
		end;
	end;
end;

procedure imprimir_lista (L:lista);
var
	i:integer;
begin
	if (L <> nil) then begin
		i:=1;
		while (L <> nil) do begin
			writeln ('La compra numero: ',i,' contiene: ');
			writeln ('Dia: ',L^.dato.dia);
			writeln ('Cantidad de combos: ',L^.dato.cant_combos);
			writeln ('Monto: ',L^.dato.monto:0:2);
			i:=i+1;
			L:=L^.sig;
		end;
	end;
end;

procedure calcular_monto_total (L:lista; var total:real);
begin
	if (L <> nil) then begin
		total:=total+L^.dato.monto;
		calcular_monto_total (L^.sig,total);
	end;
end;

var
	A:arbol;
	L_busqueda:lista;
	nro:integer;
	total:real;
begin
	A:=nil; L_busqueda:=nil; total:=0;
	cargarArbol (A);
	writeln ('Ingrese el nro_cliente a buscar: '); readln (nro);
	buscar_cliente (A,nro,L_busqueda);
	imprimir_lista (L_busqueda);
	calcular_monto_total (L_busqueda,total);
	writeln ('El monto total es: ',total:0:2);
end.
		
	
