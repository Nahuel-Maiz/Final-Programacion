unit Vectores_Proyectos;
interface
uses crt, Archivos_Proyectos;
var
   arch: archivo_proyectos;

const
    n=100;
type
    r_titulos = record
              campo:string;
              pos_archivo:integer;
    end;
    v_proyectos = array [1..n] of r_titulos;


procedure inicializar_vector_proyectos(var v:v_proyectos);
procedure titulo_proyectos(var arch:archivo_proyectos; var vec:v_proyectos);
procedure ordenar_titulo2(var arch:archivo_proyectos; var vec:v_proyectos);
procedure listado_titulo2();
procedure listado_titulo_rangos2(var fecha_inicio:string; var fecha_fin:string);

implementation

procedure inicializar_vector_proyectos(var v:v_proyectos);
var
   i:integer;
   reg:r_titulos;
begin
     reg.campo:= '';
     reg.pos_archivo:= 0;
     for i:=1 to n do
     begin
          v[i]:=reg;
     end;
end;

//aca

procedure titulo_proyectos(var arch:archivo_proyectos; var vec:v_proyectos);
    var
       reg:r_proyectos;
       pos:integer;
       lim:integer;
       i: integer;
    begin
         pos:=0;
         abrir_proyectos(arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_proyectos(pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.titulo;
                            pos_archivo:=pos;
                       end;
                  inc(pos);
             end;
    end;

procedure ordenar_titulo2(var arch:archivo_proyectos; var vec:v_proyectos);
var
   aux:r_titulos;
   i,j:integer;
   lim: integer;

begin
abrir_proyectos(arch);
lim:=filesize(arch);
close(arch);
for i:=1 to lim-1 do
             begin
                  for j:=1 to lim-i do
                      begin
                           if vec[j].campo > vec[j+1].campo then
                              begin
                                   aux:=vec[j];
                                   vec[j]:=vec[j+1];
                                   vec[j+1]:=aux;
                              end;
                      end;
             end;
end;

procedure listado_titulo2();
var
   i:integer;
   reg:r_proyectos;
   lim,w:integer;
   control:char;
   j,y:integer;
   v: v_proyectos;
begin
w:=3;
abrir_proyectos(arch);
lim:=filesize(arch);
close(arch);
inicializar_vector_proyectos(v);
titulo_proyectos(arch, v);
ordenar_titulo2(arch, v);
                   gotoxy(22,1);
                   writeln ('Listado de Proyectos de Software ordenados por titulo');
                   Gotoxy (1,2);
                   writeln ('|  Titulo  |  iD del Proyecto  |    Costo    |     Cuit     |    Director    |   Fecha de Entrega  |  Exporta  |');
                   Gotoxy (1,3);
                   Writeln ('________________________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_proyectos(pos_archivo, reg);
                                     end;
                                if (reg.estado) then
                                   begin
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
                                        Gotoxy (1,w);
                                        Writeln ('________________________________________________________________________________________________________________');
                                   end;
                           end
                              else
                                  begin
                                       with v[i] do
                                            begin
                                                 leer_proyectos(pos_archivo, reg);
                                            end;
                                       if (reg.estado) then
                                          begin
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
                                               Writeln (reg.fecha_de_entre);
                                               Gotoxy(104,w);
                                               Writeln(reg.exporta);
                                               Inc (w);
                                               Gotoxy (1,w);
                                               Writeln ('________________________________________________________________________________________________');
                                          end;
                                       writeln('s: Siguiente; a: Volver al principio; ESC: salir');
                                    gotoxy(1,1);
                                    repeat
                                          control:=readkey;
                                          keypressed;
                                          case control of
                                               's':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                                ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                   end;
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        i:=0;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='s') or (control='a') or (control=#27);
                               end;
                               if i=lim then
                                  begin
                                       writeln('a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        i:=0;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='a') or (control=#27);
                                  end;
                   end;
                   writeln('Presione ESC para salir.');
                   gotoxy(1,1);

              end;

//punto 5
procedure listado_titulo_rangos2(var fecha_inicio:string; var fecha_fin:string);
var
   i, deter:integer;
   reg:r_proyectos;
   lim,w:integer;
   v: v_proyectos;
   f_i_d, f_i_m, f_i_a, f_f_d ,f_f_m, f_f_a: string;
   f_a_d, f_a_m, f_a_a: string;
begin
w:=3;
deter:=0;
abrir_proyectos(arch);
lim:=filesize(arch);
close(arch);
inicializar_vector_proyectos(v);
titulo_proyectos(arch, v);
ordenar_titulo2(arch, v);
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
                   Gotoxy (1,2);   writeln ('|  Titulo  |  ID del Proyecto  |    Costo    |     Cuit     |    Director    |   Fecha de Entrega  |  Exporta  |');
                   Gotoxy (1,3);
                   Writeln ('________________________________________________________________________________________________________________');
                   for i:= 1 to lim do
                       begin
                            with v[i] do
                                 begin
                                      leer_proyectos(pos_archivo, reg);
                                 end;
                            if (reg.estado) then
                               begin
                                    f_a_d:= copy(reg.fecha_de_entre, 1, 2);
                                    f_a_m:= copy(reg.fecha_de_entre, 4, 2);
                                    f_a_a:= copy(reg.fecha_de_entre, 7, 2);
                                    if (f_a_a > f_i_a) and (f_a_a < f_f_a) and (reg.exporta = true) then
                                       begin
                                            Inc (w);
                                            deter:=deter+1;
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
                                            Gotoxy (1,w);
                                            Writeln ('________________________________________________________________________________________________________________');
                                       end
                                    else
                                        begin
                                             if (f_a_a = f_i_a) or (f_a_a = f_f_a) and (reg.exporta = true) then
                                                begin
                                                     if (f_a_m > f_i_m) and (f_a_m < f_f_m) and (reg.exporta = true) then
                                                        begin
                                                             Inc (w);
                                                             deter:=deter+1;
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
                                                             Gotoxy (1,w);
                                                             Writeln ('________________________________________________________________________________________________________________');
                                                        end
                                                     else
                                                         begin
                                                              if (f_a_m = f_i_m) or (f_a_m = f_f_m) and (reg.exporta = true) then
                                                                 begin
                                                                      if (f_a_d > f_i_d) and (f_a_d < f_f_d) and (reg.exporta = true) then
                                                                         begin
                                                                              Inc (w);
                                                                              deter:=deter+1;
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
                                                                              Gotoxy (1,w);
                                                                              Writeln ('________________________________________________________________________________________________________________');
                                                                         end
                                                                      else
                                                                          begin
                                                                               if (f_a_d = f_i_d) or (f_a_d = f_f_d) and (reg.exporta = true) then
                                                                                  begin
                                                                                       Inc (w);
                                                                                       deter:=deter+1;
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
                                                                                       Gotoxy (1,w);
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
                                                                       //writeln('No hay proyectos entre las fechas ingresadas'); // es mayor o menor al dia
                                                                  end;
                                                         end;
                                                end
                                             else
                                                 begin
                                                      //writeln('No hay proyectos entre las fechas ingresadas'); // es mayor o menor al dia
                                                 end;
                                        end;
                               end;
                       end;
if (deter = 0) then
   begin
        clrscr;
        writeln('No existen proyectos entre las fechas ', fecha_inicio, ' y ', fecha_fin);
   end;
end;

begin
end.

