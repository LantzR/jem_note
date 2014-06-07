--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: jems; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE jems (
    name character varying(255) NOT NULL,
    seq integer DEFAULT 0 NOT NULL,
    comment character varying(50) DEFAULT ''::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT jems_check_jems_seq_0_100 CHECK (((seq >= 0) AND (seq <= 100))),
    CONSTRAINT jems_check_name_not_blank CHECK (((name)::text ~ '^\w'::text)),
    CONSTRAINT jems_check_name_not_empty CHECK (((name)::text <> ''::text))
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: pkey_jems; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jems
    ADD CONSTRAINT pkey_jems PRIMARY KEY (name);


--
-- Name: index_jems_on_seq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_jems_on_seq ON jems USING btree (seq);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140516074702');

