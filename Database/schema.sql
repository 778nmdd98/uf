-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public.buildings_building_id_seq;

CREATE SEQUENCE public.buildings_building_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.classschedule_schedule_id_seq;

CREATE SEQUENCE public.classschedule_schedule_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.favorites_favorite_id_seq;

CREATE SEQUENCE public.favorites_favorite_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.floors_floor_id_seq;

CREATE SEQUENCE public.floors_floor_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.rooms_room_id_seq;

CREATE SEQUENCE public.rooms_room_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.subjects_subject_id_seq;

CREATE SEQUENCE public.subjects_subject_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.users_user_id_seq;

CREATE SEQUENCE public.users_user_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.usersubjects_user_subject_id_seq;

CREATE SEQUENCE public.usersubjects_user_subject_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.buildings definition

-- Drop table

-- DROP TABLE public.buildings;

CREATE TABLE public.buildings (
	building_id serial4 NOT NULL,
	buildling_name varchar(100) NOT NULL,
	description text NULL,
	CONSTRAINT buildings_pkey PRIMARY KEY (building_id)
);


-- public.subjects definition

-- Drop table

-- DROP TABLE public.subjects;

CREATE TABLE public.subjects (
	subject_id serial4 NOT NULL,
	subject_code varchar(50) NOT NULL,
	subject_name varchar(100) NOT NULL,
	CONSTRAINT subjects_pkey PRIMARY KEY (subject_id),
	CONSTRAINT subjects_subject_code_key UNIQUE (subject_code)
);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	user_id serial4 NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	password_hash varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (user_id)
);


-- public.floors definition

-- Drop table

-- DROP TABLE public.floors;

CREATE TABLE public.floors (
	floor_id serial4 NOT NULL,
	building_id int4 NOT NULL,
	floor_number int4 NOT NULL,
	floor_map_image varchar(255) NULL,
	CONSTRAINT floors_pkey PRIMARY KEY (floor_id),
	CONSTRAINT fk_floor_building FOREIGN KEY (building_id) REFERENCES public.buildings(building_id) ON DELETE CASCADE
);


-- public.rooms definition

-- Drop table

-- DROP TABLE public.rooms;

CREATE TABLE public.rooms (
	room_id serial4 NOT NULL,
	floor_id int4 NOT NULL,
	room_code varchar NULL,
	room_name varchar NULL,
	room_type varchar NULL,
	map_x int4 NULL,
	map_y int4 NULL,
	CONSTRAINT rooms_pkey PRIMARY KEY (room_id),
	CONSTRAINT fk_floor_room FOREIGN KEY (floor_id) REFERENCES public.floors(floor_id) ON DELETE CASCADE
);


-- public.usersubjects definition

-- Drop table

-- DROP TABLE public.usersubjects;

CREATE TABLE public.usersubjects (
	user_subject_id serial4 NOT NULL,
	user_id int4 NOT NULL,
	subject_id int4 NOT NULL,
	CONSTRAINT usersubjects_pkey PRIMARY KEY (user_subject_id),
	CONSTRAINT fk_subject_id FOREIGN KEY (subject_id) REFERENCES public.subjects(subject_id) ON DELETE CASCADE,
	CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE
);


-- public.classschedule definition

-- Drop table

-- DROP TABLE public.classschedule;

CREATE TABLE public.classschedule (
	schedule_id serial4 NOT NULL,
	subject_id int4 NOT NULL,
	room_id int4 NOT NULL,
	day_of_week varchar(20) NOT NULL,
	start_time time NULL,
	end_time time NULL,
	CONSTRAINT classschedule_pkey PRIMARY KEY (schedule_id),
	CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES public.rooms(room_id) ON DELETE CASCADE,
	CONSTRAINT fk_subject_id FOREIGN KEY (subject_id) REFERENCES public.subjects(subject_id) ON DELETE CASCADE
);


-- public.favorites definition

-- Drop table

-- DROP TABLE public.favorites;

CREATE TABLE public.favorites (
	favorite_id serial4 NOT NULL,
	user_id int4 NOT NULL,
	room_id int4 NOT NULL,
	CONSTRAINT favorites_pkey PRIMARY KEY (favorite_id),
	CONSTRAINT fk_fav_room FOREIGN KEY (room_id) REFERENCES public.rooms(room_id) ON DELETE CASCADE,
	CONSTRAINT fk_fav_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE
);