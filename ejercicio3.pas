program ejercicio3;
const
 FIN = 'fin';
  type
    empleado=record
     num: integer;
     apellido: string [15];
     nomb: string [15];
     edad: integer;
     DNI: integer;
     end;
    archivo = file of empleado;
procedure leerEmp (var emp: empleado);
begin
 writeln('ingrese el apellido del empleado:  ');
 readln(emp.apellido);
 if(emp.apellido <> FIN) then begin
   writeln('ingrese el nombre:  ');
   readln(emp.nomb);
   writeln('ingrese el numero de empleado:  ');
   readln(emp.num);
   writeln('ingrese el dni o 0 si no se dispone:  ');
   readln(emp.dni);
   writeln('ingrese edad:  ');
   readln(emp.edad);
 end;
end;
procedure cargarArchivo (var arch: archivo);
var 
 emp: empleado;
begin
 reset(arch);
 seek(arch,filesize(arch));
 leerEmp(emp);
 while(emp.apellido <> FIN) do begin
  write(arch, emp);
  leerEmp(emp); 
 end;
close(arch);
end;
procedure mostrarEmp(emp:empleado);
begin
 writeln('nombre: ', emp.nomb,' ', emp.apellido,', edad: ', emp.edad,', numero: ', emp.num,', dni: ', emp.DNI);
end;

procedure buscarEmpleado (var arch: archivo; nomb_ap: string);
var 
 emp: empleado;
 coincide: boolean;
begin
 reset(arch);
 coincide:=False;
 writeln('el dato coincide con:  ');
 while not eof(arch) do begin
  read(arch,emp);
  if(emp.nomb = nomb_ap) or (emp.apellido = nomb_ap)then 
    coincide:=True;
    mostrarEmp(emp);
 end;
 if not(coincide) then
   writeln('no se encontraron coincidencias');
 close(arch);
end;
procedure imprimirEmpleados (var arch: archivo);
var
 emp: empleado;
begin
 reset(arch);
 while not eof(arch) do begin
  read(arch,emp);
  mostrarEmp(emp);
 end;
close(arch);
end;
procedure porJubilar (var arch: archivo);
var
 emp: empleado;
begin
 reset(arch);
 while not eof(arch) do begin
   read(arch,emp);
   if(emp.edad>70) then
     mostrarEmp(emp);
 end;
 close(arch);
end;


var
arch_emp:archivo;
nomb_fisico: string[15];
nom_ap: string[15];
opcion: integer;
BEGIN
 writeln('ingrese nombre del archivo:  ');
 readln(nomb_fisico);
 assign(arch_emp, nomb_fisico);
 writeln('MENU:   ');
 writeln('opcion 1: crear archivo binario de empleados. ');
 writeln('opcion 2: mostrar informacion de empleados. ');
 readln(opcion);
 case opcion of 
  1: begin //inciso a
    writeln('ingresaste opcion 1');
    rewrite(arch_emp);
    close(arch_emp);
    cargarArchivo(arch_emp);
    end;
  2: begin // inciso b
    writeln('ingresaste opcion 2');
    writeln('ingrese nombre o apellido de empleados que busca informacion');
    readln(nom_ap);
    buscarEmpleado(arch_emp,nom_ap); //inciso b i
    writeln('Listado de empleados: ');
    imprimirEmpleados(arch_emp); //inciso b ii
    porJubilar(arch_emp);// inciso b iii
    end;
    

end;

END.

