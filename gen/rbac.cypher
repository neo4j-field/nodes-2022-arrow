create or replace database $homedb;
create or replace role $role;
grant read {*} on graph $homedb to $role;
grant write on graph $homedb to $role;
grant traverse on graph $homedb to $role;
grant access on database $homedb to $role;
grant all database privileges on database $homedb to $role;
create or replace user $user set password $password change not required SET HOME DATABASE $homedb;
grant role $role to $user ;
