{
   PRACTICA2_IMPERATIVO_P5.pas
   
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


program dicotomiayrecursion;
Type
	vector = array [1..50] of integer;
	
procedure cargarVector (var V:vector);
var
	i:integer;
begin
	for i:=1 to 50 do begin
		V[i]:=i;
	end;
end;

Procedure busquedaDicotomica (v: vector; var ini,fin,medio:integer; dato:integer; var pos:integer);
begin
	if (V[medio] = dato) then
		pos:=V[medio];
	if (ini > fin) then begin
		medio:=-1;
	end
	else begin
		if (dato < V[medio]) then
			fin:=medio-1
		else
			ini:=medio+1;
		medio:=(ini+fin) div 2;
		busquedaDicotomica (v,ini,fin,medio,dato,pos);
	end;
end;
	
var
	medio,pos,dato,ini,fin:integer;
	v:vector;
begin
	ini:=1; fin:=50;
	cargarVector (V);
	readln (dato);
	medio:=(ini+fin) div 2;
	busquedaDicotomica (v,ini,fin,medio,dato,pos);
	writeln ('Tiene el valor: ',pos);
end.
		
		
