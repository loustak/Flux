-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           PostgreSQL 9.5.12 on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609, 64-bit
-- SE du serveur:                
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Export de la structure de la fonction public. create_default_community
DELIMITER //
CREATE FUNCTION "create_default_community"() RETURNS UNKNOWN AS $$ 
    DECLARE
      save_community_id bigint;
    BEGIN
      INSERT INTO communities(user_id, name, inserted_at, updated_at) values(NEW.id, NEW.username, now(), now()) RETURNING id into save_community_id;
      RETURN NEW;
    END;
     $$//
DELIMITER ;

-- Export de la structure de la fonction public. join_created_community
DELIMITER //
CREATE FUNCTION "join_created_community"() RETURNS UNKNOWN AS $$ 
    BEGIN
      INSERT INTO discussions(community_id, name, inserted_at, updated_at) values(NEW.id, 'Main', now(), now());
      INSERT INTO user_communities(user_id, community_id, inserted_at, updated_at) values(NEW.user_id, NEW.id, now(), now());
      RETURN NEW;
    END;
     $$//
DELIMITER ;

-- Export de la structure de la table public. communities
CREATE TABLE IF NOT EXISTS "communities" (
	"id" BIGINT NOT NULL DEFAULT nextval('communities_id_seq'::regclass) COMMENT E'',
	"user_id" BIGINT NOT NULL COMMENT E'',
	"name" CHARACTER VARYING(255) NOT NULL COMMENT E'',
	"public" BOOLEAN NOT NULL DEFAULT false COMMENT E'',
	"joinable" BOOLEAN NOT NULL DEFAULT true COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	"updated_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	KEY ("user_id")
);

-- Export de données de la table public.communities : 0 rows
DELETE FROM "communities";
/*!40000 ALTER TABLE "communities" DISABLE KEYS */;
INSERT INTO "communities" ("id", "user_id", "name", "public", "joinable", "inserted_at", "updated_at") VALUES
	(46, 36, E'Anne Laurent', E'false', E'true', E'2018-06-03 17:39:37.80348', E'2018-06-03 17:39:37.80348'),
	(47, 37, E'Arnaud Castelltort', E'false', E'true', E'2018-06-03 17:40:03.323658', E'2018-06-03 17:40:03.323658'),
	(49, 36, E'Polytech', E'false', E'true', E'2018-06-03 15:42:54.001489', E'2018-06-03 15:42:54.001496'),
	(50, 36, E'IG3', E'false', E'true', E'2018-06-03 15:48:39.601341', E'2018-06-03 15:48:39.601347'),
	(51, 39, E'Martin', E'false', E'true', E'2018-06-03 18:06:48.815448', E'2018-06-03 18:06:48.815448'),
	(48, 38, E'Paul', E'false', E'true', E'2018-06-03 17:41:13.307397', E'2018-06-03 17:41:13.307397');
/*!40000 ALTER TABLE "communities" ENABLE KEYS */;

-- Export de la structure de la table public. discussions
CREATE TABLE IF NOT EXISTS "discussions" (
	"id" BIGINT NOT NULL DEFAULT nextval('discussions_id_seq'::regclass) COMMENT E'',
	"community_id" BIGINT NOT NULL COMMENT E'',
	"name" CHARACTER VARYING(255) NOT NULL COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	"updated_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	KEY ("community_id")
);

-- Export de données de la table public.discussions : 0 rows
DELETE FROM "discussions";
/*!40000 ALTER TABLE "discussions" DISABLE KEYS */;
INSERT INTO "discussions" ("id", "community_id", "name", "inserted_at", "updated_at") VALUES
	(62, 46, E'Main', E'2018-06-03 17:39:37.80348', E'2018-06-03 17:39:37.80348'),
	(66, 49, E'bde', E'2018-06-03 15:44:15.942366', E'2018-06-03 15:44:15.942374'),
	(70, 49, E'actualités', E'2018-06-03 15:48:06.525651', E'2018-06-03 15:48:06.525657'),
	(72, 50, E'projet web', E'2018-06-03 15:49:21.088729', E'2018-06-03 15:49:21.088735'),
	(73, 50, E'entraide', E'2018-06-03 15:49:56.950641', E'2018-06-03 15:49:56.950647'),
	(63, 47, E'notes', E'2018-06-03 17:40:03.323658', E'2018-06-03 15:57:23.246359'),
	(64, 48, E'notes', E'2018-06-03 17:41:13.307397', E'2018-06-03 16:01:06.037921'),
	(74, 51, E'Main', E'2018-06-03 18:06:48.815448', E'2018-06-03 18:06:48.815448');
/*!40000 ALTER TABLE "discussions" ENABLE KEYS */;

-- Export de la structure de la table public. messages
CREATE TABLE IF NOT EXISTS "messages" (
	"id" BIGINT NOT NULL DEFAULT nextval('messages_id_seq'::regclass) COMMENT E'',
	"discussion_id" BIGINT NOT NULL COMMENT E'',
	"user_id" BIGINT NOT NULL COMMENT E'',
	"text" CHARACTER VARYING(255) NULL DEFAULT NULL COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	"updated_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	KEY ("discussion_id"),
	KEY ("user_id")
);

-- Export de données de la table public.messages : 2 rows
DELETE FROM "messages";
/*!40000 ALTER TABLE "messages" DISABLE KEYS */;
INSERT INTO "messages" ("id", "discussion_id", "user_id", "text", "inserted_at", "updated_at") VALUES
	(55, 63, 37, E'Apprendre l\'emoji code', E'2018-06-03 15:58:14.721983', E'2018-06-03 15:58:14.721992'),
	(56, 63, 37, E'https://www.emojicode.org/', E'2018-06-03 15:58:16.007164', E'2018-06-03 15:58:16.00717'),
	(57, 73, 36, E'N\'hésitez pas à vous entraider les uns les autres pendant le projet web ! Cette discussion est faites pour ça :)', E'2018-06-03 15:59:42.119588', E'2018-06-03 15:59:42.119594'),
	(58, 64, 38, E'Faire le TP de Math', E'2018-06-03 16:01:43.00752', E'2018-06-03 16:01:43.007526'),
	(59, 73, 38, E'Comment on déploie son site sur Heroku svp ?', E'2018-06-03 16:03:20.737386', E'2018-06-03 16:03:20.737392'),
	(60, 73, 39, E'Il faut que tu commit ton site sur github. Après tu fais le lien entre ton compte heroku et ton repository puis tu déploie. Bonne chance !', E'2018-06-03 16:07:59.191336', E'2018-06-03 16:07:59.191342'),
	(62, 66, 39, E'Super soirée hier !', E'2018-06-03 16:09:18.026531', E'2018-06-03 16:09:18.026537'),
	(63, 66, 38, E'C\'est clair !', E'2018-06-03 16:10:09.445258', E'2018-06-03 16:10:09.445264'),
	(53, 70, 37, E'N\'oubliez pas la soirée blockchain mercredi soir à 20h', E'2018-06-03 15:52:46.541132', E'2018-06-03 15:52:46.541139'),
	(54, 72, 37, E'Vous avez 180 secondes pour présenter votre projet. A vous de déterminer les éléments qui vous semblent pertinents à aborder. Un ordinateur sera mis à votre disposition avec un navigateur internet.', E'2018-06-03 15:56:14.669292', E'2018-06-03 15:56:14.669299');
/*!40000 ALTER TABLE "messages" ENABLE KEYS */;

-- Export de la structure de la table public. schema_migrations
CREATE TABLE IF NOT EXISTS "schema_migrations" (
	"version" BIGINT NOT NULL COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NULL DEFAULT NULL COMMENT E'',
	PRIMARY KEY ("version")
);

-- Export de données de la table public.schema_migrations : 6 rows
DELETE FROM "schema_migrations";
/*!40000 ALTER TABLE "schema_migrations" DISABLE KEYS */;
INSERT INTO "schema_migrations" ("version", "inserted_at") VALUES
	(20180521162140, E'2018-06-01 22:44:07.993802'),
	(20180524152652, E'2018-06-01 22:44:08.030812'),
	(20180525195920, E'2018-06-01 22:44:08.06824'),
	(20180526130111, E'2018-06-01 22:44:08.09095'),
	(20180531145657, E'2018-06-01 22:44:08.125347'),
	(20180601231523, E'2018-06-02 07:47:46.482466');
/*!40000 ALTER TABLE "schema_migrations" ENABLE KEYS */;

-- Export de la structure de la table public. users
CREATE TABLE IF NOT EXISTS "users" (
	"id" BIGINT NOT NULL DEFAULT nextval('users_id_seq'::regclass) COMMENT E'',
	"email" CHARACTER VARYING(255) NOT NULL COMMENT E'',
	"password_hash" CHARACTER VARYING(255) NOT NULL COMMENT E'',
	"username" CHARACTER VARYING(255) NOT NULL COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	"updated_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	UNIQUE KEY ("email")
);

-- Export de données de la table public.users : 0 rows
DELETE FROM "users";
/*!40000 ALTER TABLE "users" DISABLE KEYS */;
INSERT INTO "users" ("id", "email", "password_hash", "username", "inserted_at", "updated_at") VALUES
	(36, E'laurent@lirmm.fr', E'$argon2i$v=19$m=65536,t=6,p=1$ojybAR8OBoy1ywk8UwZvKg$I2tacEeyVoMa2ixgo+gltwyqe7KYPQ14UExqHYAnYGA', E'Anne Laurent', E'2018-06-03 15:39:37.80369', E'2018-06-03 15:39:37.803698'),
	(37, E'arnaud.castelltort@gmail.com', E'$argon2i$v=19$m=65536,t=6,p=1$70M3SZ4HQ815N7FpC8Kz5Q$5JZgM8WsMf+WCeZ0LMi9dPxua4zBleXqFbL6A1z/AVs', E'Arnaud Castelltort', E'2018-06-03 15:40:03.323837', E'2018-06-03 15:40:03.323843'),
	(38, E'paul@gmail.com', E'$argon2i$v=19$m=65536,t=6,p=1$tnZlOJpSM7/ixSwWjV+FAw$hA1Abt3hi8z0tHwfodkBIbXUAd20j0fLEqvm8qU9vts', E'Paul', E'2018-06-03 15:41:13.307573', E'2018-06-03 15:41:13.30758'),
	(39, E'martin@gmail.com', E'$argon2i$v=19$m=65536,t=6,p=1$32Nt4GV00xcHZTxP1ShRVw$BEgcuFyEpn7XV9hTpy1p+ciwabj1VeKPpwCdXUe4D7U', E'Martin', E'2018-06-03 16:06:48.815615', E'2018-06-03 16:06:48.815624');
/*!40000 ALTER TABLE "users" ENABLE KEYS */;

-- Export de la structure de la table public. user_communities
CREATE TABLE IF NOT EXISTS "user_communities" (
	"id" BIGINT NOT NULL DEFAULT nextval('user_communities_id_seq'::regclass) COMMENT E'',
	"user_id" BIGINT NOT NULL COMMENT E'',
	"community_id" BIGINT NOT NULL COMMENT E'',
	"inserted_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	"updated_at" TIMESTAMP WITHOUT TIME ZONE NOT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	KEY ("user_id"),
	KEY ("community_id"),
	UNIQUE KEY ("user_id","community_id")
);

-- Export de données de la table public.user_communities : 0 rows
DELETE FROM "user_communities";
/*!40000 ALTER TABLE "user_communities" DISABLE KEYS */;
INSERT INTO "user_communities" ("id", "user_id", "community_id", "inserted_at", "updated_at") VALUES
	(54, 36, 46, E'2018-06-03 17:39:37.80348', E'2018-06-03 17:39:37.80348'),
	(55, 37, 47, E'2018-06-03 17:40:03.323658', E'2018-06-03 17:40:03.323658'),
	(56, 38, 48, E'2018-06-03 17:41:13.307397', E'2018-06-03 17:41:13.307397'),
	(57, 36, 49, E'2018-06-03 17:42:54.001357', E'2018-06-03 17:42:54.001357'),
	(58, 36, 50, E'2018-06-03 17:48:39.601195', E'2018-06-03 17:48:39.601195'),
	(59, 37, 49, E'2018-06-03 15:50:36.565828', E'2018-06-03 15:50:36.565834'),
	(60, 37, 50, E'2018-06-03 15:55:29.768964', E'2018-06-03 15:55:29.76897'),
	(61, 38, 50, E'2018-06-03 16:01:53.125539', E'2018-06-03 16:01:53.125545'),
	(62, 39, 51, E'2018-06-03 18:06:48.815448', E'2018-06-03 18:06:48.815448'),
	(63, 39, 50, E'2018-06-03 16:07:17.409132', E'2018-06-03 16:07:17.409138'),
	(64, 39, 49, E'2018-06-03 16:09:11.058565', E'2018-06-03 16:09:11.058571'),
	(65, 38, 49, E'2018-06-03 16:09:45.601709', E'2018-06-03 16:09:45.601715');
/*!40000 ALTER TABLE "user_communities" ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
