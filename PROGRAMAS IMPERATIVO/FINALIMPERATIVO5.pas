{
   FINALIMPERATIVO5.pas
   
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
program FINAL5;
Type
	categorias=1..6; meses=1..12; dias=1..31;
	denuncia = record
		categoria:categorias;
		dni:integer;
		nroCalle:integer;
		nroAltura:integer;
		mes:meses;
		dia:dias;
		hora:String;
	end;
	arbol = ^nodo;
	nodo = record
		dato:denuncia;
		HI:arbol;
		HD:arbol;
	end;
	Vector = array [categorias] of arbol;
	recopilacion = record
		nro:integer;
		cantDenuncias:integer;
		denunciasJulio:integer;
	end;
	lista = ^nodo_lista;
	nodo_lista = record
		dato:
		sig:lista;
	end;
procedure leer (var D:denuncia);
begin
	writeln ('Ingrese su dni: '); readln (D.dni);
	if (D.dni <> 0) then begin
		writeln ('Ingrese la categoria de la denuncia: '); readln (D.categoria);
		writeln ('Ingrese el numero de calle: '); readln (D.nroCalle);
		writeln ('Ingrese el numero de altura: '); readln (D.nroAltura);
		writeln ('Ingrese el mes: '); readln (D.mes);
		writeln ('Ingrese el dia: '); readln (D.dia);
		writeln ('Ingrese la hora: '); readln (D.hora);
	end;
end;
procedure agregarAlArbol (var A:arbol;D:denuncia);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.nroCalle <= A^.dato.nroCalle) then begin
			agregarAlArbol (A^.HI,D);
		end
		else begin
			agregarAlArbol (A^.HD,D);
		end;
	end;
end;
procedure cargarVector (var V:Vector);
var
	D:denuncia;
begin
	leer (D);
	if (D.dni <> 0) then begin
		agregarAlArbol (V[D.categoria],D);
		leer (D);
	end;
end;
procedure agregarALaLista (nro,cantDenuncias,denunciasJulio,L);
var
	aux,L2:lista;
begin
	if (L = nil) then begin
		new(L); L^.dato.nro:=nro; L^.dato.cantDenuncias:=cantDenuncias; L^.dato.denunciasJulio:=denunciasJulio; L^.sig:=nil;
	end
	else begin
		L2:=L;
		while (L2^.sig <> nil) do begin
			L2:=L2^.sig;
		end
		new (aux); aux^.dato.nro:=nro; aux^.dato.cantDenuncias:=cantDenuncias; aux^.dato.denunciasJulio:=denunciasJulio; aux^.sig:=nil;
		L2^.sig:=aux;
	end;
end;
procedure busqueda (var L:lista;A:arbol;var nro,cantDenuncias,denunciasJulio:integer);
begin
	if (A <> nil) then begin
		busqueda (A^.HI,nro,cantDenuncias,denunciasJulio);
		if (nro = 0) then begin {primera coincidencia}
			nro:=A^.dato.nroCalle;
			cantDenuncias:=cantDenuncias+1;
			if (A^.dato.mes = 7) then
				denunciasJulio:=denunciasJulio+1;
		end
		else begin
			if (A^.dato.nroCalle = nro) then begin
				cantDenuncias:=cantDenuncias+1;
				if (A^.dato.mes = 7) then
					denunciasJulio:=denunciasJulio+1;
			end
			else begin
				agregarALaLista (nro,cantDenuncias,denunciasJulio,L);
				cantDenuncias:=0;
				denunciasJulio:=0;
				nro:=A^.dato.nroCalle;
			end;
		end;
		busqueda (A^.HD,nro,cantDenuncias,denunciasJulio);
	end;
end;
