
unit unit_estancias;

interface
Uses Crt;
const n=1000;

Type
T_estancia=record
    ID_Estancia : integer;
    nombreEstancia:string;
    apellNomDueno:String;
    Dni:Integer;
    domicilio:String;
    cod_provincia: Integer;
    numeroContacto:Integer;
    email:String;
    caracteristicas:String;
    tienePiscina:Boolean;
    capacidadMaxima:Integer;
    alta:Boolean;
end;

T_provincias= record
  Denominacion:String;
  cod_provincia: Integer;
  Telefono:Integer
  end;

archivo_Provincia= file of T_provincias;
archivo=file of T_estancia;
T_vector= array [1..n] of T_estancia;


procedure incializarRegistro(var registroE:T_estancia);
procedure CargarRegistroEstancia (var registroE:T_estancia);
procedure mostrarEstancia (estanciaE : T_estancia);
function Posicion( N:String; var archiv:archivo):Integer;
procedure altaEstancia (var registroE:T_estancia; var archiv: archivo);
procedure baja(var archiv:archivo; var estancia : T_estancia; posicionEstancia : integer);
procedure ConsultarEstancia (var estanciaE: T_estancia; var archiv:archivo);
procedure modificarEstancia(var archiv:archivo);
procedure consultar(var archiv:archivo);
procedure incializarRegistroProvincia(var registroP:T_provincias);
procedure CargarRegistroProvincia (var registroP:T_provincias);
procedure MostrarProvincias (var registroP:T_provincias);
procedure DatosProvincia (var archivoP:archivo_Provincia; var RegistroP:T_provincias);
function PosicionProvincia( N:String; var archivoP:archivo_Provincia):Integer;
procedure altaProvincia (var registroP:T_provincias; var archivoP: archivo_Provincia);
procedure LeerArchivo(var archiv:archivo; var v:T_vector; var lim:integer);
procedure ListadoProvincias (var archivoP:archivo_Provincia;var archivoE:archivo);
procedure ModificarArchivo(var archiv:archivo; var v:T_vector; var lim:Integer);  //modifica el archivo guardando los registros ordenados
procedure listado (var archiv:archivo);
procedure burbuja( var v:T_vector; lim: Integer);
procedure listadoPiscinas(var archiv : archivo);



IMPLEMENTATION

procedure incializarRegistro(var registroE:T_estancia);
begin
    //contadorEstancias := contadorEstancias + 1;var contadorEstancias : integer
      with registroE do 
      begin
        //ID_Estancia:= contadorEstancias;
        nombreEstancia:=' ';
        apellNomDueno:=' ';
        Dni:=0;
        domicilio:= ' '; 
        cod_provincia:= 0;
        numeroContacto:=0;
        email:='';
        caracteristicas:='';
        tienePiscina:=false;
        capacidadMaxima:=0;
        alta:=true;
        
      end;
end;

procedure CargarRegistroEstancia (var registroE:T_estancia);
var 
  aux : string;
begin

  with registroE do
    begin
      WriteLn('Ingrese el nombre de la estancia.');
      ReadLn(nombreEstancia);
      WriteLn('Ingrese el apellido y nombre del duenio.');
      ReadLn(apellNomDueno);
      WriteLn('Ingrese el DNI.');
      ReadLn(Dni);
      WriteLn('Ingrese su domicilio.');
      ReadLn(domicilio);
      WriteLn('Ingrese el codigo de la provincia.');
      ReadLn(cod_provincia);  
      WriteLn('Ingrese un numero de contacto.');
      ReadLn(numeroContacto);
      WriteLn('Ingrese su email.');
      ReadLn(email);
      WriteLn('Caracterice a la estancia.');
      ReadLn(caracteristicas);
      WriteLn('¿Tiene piscina? s/n');
      ReadLn(aux);
        if(aux = 's') then tienePiscina := true;        //Si se ingresa 's', tienePiscina es true. Si se ingresa algo distinto a 's', no pasa nada y conserva el valor false con el que se inicializó
      WriteLn('¿Cual es la capacidad de la estancia?');
      ReadLn(capacidadMaxima);
      alta := true;            
    end;
end;

procedure mostrarEstancia (estanciaE : T_estancia);
begin
  with estanciaE do
    begin
      WriteLn('Nombre de la estancia: ', nombreEstancia);
      WriteLn('Apellido y nombre del duenio: ', apellNomDueno);
      WriteLn('DNI: ', Dni);
      WriteLn('Domicilio: ', domicilio);
      Writeln('Codigo de provincia: ',cod_provincia );
      WriteLn('Numero de contacto: ', numeroContacto);
      WriteLn('Email: ', email);
      WriteLn('Caracteristicas de la estancia: ', caracteristicas);
      if (tienePiscina=true) then
        WriteLn('tiene piscina?: si')
        else
        WriteLn('Tiene Piscina?: No');
      WriteLn('Capacidad maxima de la estancia: ', capacidadMaxima);
      
    end;
end;

function Posicion( N:String; var archiv:archivo):Integer;
var 
registro:T_estancia;
encontrado:Boolean;
posicionArchivo : integer;

begin
  //Inicialización de variables
  encontrado:=false;
  posicionArchivo := 0;
  seek(archiv, posicionArchivo);
  //Ciclo mientras NO sea el final del archivo y NO se haya encontrado
  while not Eof(archiv) and not encontrado do 
  begin
    //Posicionamiento en el archivo
    seek(archiv, posicionArchivo);
    
    //Lectura de la variable
    read(archiv,registro);

    //Comprobación: el nombreEstancia es igual al nombre ingresado?
    if registro.nombreEstancia = N then
      encontrado:= true
    else 
      //Actualización para la próxima iteración
      posicionArchivo := posicionArchivo + 1;
  end;
// WriteLn('encontrado ', encontrado );
// WriteLn('posicion archivo ',posicionArchivo );
  if encontrado then 
  Posicion:=posicionArchivo
  else
  Posicion:=-1;
end;

procedure altaEstancia (var registroE:T_estancia; var archiv: archivo);
var opcion:char;
i:Integer;

begin
WriteLn('Desea cargar una estancia?');
ReadLn(opcion);
while (opcion <> 'n') do
  begin
  ClrScr;
  GotoXY(3,whereY());
  WriteLn('Ingrese los datos de la estancia.');
  WriteLn('');
  CargarRegistroEstancia(registroE);
  i:=Posicion(registroE.nombreEstancia,archiv);
  if i= -1 then
  begin
    i:= FileSize(archiv); // nos da el tamaño del archivo
    seek (archiv,i);
    Write(archiv,registroE);  
  end
  else
  WriteLn('Ya existe una estancia con ese nombre. Los datos no fueron cargados');
  WriteLn('Desea cargar una estancia?');
  ReadLn(opcion);
    end;

end;

procedure baja(var archiv:archivo; var estancia : T_estancia; posicionEstancia : integer);
var 
opcion : char;
begin

WriteLn('Desea dar de baja una estancia?');
ReadLn(opcion);
ClrScr;
  if (Upcase(opcion) <> 'N') then
  begin
   
    //Se posiciona en la estancia
    seek(archiv,posicionEstancia);
    //Lee la estancia
    Read(archiv,estancia);
    //Escribe el nombre a modo de prueba
    WriteLn('Se elimino la estancia ', estancia.nombreEstancia);
    
    //Si la estancia está activa
    if (estancia.alta) then
    begin
    //La da de baja
    estancia.alta:=False;
    //Escribe el archivo para guardar los cambios
    seek(archiv,posicionEstancia);//faltaba agregarle el seek para que se posicione y lo borre
    Write(archiv,estancia);        
    end
  else
  //Si la estancia ya estaba inactiva, avisa al usuario
  WriteLn('La estancia ingresada ya habia sido dada de baja');
  end;
end;


procedure ConsultarEstancia (var estanciaE: T_estancia; var archiv:archivo);
var i:integer;
 n:String;
begin
WriteLn('Ingrese el nombre de la estancia que desea consultar.');
readln(n);
ClrScr;
i:= Posicion(n,archiv);
if  (i>-1) then
  begin
  seek(archiv,i);
  read(archiv,estanciaE);
  if (estanciaE.alta) then
  mostrarEstancia(estanciaE)
    else
     WriteLn('La estancia no existe.');
  end
  else
   WriteLn('La estancia no existe.');
end;

procedure modificarEstancia(var archiv:archivo);
var E:String;
I:integer;
estancia:T_estancia;
begin
  WriteLn('Introduzca el nombre de la estancia que desea modificar.');
  ReadLn(E);
  ClrScr;
  I:= Posicion (E,archiv);
  if I=-1 then
    WriteLn('No existe la estancia buscada.')
    else
    begin
      seek(archiv,I);
      Read(archiv,estancia);
      if estancia.alta then // aca se utiliza un boleano para modificarlo, podemos ver si usamos el mismo o si generamos otro.
        begin
        WriteLn('Introduzca nuevos datos de la estancia.');
        CargarRegistroEstancia(estancia);
        I:= FilePos (archiv) -1;
        seek(archiv,I);
        Write(archiv,estancia);
        WriteLn('El registro ha sido modificado.');
        end
      else
        WriteLn('El registro fue dado de baja.');
      end;

end;


 procedure consultar(var archiv:archivo);
 var 
 estancia:T_estancia;
 N:String;
 i:Integer;
 begin
   WriteLn('Que estancia desea consultar?');
   Read(N);
   ClrScr;
   i:= Posicion(N,archiv);
   if i= -1 then
     WriteLn('No existe la estancia que esta buscando.')
     else
     seek(archiv,i);
     read(archiv,estancia);
     mostrarEstancia(estancia);
 end;

procedure incializarRegistroProvincia(var registroP:T_provincias);
begin
      with registroP do 
      begin
      Denominacion:=' ';
      cod_provincia:= 0;
      Telefono:=0;
        
      end;
end;

procedure CargarRegistroProvincia (var registroP:T_provincias);
begin

  with registroP do
    begin
     WriteLn('Ingrese el nombre de la provincia.');
     ReadLn(Denominacion);
     WriteLn('Ingrese el telefono del ministerios de turismo.');
     ReadLn(telefono);
    end;
end;

procedure MostrarProvincias (var registroP:T_provincias);
begin
  with registroP do
    begin
    WriteLn('Provincia: ',Denominacion );
    WriteLn('codigo de la provincia: ',cod_provincia);
    WriteLn('telefono del ministerio de turismo: ',telefono);
    end;
end;

procedure DatosProvincia (var archivoP:archivo_Provincia; var RegistroP:T_provincias);
var provincia:String;
posProvincia:Integer;
begin
  posProvincia:=0;
  WriteLn ('Los datos de que provincia desea obtener?');
  ReadLn(provincia);
  ClrScr;
  posProvincia:= PosicionProvincia(provincia,archivoP);
  if posProvincia<= 0 then
    begin
    Seek(archivoP,posProvincia);
    Read(archivoP,RegistroP);
    MostrarProvincias(RegistroP);
    end
  else
  WriteLn('La provincia no se encuentra cargada en el sistema.');


end;
function PosicionProvincia( N:String; var archivoP:archivo_Provincia):Integer;
var 
registroP:T_provincias;
encontrado:Boolean;
posicionArchivo : integer;

begin
  //Inicialización de variables
  encontrado:=false;
  posicionArchivo := 0;
  seek(archivoP, posicionArchivo);
  //Ciclo mientras NO sea el final del archivo y NO se haya encontrado
  while not Eof(archivoP) and not encontrado do 
  begin
    //Posicionamiento en el archivo
    seek(archivoP, posicionArchivo);
    
    //Lectura de la variable
    read(archivoP,registroP);

    //Comprobación: el nombreEstancia es igual al nombre ingresado?
    if registroP.Denominacion = N then
      encontrado:= true
    else 
      //Actualización para la próxima iteración
      posicionArchivo := posicionArchivo + 1;
  end;
// WriteLn('encontrado ', encontrado );
// WriteLn('posicion archivo ',posicionArchivo );
  if encontrado then 
  PosicionProvincia:=posicionArchivo
  else
  PosicionProvincia:=-1;
end;

procedure altaProvincia (var registroP:T_provincias; var archivoP: archivo_Provincia);
var opcion:char;
i:Integer;
begin
WriteLn('Desea cargar una provincia?');
ReadLn(opcion);
while (opcion <> 'n') do
  begin
  ClrScr;
  WriteLn('Ingrese los datos de la provincia.');
  CargarRegistroProvincia(registroP);
  i:=PosicionProvincia(registroP.Denominacion,archivoP);
  if i= -1 then
  begin
    i:= FileSize(archivoP); // nos da el tamaño del archivo
    registroP.cod_provincia:= i;
    seek (archivoP,i);
    Write(archivoP,registroP)
  end
  else 
  WriteLn('Ya existe una provincia con ese nombre. Los datos no fueron cargados.');
   
  WriteLn('Desea cargar otra provincia?');
  ReadLn(opcion);
    end;

end;

procedure ListadoProvincias (var archivoP:archivo_Provincia; var archivoE:archivo);
var estProvincia:String;
PosProvincia,codigoProvincia,i,listado:Integer;
registroP:T_provincias;
registroE:T_estancia;
begin
codigoProvincia:=0;
PosProvincia:=0;
listado:=0;
  WriteLn('Las estancias de que provincia desea buscar?');
  ReadLn(EstProvincia);
  ClrScr;
  PosProvincia:= posicionProvincia(estProvincia,archivoP);
  if (PosProvincia >= 0) then
  begin
  Seek(archivoP,PosProvincia);
  Read(archivoP,registroP);
  codigoProvincia:= registroP.cod_provincia;
  
  for i:= 0 to FileSize(archivoE)-1 do
    begin
    Seek(archivoE,i);
    Read(archivoE,registroE);
    if (codigoProvincia = registroE.cod_provincia) then
    mostrarEstancia(registroE);
    listado:= listado+1;
    end;
  if listado=0 then
  WriteLn('La provincia ingresada no tiene estancias cargadas en el sistemas.');
  end
  else 
  WriteLn('La provincia no se encuentra en el sistema.');

end;
procedure LeerArchivo (var archiv:archivo; var v:T_vector; var lim:integer);
begin
  lim:=0;
  repeat 
  lim:= lim+1;
  Read(archiv,v[lim]);
  until Eof(archiv);
end;

procedure burbuja( var v:T_vector; lim: Integer);
    var i,j: Integer;
    aux:T_estancia;
begin
  for i := 1 to lim - 1 do 
    begin
      for j:= 1 to lim -i do 
        begin
          if v[j].nombreEstancia > v [j+1].nombreEstancia then 
            begin
              aux:= v [j];
              v[j]:= v [j+1];
              v[j+1]:= aux;
            end;
        end;      
    end;
end;

procedure ModificarArchivo(var archiv:archivo; var v:T_vector; var lim:Integer);  //modifica el archivo guardando los registros ordenados
var i:Integer;
begin
  Rewrite(archiv);//sobreescribe el archivo
  for i:= 1 to lim do 
  Write(archiv,v[i]);
end;

procedure listado (var archiv:archivo);
var estancia:T_estancia;
begin

reset(archiv);
 while not Eof(archiv) do
  begin
  
    WriteLn('Registro: ', FilePos(archiv) + 1);
    Read(archiv,estancia);
    
    if estancia.alta then
      mostrarEstancia(estancia)
      else
      WriteLn('el registro esta vacio');
  end;
end;

procedure listadoPiscinas( var archiv : archivo);
var estancia:T_estancia;
begin

reset(archiv);
 while not Eof(archiv) do
  begin
    WriteLn('');
    WriteLn('Listado de estancias que poseen piscina.');
    WriteLn('Registro: ', FilePos(archiv) + 1);
    Read(archiv,estancia);
    
    if estancia.alta  AND estancia.tienePiscina then
      mostrarEstancia(estancia)
  end;
end;

Begin
End.