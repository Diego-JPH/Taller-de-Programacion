{
   FINALIMPERATIVO1.pas
   
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
program	finalimperativo;
Type
	meses=1..12; dias=1..31;
	
	fechas = record
		anio:integer;
		mes:meses;
		dia:dias;
	end;
	
	recital = record
		nombre:string;
		fecha:fechas;
		cantCanciones:integer;
		montoRecaudado:real;
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
	writeln ('Ingrese el nombre de la banda: ');
	readln (R.nombre);
	while (R.nombre <> 'ZZZ') do begin
		writeln ('Ingrese el anio, mes y dia del recital: (en ese orden)');
		readln (R.fecha.anio); readln (R.fecha.mes); readln (R.fecha.dia);
		writeln ('Ingrese la cantidad de canciones que se tocaran: ');
		readln (R.cantCanciones);
		writeln ('Ingrese el monto total recaudado en entradas: ');
		readln (R.montoRecaudado);
		writeln ('Ingrese el nombre de la banda: ');
		readln (R.nombre);
	end;
end;

procedure agregarAlArbol (var A:arbol; R:recital);
begin
	if (A = nil) then begin
		new (A); A^.dato:=R; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (A^.dato.montoRecaudado <= R.montoRecaudado) then begin
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

procedure agregarALaListaEnOrden (var L:lista; R:recital);
var
	ant,act,aux:lista;
begin
	if (L = nil) then begin {VACIO}
		new (L); L^.dato:=R; L^.sig:=nil;
	end
	else begin
		ant:=nil;
		act:=L;
		while (act <> nil) and (R.montoRecaudado > act^.dato.montoRecaudado) do begin
			ant:=act;
			act:=act^.sig;
		end;
		new (aux); aux^.dato:=R; aux^.sig:=nil;
		if (act = L) then begin {AL INICIO}
			aux^.sig:=L;
			L:=aux;
		end
		else begin {AL MEDIO Y FINAL}
			ant^.sig:=aux;
			aux^.sig:=act;
		end;
	end;
end;

procedure busqueda (A:arbol; V1,V2:real; var L:lista);
begin
	if (A <> nil) and (A^.dato.montoRecaudado >= V1) and (A^.dato.montoRecaudado <= V2) then begin {MAL}
		busqueda (A^.HI,V1,V2,L);
		agregarALaListaEnOrden (L,A^.dato);
		busqueda (A^.HD,V1,V2,L);
	end;
end;

procedure cantRecitales (L:lista; var cant:integer);
begin
	if (L <> nil) then begin
		if (L^.dato.cantCanciones > 12) then
			cant:=cant+1;
		cantRecitales (L^.sig,cant);
	end;
end;

procedure imprimirArbol (A:arbol);
begin
	if (A <> nil) then begin
		imprimirArbol (A^.HI);
		writeln (A^.dato.nombre);
		imprimirArbol (A^.HD);
	end;
end;

procedure imprimirLista (L:lista);
begin
	while (L <> nil) do begin
		writeln (L^.dato.nombre);
		L:=L^.sig;
	end;
end;

var
	A:arbol; L:lista; cant:integer; V1,V2:real;
begin
	A:=nil; L:=nil; cant:=0;
	cargarArbol (A);
	writeln ('Ingrese los dos montos entre los que quiere armar una lista de recitales: ');
	readln (V1); readln (V2);
	busqueda (A,V1,V2,L);
	imprimirArbol (A);
	cantRecitales (L,cant);
	writeln ('La cantidad de recitales con mas de 12 canciones es: ',cant);
end.
