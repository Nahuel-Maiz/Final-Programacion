unit Archivos_Clientes;
interface    
uses crt;

type
	r_clientes = record
		r_social: string[25];
        cuit: integer;
        telefono: integer;
        domicilio: string[30];
        email: string[25];
        estado: boolean;
    end;
	
	archivo_clientes = file of r_clientes;
const
   nombre_arch= 'ClientesFinalPrueba8.dat';

procedure abrir_clientes(var arch:archivo_clientes);
procedure leer_clientes(var pos:integer; var dato_leido:r_clientes);
procedure guardar_clientes(var escribir_dato:r_clientes);
procedure alta_cliente();
procedure busqueda_cuit(var buscado: integer; var posicion:integer);
procedure guardar_clientes_en(var escribir_dato: r_clientes; posicion: integer);
procedure baja_cliente(var cuit: integer);
procedure consultar_cliente(var cuit:integer; var reg: r_clientes);
procedure modificar_cliente(var cuit:integer);

implementation

procedure abrir_clientes(var arch:archivo_clientes);
    begin
        assign(arch, nombre_arch);
        {$I-}                       
            reset(arch);
        {$I-}
        if ioresult <> 0 then
            rewrite(arch);
    end;

procedure leer_clientes(var pos:integer; var dato_leido:r_clientes);
var
   arch: archivo_clientes;

    begin
        abrir_clientes(arch);
        seek(arch, pos);
        read(arch, dato_leido);
        close(arch);
    end;

procedure guardar_clientes(var escribir_dato: r_clientes);
var
   arch: archivo_clientes;

    begin
        abrir_clientes(arch);
        seek(arch, filesize(arch));
        write(arch, escribir_dato);
        writeln('guardado');
        close(arch);
    end;

procedure guardar_clientes_en(var escribir_dato: r_clientes; posicion: integer);
var
   arch: archivo_clientes;

    begin
        abrir_clientes(arch);
        seek(arch, posicion);
        write(arch, escribir_dato);
        close(arch);
    end;

procedure alta_cliente();
var
   reg: r_clientes;
   posicion: integer;
   control: char;

begin
     writeln('Ingrese el Cuit que desee dar de Alta');
     {$I-}
     readln(reg.cuit);
     {$I-}
     if (ioresult <> 0 ) then
     begin
          repeat
                writeln('Cuit incorrecto, ingrese el cuit solo con numeros');
                {$I-}
                readln(reg.cuit);
                {$I-}
          until (ioresult = 0);
     end;
     busqueda_cuit(reg.cuit, posicion);
     if (posicion = -1) then
        begin
        writeln('Ingrese la Razon Social');
        readln(reg.r_social);
        writeln('Ingrese el numero de Telefono');
        {$I-}
        readln(reg.telefono);
        {$I-}
        if (ioresult <> 0 ) then
        begin
             repeat
                   writeln('Telefono incorrecto, ingrese el telefono solo con numeros');
                   {$I-}
                   readln(reg.telefono);
                   {$I-}
             until (ioresult = 0);
        end;
        writeln('Ingrese el Email');
        readln(reg.email);
        writeln('Ingrese el Domicilio');
        readln(reg.domicilio);
        reg.estado:= true;
        guardar_clientes(reg);
        end
     else
         begin
         writeln('El Cuit que ingreso ya existe');
         leer_clientes(posicion, reg);
         if (reg.estado = False) then
            begin
                 writeln('El cliente esta dado de Baja');
                 writeln('Desea darlo de Alta?');
                 repeat
                 writeln('Presione la tecla s para SI, y n para NO');
                 control:= readkey;
                 keypressed;
                 case control of
                      's': begin
                                reg.estado:= True;
                                guardar_clientes_en(reg, posicion);
                                writeln('El cliente fue dado de Alta con exito');
                           end;
            end;
            until (control = 's') or (control = 'n');
         end;
end;
end;

procedure busqueda_cuit(var buscado: integer; var posicion:integer);
var
   reg: r_clientes;
   arch: archivo_clientes;
   indice: integer;

begin
     indice:= 0;
     posicion:= -1;
     abrir_clientes(arch);
     while not eof(arch) and (posicion = -1) do
     begin
          read(arch, reg);
          if (reg.cuit = buscado) then
             begin
             posicion:= indice;
             end;
          indice:= indice+1;
          seek(arch, indice);
     end;
     close(arch);

end;

procedure baja_cliente(var cuit: integer);
var
   reg: r_clientes;
   posicion: integer;
   control: char;

begin
     busqueda_cuit(cuit, posicion);
     if (posicion <> -1) then
        begin
             leer_clientes(posicion, reg);
             if (reg.estado = True) then
                begin
                writeln('Esta seguro de dar de Baja a este cliente?');
                repeat
                writeln('Presione la tecla s para SI, y n para NO');
                control:= readkey;
                keypressed;
                case control of
                     's': begin
                               reg.estado:= False;
                               guardar_clientes_en(reg, posicion);
                               writeln('El cliente fue dado de Baja con exito');
                          end;
                end;
                until (control = 's') or (control = 'n');
                end;
        end
     else
         begin
         writeln('El Cuit ingresado NO existe');
         end;
end;

procedure consultar_cliente(var cuit:integer; var reg: r_clientes);
var
   posicion, w: integer;

begin
w:=4;
busqueda_cuit(cuit, posicion);
if (posicion = -1) then
   begin
   writeln('El cuit del cliente ingresado NO esta registrado o esta dado de Baja');
   end
else
    begin
         leer_clientes(posicion, reg);
         if (reg.estado = false) then
            begin
                 writeln('El cuit del cliente ingresado NO esta registrado o esta dado de Baja');
            end
         else
             begin
                  writeln('Cliente encontrado Satisfactoriamente');
                  leer_clientes(posicion, reg);
                  Gotoxy (1,3);
                  writeln ('|      Cuit      |  Razon Social  |     Telefono     |     Domicilio     |     Email     |');
                  Gotoxy (1,4);
                  Writeln ('________________________________________________________________________________________________');
                  w:=w+1;
                  gotoxy(7,w);
                  writeln(reg.cuit);
                  gotoxy(24,w);
                  writeln(reg.r_social);
                  gotoxy(40,w);
                  writeln(reg.telefono);
                  gotoxy(58,w);
                  writeln(reg.domicilio);
                  gotoxy(78,w);
                  writeln(reg.email);
                  Writeln ('________________________________________________________________________________________________');
             end;
    end;
end;

procedure modificar_cliente(var cuit:integer);
var
	posicion: integer;
	opcion: char;
    reg: r_clientes;

begin
    busqueda_cuit(cuit, posicion);
    if (posicion <> -1) then
       begin
            consultar_cliente(cuit, reg);
            if (reg.estado) then
               begin
                 with reg do
                 begin
                      repeat
                      writeln('-------');
                      writeln('0) Salir');
                      writeln('1) Razon Social');
                      writeln('2) Telefono');
                      writeln('3) Domicilio');
                      writeln('4) Email');
                      write('Opcion: ');
                      {$I-}
                      opcion:= readkey;
                      {$I-}
                      keypressed;
                      writeln('-------');
				      case opcion of
					      '1':begin
                                   write('Razon social: ');
                                   readln(r_social);
                                   guardar_clientes_en(reg, posicion);
                              end;
                          '2':begin
                                   write('Telefono: ');
                                   {$I-}
                                   readln(telefono);
                                   {$I-}
                                   if (ioresult <> 0) then
                                   begin
                                        repeat
                                              writeln('Telefono incorrecto, ingrese el telefono solo con numeros');
                                              {$I-}
                                              readln(telefono);
                                              {$I-}
                                        until (ioresult = 0);
                                   end;
                                   guardar_clientes_en(reg, posicion);
						      end;
					      '3':begin
                                   write('Domicilio: ');
                                   readln(domicilio);
                                   guardar_clientes_en(reg, posicion);
					  	      end;
					      '4':begin
                                   write('Email: ');
                                   readln(email);
                                   guardar_clientes_en(reg, posicion);
                              end;
                       end;
                       clrscr;
                       consultar_cliente(cuit, reg);
                       Until (opcion = '0');
                 end;
               end
               else
                   begin
                        writeln('El cliente esta dado de Baja, desea darlo de alta?');
                        writeln('Presione s para SI, y n para NO');
                        repeat
                              opcion:= readkey;
                              keypressed;
                              case opcion of
                                   's':begin
                                            reg.estado:= True;
                                            guardar_clientes_en(reg, posicion);
                                            writeln('El cliente fue dado de Alta satisfactoriamente');
                                       end;
                                   'n':begin
                                            writeln('Menu');
                                       end;
                              end;
                        until (opcion = 's') or (opcion = 'n');
                   end;
       end
       else
           begin
                writeln('El cuit ingresado es incorrecto o no esta registrado');
           end;
end;

begin
end.
