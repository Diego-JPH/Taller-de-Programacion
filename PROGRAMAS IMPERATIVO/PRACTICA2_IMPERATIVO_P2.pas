{
   PRACTICA2_IMPERATIVO_P2.pas
   
   Copyright 2023 alumnos <alumnos@LAB09-01>
   
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
program asd;

procedure descomponer (num:integer);
begin
	if (num >= 10) then begin
		descomponer (num div 10);
		writeln (num mod 10);
	end
	else begin
		writeln (num mod 10)
	end;
end;

procedure leer_recursivo (num:integer);
begin
	writeln ('Ingrese el numero: '); readln (num);
	if (num <> 0) then begin
		descomponer (num);
		leer_recursivo (num);
	end;
end;

var
	num:integer;
begin
	leer_recursivo (num);
end.
	
		
