program ejercicio3;
const
 FIN = 'fin';
  type
    empleado=record
     cod: integer;
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
   writeln('ingrese el codigo del empleado:  ');
   readln(emp.cod);
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
 writeln('nombre: ', emp.nomb,' ', emp.apellido,', edad: ', emp.edad,', codigo: ', emp.cod,', dni: ', emp.DNI);
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

procedure existeEmpleado (var arch:archivo; cod: integer; var existe: boolean);
var
 emp:empleado;
begin
 existe:=false;
 reset(arch);
 while not eof(arch) and (not existe) do begin
  read(arch,emp);
  if(emp.cod = cod) then
    existe:= true;
end;
close(arch);
end;

procedure agregar (var arch:archivo);
var
 ok:boolean;
 emp: empleado;
begin
 ok:=false;
 leerEmp(emp);
 existeEmpleado(arch,emp.cod,ok);
 reset(arch);
 if(not ok) then begin
  seek(arch,filesize(arch));
  write(arch,emp);
  writeln('empleado ingresado con exito');
 end;
 close(arch);
end;

procedure modificarEdad (var arch: archivo; cod: integer);
var 
 edad: integer;
 emp: empleado;
begin
 reset(arch);
 writeln('ingrese la nueva edad: ');
 readln(edad);
 read(arch,emp);
 while not eof(arch) and (emp.cod<>cod) do 
  read(arch,emp);
 if(emp.cod = cod) then begin
  emp.edad:=edad;
  seek(arch,filepos(arch)-1);
  write(arch,emp);
  writeln('cambios guardados con exito.');
  writeln('los datos del empleado quedaron guardados: ');
  mostrarEmp(emp);
 end
 else 
   writeln('empleado no encontrado.');
 close(arch);
end;




var
arch_emp:archivo;
nomb_fisico: string[15];
nom_ap: string[15];
opcion: integer;
cant_emp: integer;
cod_emp: integer;
BEGIN
 writeln('ingrese nombre del archivo:  ');
 readln(nomb_fisico);
 assign(arch_emp, nomb_fisico);
 writeln('MENU:   ');
 writeln('opcion 1: crear archivo binario de empleados. ');
 writeln('opcion 2: buscar informacion de empleados por nombre. ');
 writeln('opcion 3: lista completa de empleados. ');
 writeln('opcion 4: informacion de empleados cercanos a jubilarse. ');
 writeln('opcion 5: agregar uno o mas empleados. ');
 readln(opcion);
 case opcion of 
  1: begin //inciso a
    writeln('ingresaste la opcion 1');
    rewrite(arch_emp);
    close(arch_emp);
    cargarArchivo(arch_emp);
    end;
  2: begin // inciso b i
    writeln('ingresaste la opcion 2');
    writeln('ingrese nombre o apellido de empleados que busca informacion ');
    readln(nom_ap);
    buscarEmpleado(arch_emp,nom_ap); //inciso b i
    end;
  3: begin
    writeln('ingresaste la opcion 3');
    writeln('Listado de empleados: ');
    imprimirEmpleados(arch_emp); //inciso b ii
    end;
  4: begin
    writeln('ingresaste la opcion 4');
    porJubilar(arch_emp);// inciso b iii
    end;
  5: begin // punto 4 a
     writeln('ingresaste la opcion 5');
     writeln('ingrese la cantidad de empleados que desee añadir. ');
     readln(cant_emp);
     while (cant_emp>0) do begin
       agregar(arch_emp);
       cant_emp:= cant_emp-1;
     end;
    end;
  6:begin//punto 4 b
    writeln('ingresaste la opcion 6');
    writeln('ingrese el codigo del empleado que busca modificar la edad: ');
    readln(cod_emp);
    modificarEdad(arch_emp,cod_emp);
   end;

end;

END.
