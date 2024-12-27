{
   FINALIMPERATIVO2.pas
   
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
program final2;
Type
	ids=1..5; flores=0..10; papeles=0..10; calles=1..100; avenidas=1..100;
	mensaje = record
		id:ids;
		flor:flores;
		papel:papeles;
		calle:calles;
		avenida:avenidas;
	end;
	arbol = ^nodo_arbol;
	nodo_arbol = record
		dato:mensaje;
		HI:arbol;
		HD:arbol;
	end;
	Vector = array [ids] of arbol;
	
	info_lista = record
		avenida:avenidas;
		totalFlores:integer;
		cantEsquinasConCeroPapeles:integer;
	end;
	lista = ^nodo_lista;
	nodo_lista = record
		dato:info_lista;
		sig:lista;
	end;
	
	arbol_lista = ^nodo_arbol_lista;
	
	nodo_arbol_lista = record
		dato:info_lista;
		HI:arbol_lista;
		HD:arbol_lista;
	end;
	
procedure inicializarVector (var V:Vector);
var
	i:integer;
begin
	for i:=1 to 5 do begin
		V[i]:=nil
	end;
end;
	
procedure leer (var M:mensaje);
begin
	writeln ('Ingrese el id del robot: '); readln (M.id);
	writeln ('Ingrese la cantidad de flores recolectadas: '); readln (M.flor);
	writeln ('Ingrese la cantidad de papeles recolectadas: '); readln (M.papel);
	writeln ('Ingrese la calle: '); readln (M.calle);
	writeln ('Ingrese la avenida: '); readln (M.avenida);
end;

procedure agregarAlArbol (var A:arbol; M:mensaje);
begin
	if (A = nil) then begin
		new (A); A^.dato:=M; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (M.avenida <= A^.dato.avenida) then begin
			agregarAlArbol (A^.HI,M);
		end
		else begin
			agregarAlArbol (A^.HD,M);
		end;
	end;
end;

procedure cargarVector (var V:Vector);
var
	M:mensaje; i:integer;
begin
	inicializarVector (V);
	for i:=1 to 3 do begin
		leer (M);
		agregarAlArbol (V[M.id],M);
	end;
end;

procedure recorrerArbol (A:arbol; var L:lista);
var
	aux,L2:lista;
begin
	if (A <> nil) then begin
		recorrerArbol (A^.HI,L);
		if (L = nil) then begin
			new (L); L^.dato.avenida:=A^.dato.avenida; L^.sig:=nil;
		end
		else begin
			L2:=L;
			while (L2^.sig <> nil) and (L2^.dato.avenida <> A^.dato.avenida) do begin
				L2:=L2^.sig;
			end;
			if (L2^.dato.avenida = A^.dato.avenida) then begin
				L2^.dato.totalFlores:=L2^.dato.totalFlores+A^.dato.flor;
				if (A^.dato.papel = 0) then begin
					L2^.dato.cantEsquinasConCeroPapeles:=L2^.dato.cantEsquinasConCeroPapeles+1;
				end;
			end
			else begin
				new (aux); aux^.dato.avenida:=A^.dato.avenida; aux^.sig:=nil;
				L2^.sig:=aux;
			end;
		end;
		recorrerArbol (A^.HD,L);
	end;
end;

procedure armarLista (V:Vector; var L:lista);
var
	i:integer;
begin
	for i:=1 to 5 do begin
		recorrerArbol (V[i],L);
	end;
end;

procedure agregarAlArbol_lista (var A:arbol_lista; L:lista);
begin
	if (A = nil) then begin
		new (A); A^.dato:=L^.dato; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (L^.dato.totalFlores <= A^.dato.totalFlores) then begin
			agregarAlArbol_lista (A^.HI,L);
		end
		else begin
			agregarAlArbol_lista (A^.HD,L);
		end;
	end;
end;

procedure arbolDeLista (L:lista; var A:arbol_lista);
begin
	while (L <> nil) do begin
		agregarAlArbol_lista (A,L);
		L:=L^.sig;
	end;
end;

procedure imprimirLista (L:lista);
begin
	while (L <> nil) do begin
		writeln (L^.dato.avenida);
		writeln (L^.dato.totalFlores);
		L:=L^.sig;
	end;
end;

procedure imprimirArbol (A:arbol);
begin
	if (A <> nil) then begin
		imprimirArbol (A^.HI);
		writeln (A^.dato.id);
		imprimirArbol (A^.HD);
	end;
end;

var
	V:Vector; L:lista; A:arbol_lista; i:integer;
begin
	L:=nil; A:=nil;
	cargarVector (V);
	armarLista (V,L);
	arbolDeLista (L,A);
	writeln ('-------------------------------------------');
	imprimirLista (L);
	writeln ('-------------------------------------------');
	for i:=1 to 5 do begin
		imprimirArbol (V[i]);
	end;
end.
