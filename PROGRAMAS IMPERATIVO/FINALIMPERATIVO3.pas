{
   FINALIMPERATIVO3.pas
   
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
program FINAL3;
Type
	categorias=0..5; meses=1..12; dias=1..31;
	direccion = record
		numCalle:integer;
		numAltura:integer;
	end;
	denuncia = record
		categoria:categorias;
		dni:integer;
		residencia:direccion;
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
	lista = ^nodo_l;
	total = record
		calle:integer;
		denunciasTotales:integer;
		denunciasJulio:integer;
	end;
	nodo_l = record
		dato:total;
		sig:lista;
	end;
	
procedure inicializarVector (var V:Vector);
var
	i:integer;
begin
	for i:=1 to 5 do begin
		V[i]:=nil
	end;
end;
		
procedure leer (var D:denuncia);
begin
	writeln ('Ingrese su DNI: '); readln (D.dni);
	if (D.dni <> 0) then begin
		writeln ('Ingrese la categoria de la denuncia: '); readln (D.categoria);
		writeln ('Ingrese la residencia del denunciante: (numero de calle y numero de altura)'); readln (D.residencia.numCalle); readln (D.residencia.numAltura);
		writeln ('Ingrese el mes, dia y hora de la denuncia: '); readln (D.mes); readln (D.dia); readln (D.hora);
	end;
end;

procedure agregarOrdenado (var A:arbol; D:denuncia);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.residencia.numCalle <= A^.dato.residencia.numCalle) then begin
			agregarOrdenado (A^.HI,D);
		end
		else begin
			agregarOrdenado (A^.HD,D);
		end;
	end;
end;

procedure armarVectorArboles (var V:Vector);
var
	D:denuncia;
begin
	leer (D);
	while (D.dni <> 0) do begin
		agregarOrdenado (V[D.categoria],D);
		leer (D);
	end;
end;

procedure recorrerLista (var L:lista; mes,calle:integer);
var
	aux,act,ant:lista;
begin
	if (L = nil) then begin
		new (L); L^.dato.denunciasTotales:=1; L^.dato.calle:=calle; L^.sig:=nil;
		if (mes = 7) then begin
			L^.dato.denunciasJulio:=1;
		end
		else begin
			L^.dato.denunciasJulio:=0;
		end;
	end
	else begin
		act:=L;
		ant:=L;
		while (act <> nil) and (act^.dato.calle <> calle) do begin
			ant:=act;
			act:=act^.sig;
		end;
		if (L = act) or (act^.dato.calle = calle) then begin
			act^.dato.denunciasTotales:=act^.dato.denunciasTotales+1;
			if (mes = 7) then begin
				act^.dato.denunciasJulio:=act^.dato.denunciasJulio+1;
			end;
		end
		else begin
			new (aux); aux^.dato.calle:=calle; aux^.dato.denunciasTotales:=1; aux^.sig:=nil;
			if (mes = 7) then begin
				aux^.dato.denunciasJulio:=1;
			end
			else begin
				aux^.dato.denunciasJulio:=0;
			end;
			ant^.sig:=aux;
		end;
	end;
end;

procedure recorrerArbol (A:arbol; var L:lista);
begin
	if (A <> nil) then begin
		recorrerArbol (A^.HI,L);
		recorrerLista (L,A^.dato.mes,A^.dato.residencia.numCalle);
		recorrerArbol (A^.HD,L);
	end;
end;

procedure recorrerVector (V:Vector; var L:lista);
var
	i:integer;
begin
	for i:=1 to 5 do begin
		recorrerArbol (V[i],L);
	end;
end;

procedure buscarMaximo (L:lista; var calle,denuncias:integer);
begin
	if (L^.sig <> nil) then begin
		if (L^.dato.denunciasTotales > denuncias) then begin
			calle:=L^.dato.calle;
			denuncias:=L^.dato.denunciasTotales;
		end;
		buscarMaximo (L^.sig,calle,denuncias);
	end;
end;

procedure imprimirLista (L:lista);
begin
	while (L <> nil) do begin
		writeln (L^.dato.calle);
		writeln (L^.dato.denunciasTotales);
		L:=L^.sig;
	end;
end;

var
	L:lista; V:Vector;
	calle,denuncias:integer;
begin
	L:=nil; calle:=0; denuncias:=-1;
	inicializarVector (V);
	armarVectorArboles (V);
	recorrerVector (V,L);
	imprimirLista (L);
end.
