{
   PRACTICA_1_PUNTO_1.pas
   
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
program ejercicio_1;

Type 
	lista=^nodo;
	
	limite=1..36;
	
	materia = record
		aprobado:string;
		nota:real;
	end;
	
	Vcontador = array [limite] of materia;
	
	datos = record
		apellido:string;
		numero_alu:integer;
		anio_ingreso:integer;
		materias:Vcontador;
		dimL:integer;
	end;
	
	nodo = record
		dato:datos;
		sig:lista;
	end;
	
procedure cargarVector (var V:Vcontador);
var i:integer;
begin
	for i:=1 to 36 do begin
		V[i]:=0;
	end
end;


procedure leerMateria (var materia:record);
var
	situacion:string;
begin
	writeln ('¿El alunno esta aprobado? si o no'); readln (situacion)
		if (situacion = 'Si') then begin
			materia.aprobado:='Aprobado';
		end
		else begin
			materia.aprobado:='Desaprobado';
		end;
		writeln ('Ingrese la nota');
		readln (materia.nota);
end

procedure cargarContador (var V:Vcontador, var D:datos);
var
	M:materia;
begin
	D.dimL:=1;
	leermateria(M);
	while (D.dimL <= 36) and (V.materia.nota <> -1) do begin
		V[D.dimL]:= M;
		leermateria(M);
		D.dimL:=D.dimL+1;
	end;
end;
		
		
	
procedure leer (var D:datos);
var
begin
	writeln ('Ingrese el apeliido:') readln (D.apeliido);
	readln (D.numero_alu);
	readln (D.anio_ingreso);
	


		

BEGIN
	
	
END.
