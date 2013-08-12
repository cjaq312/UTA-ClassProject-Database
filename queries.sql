create database project;

use project;

create table EMPLOYEE(Fname varchar(15) not null,Minit char,Lname varchar(15) not null,Ssn char(9) not null,Bdate date,Address varchar(30),Sex char,Salary Decimal(10,2),Super_ssn char(9),Dno int not null,primary key(Ssn),Foreign key(Super_ssn) references EMPLOYEE(Ssn))engine innodb;

desc employee;

create table DEPARTMENT(Dname varchar(15) not null,Dnumber int not null,Mgr_ssn char(9) not null,Mgr_start_date date,primary key(Dnumber),unique key(Dname),foreign key(Mgr_ssn) references EMPLOYEE(Ssn))engine innodb;

desc department;

alter table EMPLOYEE add foreign key(Dno) references DEPARTMENT(Dnumber);

desc employee;

create table DEPT_LOCATIONS(Dnumber int not null,Dlocation varchar(15) not null,primary key(Dnumber,Dlocation),foreign key(Dnumber) references DEPARTMENT(Dnumber))engine innodb;

desc dept_locations;

create table PROJECT(Pname varchar(15) not null,Pnumber int not null,Plocation varchar(15),Dnum int not null,primary key(Pnumber),unique(Pname),foreign key(Dnum) references DEPARTMENT(Dnumber))engine innodb;

desc project;

create table WORKS_ON(Essn char(9) not null,Pno int not null,Hours decimal(3,1) not null,primary key(Essn,Pno),foreign key(Pno) references PROJECT(Pnumber),foreign key(Essn) references EMPLOYEE(Ssn))engine innodb;

desc works_on;

create table dependent(Essn char(9) not null,Dependent_name varchar(15) not null,Sex char,Bdate date,Relationship varchar(8),primary key(Essn,Dependent_name),foreign key(Essn) references EMPLOYEE(Ssn))engine innodb;

desc dependent;