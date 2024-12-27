{
   PRACTICA2_IMPERATIVO_P1.pas
   
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
program modulos;
Type
	lista=^nodo;
	
	nodo = record
		dato:string;
		sig:lista;
	end;
	
	Vchars = array [1..10] of string;
	
procedure secuencia (var V:Vchars; aux:integer);
var
	caracter:string;
begin
	aux:=aux+1;
	writeln ('Ingrese el caracter: '); readln (caracter);
	V[aux]:=caracter;
	if (aux <= 10) and (caracter <> '.') then
		secuencia (V,aux)
end;
	
procedure imprimir_vector (V:Vchars);
var
	i:integer;
begin
	for i:=1 to 10 do begin
		writeln ('La posicion numero: ',i,' contiene: ',V[i]);
	end;
end;
	
procedure imprimir_recursivo (V:Vchars; aux:integer);
begin
	aux:=aux+1;
	if (aux <=10) then begin
		writeln ('La posicion numero: ',aux,' contiene: ',V[aux]);
		imprimir_recursivo (V,aux);
	end;
end;

procedure leer_recursivo (var cantidad:integer);
var
	dato:string;
begin
	writeln ('Ingrese el character (lectura normal): '); readln (dato);
		if (dato <> '.') then begin
			cantidad:=cantidad+1;
			leer_recursivo (cantidad);
		end
		else begin
			cantidad:=cantidad+1;
		end;
end;

procedure lista_recursiva (var L:lista);
var
	caracter:string;
	aux,L2:lista;
begin
	writeln ('Ingrese el character (lista): '); readln (caracter);
	new (aux); aux^.dato:=caracter; aux^.sig:=nil; L2:=L;
	if (caracter <> '.') then begin
		if (L = nil) then begin
			L:=aux;
		end
		else begin
			while (L2^.sig <> nil) do begin
				L2:=L2^.sig;
			end;
			L2^.sig:=aux;
		end;
		lista_recursiva	(L);
	end
	else begin
		while (L2^.sig <> nil) do begin
			L2:=L2^.sig;
		end;
		L2^.sig:=aux;
	end;
end;
		

var
	V:Vchars;
	aux,cantidad:integer;
	L:lista;
begin
	aux:=0; cantidad:=0; L:=nil;
	lista_recursiva (L);
	leer_recursivo (cantidad);
	writeln ('La cantidad total fue de: ',cantidad);
	secuencia (V,aux);
	imprimir_recursivo (V,aux);
end.
