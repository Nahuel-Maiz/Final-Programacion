unit Archivos_Proyectos;
interface
uses crt, Archivos_Clientes;
const
     nombre_arch= 'ProyectosFinalPrueba8.dat';

type
    //Crea un tipo de variable que es un string que admite solo 20 caracteres
    st20=string[40];

    //Creamos el registros con los campos que pide el ejercicio
    r_proyectos=record
                      id_proyecto: integer;
                      titulo: st20;
                      costo: real;
                      cuit: integer;
                      director: st20;
                      fecha_de_entre: string;
                      exporta: boolean;
                      estado: boolean;
    end;

    //Establecemos un tipo de archivo llamado archivo_proyectos
    //Que solamente admite registros del tipo r_proyectos
    archivo_proyectos = file of r_proyectos;

procedure abrir_proyectos(var arch:archivo_proyectos);
procedure leer_proyectos(var pos:integer; var dato_leido:r_proyectos);
procedure guardar_proyectos(var escribir_dato:r_proyectos);
procedure alta_proyecto();
procedure busqueda_id_proyecto(var buscado: integer; var posicion:integer);
procedure guardar_proyecto_en(var escribir_dato: r_proyectos; posicion: integer);
procedure baja_proyecto(var id_proyecto: integer);
procedure consultar_proyecto(var id_proyecto:integer; var reg: r_proyectos);
procedure modificar_proyecto(var id_proyecto:integer);
procedure proyectos_cliente(var buscado: integer);
procedure proyectos_rango_fechas(var fecha_inicio: string; var fecha_fin: string);

implementation

procedure abrir_proyectos(var arch:archivo_proyectos); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
begin
     assign(arch, nombre_arch);
     {$I-}  //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
            reset(arch);
     {$I-}
     if ioresult<>0 then
        rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.                   close(arch);
     //close(arch);
end;

//El procedimiento pide la posicion que se quiere leer del archivo
//Y pide una variable en donde se van a guardar esos datos que estan en el archivo
procedure leer_proyectos(var pos:integer; var dato_leido:r_proyectos); //Lee archivo de tipo texto
var
   //Como es un procedimiento para leer unicamente del archivo de proyectos
   //declaro una variable de tipo archivo_proyectos con la que van a manejar el archivo
   arch:archivo_proyectos;

begin
     //abro el archivo con el procedimiento de arriba
     abrir_proyectos(arch);
     seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el primer parametro POS
     //una vez posicionado el puntero donde queremos
     read(arch, dato_leido);       //Usamos read para leer lo que hay ahí
     close(arch);                   //termina de hacer lo que tiene que hacer y cierra el archivo
end;


//El guardar pide como parametro el registro que se desea guardar
procedure guardar_proyectos(var escribir_dato:r_proyectos);
var
   //Como es un procedimiento para guardar es unicamente del archivo de proyectos
   //declaro una variable de tipo archivo_proyectos con la que van a manejar el archivo
   arch:archivo_proyectos;

begin
     //Abre el archivo con el procedimiento que creamos
     abrir_proyectos(arch);
     //Como se va a guardar un dato nuevo queremos ir a la primer posicion vacia del archivo
     seek(arch, filesize(arch));         //Posiciona el puntero en el numero que te da la funcion filesize(arch)
     //una vez posicionado el puntero donde queremos
     write(arch, escribir_dato);       //guardamos lo que hay en escribir_dato en el archivo
     writeln('guardado');
     //Y se cierra..
     close(Arch);
end;

procedure guardar_proyecto_en(var escribir_dato: r_proyectos; posicion: integer);
var
   arch: archivo_proyectos;

    begin
        abrir_proyectos(arch);
        seek(arch, posicion);
        write(arch, escribir_dato);
        close(arch);
    end;

procedure alta_proyecto();
var
   reg: r_proyectos;
   reg2: r_clientes;
   posicion: integer;
   control: char;

begin
     writeln('Ingrese el Cuit');
     {$I-}
     readln(reg.cuit);
     {$I-}
     if (ioresult <> 0) then
     begin
          repeat
                writeln('El cuit ingresado se escribio mal');
                writeln('Escriba de nuevo el cuit pero solo con numeros');
                {$I-}
                readln(reg.cuit);
                {$I-}
          until (ioresult = 0);
     end;
     busqueda_cuit(reg.cuit, posicion);
     leer_clientes(posicion, reg2);
     if (posicion <> -1) and (reg2.estado = true)then
        begin
             writeln('Ingrese el ID del proyecto que desee dar de Alta');
             {$I-}
             readln(reg.id_proyecto);
             {$I-}
             if (ioresult <> 0) then
             begin
                  repeat
                  writeln('El ID ingresado se escribio mal');
                  writeln('Escriba de nuevo el ID pero solo con numeros');
                  {$I-}
                  readln(reg.cuit);
                  {$I-}
                  until (ioresult = 0);
             end;
             busqueda_id_proyecto(reg.id_proyecto, posicion);
             if (posicion = -1) then
                begin
                     writeln('Ingrese el Titulo');
                     readln(reg.titulo);
                     writeln('Ingrese el Costo');
                     {$I-}
                     readln(reg.costo);
                     {$I-}
                     if (ioresult <> 0) then
                     begin
                     repeat
                           writeln('Costo incorrecto, el costo solo debe tener numeros');
                           {$I-}
                           readln(reg.costo);
                           {$I-}
                     until (ioresult = 0);
                     end;
                     writeln('Ingrese el Director');
                     readln(reg.director);
                     writeln('Ingrese la Fecha de Entrega, con el formato DDMMAA');
                     readln(reg.fecha_de_entre);
                     while not (length(reg.fecha_de_entre) = 6) do
                           begin
                                writeln('fecha erroenea, ingrese nuevamente la fecha');
                                readln(reg.fecha_de_entre);
                           end;
                     insert('/', reg.fecha_de_entre, 3);
                     insert('/', reg.fecha_de_entre, 6);
                     repeat
                     writeln('Exporta, s para SI, n para NO');
                     control:= readkey;
                               keypressed;
                               case control of
                                    's': begin
                                              reg.exporta:= True;
                                         end;
                                    'n': begin
                                              reg.exporta:= False
                                         end;
                               end;
                               reg.estado:= true;
                     until (control = 's') or (control = 'n');
                     guardar_proyectos(reg);
             end
             else
                 begin
                      writeln('El ID del proyecto que ingreso ya existe');
                      leer_proyectos(posicion, reg);
                      if (reg.estado = False) then
                         begin
                              writeln('El ID del proyecto esta dado de Baja');
                              writeln('Desea darlo de Alta?');
                              repeat
                              writeln('Presione la tecla s para SI, y n para NO');
                              control:= readkey;
                              keypressed;
                              case control of
                                  's': begin
                                            reg.estado:= True;
                                            guardar_proyecto_en(reg, posicion);
                                            writeln('El ID fue dado de Alta con exito');
                                       end;
                              end;
                              until (control = 's') or (control = 'n');
                         end;
                 end;
        end
     else
         begin
              writeln('El cuit ingresado no esta asociado a ningun clientes');
              readkey;
         end;
end;

procedure busqueda_id_proyecto(var buscado: integer; var posicion:integer);
var
   reg: r_proyectos;
   arch: archivo_proyectos;
   indice: integer;

begin
     indice:= 0;
     posicion:= -1;
     abrir_proyectos(arch);
     while not eof(arch) and (posicion = -1) do
     begin
          read(arch, reg);
          if (reg.id_proyecto = buscado) then
             begin
             posicion:= indice;
             end;
          indice:= indice+1;
          seek(arch, indice);
     end;
     close(arch);
end;

procedure baja_proyecto(var id_proyecto: integer);
var
   reg: r_proyectos;
   posicion: integer;
   control: char;

begin
     busqueda_id_proyecto(id_proyecto, posicion);
     if (posicion <> -1) then
        begin
             leer_proyectos(posicion, reg);
             if (reg.estado = True) then
                begin
                writeln('Esta seguro de dar de Baja a este Proyecto?');
                repeat
                writeln('Presione la tecla s para SI, y n para NO');
                control:= readkey;
                keypressed;
                case control of
                     's': begin
                               reg.estado:= False;
                               guardar_proyecto_en(reg, posicion);
                               writeln('El Proyecto fue dado de Baja con exito');
                          end;
                end;
                until (control = 's') or (control = 'n');
                end;
        end
     else
         begin
         writeln('El ID del proyecto ingresado NO existe');
         end;
end;

procedure consultar_proyecto(var id_proyecto:integer; var reg: r_proyectos);
var
   posicion, w: integer;

begin
w:=5;
busqueda_id_proyecto(id_proyecto, posicion);
if (posicion = -1) then
   begin
   writeln('El ID del proyecto ingresado NO esta registrado o ha sido dado de baja');
   end
else
    begin
    leer_proyectos(posicion, reg);
    if (reg.estado = false) then
       begin
            writeln('El ID del proyecto ingresado NO esta registrado o ha sido dado de baja');
       end
    else
        begin
             writeln('ID de proyecto encontrado Satisfactoriamente');
             leer_proyectos(posicion, reg);
             Gotoxy (1,4);
             writeln ('|  iD del Proyecto  |  Titulo  |    Costo    |     Cuit     |    Director    |   Fecha de Entrega  |  Exporta  |');
             Gotoxy (1,5);
             Writeln ('________________________________________________________________________________________________________________');
             w:=w+1;
             Gotoxy (5,w);
             writeln(reg.id_proyecto);
             Gotoxy (23,w);
             writeln(reg.titulo);
             Gotoxy (35,w);
             writeln(reg.costo:2:2);
             Gotoxy (49,w);
             writeln(reg.cuit);
             Gotoxy (65,w);
             writeln(reg.director);
             Gotoxy (86,w);
             writeln(reg.fecha_de_entre);
             Gotoxy (104,w);
             writeln(reg.exporta);
             Writeln ('________________________________________________________________________________________________________________');
        end;
    end;
end;

procedure modificar_proyecto(var id_proyecto:integer);
var
	posicion: integer;
	opcion, opcion1: char;
    reg: r_proyectos;

begin
    busqueda_id_proyecto(id_proyecto, posicion);
    if (posicion <> -1) then
       begin
            consultar_proyecto(id_proyecto, reg);
            if (reg.estado) then
               begin
                 with reg do
                 begin
                      repeat
                      writeln('-------');
                      writeln('0) Salir');
                      writeln('1) Titulo');
                      writeln('2) Costo');
                      writeln('3) Director');
                      writeln('4) Fecha de entrega');
                      writeln('5) Exporta');
                      write('Opcion: ');
                      {$I-}
                      opcion:= readkey;
                      {$I-}
                      keypressed;
                      writeln('-------');
				      case opcion of
					      '1':begin
                                   write('Titulo: ');
                                   readln(titulo);
                                   guardar_proyecto_en(reg, posicion);
                              end;
                          '2':begin
                                   write('Costo: ');
                                   {$I-}
                                   readln(costo);
                                   {$I-}
                                   if (ioresult <> 0) then
                                   begin
                                        repeat
                                              writeln('Costo incorrecto, el costo solo debe tener numeros');
                                              {$I-}
                                              readln(costo);
                                              {$I-}
                                        until (ioresult = 0);
                                   end;
                                   guardar_proyecto_en(reg, posicion);
						      end;
					      '3':begin
                                   write('Director: ');
                                   readln(director);
                                   guardar_proyecto_en(reg, posicion);
					  	      end;
					      '4':begin
                                   write('Fecha de entrega: ');
                                   readln(fecha_de_entre);
                                    while not (length(reg.fecha_de_entre) = 6) do
                                          begin
                                               writeln('fecha erroenea, ingrese nuevamente la fecha');
                                               readln(fecha_de_entre);
                                          end;
                                          insert('/', fecha_de_entre, 3);
                                          insert('/', fecha_de_entre, 6);
                                          guardar_proyecto_en(reg, posicion);
                              end;
                          '5':begin
                                   repeat
                                   writeln('Presione s para indicar que SI, y n para indicar que NO');
                                   opcion1:= readkey;
                                   keypressed;
                                   case opcion1 of
                                        's': begin
                                                  exporta:= True;
                                                  writeln('Exporta: ');
                                                  guardar_proyecto_en(reg, posicion);
                                             end;
                                        'n': begin
                                                  exporta:= False;
                                                  writeln('Exporta: ');
                                                  guardar_proyecto_en(reg, posicion);
                                             end;
                                   end;
                                   until (opcion1 = 's') or (opcion1 = 'n');
                              end;
                       end;
                       clrscr;
                       consultar_proyecto(id_proyecto, reg);
                       Until (opcion = '0');
                       clrscr;
                 end;
               end
               else
                   begin
                        writeln('El Proyecto esta dado de Baja, desea darlo de alta?');
                        writeln('Presione s para SI, y n para NO');
                        repeat
                              opcion:= readkey;
                              keypressed;
                              case opcion of
                                   's':begin
                                            reg.estado:= True;
                                            guardar_proyecto_en(reg, posicion);
                                            writeln('El Proyecto fue dado de Alta satisfactoriamente');
                                       end;
                                   'n':begin
                                            writeln('Se ha denegado darlo de Alta');
                                       end;
                              end;
                        until (opcion = 's') or (opcion = 'n');
                   end;
       end
       else
           begin
                writeln('El ID ingresado es incorrecto, no esta registrado o ha sido dado de baja');
           end;
end;

procedure proyectos_cliente(var buscado: integer);
var
   reg: r_proyectos;
   arch: archivo_proyectos;
   indice, deter: integer;
   cont, w: integer;
   acu_costo: real;

begin
     w:=3;
     cont:= 0;
     acu_costo:= 0;
     indice:= 0;
     abrir_proyectos(arch);
     gotoxy(1,1);
     writeln('Los Proyectos del Cliente ', buscado, ' son:');
     Gotoxy (1,2);
     writeln ('|  Titulo  |  iD del Proyecto  |    Costo    |     Cuit     |    Director    |   Fecha de Entrega  |  Exporta  |');
     Gotoxy (1,3);
     Writeln ('________________________________________________________________________________________________________________');
     while not eof(arch) do
     begin
          read(arch, reg);
          if (reg.cuit = buscado) then
             begin
             Inc (w);
             deter:= deter+1;
             Gotoxy (4,w);
             writeln (reg.titulo);
             Gotoxy (17,w);
             writeln (reg.id_proyecto);
             Gotoxy (35,w);
             Writeln (reg.costo:2:2);
             Gotoxy (49,w);
             Writeln (reg.cuit);
             Gotoxy (65,w);
             writeln (reg.director);
             Gotoxy (83,w);
             writeln (reg.fecha_de_entre);
             Gotoxy(104,w);
             writeln(reg.exporta);
             Inc (w);
             Writeln ('________________________________________________________________________________________________________________');
             cont:= cont+1;
             acu_costo:= acu_costo+ reg.costo;
             end;
          indice:= indice+1;
          seek(arch, indice);
     end;
     if (deter <> 0) then
     begin
     writeln('EL cliente, ', buscado, ' tiene ', cont, ' proyectos');
     writeln('El total invertido del cliente ', buscado, ' es: $', acu_costo:2:2);
     end
     else
         begin
              clrscr;
              writeln('EL cliente, ', buscado, ' NO tiene proyectos');
         end;
     close(arch);
end;

procedure proyectos_rango_fechas(var fecha_inicio: string; var fecha_fin: string);
var
   reg: r_proyectos;
   arch: archivo_proyectos;
   indice, w: integer;
   f_i_d, f_i_m, f_i_a, f_f_d ,f_f_m, f_f_a: string;
   f_a_d, f_a_m, f_a_a: string;
   deter: integer;

begin
     deter:=0;
     w:=3;
     indice:= 0;
     abrir_proyectos(arch);
     insert('/', fecha_inicio, 3);
     insert('/', fecha_inicio, 6);
     insert('/', fecha_fin, 3);
     insert('/', fecha_fin, 6);
     Gotoxy (1,1);
     writeln('Los Proyectos entregados entre la fecha ', fecha_inicio, ' y la fecha ', fecha_fin, ' son:');
     f_i_d:= copy(fecha_inicio, 1, 2);
     f_i_m:= copy(fecha_inicio, 4, 2);
     f_i_a:= copy(fecha_inicio, 7, 2);
     f_f_d:= copy(fecha_fin, 1, 2);
     f_f_m:= copy(fecha_fin, 4, 2);
     f_f_a:= copy(fecha_fin, 7, 2);
     Gotoxy (1,2);
     writeln ('|  Titulo  |  iD del Proyecto  |    Costo    |     Cuit     |    Director    |   Fecha de Entrega  |  Exporta  |');
     Gotoxy (1,3);
     Writeln ('________________________________________________________________________________________________________________');
     while not eof(arch) do
     begin
          read(arch, reg);
          f_a_d:= copy(reg.fecha_de_entre, 1, 2);
          f_a_m:= copy(reg.fecha_de_entre, 4, 2);
          f_a_a:= copy(reg.fecha_de_entre, 7, 2);
          if (f_a_a > f_i_a) and (f_a_a < f_f_a) then
             begin
             deter:= deter+1;
             Inc (w);
             Gotoxy (4,w);
             writeln (reg.titulo);
             Gotoxy (17,w);
             writeln (reg.id_proyecto);
             Gotoxy (35,w);
             Writeln (reg.costo:2:2);
             Gotoxy (49,w);
             Writeln (reg.cuit);
             Gotoxy (65,w);
             writeln (reg.director);
             Gotoxy (83,w);
             writeln (reg.fecha_de_entre);
             Gotoxy(104,w);
             writeln(reg.exporta);
             Inc (w);
             Writeln ('________________________________________________________________________________________________________________');
             end
          else
              begin
                   if (f_a_a = f_i_a) or (f_a_a = f_f_a) then
                      begin
                           if (f_a_m > f_i_m) and (f_a_m < f_f_m) then
                              begin
                                   deter:= deter+1;
                                   Inc (w);
                                   Gotoxy (4,w);
                                   writeln (reg.titulo);
                                   Gotoxy (17,w);
                                   writeln (reg.id_proyecto);
                                   Gotoxy (35,w);
                                   Writeln (reg.costo:2:2);
                                   Gotoxy (49,w);
                                   Writeln (reg.cuit);
                                   Gotoxy (65,w);
                                   writeln (reg.director);
                                   Gotoxy (83,w);
                                   writeln (reg.fecha_de_entre);
                                   Gotoxy(104,w);
                                   writeln(reg.exporta);
                                   Inc (w);
                                   Writeln ('________________________________________________________________________________________________________________');
                              end
                           else
                               begin
                                    if (f_a_m = f_i_m) or (f_a_m = f_f_m) then
                                       begin
                                            if (f_a_d > f_i_d) and (f_a_d < f_f_d) then
                                               begin
                                                    deter:= deter+1;
                                                    Inc (w);
                                                    Gotoxy (4,w);
                                                    writeln (reg.titulo);
                                                    Gotoxy (17,w);
                                                    writeln (reg.id_proyecto);
                                                    Gotoxy (35,w);
                                                    Writeln (reg.costo:2:2);
                                                    Gotoxy (49,w);
                                                    Writeln (reg.cuit);
                                                    Gotoxy (65,w);
                                                    writeln (reg.director);
                                                    Gotoxy (83,w);
                                                    writeln (reg.fecha_de_entre);
                                                    Gotoxy(104,w);
                                                    writeln(reg.exporta);
                                                    Inc (w);
                                                    Writeln ('________________________________________________________________________________________________________________');
                                               end
                                            else
                                                begin
                                                     if (f_a_d = f_i_d) or (f_a_d = f_f_d) then
                                                        begin
                                                             deter:= deter+1;
                                                             Inc (w);
                                                             Gotoxy (4,w);
                                                             writeln (reg.titulo);
                                                             Gotoxy (17,w);
                                                             writeln (reg.id_proyecto);
                                                             Gotoxy (35,w);
                                                             Writeln (reg.costo:2:2);
                                                             Gotoxy (49,w);
                                                             Writeln (reg.cuit);
                                                             Gotoxy (65,w);
                                                             writeln (reg.director);
                                                             Gotoxy (83,w);
                                                             writeln (reg.fecha_de_entre);
                                                             Gotoxy(104,w);
                                                             writeln(reg.exporta);
                                                             Inc (w);
                                                             Writeln ('________________________________________________________________________________________________________________');
                                                        end
                                                     else
                                                         begin
                                                              //writeln('No hay proyectos entre las fechas ingresadas'); // es mayor o menor al dia
                                                         end;
                                                end;
                                       end
                                    else
                                        begin
                                             //writeln('No hay proyectos entre las fechas ingresadas'); // es mayor o menor al mes
                                        end;
                               end;
                      end
                   else
                       begin
                            //writeln('No hay proyectos entre las fechas ingresadas'); // es mayor o menor al anio
                       end;
              end;
          //gotoxy(145, 1);
          //writeln(f_a_m);
          indice:= indice+1;
          seek(arch, indice);
     end;
     if (deter = 0) then
        begin
        clrscr;
        writeln('No existen proyectos entre las fechas ', fecha_inicio, ' y ', fecha_fin);
        end;
     close(arch);
end;

begin
end.

