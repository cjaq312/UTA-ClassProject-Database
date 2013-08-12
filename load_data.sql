create database pro1;

use pro1;

create table login(user varchar(50) not null,password varchar(50) not null,status char(9),md5 varchar(50), primary key(user));

create table employee(user varchar(50) not null,ssn int (10) not null,fname char(10),lname char(10),age int(3),address varchar(50),vnt date,vet date,primary key(ssn));

create table bonus(user varchar(10),vnt datetime,vet datetime,salary int(10),primary key(user,VNT));

create table item(id int(10) not null,name varchar(50),description varchar(50),amount int(10),cost int(10),primary key(id));

create table cost_log(sno int(10) not null AUTO_INCREMENT,id int(10),oldcost int(10),newcost int(10),diff int(10),vnt datetime,vet datetime,primary key(sno));

	DELIMITER $$
create trigger logus after update on login  
for each row 
	BEGIN 
    	IF new.status = 'active'
    	THEN  
        insert into bonus values(new.user,NOW(),'null',0);
    	ELSEIF new.status = 'inactive'
	THEN  
        update bonus set vet = NOW() where user = new.user; 
	SET @diff = (SELECT TIMESTAMPDIFF(SECOND,vnt, vet) from bonus where user=new.user and salary = 0);
SET @whole = @diff * 6;
update bonus set salary = @whole where user=new.user and salary = 0;
    END IF;

	END;
	$$
	DELIMITER ;

	DELIMITER $$
create trigger icos1 after update on item  
for each row 
	BEGIN 
    	IF (NOT EXISTS(select * from cost_log where id = new.id))
    	THEN  
insert into cost_log(id,oldcost,vnt) values(new.id,new.cost,NOW());
     	ELSEIF (EXISTS(select * from cost_log where id = new.id))
	THEN
update cost_log set newcost = new.cost where id = new.id and newcost is NULL;
	SET @diff = (select newcost-oldcost from cost_log where id = new.id and vet is NULL);
update cost_log set diff = @diff,vet = NOW() where id = new.id and vet is NULL;
insert into cost_log(id,oldcost,vnt) values(new.id,new.cost,curdate()+1);
	END IF;

	END;
	$$
	DELIMITER ;


	DELIMITER $$
create trigger icos2 after insert on item  
for each row 
	BEGIN 
    	IF (NOT EXISTS(select * from cost_log where id = new.id))
    	THEN  
insert into cost_log(id,oldcost,vnt) values(new.id,new.cost,NOW());
     	END IF;
END;
	$$
	DELIMITER ;