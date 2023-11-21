
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
Insert into conserje (ApeyNom,tel,fechnac,estciv) values ('enzo lopez.', '111111111', '22222222', 'C');
select* from auditoria_conserje;


UPDATE  conserje   SET ApeyNom  = 'guillermo hugo' where tel =  '000000001';
select* from auditoria_conserje;

delete from conserje where tel =  '000000001';


