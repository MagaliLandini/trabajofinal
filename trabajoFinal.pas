Program trabajofinal;
Uses Crt,unit_estancias;
var 
estancia:T_estancia; 
archivo1:archivo;
archivo_p:archivo_Provincia;
posicionEstancia, opcionMenu,lim, opcionListados : integer;
nombreEst:String;
vectorEstancia:T_vector;
provincia:T_provincias;


begin
  Assign(archivo1,'./archivo1.dat');
  Assign(archivo_p,'./archivoProv.dat');
  Reset(archivo1);
  Reset(archivo_p);

  //MENÚ
  repeat
  ClrScr;
  GotoXY(20,whereY());
  TextColor(0);
  TextBackground(7);
  WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
  TextBackground(0);
  TextColor(7);
  WriteLn('Que accion desea realizar?');
  Writeln('');
  WriteLn('1. Consultar una estancia');
  WriteLn('2. Dar de alta una estancia');
  WriteLn('3. Dar de baja una estancia');
  WriteLn('4. Modificar una estancia');
  WriteLn('5. Listar Estancias');
  WriteLn('6. Dar de alta y consultar una provincia'); 
  
  Writeln('');
  WriteLn('0. Salir ');
  ReadLn(opcionMenu);
  ClrScr;
  case (opcionMenu) of
    0: begin
       close(archivo1);
       close(archivo_p);
       WriteLn('El programa se ha cerrado satisfactoriamente');
       ReadKey;
       end;
    1: begin 
        GotoXY(20,whereY());
        TextColor(0);
        TextBackground(7);
        WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
        TextBackground(0);
        TextColor(7);
        ConsultarEstancia(estancia,archivo1);
        GotoXY(WhereX(),WhereY()+5);
        TextColor(11);
        WriteLn('Presione una tecla para continuar.');
        ReadKey;
        end;
    2: begin
        GotoXY(20,whereY());
        TextColor(0);
        TextBackground(7);
        WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
        TextBackground(0);
        TextColor(7);
       incializarRegistro(estancia); 
       altaEstancia(estancia,archivo1);
       GotoXY(WhereX(),WhereY()+5);
       TextColor(11);
       WriteLn('Presione una tecla para continuar.');
       ReadKey;
      end;
    3:  begin
        GotoXY(20,whereY());
        TextColor(0);
        TextBackground(7);
        WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
        TextBackground(0);
        TextColor(7);
        WriteLn('Ingrese el nombre de la estancia que desea dar de baja: ');
        Readln(nombreEst); 
        posicionEstancia := Posicion(nombreEst, archivo1);
         if (posicionEstancia > -1) then
          baja(archivo1, estancia, posicionEstancia);
        GotoXY(WhereX(),WhereY()+5);
        TextColor(11);
        WriteLn('Presione una tecla para continuar.');
        ReadKey;
        end;
    4: begin 
         GotoXY(20,whereY());
         TextColor(0);
         TextBackground(7);
         WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
         TextBackground(0);
         TextColor(7);
         modificarEstancia(archivo1);
         GotoXY(WhereX(),WhereY()+5);
        TextColor(11);
         WriteLn('Presione una tecla para continuar.');
         ReadKey;end;
    5:  begin 
    repeat
         GotoXY(20,whereY());
         TextColor(0);
         TextBackground(7);
         WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
         TextBackground(0);
         TextColor(7);
         GotoXY(20,whereY());
         WriteLn('Seccion listar estancias');
         WriteLn('Que accion desea realizar?');
         Writeln('');
         WriteLn('1. Listar estancias.');
         WriteLn('2. Listado de estancias por provincias.');
         WriteLn('3. Estancias que poseen piscinas.');
         WriteLn('4. Volver al menu principal.');
         ReadLn(opcionListados);
         ClrScr;
         case (opcionListados) of
          1: begin
              LeerArchivo(archivo1,vectorEstancia,lim);
              burbuja(vectorEstancia,lim);
              ModificarArchivo(archivo1,vectorEstancia,lim);
              listado(archivo1);
              GotoXY(WhereX(),WhereY()+5);
              TextColor(11);
              WriteLn('Presione una tecla para continuar.');
              ReadKey;
              end;
          2: begin 
             ListadoProvincias(archivo_p,archivo1);
             GotoXY(WhereX(),WhereY()+5);
            TextColor(11);
             WriteLn('Presione una tecla para continuar.');
             ReadKey;
             end;
          3: begin
                LeerArchivo(archivo1, vectorEstancia, lim);
                burbuja(vectorEstancia, lim);
                listadoPiscinas(archivo1);
                GotoXY(WhereX(),WhereY()+5);
                TextColor(11);
                WriteLn('Presione una tecla para continuar.');
                ReadKey;
              end;
         end;
      until opcionListados=4;
          end;
    6: begin
        repeat
        GotoXY(20,whereY());
        TextColor(0);
        TextBackground(7);
        WriteLn('----- Sistema de Gestion de Estancias Turisiticas -----');
        TextBackground(0);
        TextColor(7);
        GotoXY(20,whereY());
        WriteLn('Seecion provincias');
        WriteLn('Que accion desea realizar?');
        Writeln('');
        WriteLn('1.Dar de alta una provincia');
        WriteLn('Consultar los datos de una prvincia');
        WriteLn('3.volver al menu principal');
        ReadLn(opcionListados);
        ClrScr;
        case (opcionListados) of
        1: begin
          incializarRegistroProvincia(provincia);
          altaProvincia(provincia,archivo_p);
          GotoXY(WhereX(),WhereY()+5);
          WriteLn('Presione una tecla para continuar.');
          ReadKey;
          end;
        2:begin 
          DatosProvincia(archivo_p,provincia);
          GotoXY(WhereX(),WhereY()+5);
          TextColor(11);
          WriteLn('Presione una tecla para continuar.');
          ReadKey;
          end;
        end;
      until opcionListados=3;  
      end;
    else
    begin
      WriteLn('No se reconoce la operación ingresada');
      GotoXY(WhereX(),WhereY()+5);
      TextColor(11);
      WriteLn('Presione una tecla para continuar.');
      ReadKey;
      end;
    end;
    until opcionMenu = 0;
    ReadKey;
end.