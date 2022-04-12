program menu_prueba;
uses crt, Archivos_Proyectos, Archivos_Clientes, Vectores_Clientes, Vectores_Proyectos;
var
   opcion, opcion1, opcion2: char;
   id, cuit: integer;
   reg: r_proyectos;
   reg2: r_clientes;
   cliente: integer;
   fecha_inicio, fecha_fin: string;

begin
repeat
gotoxy(79,25);
writeln('Bienvenido a nuestro TP final');
textbackground(blue);
textcolor(white);
delay(400);
gotoxy(75,28);
writeln('Presione cualquier tecla para empezar');
delay(400);
clrscr;
until keypressed;
repeat
      gotoxy(66,20);
      writeln('___________________________________________________________');
      gotoxy(65,21);
      writeln('|');
      gotoxy(65,22);
      writeln('|');
      gotoxy(65,23);
      writeln('|');
      gotoxy(65,24);
      writeln('|');
      gotoxy(65,25);
      writeln('|');
      gotoxy(65,26);
      writeln('|');
      gotoxy(65,27);
      writeln('|');
      gotoxy(65,28);
      writeln('|');
      gotoxy(65,29);
      writeln('|');
      gotoxy(75,21);
      writeln('Ingrese la opcion que quiera realizar');
      gotoxy(66,22);
      writeln('1. Clientes');
      gotoxy(66,23);
      writeln('2. Proyectos');
      gotoxy(66,24);
      writeln('3. Listado de Proyectos de Software que contrato un Cliente');
      gotoxy(66,25);
      writeln('4. Proyectos entregados en un rango de fechas');
      gotoxy(66,26);
      writeln('5. Listado de Proyectos de Software ordenados por titulo ');
      gotoxy(69,27);
      writeln('que fueron exportados en un rango de fechas');
      gotoxy(66,28);
      writeln('ESC. Salir del Programa');
      gotoxy(66,29);
      writeln('___________________________________________________________');
      gotoxy(125,29);
      writeln('|');
      gotoxy(125,21);
      writeln('|');
      gotoxy(125,22);
      writeln('|');
      gotoxy(125,23);
      writeln('|');
      gotoxy(125,24);
      writeln('|');
      gotoxy(125,25);
      writeln('|');
      gotoxy(125,26);
      writeln('|');
      gotoxy(125,27);
      writeln('|');
      gotoxy(125,28);
      writeln('|');
      opcion:= readkey;
      keypressed;
      clrscr;
      case opcion of
           '1': begin
                     repeat
                           gotoxy(66,20);
                           writeln('___________________________________________________________');
                           gotoxy(65,21);
                           writeln('|');
                           gotoxy(65,22);
                           writeln('|');
                           gotoxy(65,23);
                           writeln('|');
                           gotoxy(65,24);
                           writeln('|');
                           gotoxy(65,25);
                           writeln('|');
                           gotoxy(65,26);
                           writeln('|');
                           gotoxy(65,27);
                           writeln('|');
                           gotoxy(66,21);
                           writeln('1. Alta Cliente');
                           gotoxy(66,22);
                           writeln('2. Baja Cliente');
                           gotoxy(66,23);
                           writeln('3. Modificacion Cliente');
                           gotoxy(66,24);
                           writeln('4. Consulta Cliente');
                           gotoxy(66,25);
                           writeln('5. Listado de Clientes ordenado por Razon Social');
                           gotoxy(66,26);
                           writeln('0. Volver al menu principal');
                           gotoxy(66,27);
                           writeln('___________________________________________________________');
                           gotoxy(125,21);
                           writeln('|');
                           gotoxy(125,22);
                           writeln('|');
                           gotoxy(125,23);
                           writeln('|');
                           gotoxy(125,24);
                           writeln('|');
                           gotoxy(125,25);
                           writeln('|');
                           gotoxy(125,26);
                           writeln('|');
                           gotoxy(125,27);
                           writeln('|');
                           opcion1:= readkey;
                           keypressed;
                           clrscr;
                           case opcion1 of
                                '1': begin
                                          writeln('Alta Cliente');
                                          alta_cliente();
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '2': begin
                                          writeln('Baja Cliente');
                                          writeln('Ingrese el Cuit del Cliente a dar de baja');
                                          {$I-}
                                          readln(cuit);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('Cuit incorrecto, el cuit solo debe contener numeros');
                                                     {$I-}
                                                     readln(cuit);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          baja_cliente(cuit);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '3': begin
                                          writeln('Modificacion Cliente');
                                          writeln('Igrese el Cuit del Cliente a modificar');
                                          {$I-}
                                          readln(cuit);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('Cuit incorrecto, el cuit solo debe contener numeros');
                                                     {$I-}
                                                     readln(cuit);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          modificar_cliente(cuit);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '4': begin
                                          writeln('Consulta Cliente');
                                          writeln('Ingrese el Cuit del Cliente a consultar');
                                          {$I-}
                                          readln(cuit);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('Cuit incorrecto, el cuit solo debe contener numeros');
                                                     {$I-}
                                                     readln(cuit);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          consultar_cliente(cuit, reg2);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '5': begin
                                          listado_razon();
                                          clrscr;
                                     end;
                           end;
                     until (opcion1 = '0');
                end;
           '2': begin
                     repeat
                           gotoxy(66,20);
                           writeln('___________________________________________________________');
                           gotoxy(65,21);
                           writeln('|');
                           gotoxy(65,22);
                           writeln('|');
                           gotoxy(65,23);
                           writeln('|');
                           gotoxy(65,24);
                           writeln('|');
                           gotoxy(65,25);
                           writeln('|');
                           gotoxy(65,26);
                           writeln('|');
                           gotoxy(65,27);
                           writeln('|');
                           gotoxy(66,21);
                           writeln('1. Alta Proyecto');
                           gotoxy(66,22);
                           writeln('2. Baja Proyecto');
                           gotoxy(66,23);
                           writeln('3. Modificacion Proyecto');
                           gotoxy(66,24);
                           writeln('4. Consulta Proyecto');
                           gotoxy(66,25);
                           writeln('5. Listado de Proyectos de Software ordeado por titulo');
                           gotoxy(66,26);
                           writeln('0. Salir al menu principal');
                           gotoxy(66,27);
                           writeln('___________________________________________________________');
                           gotoxy(125,21);
                           writeln('|');
                           gotoxy(125,22);
                           writeln('|');
                           gotoxy(125,23);
                           writeln('|');
                           gotoxy(125,24);
                           writeln('|');
                           gotoxy(125,25);
                           writeln('|');
                           gotoxy(125,26);
                           writeln('|');
                           gotoxy(125,27);
                           writeln('|');
                           opcion2:= readkey;
                           keypressed;
                           clrscr;
                           case opcion2 of
                                '1': begin
                                          writeln('Alta Proyecto');
                                          alta_proyecto();
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '2': begin
                                          writeln('Baja Proyecto');
                                          writeln('Ingrese el ID del proyecto a dar de baja');
                                          {$I-}
                                          readln(id);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('ID incorrecto, el ID solo debe contener numeros');
                                                     {$I-}
                                                     readln(id);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          baja_proyecto(id);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '3': begin
                                          writeln('Modificacion Proyecto');
                                          writeln('Igrese el ID del proyecto a modificar');
                                          {$I-}
                                          readln(id);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('ID incorrecto, el ID solo debe contener numeros');
                                                     {$I-}
                                                     readln(id);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          modificar_proyecto(id);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '4': begin
                                          writeln('Consulta Proyecto');
                                          writeln('Ingrese el ID del proyecto a consultar');
                                          {$I-}
                                          readln(id);
                                          {$I-}
                                          if (ioresult <> 0) then
                                          begin
                                               repeat
                                                     writeln('ID incorrecto, el ID solo debe contener numeros');
                                                     {$I-}
                                                     readln(id);
                                                     {$I-}
                                               until (ioresult = 0);
                                          end;
                                          consultar_proyecto(id, reg);
                                          writeln('Presione Enter para volver al menu');
                                          readln();
                                          clrscr;
                                     end;
                                '5': begin
                                          listado_titulo2();
                                          clrscr;
                                     end;
                           end;
                     until (opcion2 = '0');
                end;
           '3': begin
                     writeln('Ingrese el Cuit del cliente que desee buscar');
                     {$I-}
                     readln(cliente);
                     {$I-}
                     if (ioresult <> 0) then
                     begin
                          repeat
                                writeln('Cuit incorrecto, el Cuit solo debe contener numeros');
                                {$I-}
                                readln(cliente);
                                {$I-}
                          until (ioresult = 0);
                     end;
                     clrscr;
                     proyectos_cliente(cliente);
                     writeln('Presione Enter para volver al menu');
                     readln();
                     clrscr;
                end;
           '4': begin
                     fecha_inicio:='';
                     fecha_fin:= '';
                     writeln('Proyectos entregados en un rango de fechas');
                     writeln('Ingrese la Fecha de inicio, con el formato DDMMAA');
                     readln(fecha_inicio);
                     while not (length(fecha_inicio) = 6) do
                           begin
                                writeln('Fecha erroenea, ingrese nuevamente la fecha');
                                readln(fecha_inicio);
                           end;
                     writeln('Ingrese la Fecha de fin, con el formato DDMMAA');
                     readln(fecha_fin);
                     while not (length(fecha_fin) = 6) do
                           begin
                                writeln('Fecha erroenea, ingrese nuevamente la fecha');
                                readln(fecha_fin);
                           end;
                     clrscr;
                     proyectos_rango_fechas(fecha_inicio, fecha_fin);
                     writeln('Presione Enter para volver al menu');
                     readln();
                     clrscr;
                end;
           '5': begin
                     writeln('Proyectos entregados en un rango de fechas');
                     writeln('Ingrese la Fecha de inicio, con el formato DDMMAA');
                     readln(fecha_inicio);
                     while not (length(fecha_inicio) = 6) do
                           begin
                                writeln('Fecha erroenea, ingrese nuevamente la fecha');
                                readln(fecha_inicio);
                           end;
                     writeln('Ingrese la Fecha de fin, con el formato DDMMAA');
                     readln(fecha_fin);
                     while not (length(fecha_fin) = 6) do
                           begin
                                writeln('Fecha erroenea, ingrese nuevamente la fecha');
                                readln(fecha_fin);
                           end;
                     clrscr;
                     listado_titulo_rangos2(fecha_inicio, fecha_fin);
                     readkey;
                     writeln('Presione Enter para volver al menu');
                     readln();
                     clrscr;
                end;
      end;
until (opcion = #27);
repeat
gotoxy(78,25);
writeln('Gracias por utilizar nuestro Programa');
gotoxy(85,26);
writeln('Integrantes del grupo:');
delay(700);
gotoxy(87,27);
writeln('Gimenez Milagros.');
delay(700);
gotoxy(87,28);
writeln('Maiz Nahuel.');
delay(700);
gotoxy(87,29);
writeln('Queirolo Estefania.');
delay(700);
gotoxy(87,30);
writeln('Traverso Joaquin.');
delay(700);
clrscr;
until keypressed;
end.
