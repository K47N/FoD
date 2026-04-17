program untitled;
Type archivo= file of integer;
var
arc_logico: archivo;
arc_fisico: string[12];
cant_num:integer;
nums_menores: integer;
promedio: real;
num: integer;

BEGIN
cant_num:=0;
nums_menores:=0;
promedio:=0;
write('ingresar nombre del archivo: ');
read(arc_fisico);
assign(arc_logico, arc_fisico);
reset(arc_logico);
while not eof(arc_logico) do begin 
 read(arc_logico, num);
 promedio:= promedio + num;
 cant_num:=cant_num + 1;
 if(num<15000) then
  nums_menores:= nums_menores + 1;
 writeln(num);
end;
promedio:= promedio / cant_num;
writeln('numeros menores a 15000: ', nums_menores);
writeln('promedio de los numeros del archivo: ', promedio);
END.

