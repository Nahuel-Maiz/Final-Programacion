unit Vectores_Clientes;
interface
uses crt, Archivos_Clientes;
var
   arch: archivo_clientes;

const
    n=100;
type
    r_razon = record
              campo:string;
              pos_archivo:integer;
    end;
    v_clientes = array [1..n] of r_razon;

procedure inicializar_vector_clientes(var v:v_clientes);
procedure razon_clientes(var arch:archivo_clientes; var vec:v_clientes);
procedure ordenar_razon(var arch:archivo_clientes; var vec:v_clientes);
procedure listado_razon();

implementation

//PROCEDIMIENTOS

procedure inicializar_vector_clientes(var v:v_clientes);
var
   i:integer;
   reg:r_razon;
begin
     reg.campo:= '';
     reg.pos_archivo:= 0;
     for i:=1 to n do
     begin
          v[i]:=reg;
     end;
end;

procedure razon_clientes(var arch:archivo_clientes; var vec:v_clientes);
    var
       reg:r_clientes;
       pos:integer;
       i:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_clientes(arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_clientes(pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.r_social;
                            pos_archivo:=pos;
                       end;
                  inc(pos);
             end;
    end;

procedure ordenar_razon(var arch:archivo_clientes; var vec:v_clientes);
var
   aux: r_razon;
   i,j:integer;
   lim:integer;

begin
abrir_clientes(arch);
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

procedure listado_razon();
              var
                 i:integer;
                 reg:r_clientes;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
                 v: v_clientes;
              begin
                   w:=3;
                   abrir_clientes(arch);
                   lim:=filesize(arch);
                   close(arch);
                   inicializar_vector_clientes(v);
                   razon_clientes(arch, v);
                   ordenar_razon(arch, v);
                   gotoxy(22,1);
                   writeln ('Listado de los Clientes ordenado por Razon Social');
                   Gotoxy (1,2);
                   writeln ('|  Razon Social  |      Cuit      |     Telefono     |     Domicilio     |     Email     |');
                   Gotoxy (1,3);
                   Writeln ('________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_clientes(pos_archivo, reg);
                                     end;
                                if (reg.estado) then
                                   begin
                                        Inc (w);
                                        Gotoxy (7,w);
                                        writeln (reg.r_social);
                                        Gotoxy (24,w);
                                        writeln (reg.cuit);
                                        Gotoxy (40,w);
                                        Writeln (reg.telefono);
                                        Gotoxy (58,w);
                                        Writeln (reg.domicilio);
                                        Gotoxy (78,w);
                                        writeln (reg.email);
                                        Inc (w);
                                        Gotoxy (1,w);
                                        Writeln ('________________________________________________________________________________________________');
                                   end;
                           end
                              else
                                  begin
                                       with v[i] do
                                            begin
                                                 leer_clientes(pos_archivo, reg);
                                            end;
                                       if (reg.estado) then
                                          begin
                                               Inc (w);
                                               Gotoxy (7,w);
                                               writeln (reg.r_social);
                                               Gotoxy (24,w);
                                               writeln (reg.cuit);
                                               Gotoxy (40,w);
                                               Writeln (reg.telefono);
                                               Gotoxy (58,w);
                                               Writeln (reg.domicilio);
                                               Gotoxy (78,w);
                                               writeln (reg.email);
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


begin
end.
