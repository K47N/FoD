program ejercicio1FoD;
Type archivo= file of integer;
var 
arc_logico: archivo;
nro: integer;
arc_fisico: string[12];
procedure mostrar_archivo(var arc_logico: archivo);
var 
 nro: integer;
begin
reset(arc_logico);
while not eof(arc_logico) do begin
  read(arc_logico, nro);
  writeln(nro);
end;
 close(arc_logico);
end;
BEGIN
	write('ingrese el nombre del archivo(maximo 12 caracteres): ');
	read(arc_fisico);
	assign(arc_logico, arc_fisico);
	rewrite(arc_logico);
	write('ingrese numero para agregar: ');
	read(nro);
	while nro <> 30000 do begin
	  write(arc_logico, nro);
	  write('ingrese numero para agregar: ');
	  read(nro);
	end;
	close(arc_logico);
	mostrar_archivo(arc_logico);
END.

