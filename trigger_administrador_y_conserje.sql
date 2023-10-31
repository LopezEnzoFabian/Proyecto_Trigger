use base_consorcio

--no permitir eliminar registros de la tabla administrador

create trigger trigger_administrador_no_borrar
  ON administrador
INSTEAD OF DELETE
AS
   if (select count(*) from deleted) > 0
   begin
     
    raiserror('No se puede eliminar ningun registro de la tabla administrador',16,1)
    rollback transaction
	
   end;

   DELETE FROM administrador
    WHERE idadmin = 1 


/*Al ingresar un registro en la tabla conserje, el trigger se dispara automaticamente, y crea un registro en la tabla auxiliar
auditoria_conserje que ademas de cargar los datos a dicha tabla, agrega dos columnas mas, fechaModif que toma del sistema la 
fecha de hoy indicando cuando se ralizo el alta del registro y la comuna usuario_accion que toda del sistema quien realizo
 dicha aperacion
 */
	CREATE TRIGGER trg_auditoria_conserje 
   ON  conserje     
   AFTER INSERT
AS 
BEGIN
    declare @usuario varchar(50)
	select @usuario=SYSTEM_USER
	if exists (select 1 from inserted)
	begin
	insert into  auditoria_conserje (idconserje, apeynom, tel, fechnac, estciv,
	fechaModif,usuario_accion)
	SELECT i.idconserje, i.apeynom, i.tel, i.fechnac, i.estciv,
	getdate(),@usuario
	from inserted as i
	end

END
GO

--creo la tabla auxiliar 

create table auditoria_conserje(
idconserje int,
apeynom varchar(50),
tel varchar(50),
fechnac date,
estciv varchar (1),					     
fechaModif datetime,
usuario_accion varchar(100),
);

-- ingreso un registro y veo que dos filas se agragan, una de ellas a la tabla conserje y otra a lka tabla auxiliar
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('guillermo hugo A.', '374445972', '19870223', 'C')
--pruebo que efectivamente se cargo en la tabla auxiliar
select* from auditoria_conserje;



