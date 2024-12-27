{
   PRACTICA3_IMPERATIVO_P3.pas
   
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
program alumnos;
Type
	arbol=^nodo_arbol;

	lista=^nodo_lista;
	
	lista_b=^nodo_lista_b;
	
	datos_b = record {datos lista B}
		DNI:integer;
		anio:integer;
	end;
	
	nodo_lista_b = record {lista inciso B}
		dato:datos_b;
		sig:lista_b;
	end;

	datos = record {arbol}
		legajo:integer;
		DNI:integer;
		anio_ingreso:integer;
		finales:lista;
	end;
	
	datos_lista = record {lista dentro del arbol}
		cod:integer;
		nota:real;
	end;
	
	nodo_lista = record {lista}
		dato:datos_lista;
		sig:lista;
	end;
	
	nodo_arbol = record {arbol}
		dato:datos;
		HI:arbol;
		HD:arbol;
	end;

procedure leer (var D:datos);
var
	aux:lista;
	cod_aux:integer;
	nota_aux:real;
begin
	writeln ('Ingrese el numero de legajo: '); readln (D.legajo);
	if (D.legajo <> 0) then begin
		writeln ('Ingrese el DNI: '); readln (D.DNI);
		writeln ('Ingrese el anio de ingreso: '); readln (D.anio_ingreso);
		writeln ('Ingrese el codigo de la materia: '); readln (cod_aux);
		while (cod_aux <> -1) do begin
			writeln ('Ingrese la nota: '); readln (nota_aux);
			new (aux); aux^.dato.cod:=cod_aux; aux^.dato.nota:=nota_aux; aux^.sig:=nil;
			if (D.finales = nil) then
				D.finales:=aux
			else begin
				aux^.sig:=D.finales;
				D.finales:=aux;
			end;
			writeln ('Ingrese el codigo de la materia: '); readln (cod_aux);
		end;
	end;
end;

procedure agregar (var A:arbol; D:datos);
begin
	if (A = nil) then begin
		new (A); A^.dato:=D; A^.HI:=nil; A^.HD:=nil;
	end
	else begin
		if (D.legajo <= A^.dato.legajo) then
			agregar (A^.HI,D);
		if (D.legajo > A^.dato.legajo) then
			agregar (A^.HD,D);
	end;
end;
		

procedure cargarArbol (var A:arbol);
var
	D:datos;
begin
	leer (D);
	while (D.legajo <> 0) do begin
		D.finales:=nil;
		agregar (A,D);
		leer (D);
	end;
end;

procedure crearLista (var L:lista_b; DNI:integer; anio:integer);
var
	aux:lista_b;
begin
	new (aux); aux^.dato.DNI:=DNI; aux^.dato.anio:=anio; aux^.sig:=nil;
	if (L = nil) then begin
		L:=aux;
	end
	else begin
		aux^.sig:=L;
		L:=aux;
	end;
end;
		

procedure cargarLista_b (A:arbol; var L:lista_b; valor:integer);
begin
	if (A <> nil) then begin
		if (A^.HI <> nil) then
			cargarLista_b (A^.HI,L,valor);
		if (A^.dato.legajo < valor) then
			crearLista (L, A^.dato.DNI, A^.dato.anio_ingreso);
		if (A^.HD <> nil) then
			cargarLista_b (A^.HD,L,valor);
	end;
end;

procedure buscar_max_legajo (A:arbol; var max:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.legajo >= max) then
			max:=A^.dato.legajo;
		if (A^.dato.legajo <= max) then begin
			buscar_max_legajo (A^.HD,max);
		end
		else begin
			buscar_max_legajo (A^.HI,max);
		end;
	end;
end;

procedure buscar_max_DNI (A:arbol; var max:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.DNI >= max) then
			max:=A^.dato.DNI;
		if (A^.dato.DNI <= max) then begin
			buscar_max_DNI (A^.HD,max);
		end
		else begin
			buscar_max_DNI (A^.HI,max);
		end;
	end;
end;

procedure cant_impares (A:arbol; var cant:integer);
begin
	if (A <> nil) then begin
		if (A^.dato.legajo mod 2 <> 0) then
			cant:=cant+1;
		if (A^.HI <> nil) then
			cant_impares (A^.HI,cant);
		if (A^.HD <> nil) then
			cant_impares (A^.HD,cant);
	end;
end;

procedure promedio (A:arbol; var leg:integer; var prom_max:real);
var
	L2:lista;
	prom:real;
	cant:integer;
begin
	if (A <> nil) then begin
		if (A^.dato.finales <> nil) then begin
			L2:=A^.dato.finales;
			prom:=0;
			cant:=0;
			while (L2 <> nil) do begin
				prom:=prom+L2^.dato.nota;
				cant:=cant+1;
				L2:=L2^.sig;
			end;
			if (prom / cant >= prom_max) then begin
				prom_max:=prom / cant;
				leg:=A^.dato.legajo;
			end;
		end
		else begin
			if (A^.HI <> nil) then
				promedio (A^.HI,leg,prom_max);
			if (A^.HD <> nil) then
				promedio (A^.HD,leg,prom_max);
		end;
	end;
end;
			
var
	A:arbol;
	LB:lista_b;
	leg,cant,max_DNI,valor,max_leg:integer;
	prom_max:real;
begin
	A:=nil; LB:=nil; cant:=0; leg:=0; prom_max:=-1; max_leg:=-1;
	cargarArbol (A);
	writeln ('Ingrese el valor apartir del cual se creara la lista: '); readln (valor);
	cargarLista_b (A,LB,valor);
	buscar_max_legajo (A,max_leg);
	writeln ('El legajo mas grande es: ',max_leg);
	buscar_max_DNI (A,max_DNI);
	writeln ('El DNI mas grande es: ',max_DNI);
	cant_impares (A,cant);
	writeln ('La cantidad de legajos impares es: ',cant);
	promedio (A,leg,prom_max);
	writeln ('El legajo con mayor promedio es: ',leg,' con el promedio: ',prom_max:0:2);
end.


	{promedio (A,cant_notas,cod_aux,leg,prom,prom_aux,prom_max);
	writeln ('El legajo del alumno con mayor promedio es: ',leg,' con el promedio: ',prom_max);
end.











procedure promedio (A:arbol; var cant_notas,cod_aux,leg:integer; var prom,prom_aux,prom_max:real);
begin
	if (A <> nil) then begin
		if ((A^.dato.finales <> nil) and (A^.dato.finales^.dato.cod = cod_aux)) then begin
			prom:=prom+A^.dato.finales^.dato.nota+prom_aux;
			cant_notas:=cant_notas+1;
			promedio (A^.HI,cant_notas,cod_aux,leg,prom,prom_aux,prom_max);
			prom:=prom / cant_notas;
			if (prom >= prom_max) then begin
				leg:=A^.dato.legajo;
				prom_max:=prom;
			end;
			prom:=0;
			prom_aux:=0;
			cod_aux:=0;
		end
		else begin
			if (A^.HI <> nil) then begin
				cod_aux:=A^.dato.finales^.dato.cod;
				prom_aux:=A^.dato.finales^.dato.nota;
				promedio (A^.HI,cant_notas,cod_aux,leg,prom,prom_aux,prom_max);
			end;
			if (A^.HD <> nil) then begin
				cod_aux:=A^.dato.finales^.dato.cod;
				prom_aux:=A^.dato.finales^.dato.nota;
				promedio (A^.HD,cant_notas,cod_aux,leg,prom,prom_aux,prom_max);
			end;
		end;
	end;
end;}
			
			
			
			
			
			
			
			
