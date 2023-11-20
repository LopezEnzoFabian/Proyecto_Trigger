
--********************IMPLEMENTACION DE TRIGGER--ALTA-BAJA-MODIFICACIONES***************************--
use base_consorcio

create table auditoria_conserje(
idconserje int,
apeynom varchar(50),
tel varchar(50),
fechnac date,
estciv varchar (1),					     
fechaModif datetime,
usuario_accion varchar(100),
accion varchar (20)
);




create trigger trg_auditoria_conserje_insertar
on conserje  for insert
as 
declare  @idconserje int, @apeynom varchar(50), @tel varchar(50), @fechnac date, @estciv varchar (1),
	@fechaModif date,@usuario varchar(50),@accion varchar(20)
select  @idconserje= idconserje,@apeynom=ApeyNom, @tel=tel,@fechnac=fechnac,@estciv=estciv,
@fechaModif=getdate(),@usuario=SYSTEM_USER from inserted 
insert into auditoria_conserje values (@idconserje, @apeynom,@tel, @fechnac, @estciv,
	getdate(),@usuario,'accion insert')


create trigger  trg_auditoria_conserje_modificar
on conserje  for update
as 
declare  @idconserje int, @apeynom varchar(50), @tel varchar(50), @fechnac date, @estciv varchar (1),
	@fechaModif date,@usuario varchar(50)
select  @idconserje= idconserje,@apeynom=ApeyNom, @tel=tel,@fechnac=fechnac,@estciv=estciv,
@fechaModif=getdate(),@usuario=SYSTEM_USER  from inserted 
insert into auditoria_conserje values (@idconserje, @apeynom,@tel, @fechnac, @estciv,
	getdate(),@usuario,'accion modify')

create trigger  trg_auditoria_conserje_borrar
on conserje  for update
as 
declare  @idconserje int, @apeynom varchar(50), @tel varchar(50), @fechnac date, @estciv varchar (1),
	@fechaModif date,@usuario varchar(50)
select  @idconserje= idconserje,@apeynom=ApeyNom, @tel=tel,@fechnac=fechnac,@estciv=estciv,
@fechaModif=getdate(),@usuario=SYSTEM_USER  from deleted 
insert into auditoria_conserje values (@idconserje, @apeynom,@tel, @fechnac, @estciv,
	getdate(),@usuario,'accion delete')



Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('guillermo hugo ggA.', '000000001', '19870223', 'C');
select* from auditoria_conserje;


UPDATE  conserje   SET ApeyNom  = 'guillermo hugo' where tel =  '000000001';
select* from auditoria_conserje;

delete from conserje where tel =  '000000001';


--*********************************IMPLEMENTACION ROLES DE USUARIO*************************************--

create login enzo with password='Password123';
create login guille with password='Password123';

--creamos usuarios con los long in anteriores
create user enzo for login enzo
create user guille for login guille
--asignamos roles a los usuarios
alter role db_datareader add member enzo
alter role db_ddladmin add guille

go
-- creamos el procedimiento insertarAdministrador

create procedure insertarAdministrador
@apeynom varchar(50),
@viveahi varchar(1),
@tel varchar(20),
@s varchar(1),
@nacimiento datetime
as
begin
	insert into administrador(apeynom,viveahi,tel,sexo,fechnac)
	values (@apeynom,@viveahi,@tel,@s,@nacimiento);
end
	
Create User Josefina without login
alter role [db_datareader] add member Josefina
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'Josefina';
    exec insertarAdministrador 'nom ape1', 'S', '19870223', 'M','2003-05-26';
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;

grant execute on insertarAdministrador TO Josefina
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'guille';
    exec insertarAdministrador 'nom ape1', 'S', '19870223', 'M','2003-05-26';
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;

select* from auditoria_administrador;


--**********************************IMPLEMENTACION DE BACKUP Y RESTORE*****************************************--

-- 1 Verificar el modo de recuperacion de la base de datos
use base_consorcio

SELECT name, recovery_model_desc
FROM sys.databases
WHERE name = 'base_consorcio';


-- 2 cambiamos el modo de recuperacion

USE master; -- Asegúrate de estar en el contexto de la base de datos master
ALTER DATABASE base_consorcio
SET RECOVERY FULL;

-- 3 Realizamos backup de la base de datos

BACKUP DATABASE base_consorcio
TO DISK = 'C:\backup\consorcio_backup.bak'
WITH FORMAT, INIT;

-- Agregamos 10 registros

select * from gasto;

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (1,1,1,5,GETDATE(),5,1200);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (1,2,2,5,GETDATE(),2,1630);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (3,20,2,2,GETDATE(),4,500);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (5,3,1,3,GETDATE(),3,1520);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (5,12,3,4,GETDATE(),5,1120);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (6,45,2,4,GETDATE(),4,2000);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (14,36,2,2,GETDATE(),1,1740);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (18,3,1,2,GETDATE(),2,1520);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (2,48,1,5,GETDATE(),2,1500);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (13,10,2,1,GETDATE(),1,1420);


-- 4 Realizamos backup del log de la base de datos

BACKUP LOG base_consorcio
TO DISK = 'C:\backup\LogBackup.trn'
WITH FORMAT, INIT;


-- Insertamos 10 registros mas

select * from gasto

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (1,1,1,5,GETDATE(),5,1200);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (2,48,1,5,GETDATE(),2,1500);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (3,16,1,2,GETDATE(),4,2300);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (4,21,1,3,GETDATE(),3,1000);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (5,3,1,2,GETDATE(),5,1500);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (6,45,2,4,GETDATE(),4,2000);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (8,17,2,2,GETDATE(),1,1300);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (9,14,1,3,GETDATE(),2,1700);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (12,7,4,2,GETDATE(),3,2100);

insert into gasto (idprovincia,idlocalidad,idconsorcio,periodo,fechapago,idtipogasto,importe) 
values (13,10,2,1,GETDATE(),1,1100);


--5 Realizamos backup del log en otra ubicacion

BACKUP LOG base_consorcio
TO DISK = 'C:\backup\logs\LogBackup2.trn'
WITH FORMAT, INIT;

--6 Restauramos el backup de la base de datos

use master

RESTORE DATABASE base_consorcio
FROM DISK = 'C:\backup\consorcio_backup.bak'
WITH REPLACE, NORECOVERY;

RESTORE LOG base_consorcio
FROM DISK = 'C:\backup\LogBackup.trn'
WITH RECOVERY;

-- Segundo log

RESTORE LOG base_consorcio
FROM DISK = 'C:\backup\logs\LogBackup2.trn'
WITH RECOVERY;

select * from gasto