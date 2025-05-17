CREATE DATABASE homerep_auth;
CREATE DATABASE homerep_userservice;
CREATE DATABASE homerep_orders;
CREATE DATABASE homerep_notif;
ALTER SYSTEM SET max_connections = 1000;
SELECT COUNT(*) from pg_stat_activity;