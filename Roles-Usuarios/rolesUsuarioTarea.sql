--
-- triggers
--
create table auditoria_administrador(
idAdministrador int,
apeynom varchar(50),
tel varchar(50),
fechnac date,
viveahi varchar(1),
sexo varchar (1),					     
fechaModif datetime,
usuario_accion varchar(100),
accion varchar (20)
);
go

go
CREATE TRIGGER trg_auditoria_administrador_insertar
ON administrador
FOR INSERT
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion insert'
    FROM
        inserted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;

	go
CREATE TRIGGER trg_auditoria_administrador_modificar
ON administrador
FOR update
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion modify'
    FROM
        inserted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;

	go
CREATE TRIGGER trg_auditoria_administrador_eliminar
ON administrador
FOR delete
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion delete'
    FROM
        deleted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;

--
--triggers
--
go
	
create login benn with password='Password123';
create login artur with password='Password123';

--creamos usuarios con los long in anteriores
create user benn for login benn
create user artur for login artur
--asignamos roles a los usuarios
alter role db_datareader add member benn
alter role db_ddladmin add member artur

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
	

GO
Create User Tomas without login
alter role [db_datareader] add member Tomas
BEGIN TRANSACTION;
BEGIN TRY  
	   EXECUTE AS USER = 'Tomas'; 
    exec insertarAdministrador 'nom ape1', 'S', '19870223', 'M','2003-05-26';
      COMMIT;


END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;
REVERT;
go

grant execute on insertarAdministrador TO Tomas
BEGIN TRANSACTION;
BEGIN TRY
	EXECUTE AS USER = 'Tomas';
    exec insertarAdministrador 'nom ape1', 'S', '19870223', 'M','2003-05-26';
       COMMIT;


END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;
REVERT;
select* from auditoria_administrador

-- scrit para hacer drop  y poder volver a ejecutar
-- DROP TRIGGER trg_auditoria_administrador_insertar;
-- DROP TRIGGER trg_auditoria_administrador_modificar;
-- DROP TRIGGER trg_auditoria_administrador_eliminar;
-- DROP TABLE auditoria_administrador;
-- DROP LOGIN benn;
-- DROP LOGIN artur;
-- DROP USER benn;
-- DROP USER artur;
-- DROP USER Tomas;
-- DROP PROCEDURE insertarAdministrador;
