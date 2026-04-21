program ejercicio5_prac1;
  type
     celulares=record
       cod: Integer;
       nomb:String[20];
       desc:String;
       marca:String[20];
       precio:Integer;
       stock_min:Integer;
       stock_disp:Integer;
     end;
    arch_celulares= file of celulares;
procedure leerCelular (var celu: celular; texto:Text);
begin
 read(texto, celu.cod, celu.precio, celu.marca);
 read(texto, celu.stock_disp, celu.stock_min, celu.desc);
 read(texto, celu.nomb);
end;

procedure crearArchivo(var arch:arch_celulares);
var
 celu:celulares;
 text1:Text;
 nomb_texto: String[20];
begin
 writeln('Ingrese nombre de archivo de carga.  ');
 readln(nomb_texto);
 assign(text1,nomb_texto);
 rewrite(arch);
 reset(text1);
 while not eof(text1) do begin
    leerCelular(celu,text1);
    write(arch,celu);
 end;
 close(arch);
 close(text1);
end;



var
 arch:arch_celulares;
 text1: Texto;
 opcion:Integer;
 nomb_arch:String[20];
BEGIN
 writeln('MENU:      ');
 writeln('opcion 1: Crear archivos de celulares.   ');
 writeln('opcion 2: Imprimir todos los celulares con stock menor al minimo.  ');
 writeln('opcion 3: Imprimir celulares con coincidencia en descripcion.  ');
 writeln('opcion 4: Crear archivo de texto.  ');
 readln(opcion);
 writeln('Ingrese nombre del archivo bianario.   ');
 readln(nomb_arch);
 assign(arch,nomb_arch);
 case opcion of
 1. begin
    writeln('');
    crearArchivo(arch);
 end;
END.

