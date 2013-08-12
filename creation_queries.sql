create database project2;

use project2;

create table publication(p_name varchar(50),frequency char(10) not null,type char(10) not null,primary key(p_name,frequency,type))engine innodb;

create table newspaper(n_pname varchar(50),n_name varchar(50),noof_days int(10),n_sid varchar(10),n_frequency char(10),rate int(10),primary key(n_pname,n_frequency,noof_days,n_name))engine innodb;

create table magazine(m_pname varchar(50),m_name varchar(50),issue int(10),m_sid varchar(10),m_frequency char(10),rate int(10),primary key(m_pname,m_frequency,issue,m_name))engine innodb;

create table subscribed(sid varchar(10) not null primary key)engine innodb;

create table customer(cid INT(10) not null AUTO_INCREMENT primary key,initial varchar(2),last varchar(20),address varchar(40))engine innodb;

create table subscription(s_sid varchar(10),s_cid int(10),start_date date,end_date date,noof_months int(10),total_cost int(10),primary key(s_sid,s_cid))engine innodb;


alter table subscription add foreign key(s_sid) references subscribed(sid);

alter table subscription add foreign key(s_cid) references customer(cid);

alter table newspaper add foreign key(n_sid) references subscribed(sid);

alter table magazine add foreign key(m_sid) references subscribed(sid);

alter table newspaper add foreign key(n_pname,n_frequency) references publication(p_name,frequency);

alter table magazine add foreign key(m_pname,m_frequency) references publication(p_name,frequency);

show tables;

show create table publication;

show create table newspaper;

show create table magazine;

show create table subscribed;

show create table customer;

show create table subscription;