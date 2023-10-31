





CREATE TRIGGER trg_auditoria_consorcio
ON consorcio

INSTEAD OF DELETE
AS
BEGIN
 
   DECLARE @usuario varchar(50)--declaracion de variable vacia
   SELECT @usuario=SYSTEM_USER
   DECLARE @nombre VARCHAR(50)
   SET @nombre = (SELECT nombre FROM deleted)
   DECLARE @direccion VARCHAR(250)
   SET @direccion = (SELECT direccion FROM deleted)
   DECLARE @idzona INT
   SET @idzona = (SELECT idzona FROM deleted)
   DECLARE @idconserje INT
   SET @idconserje = (SELECT idconserje FROM deleted)
   DECLARE @idadmin INT
   SET @idadmin= (SELECT idadmin FROM deleted)
   
   

       IF EXISTS (SELECT 1 FROM deleted)--
      BEGIN
	   INSERT INTO dbo.Auditoria_Consorcio(idprovincia,idlocalidad,idcosorcio,nombre,direccion, idzona, idconserje, idadmin,fechaAccion, UsuarioAccion)
	   SELECT d.idprovincia, d.idlocalidad, d.idconsorcio,@nombre, @direccion, @idzona, @idconserje, @idadmin, GETDATE(), @usuario
	   FROM inserted AS d
	   
	  END


END

SELECT * FROM consorcio

 SELECT * FROM  dbo.Auditoria_Consorcio

 
DELETE FROM consorcio where (idprovincia = 1 and idlocalidad = 1 and idconsorcio = 1)
