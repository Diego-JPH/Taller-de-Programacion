{
   PRACTICA3_IMPERATIVO_P1.pas
   
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
program socios;
Type
	datos=record
	nro_socio:integer;
	nombre:string;
	edad:integer;
	end;
	
	arbol=^nodo;
	
	nodo = record
		dato:datos;
		HI:arbol;
		HD:arbol;
	end;
	
procedure leer (var D:datos);
begin
	writeln ('Ingrese el numero de socio: '); readln (D.nro_socio);
	if (D.nro_socio <> 0) then begin
		writeln ('Ingrese el nombre: '); readln (D.nombre);
		writeln ('Ingrese la edad: '); readln (D.edad);
	end;
end;

procedure agregar (var A:arbol; D:datos);
var
	aux:arbol;
begin
	if (A = nil) then begin
		new (aux); aux^.dato:=D; aux^.HI:=nil; aux^.HD:=nil;
		A:=aux;
	end
	else begin
		if (D.nro_socio <= A^.dato.nro_socio) then begin
			agregar (A^.HI,D);
		end
		else begin
			agregar (A^.HD,D);
		end;
	end;
end;

procedure cargarArbol (var A:arbol);
var
	D:datos;
begin
	leer (D);
	while (D.nro_socio <> 0) do begin
		agregar (A,D);
		leer (D);
	end;
end;

procedure socio_max (A:arbol; var max:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.nro_socio < max) then
			socio_max (A^.HD,max)
		else begin
			max:=A^.dato.nro_socio;
			socio_max (A^.HD,max);
		end;
	end;
end;

procedure socio_min (A:arbol; var min:datos);
begin
	if (A <> nil) then begin
		if (A^.dato.nro_socio <= min.nro_socio) then 
				min:=A^.dato;
		if (A^.HI <> nil) then
			socio_min (A^.HI,min);
		if (A^.HD <> nil) then
			socio_min (A^.HD,min);
	end;
end;

procedure mayor_edad (A:arbol; var num,max:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.edad > max) then begin
			max:=A^.dato.edad;
			num:=A^.dato.nro_socio;
		end;
		if (A^.HI <> nil) then
			mayor_edad (A^.HI,num,max);
		if (A^.HD <> nil) then
			mayor_edad (A^.HD,num,max);
	end;
end;

procedure aumentar_edad (A:arbol);
begin
	if (A <> nil) then begin
		A^.dato.edad:=A^.dato.edad+1;
		if (A^.HI <> nil) then
			aumentar_edad (A^.HI);
		if (A^.HD <> nil) then
			aumentar_edad (A^.HD);
	end;
end;

procedure buscar_numero (A:arbol; var ok:boolean; num:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.nro_socio = num) then begin
			ok:=true
		end
		else begin
			if (A^.HI <> nil) then
				buscar_numero (A^.HI,ok,num);
			if (A^.HD <> nil) then
				buscar_numero (A^.HD,ok,num);
		end;
	end;
end;

procedure buscar_nombre (A:arbol; var okay:boolean; nombre:string);
begin
	if (A <> nil) then begin
		if (A^.dato.nombre = nombre) then begin
			okay:=true
		end
		else begin
			if (A^.HI <> nil) then
				buscar_nombre (A^.HI,okay,nombre);
			if (A^.HD <> nil) then
				buscar_nombre (A^.HD,okay,nombre);
		end;
	end;
end;

procedure cantidad_socios (A:arbol; var cant:integer);
begin
	if (A <> nil) then begin
		cant:=cant+1;
		if (A^.HI <> nil) then
			cantidad_socios (A^.HI,cant);
		if (A^.HD <> nil) then
			cantidad_socios (A^.HD,cant);
	end;
end;
		
procedure promedio_edad (A:arbol; var suma:integer);
begin
	if (A <> nil) then begin
		suma:=suma+A^.dato.edad;
		if (A^.HI <> nil) then
			promedio_edad (A^.HI,suma);
		if (A^.HD <> nil) then
			promedio_edad (A^.HD,suma);
	end;
end;

procedure imprimir_numeros (A:arbol);
begin
	if (A <> nil) then begin
		if (A^.HI <> nil) then
			imprimir_numeros (A^.HI);
		writeln (A^.dato.nro_socio);
		if (A^.HD <> nil) then 
			imprimir_numeros (A^.HD);
	end;
end;

var
	suma,cant_s,max,cont,num,x:integer;
	ok,okay:boolean;
	nombre:string;
	A:arbol;
	D:datos;
begin
	A:=nil;
	max:=-1; D.nro_socio:=500; cont:=-1; ok:=false; okay:=false; cant_s:=0; suma:=0;
	cargarArbol (A);
	socio_max (A,max);
	writeln ('El numero de socio mas grande es: ',max);
	socio_min (A,D);
	writeln ('El nombre del socio con el numero mas pequenio es: ',D.nombre);
	mayor_edad (A,num,cont);
	writeln ('El numero de socio del socio mas viejo es: ',num);
	aumentar_edad (A);
	writeln ('Ingrese el de numero socio que quiera verificar que esta: '); readln (x);
	buscar_numero (A,ok,x);
	writeln ('El numero esta: ',ok);
	writeln ('Ingrese el nombre para ver si existe: '); readln (nombre);
	buscar_nombre (A,okay,nombre);
	writeln ('El nombre esta: ',okay);
	cantidad_socios (A,cant_s);
	writeln ('La cantidad de socios es: ',cant_s);
	promedio_edad (A,suma);
	writeln ('El promedio de edad es: ',suma / cant_s:0:2); {da un poco mas el promedio por el modulo aumentar_edad que les suma 1 a todos}
	imprimir_numeros (A); {no los devuelve ordenados, revisar si se armo bien el arbol}
end.
	






