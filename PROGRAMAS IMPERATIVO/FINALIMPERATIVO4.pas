{
   FINALIMPERATIVO4.pas
   
   Copyright 2024 Diego <Diego@DESKTOP-B4BHKKN>
   
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
program PingoDiego;
Type
	recital = record
		nombre:String;
		fecha:String;
		cantCanciones:integer;
		monto:real;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:recital;
		HI:arbol;
		HD:arbol;
	end;
	lista = ^nodo_lista;
	nodo_lista = record
		dato:recital;
		sig:lista;
	end;
	
procedure leer (var R:recital);
begin
	writeln ('Ingrese el nombre de la banda: '); readln (R.nombre);
	if (R.nombre <> 'ZZZ') then begin
		writeln ('Ingrese la fecha del recital: '); readln (R.fecha);
		writeln ('Ingrese la cantidad de canciones que se tocaran: '); readln (R.cantCanciones);
		writeln ('Ingrese el monto recaudado en entradas: '); readln (R.monto);
	end;
end;
	
procedure agregarAlArbol (var A:arbol; R:recital);
begin
	if (A = nil) then begin
		new (A); A^.dato:=R; A^.Hi:=nil; A^.HD:=nil;
	end
	else begin
		if (R.monto <= A^.dato.monto) then begin
			agregarAlArbol (A^.HI,R);
		end
		else begin
			agregarAlArbol (A^.HD,R);
		end;
	end;
end;

procedure cargarArbol (var A:arbol);
var
	R:recital;
begin
	leer (R);
	while (R.nombre <> 'ZZZ') do begin
		agregarAlArbol (A,R);
		leer (R);
	end;
end;

procedure agregarAdelante (var L:lista; R:recital);
var
	aux:lista;
begin
	if (L = nil) then begin
		new (l); L^.dato:=R; L^.sig:=nil;
	end
	else begin
		new (aux); aux^.dato:=R; aux^.sig:=L;
		L:=aux;
	end;
end;

procedure armarLista (A:arbol; var L:lista; V1,V2:integer); {importante}
begin
	if (A <> nil) then begin
		if (V1 <= A^.dato.monto) then
			armarLista(A^.HI,L,V1,V2);
		if (A^.dato.monto >= V1) and (A^.dato.monto <= V2) then begin
			agregarAdelante (L,A^.dato);
		end;
		if (V2 >= A^.dato.monto) then
			armarLista(A^.HD,L,V1,V2);
	end;
end;

procedure recitalesCon12Canciones (L:lista; var cant:integer);
begin
	if (L <> nil) then begin
		if (L^.dato.cantCanciones > 12) then begin
			cant:=cant+1;
		end;
		recitalesCon12Canciones (L^.sig,cant);
	end;
end;

procedure imprimirLista (L:lista);
begin
	while (L <> nil) do begin
		writeln (L^.dato.monto:0:2);
		writeln (L^.dato.nombre);
		L:=L^.sig;
	end;
end;

procedure imprimirArbol (A:arbol);
begin
	if (A <> nil) then begin
		imprimirArbol (A^.HI);
		writeln (A^.dato.monto:0:2);
		imprimirArbol (A^.HD);
	end;
end;

var
	A:arbol; L:lista; V1,V2,cant:integer;
begin
	A:=nil; L:=nil; cant:=0;
	cargarArbol (A);
	writeln ('Ingrese los 2 valores de recaudacion entre los que desea buscar recitales: (De menor a mayor)'); readln (V1); readln (V2);
	armarLista (A,L,V1,V2);
	recitalesCon12Canciones (L,cant);
	imprimirArbol (A);
	writeln ('----------------------------------------------');
	imprimirLista (L);
	writeln ('----------------------------------------------');
	writeln ('Cantidad de recitales con mas de 12 canciones: ',cant);
end.
