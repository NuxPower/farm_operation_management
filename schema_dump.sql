--
-- PostgreSQL database dump
--

\restrict FyBl1i8MB4Uo2PxqdmqqmGpiNNUG5X08iH0Si1md15XpQ5RpXd0lQRG6TG9ZTcp

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-13 23:41:24 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.weather_logs DROP CONSTRAINT IF EXISTS weather_logs_farm_id_foreign;
ALTER TABLE IF EXISTS ONLY public.weather_alerts DROP CONSTRAINT IF EXISTS weather_alerts_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.weather_alerts DROP CONSTRAINT IF EXISTS weather_alerts_field_id_foreign;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_laborer_group_id_foreign;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_assigned_to_foreign;
ALTER TABLE IF EXISTS ONLY public.task_templates DROP CONSTRAINT IF EXISTS task_templates_rice_growth_stage_id_foreign;
ALTER TABLE IF EXISTS ONLY public.seed_plantings DROP CONSTRAINT IF EXISTS seed_plantings_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.seed_plantings DROP CONSTRAINT IF EXISTS seed_plantings_rice_variety_id_foreign;
ALTER TABLE IF EXISTS ONLY public.scheduled_reports DROP CONSTRAINT IF EXISTS scheduled_reports_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.scheduled_reports DROP CONSTRAINT IF EXISTS scheduled_reports_farm_id_foreign;
ALTER TABLE IF EXISTS ONLY public.sales DROP CONSTRAINT IF EXISTS sales_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.sales DROP CONSTRAINT IF EXISTS sales_rice_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.sales DROP CONSTRAINT IF EXISTS sales_harvest_id_foreign;
ALTER TABLE IF EXISTS ONLY public.sales DROP CONSTRAINT IF EXISTS sales_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_products DROP CONSTRAINT IF EXISTS rice_products_rice_variety_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_products DROP CONSTRAINT IF EXISTS rice_products_inventory_item_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_products DROP CONSTRAINT IF EXISTS rice_products_harvest_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_products DROP CONSTRAINT IF EXISTS rice_products_farmer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_orders DROP CONSTRAINT IF EXISTS rice_orders_rice_product_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_orders DROP CONSTRAINT IF EXISTS rice_orders_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_order_messages DROP CONSTRAINT IF EXISTS rice_order_messages_sender_id_foreign;
ALTER TABLE IF EXISTS ONLY public.rice_order_messages DROP CONSTRAINT IF EXISTS rice_order_messages_rice_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.product_reviews DROP CONSTRAINT IF EXISTS product_reviews_rice_product_id_foreign;
ALTER TABLE IF EXISTS ONLY public.product_reviews DROP CONSTRAINT IF EXISTS product_reviews_rice_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.product_reviews DROP CONSTRAINT IF EXISTS product_reviews_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.price_negotiations DROP CONSTRAINT IF EXISTS price_negotiations_rice_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.price_negotiations DROP CONSTRAINT IF EXISTS price_negotiations_proposer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.plantings DROP CONSTRAINT IF EXISTS plantings_seed_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.plantings DROP CONSTRAINT IF EXISTS plantings_rice_variety_id_foreign;
ALTER TABLE IF EXISTS ONLY public.plantings DROP CONSTRAINT IF EXISTS plantings_field_id_foreign;
ALTER TABLE IF EXISTS ONLY public.planting_stages DROP CONSTRAINT IF EXISTS planting_stages_rice_growth_stage_id_foreign;
ALTER TABLE IF EXISTS ONLY public.planting_stages DROP CONSTRAINT IF EXISTS planting_stages_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.pest_incidents DROP CONSTRAINT IF EXISTS pest_incidents_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.pest_incidents DROP CONSTRAINT IF EXISTS pest_incidents_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.pest_analytics_rules DROP CONSTRAINT IF EXISTS pest_analytics_rules_pest_library_id_foreign;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_inventory_item_id_foreign;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_listing_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_farmer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_orders DROP CONSTRAINT IF EXISTS marketplace_orders_listing_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_orders DROP CONSTRAINT IF EXISTS marketplace_orders_farmer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_orders DROP CONSTRAINT IF EXISTS marketplace_orders_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_listings DROP CONSTRAINT IF EXISTS marketplace_listings_rice_variety_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_listings DROP CONSTRAINT IF EXISTS marketplace_listings_harvest_id_foreign;
ALTER TABLE IF EXISTS ONLY public.marketplace_listings DROP CONSTRAINT IF EXISTS marketplace_listings_farmer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.laborers DROP CONSTRAINT IF EXISTS laborers_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.laborer_groups DROP CONSTRAINT IF EXISTS laborer_groups_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.labor_wages DROP CONSTRAINT IF EXISTS labor_wages_task_id_foreign;
ALTER TABLE IF EXISTS ONLY public.labor_wages DROP CONSTRAINT IF EXISTS labor_wages_laborer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.inventory_transactions DROP CONSTRAINT IF EXISTS inventory_transactions_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.inventory_transactions DROP CONSTRAINT IF EXISTS inventory_transactions_inventory_item_id_foreign;
ALTER TABLE IF EXISTS ONLY public.inventory_items DROP CONSTRAINT IF EXISTS inventory_items_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.inventory_items DROP CONSTRAINT IF EXISTS inventory_items_category_id_foreign;
ALTER TABLE IF EXISTS ONLY public.inventory_alerts DROP CONSTRAINT IF EXISTS inventory_alerts_inventory_item_id_foreign;
ALTER TABLE IF EXISTS ONLY public.harvests DROP CONSTRAINT IF EXISTS harvests_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.group_laborer DROP CONSTRAINT IF EXISTS group_laborer_laborer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.group_laborer DROP CONSTRAINT IF EXISTS group_laborer_laborer_group_id_foreign;
ALTER TABLE IF EXISTS ONLY public.fields DROP CONSTRAINT IF EXISTS fields_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.fields DROP CONSTRAINT IF EXISTS fields_farm_id_foreign;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS favorites_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS favorites_rice_product_id_foreign;
ALTER TABLE IF EXISTS ONLY public.farms DROP CONSTRAINT IF EXISTS farms_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.farms DROP CONSTRAINT IF EXISTS farms_primary_rice_variety_id_foreign;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_rice_product_id_foreign;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_buyer_id_foreign;
ALTER TABLE IF EXISTS ONLY public.buyers DROP CONSTRAINT IF EXISTS buyers_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.automated_tasks DROP CONSTRAINT IF EXISTS automated_tasks_task_template_id_foreign;
ALTER TABLE IF EXISTS ONLY public.automated_tasks DROP CONSTRAINT IF EXISTS automated_tasks_task_id_foreign;
ALTER TABLE IF EXISTS ONLY public.automated_tasks DROP CONSTRAINT IF EXISTS automated_tasks_planting_stage_id_foreign;
ALTER TABLE IF EXISTS ONLY public.automated_tasks DROP CONSTRAINT IF EXISTS automated_tasks_planting_id_foreign;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_user_id_foreign;
DROP INDEX IF EXISTS public.weather_logs_farm_id_recorded_at_index;
DROP INDEX IF EXISTS public.rice_orders_status_payment_status_index;
DROP INDEX IF EXISTS public.rice_orders_order_date_index;
DROP INDEX IF EXISTS public.rice_orders_checkout_group_id_index;
DROP INDEX IF EXISTS public.rice_order_messages_rice_order_id_created_at_index;
DROP INDEX IF EXISTS public.product_reviews_rice_product_id_is_approved_index;
DROP INDEX IF EXISTS public.product_reviews_buyer_id_index;
DROP INDEX IF EXISTS public.price_negotiations_rice_order_id_status_index;
DROP INDEX IF EXISTS public.price_negotiations_rice_order_id_created_at_index;
DROP INDEX IF EXISTS public.pest_incidents_user_id_status_index;
DROP INDEX IF EXISTS public.pest_incidents_planting_id_detected_date_index;
DROP INDEX IF EXISTS public.personal_access_tokens_tokenable_type_tokenable_id_index;
DROP INDEX IF EXISTS public.personal_access_tokens_expires_at_index;
DROP INDEX IF EXISTS public.notifications_user_id_read_at_index;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.inventory_transactions_reference_type_reference_id_index;
DROP INDEX IF EXISTS public.activity_logs_user_id_created_at_index;
DROP INDEX IF EXISTS public.activity_logs_model_type_model_id_index;
DROP INDEX IF EXISTS public.activity_logs_action_index;
ALTER TABLE IF EXISTS ONLY public.weather_logs DROP CONSTRAINT IF EXISTS weather_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.weather_alerts DROP CONSTRAINT IF EXISTS weather_alerts_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_phone_unique;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_unique;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.task_templates DROP CONSTRAINT IF EXISTS task_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.seed_plantings DROP CONSTRAINT IF EXISTS seed_plantings_pkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_reports DROP CONSTRAINT IF EXISTS scheduled_reports_pkey;
ALTER TABLE IF EXISTS ONLY public.sales DROP CONSTRAINT IF EXISTS sales_pkey;
ALTER TABLE IF EXISTS ONLY public.rice_varieties DROP CONSTRAINT IF EXISTS rice_varieties_variety_code_unique;
ALTER TABLE IF EXISTS ONLY public.rice_varieties DROP CONSTRAINT IF EXISTS rice_varieties_pkey;
ALTER TABLE IF EXISTS ONLY public.rice_products DROP CONSTRAINT IF EXISTS rice_products_pkey;
ALTER TABLE IF EXISTS ONLY public.rice_orders DROP CONSTRAINT IF EXISTS rice_orders_pkey;
ALTER TABLE IF EXISTS ONLY public.rice_order_messages DROP CONSTRAINT IF EXISTS rice_order_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.rice_growth_stages DROP CONSTRAINT IF EXISTS rice_growth_stages_stage_code_unique;
ALTER TABLE IF EXISTS ONLY public.rice_growth_stages DROP CONSTRAINT IF EXISTS rice_growth_stages_pkey;
ALTER TABLE IF EXISTS ONLY public.product_reviews DROP CONSTRAINT IF EXISTS product_reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.price_negotiations DROP CONSTRAINT IF EXISTS price_negotiations_pkey;
ALTER TABLE IF EXISTS ONLY public.plantings DROP CONSTRAINT IF EXISTS plantings_pkey;
ALTER TABLE IF EXISTS ONLY public.planting_stages DROP CONSTRAINT IF EXISTS planting_stages_planting_id_rice_growth_stage_id_unique;
ALTER TABLE IF EXISTS ONLY public.planting_stages DROP CONSTRAINT IF EXISTS planting_stages_pkey;
ALTER TABLE IF EXISTS ONLY public.pest_libraries DROP CONSTRAINT IF EXISTS pest_libraries_slug_unique;
ALTER TABLE IF EXISTS ONLY public.pest_libraries DROP CONSTRAINT IF EXISTS pest_libraries_pkey;
ALTER TABLE IF EXISTS ONLY public.pest_incidents DROP CONSTRAINT IF EXISTS pest_incidents_pkey;
ALTER TABLE IF EXISTS ONLY public.pest_analytics_rules DROP CONSTRAINT IF EXISTS pest_analytics_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.marketplace_reviews DROP CONSTRAINT IF EXISTS marketplace_reviews_order_id_unique;
ALTER TABLE IF EXISTS ONLY public.marketplace_orders DROP CONSTRAINT IF EXISTS marketplace_orders_pkey;
ALTER TABLE IF EXISTS ONLY public.marketplace_orders DROP CONSTRAINT IF EXISTS marketplace_orders_order_number_unique;
ALTER TABLE IF EXISTS ONLY public.marketplace_listings DROP CONSTRAINT IF EXISTS marketplace_listings_pkey;
ALTER TABLE IF EXISTS ONLY public.laborers DROP CONSTRAINT IF EXISTS laborers_pkey;
ALTER TABLE IF EXISTS ONLY public.laborer_groups DROP CONSTRAINT IF EXISTS laborer_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.labor_wages DROP CONSTRAINT IF EXISTS labor_wages_pkey;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.job_batches DROP CONSTRAINT IF EXISTS job_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_transactions DROP CONSTRAINT IF EXISTS inventory_transactions_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_items DROP CONSTRAINT IF EXISTS inventory_items_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_categories DROP CONSTRAINT IF EXISTS inventory_categories_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_categories DROP CONSTRAINT IF EXISTS inventory_categories_code_unique;
ALTER TABLE IF EXISTS ONLY public.inventory_alerts DROP CONSTRAINT IF EXISTS inventory_alerts_pkey;
ALTER TABLE IF EXISTS ONLY public.harvests DROP CONSTRAINT IF EXISTS harvests_pkey;
ALTER TABLE IF EXISTS ONLY public.group_laborer DROP CONSTRAINT IF EXISTS group_laborer_pkey;
ALTER TABLE IF EXISTS ONLY public.fields DROP CONSTRAINT IF EXISTS fields_pkey;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS favorites_user_id_rice_product_id_unique;
ALTER TABLE IF EXISTS ONLY public.favorites DROP CONSTRAINT IF EXISTS favorites_pkey;
ALTER TABLE IF EXISTS ONLY public.farms DROP CONSTRAINT IF EXISTS farms_pkey;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_uuid_unique;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_pkey;
ALTER TABLE IF EXISTS ONLY public.cart_items DROP CONSTRAINT IF EXISTS cart_items_buyer_id_rice_product_id_unique;
ALTER TABLE IF EXISTS ONLY public.cache DROP CONSTRAINT IF EXISTS cache_pkey;
ALTER TABLE IF EXISTS ONLY public.cache_locks DROP CONSTRAINT IF EXISTS cache_locks_pkey;
ALTER TABLE IF EXISTS ONLY public.buyers DROP CONSTRAINT IF EXISTS buyers_pkey;
ALTER TABLE IF EXISTS ONLY public.automated_tasks DROP CONSTRAINT IF EXISTS automated_tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_pkey;
ALTER TABLE IF EXISTS public.weather_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.weather_alerts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tasks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.task_templates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.seed_plantings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.scheduled_reports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sales ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rice_varieties ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rice_products ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rice_orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rice_order_messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rice_growth_stages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product_reviews ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.price_negotiations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.plantings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.planting_stages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pest_libraries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pest_incidents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pest_analytics_rules ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.personal_access_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.order_items ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.marketplace_reviews ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.marketplace_orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.marketplace_listings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.laborers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.laborer_groups ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.labor_wages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_transactions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_items ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_alerts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.harvests ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.group_laborer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.fields ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.favorites ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.farms ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.expenses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.cart_items ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.buyers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.automated_tasks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.activity_logs ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.weather_logs_id_seq;
DROP TABLE IF EXISTS public.weather_logs;
DROP SEQUENCE IF EXISTS public.weather_alerts_id_seq;
DROP TABLE IF EXISTS public.weather_alerts;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.tasks_id_seq;
DROP TABLE IF EXISTS public.tasks;
DROP SEQUENCE IF EXISTS public.task_templates_id_seq;
DROP TABLE IF EXISTS public.task_templates;
DROP SEQUENCE IF EXISTS public.seed_plantings_id_seq;
DROP TABLE IF EXISTS public.seed_plantings;
DROP SEQUENCE IF EXISTS public.scheduled_reports_id_seq;
DROP TABLE IF EXISTS public.scheduled_reports;
DROP SEQUENCE IF EXISTS public.sales_id_seq;
DROP TABLE IF EXISTS public.sales;
DROP SEQUENCE IF EXISTS public.rice_varieties_id_seq;
DROP TABLE IF EXISTS public.rice_varieties;
DROP SEQUENCE IF EXISTS public.rice_products_id_seq;
DROP TABLE IF EXISTS public.rice_products;
DROP SEQUENCE IF EXISTS public.rice_orders_id_seq;
DROP TABLE IF EXISTS public.rice_orders;
DROP SEQUENCE IF EXISTS public.rice_order_messages_id_seq;
DROP TABLE IF EXISTS public.rice_order_messages;
DROP SEQUENCE IF EXISTS public.rice_growth_stages_id_seq;
DROP TABLE IF EXISTS public.rice_growth_stages;
DROP SEQUENCE IF EXISTS public.product_reviews_id_seq;
DROP TABLE IF EXISTS public.product_reviews;
DROP SEQUENCE IF EXISTS public.price_negotiations_id_seq;
DROP TABLE IF EXISTS public.price_negotiations;
DROP SEQUENCE IF EXISTS public.plantings_id_seq;
DROP TABLE IF EXISTS public.plantings;
DROP SEQUENCE IF EXISTS public.planting_stages_id_seq;
DROP TABLE IF EXISTS public.planting_stages;
DROP SEQUENCE IF EXISTS public.pest_libraries_id_seq;
DROP TABLE IF EXISTS public.pest_libraries;
DROP SEQUENCE IF EXISTS public.pest_incidents_id_seq;
DROP TABLE IF EXISTS public.pest_incidents;
DROP SEQUENCE IF EXISTS public.pest_analytics_rules_id_seq;
DROP TABLE IF EXISTS public.pest_analytics_rules;
DROP SEQUENCE IF EXISTS public.personal_access_tokens_id_seq;
DROP TABLE IF EXISTS public.personal_access_tokens;
DROP SEQUENCE IF EXISTS public.orders_id_seq;
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public.order_items_id_seq;
DROP TABLE IF EXISTS public.order_items;
DROP SEQUENCE IF EXISTS public.notifications_id_seq;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.marketplace_reviews_id_seq;
DROP TABLE IF EXISTS public.marketplace_reviews;
DROP SEQUENCE IF EXISTS public.marketplace_orders_id_seq;
DROP TABLE IF EXISTS public.marketplace_orders;
DROP SEQUENCE IF EXISTS public.marketplace_listings_id_seq;
DROP TABLE IF EXISTS public.marketplace_listings;
DROP SEQUENCE IF EXISTS public.laborers_id_seq;
DROP TABLE IF EXISTS public.laborers;
DROP SEQUENCE IF EXISTS public.laborer_groups_id_seq;
DROP TABLE IF EXISTS public.laborer_groups;
DROP SEQUENCE IF EXISTS public.labor_wages_id_seq;
DROP TABLE IF EXISTS public.labor_wages;
DROP SEQUENCE IF EXISTS public.jobs_id_seq;
DROP TABLE IF EXISTS public.jobs;
DROP TABLE IF EXISTS public.job_batches;
DROP SEQUENCE IF EXISTS public.inventory_transactions_id_seq;
DROP TABLE IF EXISTS public.inventory_transactions;
DROP SEQUENCE IF EXISTS public.inventory_items_id_seq;
DROP TABLE IF EXISTS public.inventory_items;
DROP SEQUENCE IF EXISTS public.inventory_categories_id_seq;
DROP TABLE IF EXISTS public.inventory_categories;
DROP SEQUENCE IF EXISTS public.inventory_alerts_id_seq;
DROP TABLE IF EXISTS public.inventory_alerts;
DROP SEQUENCE IF EXISTS public.harvests_id_seq;
DROP TABLE IF EXISTS public.harvests;
DROP SEQUENCE IF EXISTS public.group_laborer_id_seq;
DROP TABLE IF EXISTS public.group_laborer;
DROP SEQUENCE IF EXISTS public.fields_id_seq;
DROP TABLE IF EXISTS public.fields;
DROP SEQUENCE IF EXISTS public.favorites_id_seq;
DROP TABLE IF EXISTS public.favorites;
DROP SEQUENCE IF EXISTS public.farms_id_seq;
DROP TABLE IF EXISTS public.farms;
DROP SEQUENCE IF EXISTS public.failed_jobs_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP SEQUENCE IF EXISTS public.expenses_id_seq;
DROP TABLE IF EXISTS public.expenses;
DROP SEQUENCE IF EXISTS public.categories_id_seq;
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public.cart_items_id_seq;
DROP TABLE IF EXISTS public.cart_items;
DROP TABLE IF EXISTS public.cache_locks;
DROP TABLE IF EXISTS public.cache;
DROP SEQUENCE IF EXISTS public.buyers_id_seq;
DROP TABLE IF EXISTS public.buyers;
DROP SEQUENCE IF EXISTS public.automated_tasks_id_seq;
DROP TABLE IF EXISTS public.automated_tasks;
DROP SEQUENCE IF EXISTS public.activity_logs_id_seq;
DROP TABLE IF EXISTS public.activity_logs;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 350708)
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_logs (
    id bigint NOT NULL,
    user_id bigint,
    action character varying(255) NOT NULL,
    model_type character varying(255),
    model_id bigint,
    old_values json,
    new_values json,
    description text,
    ip_address character varying(255),
    user_agent character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 220 (class 1259 OID 350715)
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 220
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- TOC entry 221 (class 1259 OID 350716)
-- Name: automated_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automated_tasks (
    id bigint NOT NULL,
    planting_id bigint NOT NULL,
    planting_stage_id bigint NOT NULL,
    task_template_id bigint NOT NULL,
    task_id bigint,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    scheduled_date timestamp(0) without time zone NOT NULL,
    due_date timestamp(0) without time zone NOT NULL,
    status character varying(255) DEFAULT 'scheduled'::character varying NOT NULL,
    weather_requirements json,
    generated_instructions json,
    delay_reason text,
    completed_at timestamp(0) without time zone,
    auto_generated boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT automated_tasks_status_check CHECK (((status)::text = ANY (ARRAY[('scheduled'::character varying)::text, ('ready'::character varying)::text, ('weather_delayed'::character varying)::text, ('completed'::character varying)::text, ('skipped'::character varying)::text, ('cancelled'::character varying)::text])))
);


--
-- TOC entry 222 (class 1259 OID 350734)
-- Name: automated_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.automated_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 222
-- Name: automated_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.automated_tasks_id_seq OWNED BY public.automated_tasks.id;


--
-- TOC entry 223 (class 1259 OID 350735)
-- Name: buyers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buyers (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    contact_info character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint NOT NULL,
    contact_person character varying(255),
    email character varying(255),
    phone character varying(32),
    type character varying(255) DEFAULT 'individual'::character varying NOT NULL,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    payment_terms character varying(255),
    credit_limit numeric(12,2),
    notes text
);


--
-- TOC entry 224 (class 1259 OID 350749)
-- Name: buyers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 224
-- Name: buyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buyers_id_seq OWNED BY public.buyers.id;


--
-- TOC entry 225 (class 1259 OID 350750)
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 350758)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 350766)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    rice_product_id bigint NOT NULL,
    quantity numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 228 (class 1259 OID 350773)
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 228
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- TOC entry 229 (class 1259 OID 350774)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 230 (class 1259 OID 350781)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 230
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 231 (class 1259 OID 350782)
-- Name: expenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expenses (
    id bigint NOT NULL,
    description text NOT NULL,
    amount numeric(10,2) NOT NULL,
    category character varying(255) NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    planting_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint NOT NULL,
    payment_method character varying(255),
    receipt_number character varying(255),
    notes text,
    related_entity_type character varying(255),
    related_entity_id bigint,
    CONSTRAINT expenses_category_check CHECK (((category)::text = ANY (ARRAY['seeds'::text, 'fertilizer'::text, 'pesticide'::text, 'labor'::text, 'equipment'::text, 'utilities'::text, 'maintenance'::text, 'inventory_purchase'::text, 'other'::text])))
);


--
-- TOC entry 232 (class 1259 OID 350794)
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 232
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- TOC entry 233 (class 1259 OID 350795)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 350808)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 234
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 235 (class 1259 OID 350809)
-- Name: farms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.farms (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    description text,
    total_area numeric(10,2),
    cultivated_area numeric(10,2),
    soil_type character varying(255),
    soil_ph numeric(3,1),
    water_source character varying(255),
    irrigation_type character varying(255),
    primary_rice_variety_id bigint,
    farm_coordinates json,
    elevation numeric(8,2),
    slope numeric(5,2),
    drainage_system character varying(255),
    is_setup_complete boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT farms_drainage_system_check CHECK (((drainage_system)::text = ANY (ARRAY[('good'::character varying)::text, ('moderate'::character varying)::text, ('poor'::character varying)::text]))),
    CONSTRAINT farms_irrigation_type_check CHECK (((irrigation_type)::text = ANY (ARRAY[('flood'::character varying)::text, ('sprinkler'::character varying)::text, ('drip'::character varying)::text, ('furrow'::character varying)::text]))),
    CONSTRAINT farms_soil_type_check CHECK (((soil_type)::text = ANY (ARRAY[('clay'::character varying)::text, ('loam'::character varying)::text, ('sandy_loam'::character varying)::text, ('clay_loam'::character varying)::text, ('silt_loam'::character varying)::text]))),
    CONSTRAINT farms_water_source_check CHECK (((water_source)::text = ANY (ARRAY[('rainfall'::character varying)::text, ('irrigation'::character varying)::text, ('river'::character varying)::text, ('well'::character varying)::text, ('pond'::character varying)::text])))
);


--
-- TOC entry 236 (class 1259 OID 350824)
-- Name: farms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.farms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 236
-- Name: farms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.farms_id_seq OWNED BY public.farms.id;


--
-- TOC entry 237 (class 1259 OID 350825)
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    rice_product_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 238 (class 1259 OID 350831)
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 238
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- TOC entry 239 (class 1259 OID 350832)
-- Name: fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fields (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    farm_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    location json,
    field_coordinates json,
    soil_type character varying(255),
    size numeric(10,2) NOT NULL,
    water_access character varying(255) DEFAULT 'good'::character varying,
    drainage_quality character varying(255) DEFAULT 'good'::character varying,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    soil_ph double precision,
    organic_matter_content double precision,
    nitrogen_level double precision,
    phosphorus_level double precision,
    potassium_level double precision,
    elevation double precision,
    water_source character varying(255),
    irrigation_type character varying(255),
    previous_crop character varying(255),
    field_preparation_status character varying(255) DEFAULT 'needs_assessment'::character varying,
    slope double precision,
    notes text,
    nickname character varying(255),
    planting_method character varying(255),
    cropping_seasons integer,
    target_yield numeric(8,2),
    infrastructure_notes text,
    CONSTRAINT fields_drainage_quality_check CHECK (((drainage_quality)::text = ANY (ARRAY[('excellent'::character varying)::text, ('good'::character varying)::text, ('moderate'::character varying)::text, ('poor'::character varying)::text]))),
    CONSTRAINT fields_water_access_check CHECK (((water_access)::text = ANY (ARRAY[('excellent'::character varying)::text, ('good'::character varying)::text, ('moderate'::character varying)::text, ('poor'::character varying)::text])))
);


--
-- TOC entry 240 (class 1259 OID 350847)
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 240
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fields_id_seq OWNED BY public.fields.id;


--
-- TOC entry 241 (class 1259 OID 350848)
-- Name: group_laborer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_laborer (
    id bigint NOT NULL,
    laborer_group_id bigint NOT NULL,
    laborer_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 242 (class 1259 OID 350854)
-- Name: group_laborer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_laborer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 242
-- Name: group_laborer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_laborer_id_seq OWNED BY public.group_laborer.id;


--
-- TOC entry 243 (class 1259 OID 350855)
-- Name: harvests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.harvests (
    id bigint NOT NULL,
    planting_id bigint NOT NULL,
    yield numeric(10,2) NOT NULL,
    harvest_date timestamp(0) without time zone NOT NULL,
    quality character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    quantity numeric(10,2),
    unit character varying(20) DEFAULT 'kg'::character varying NOT NULL,
    quality_grade character varying(50),
    price_per_unit numeric(10,2),
    total_value numeric(10,2),
    notes text,
    harvester_share numeric(10,2),
    harvester_share_percentage numeric(5,2),
    CONSTRAINT harvests_quality_check CHECK (((quality)::text = ANY (ARRAY[('excellent'::character varying)::text, ('good'::character varying)::text, ('average'::character varying)::text, ('poor'::character varying)::text])))
);


--
-- TOC entry 244 (class 1259 OID 350868)
-- Name: harvests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.harvests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 244
-- Name: harvests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.harvests_id_seq OWNED BY public.harvests.id;


--
-- TOC entry 245 (class 1259 OID 350869)
-- Name: inventory_alerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_alerts (
    id bigint NOT NULL,
    inventory_item_id bigint NOT NULL,
    alert_type character varying(255) NOT NULL,
    severity character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    alert_data json,
    recommendations json,
    is_active boolean DEFAULT true NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT inventory_alerts_alert_type_check CHECK (((alert_type)::text = ANY (ARRAY[('low_stock'::character varying)::text, ('out_of_stock'::character varying)::text, ('expiring'::character varying)::text, ('expired'::character varying)::text, ('reorder_point'::character varying)::text]))),
    CONSTRAINT inventory_alerts_severity_check CHECK (((severity)::text = ANY (ARRAY[('low'::character varying)::text, ('medium'::character varying)::text, ('high'::character varying)::text, ('critical'::character varying)::text])))
);


--
-- TOC entry 246 (class 1259 OID 350886)
-- Name: inventory_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 246
-- Name: inventory_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_alerts_id_seq OWNED BY public.inventory_alerts.id;


--
-- TOC entry 247 (class 1259 OID 350887)
-- Name: inventory_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    description text,
    icon character varying(255),
    color character varying(255) DEFAULT '#6B7280'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    metadata json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 248 (class 1259 OID 350899)
-- Name: inventory_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 248
-- Name: inventory_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_categories_id_seq OWNED BY public.inventory_categories.id;


--
-- TOC entry 249 (class 1259 OID 350900)
-- Name: inventory_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_items (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    quantity numeric(10,2),
    price numeric(8,2),
    unit character varying(255) NOT NULL,
    min_stock numeric(10,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    category_id bigint,
    sku character varying(255),
    brand character varying(255),
    reorder_point numeric(10,2),
    max_stock numeric(10,2),
    cost_per_unit numeric(8,2),
    expiry_date date,
    shelf_life_days integer,
    storage_requirements json,
    usage_instructions json,
    safety_data json,
    supplier character varying(255),
    supplier_contact character varying(255),
    lead_time_days numeric(5,1) DEFAULT '7'::numeric NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    metadata json,
    user_id bigint,
    current_stock numeric(10,2),
    unit_price numeric(8,2),
    minimum_stock numeric(10,2),
    location character varying(255),
    notes text,
    description text
);


--
-- TOC entry 250 (class 1259 OID 350913)
-- Name: inventory_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 250
-- Name: inventory_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_items_id_seq OWNED BY public.inventory_items.id;


--
-- TOC entry 251 (class 1259 OID 350914)
-- Name: inventory_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_transactions (
    id bigint NOT NULL,
    inventory_item_id bigint NOT NULL,
    user_id bigint NOT NULL,
    transaction_type character varying(255) NOT NULL,
    quantity numeric(10,2) NOT NULL,
    unit_cost numeric(8,2),
    total_cost numeric(10,2),
    reference_type character varying(255),
    reference_id bigint,
    notes text,
    transaction_date timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT inventory_transactions_transaction_type_check CHECK (((transaction_type)::text = ANY (ARRAY[('in'::character varying)::text, ('out'::character varying)::text, ('adjustment'::character varying)::text, ('loss'::character varying)::text, ('transfer'::character varying)::text])))
);


--
-- TOC entry 252 (class 1259 OID 350926)
-- Name: inventory_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 252
-- Name: inventory_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_transactions_id_seq OWNED BY public.inventory_transactions.id;


--
-- TOC entry 253 (class 1259 OID 350927)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- TOC entry 254 (class 1259 OID 350939)
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 350950)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 255
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 256 (class 1259 OID 350951)
-- Name: labor_wages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.labor_wages (
    id bigint NOT NULL,
    laborer_id bigint NOT NULL,
    task_id bigint NOT NULL,
    hours_worked numeric(8,2) NOT NULL,
    wage_amount numeric(8,2) NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 257 (class 1259 OID 350960)
-- Name: labor_wages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.labor_wages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 257
-- Name: labor_wages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.labor_wages_id_seq OWNED BY public.labor_wages.id;


--
-- TOC entry 258 (class 1259 OID 350961)
-- Name: laborer_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.laborer_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    color character varying(255) DEFAULT '#10B981'::character varying,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 259 (class 1259 OID 350970)
-- Name: laborer_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.laborer_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 259
-- Name: laborer_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.laborer_groups_id_seq OWNED BY public.laborer_groups.id;


--
-- TOC entry 260 (class 1259 OID 350971)
-- Name: laborers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.laborers (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    rate numeric(8,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint,
    phone character varying(255),
    email character varying(255),
    address character varying(255),
    skill_level character varying(255),
    specialization character varying(255),
    status character varying(255),
    hire_date date,
    notes text,
    emergency_contact_name character varying(255),
    emergency_contact_phone character varying(255),
    rate_type character varying(255) DEFAULT 'daily'::character varying NOT NULL,
    profile_picture character varying(255)
);


--
-- TOC entry 261 (class 1259 OID 350980)
-- Name: laborers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.laborers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 261
-- Name: laborers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.laborers_id_seq OWNED BY public.laborers.id;


--
-- TOC entry 262 (class 1259 OID 350981)
-- Name: marketplace_listings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketplace_listings (
    id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    harvest_id bigint,
    rice_variety_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    quantity_available numeric(10,2) NOT NULL,
    price_per_kg numeric(8,2) NOT NULL,
    unit character varying(255) DEFAULT 'kg'::character varying NOT NULL,
    quality_grade character varying(255) NOT NULL,
    moisture_content numeric(5,2),
    harvest_details json,
    images json,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    available_from timestamp(0) without time zone,
    available_until timestamp(0) without time zone,
    location character varying(255) NOT NULL,
    delivery_options json,
    minimum_order numeric(8,2) DEFAULT '1'::numeric NOT NULL,
    terms_conditions text,
    is_featured boolean DEFAULT false NOT NULL,
    views_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT marketplace_listings_quality_grade_check CHECK (((quality_grade)::text = ANY (ARRAY[('premium'::character varying)::text, ('grade_a'::character varying)::text, ('grade_b'::character varying)::text, ('standard'::character varying)::text]))),
    CONSTRAINT marketplace_listings_status_check CHECK (((status)::text = ANY (ARRAY[('draft'::character varying)::text, ('active'::character varying)::text, ('sold_out'::character varying)::text, ('expired'::character varying)::text, ('suspended'::character varying)::text])))
);


--
-- TOC entry 263 (class 1259 OID 351007)
-- Name: marketplace_listings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 263
-- Name: marketplace_listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_listings_id_seq OWNED BY public.marketplace_listings.id;


--
-- TOC entry 264 (class 1259 OID 351008)
-- Name: marketplace_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketplace_orders (
    id bigint NOT NULL,
    order_number character varying(255) NOT NULL,
    buyer_id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    quantity numeric(10,2) NOT NULL,
    unit_price numeric(8,2) NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    payment_status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    delivery_method character varying(255) NOT NULL,
    delivery_address json,
    buyer_notes text,
    farmer_notes text,
    requested_delivery_date timestamp(0) without time zone,
    confirmed_at timestamp(0) without time zone,
    delivered_at timestamp(0) without time zone,
    tracking_info json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT marketplace_orders_delivery_method_check CHECK (((delivery_method)::text = ANY (ARRAY[('pickup'::character varying)::text, ('delivery'::character varying)::text, ('shipping'::character varying)::text]))),
    CONSTRAINT marketplace_orders_payment_status_check CHECK (((payment_status)::text = ANY (ARRAY[('pending'::character varying)::text, ('paid'::character varying)::text, ('refunded'::character varying)::text, ('failed'::character varying)::text]))),
    CONSTRAINT marketplace_orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('confirmed'::character varying)::text, ('preparing'::character varying)::text, ('ready_for_pickup'::character varying)::text, ('in_transit'::character varying)::text, ('delivered'::character varying)::text, ('cancelled'::character varying)::text, ('disputed'::character varying)::text])))
);


--
-- TOC entry 265 (class 1259 OID 351029)
-- Name: marketplace_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 265
-- Name: marketplace_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_orders_id_seq OWNED BY public.marketplace_orders.id;


--
-- TOC entry 266 (class 1259 OID 351030)
-- Name: marketplace_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketplace_reviews (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    rating integer NOT NULL,
    review_text text,
    review_categories json,
    images json,
    is_verified_purchase boolean DEFAULT true NOT NULL,
    farmer_response text,
    farmer_responded_at timestamp(0) without time zone,
    is_featured boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 267 (class 1259 OID 351045)
-- Name: marketplace_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 267
-- Name: marketplace_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_reviews_id_seq OWNED BY public.marketplace_reviews.id;


--
-- TOC entry 268 (class 1259 OID 351046)
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- TOC entry 269 (class 1259 OID 351052)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 269
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 270 (class 1259 OID 351053)
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    data json,
    link character varying(255),
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 271 (class 1259 OID 351063)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 271
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 272 (class 1259 OID 351064)
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    inventory_item_id bigint NOT NULL,
    quantity numeric(10,2) NOT NULL,
    unit_price numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 273 (class 1259 OID 351072)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 273
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 274 (class 1259 OID 351073)
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    order_date date,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('confirmed'::character varying)::text, ('processing'::character varying)::text, ('shipped'::character varying)::text, ('delivered'::character varying)::text, ('cancelled'::character varying)::text])))
);


--
-- TOC entry 275 (class 1259 OID 351082)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 275
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 276 (class 1259 OID 351083)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 277 (class 1259 OID 351093)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 277
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 278 (class 1259 OID 351094)
-- Name: pest_analytics_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pest_analytics_rules (
    id bigint NOT NULL,
    pest_library_id bigint NOT NULL,
    metric character varying(255) NOT NULL,
    condition character varying(255) NOT NULL,
    value_min numeric(8,2),
    value_max numeric(8,2),
    duration_hours integer,
    risk_level character varying(255) NOT NULL,
    risk_message text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 279 (class 1259 OID 351105)
-- Name: pest_analytics_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_analytics_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 279
-- Name: pest_analytics_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_analytics_rules_id_seq OWNED BY public.pest_analytics_rules.id;


--
-- TOC entry 280 (class 1259 OID 351106)
-- Name: pest_incidents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pest_incidents (
    id bigint NOT NULL,
    planting_id bigint NOT NULL,
    user_id bigint NOT NULL,
    pest_type character varying(255) NOT NULL,
    pest_name character varying(255) NOT NULL,
    severity character varying(255) NOT NULL,
    affected_area numeric(10,2),
    detected_date date NOT NULL,
    symptoms text,
    treatment_applied text,
    treatment_date date,
    treatment_cost numeric(10,2),
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    notes text,
    images json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 281 (class 1259 OID 351120)
-- Name: pest_incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 281
-- Name: pest_incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_incidents_id_seq OWNED BY public.pest_incidents.id;


--
-- TOC entry 282 (class 1259 OID 351121)
-- Name: pest_libraries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pest_libraries (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    scientific_name character varying(255),
    description text,
    symptoms text,
    treatment_guidance text,
    images json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 283 (class 1259 OID 351130)
-- Name: pest_libraries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_libraries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 283
-- Name: pest_libraries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_libraries_id_seq OWNED BY public.pest_libraries.id;


--
-- TOC entry 284 (class 1259 OID 351131)
-- Name: planting_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.planting_stages (
    id bigint NOT NULL,
    planting_id bigint NOT NULL,
    rice_growth_stage_id bigint NOT NULL,
    started_at timestamp(0) without time zone,
    completed_at timestamp(0) without time zone,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    notes text,
    stage_data json,
    completion_percentage numeric(5,2) DEFAULT '0'::numeric NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT planting_stages_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('in_progress'::character varying)::text, ('completed'::character varying)::text, ('delayed'::character varying)::text, ('skipped'::character varying)::text])))
);


--
-- TOC entry 285 (class 1259 OID 351144)
-- Name: planting_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.planting_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 285
-- Name: planting_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.planting_stages_id_seq OWNED BY public.planting_stages.id;


--
-- TOC entry 286 (class 1259 OID 351145)
-- Name: plantings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plantings (
    id bigint NOT NULL,
    field_id bigint NOT NULL,
    rice_variety_id bigint NOT NULL,
    crop_type character varying(255) DEFAULT 'rice'::character varying NOT NULL,
    planting_date timestamp(0) without time zone NOT NULL,
    expected_harvest_date timestamp(0) without time zone NOT NULL,
    actual_harvest_date timestamp(0) without time zone,
    status character varying(255) DEFAULT 'planted'::character varying NOT NULL,
    planting_method character varying(255) DEFAULT 'transplanting'::character varying NOT NULL,
    seed_rate numeric(8,2),
    area_planted numeric(10,2) NOT NULL,
    season character varying(255) NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    seed_planting_id bigint,
    seed_unit character varying(255),
    CONSTRAINT plantings_planting_method_check CHECK (((planting_method)::text = ANY (ARRAY[('direct_seeding'::character varying)::text, ('transplanting'::character varying)::text, ('broadcasting'::character varying)::text]))),
    CONSTRAINT plantings_season_check CHECK (((season)::text = ANY (ARRAY[('wet'::character varying)::text, ('dry'::character varying)::text]))),
    CONSTRAINT plantings_status_check CHECK (((status)::text = ANY (ARRAY[('planned'::character varying)::text, ('planted'::character varying)::text, ('growing'::character varying)::text, ('ready'::character varying)::text, ('harvested'::character varying)::text, ('failed'::character varying)::text])))
);


--
-- TOC entry 287 (class 1259 OID 351166)
-- Name: plantings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plantings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 287
-- Name: plantings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plantings_id_seq OWNED BY public.plantings.id;


--
-- TOC entry 288 (class 1259 OID 351167)
-- Name: price_negotiations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_negotiations (
    id bigint NOT NULL,
    rice_order_id bigint NOT NULL,
    proposer_id bigint NOT NULL,
    proposed_price numeric(10,2) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    response_message text,
    responded_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT price_negotiations_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('accepted'::character varying)::text, ('rejected'::character varying)::text, ('superseded'::character varying)::text])))
);


--
-- TOC entry 289 (class 1259 OID 351179)
-- Name: price_negotiations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_negotiations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 289
-- Name: price_negotiations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_negotiations_id_seq OWNED BY public.price_negotiations.id;


--
-- TOC entry 290 (class 1259 OID 351180)
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_reviews (
    id bigint NOT NULL,
    rice_product_id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    rice_order_id bigint,
    rating numeric(3,1) NOT NULL,
    title character varying(255),
    review_text text,
    quality_rating numeric(3,1),
    delivery_rating numeric(3,1),
    farmer_rating numeric(3,1),
    would_recommend boolean DEFAULT false NOT NULL,
    verified_purchase boolean DEFAULT false NOT NULL,
    images json,
    helpful_votes integer DEFAULT 0 NOT NULL,
    is_approved boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 291 (class 1259 OID 351197)
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 291
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- TOC entry 292 (class 1259 OID 351198)
-- Name: rice_growth_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rice_growth_stages (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    stage_code character varying(255) NOT NULL,
    description text,
    typical_duration_days integer NOT NULL,
    order_sequence integer NOT NULL,
    key_activities json,
    weather_requirements json,
    nutrient_requirements json,
    water_requirements json,
    common_problems json,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 293 (class 1259 OID 351210)
-- Name: rice_growth_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_growth_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 293
-- Name: rice_growth_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_growth_stages_id_seq OWNED BY public.rice_growth_stages.id;


--
-- TOC entry 294 (class 1259 OID 351211)
-- Name: rice_order_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rice_order_messages (
    id bigint NOT NULL,
    rice_order_id bigint NOT NULL,
    sender_id bigint NOT NULL,
    message text NOT NULL,
    attachments json,
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 295 (class 1259 OID 351220)
-- Name: rice_order_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_order_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 295
-- Name: rice_order_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_order_messages_id_seq OWNED BY public.rice_order_messages.id;


--
-- TOC entry 296 (class 1259 OID 351221)
-- Name: rice_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rice_orders (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    rice_product_id bigint NOT NULL,
    quantity numeric(12,2) NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    total_amount numeric(14,2) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    delivery_address json NOT NULL,
    delivery_method character varying(255) NOT NULL,
    payment_method character varying(255) NOT NULL,
    payment_status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    notes text,
    order_date timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expected_delivery_date date,
    actual_delivery_date date,
    tracking_number character varying(255),
    farmer_notes text,
    buyer_notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_pre_order boolean DEFAULT false NOT NULL,
    available_date date,
    notification_sent_available boolean DEFAULT false NOT NULL,
    notification_sent_day_before boolean DEFAULT false NOT NULL,
    shipped_at timestamp(0) without time zone,
    auto_confirm_at timestamp(0) without time zone,
    dispute_reason text,
    offer_price numeric(10,2),
    pickup_deadline timestamp(0) without time zone,
    preferred_pickup_date date,
    confirmed_pickup_date date,
    checkout_group_id uuid,
    CONSTRAINT rice_orders_delivery_method_check CHECK (((delivery_method)::text = ANY (ARRAY[('pickup'::character varying)::text, ('courier'::character varying)::text, ('postal'::character varying)::text, ('truck'::character varying)::text]))),
    CONSTRAINT rice_orders_payment_status_check CHECK (((payment_status)::text = ANY (ARRAY[('pending'::character varying)::text, ('paid'::character varying)::text, ('partial'::character varying)::text, ('refunded'::character varying)::text, ('failed'::character varying)::text]))),
    CONSTRAINT rice_orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('confirmed'::character varying)::text, ('processing'::character varying)::text, ('shipped'::character varying)::text, ('delivered'::character varying)::text, ('cancelled'::character varying)::text, ('refunded'::character varying)::text, ('disputed'::character varying)::text, ('ready_for_pickup'::character varying)::text, ('picked_up'::character varying)::text, ('negotiating'::character varying)::text])))
);


--
-- TOC entry 297 (class 1259 OID 351250)
-- Name: rice_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 297
-- Name: rice_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_orders_id_seq OWNED BY public.rice_orders.id;


--
-- TOC entry 298 (class 1259 OID 351251)
-- Name: rice_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rice_products (
    id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    rice_variety_id bigint NOT NULL,
    harvest_id bigint,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    quantity_available numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    unit character varying(20) DEFAULT 'kg'::character varying NOT NULL,
    price_per_unit numeric(12,2) NOT NULL,
    quality_grade character varying(255) NOT NULL,
    moisture_content numeric(5,2),
    purity_percentage numeric(5,2),
    harvest_date date,
    processing_method character varying(255),
    storage_conditions character varying(255),
    certification character varying(255),
    images json,
    location json,
    is_organic boolean DEFAULT false NOT NULL,
    is_available boolean DEFAULT true NOT NULL,
    minimum_order_quantity numeric(12,2),
    packaging_options json,
    delivery_options json,
    payment_terms character varying(255),
    contact_info json,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    production_status character varying(255) DEFAULT 'available'::character varying NOT NULL,
    available_from date,
    inventory_item_id bigint,
    CONSTRAINT rice_products_processing_method_check CHECK (((processing_method)::text = ANY (ARRAY[('milled'::character varying)::text, ('brown'::character varying)::text, ('parboiled'::character varying)::text, ('organic'::character varying)::text]))),
    CONSTRAINT rice_products_production_status_check CHECK (((production_status)::text = ANY (ARRAY[('available'::character varying)::text, ('in_production'::character varying)::text, ('out_of_stock'::character varying)::text]))),
    CONSTRAINT rice_products_quality_grade_check CHECK (((quality_grade)::text = ANY (ARRAY[('premium'::character varying)::text, ('grade_a'::character varying)::text, ('grade_b'::character varying)::text, ('commercial'::character varying)::text])))
);


--
-- TOC entry 299 (class 1259 OID 351276)
-- Name: rice_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 299
-- Name: rice_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_products_id_seq OWNED BY public.rice_products.id;


--
-- TOC entry 300 (class 1259 OID 351277)
-- Name: rice_varieties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rice_varieties (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    variety_code character varying(255) NOT NULL,
    description text,
    maturity_days integer NOT NULL,
    average_yield_per_hectare numeric(8,2) NOT NULL,
    season character varying(255) NOT NULL,
    grain_type character varying(255) NOT NULL,
    resistance_level character varying(255) NOT NULL,
    characteristics json,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT rice_varieties_grain_type_check CHECK (((grain_type)::text = ANY (ARRAY[('long'::character varying)::text, ('medium'::character varying)::text, ('short'::character varying)::text]))),
    CONSTRAINT rice_varieties_resistance_level_check CHECK (((resistance_level)::text = ANY (ARRAY[('high'::character varying)::text, ('medium'::character varying)::text, ('low'::character varying)::text]))),
    CONSTRAINT rice_varieties_season_check CHECK (((season)::text = ANY (ARRAY[('wet'::character varying)::text, ('dry'::character varying)::text, ('both'::character varying)::text])))
);


--
-- TOC entry 301 (class 1259 OID 351295)
-- Name: rice_varieties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_varieties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 301
-- Name: rice_varieties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_varieties_id_seq OWNED BY public.rice_varieties.id;


--
-- TOC entry 302 (class 1259 OID 351296)
-- Name: sales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales (
    id bigint NOT NULL,
    harvest_id bigint,
    buyer_id bigint NOT NULL,
    quantity numeric(10,2) NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    sale_date timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id bigint NOT NULL,
    unit_price numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    payment_method character varying(255) DEFAULT 'cash'::character varying NOT NULL,
    payment_status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    delivery_date date,
    delivery_address character varying(255),
    notes text,
    rice_order_id bigint,
    CONSTRAINT sales_payment_method_check CHECK (((payment_method)::text = ANY (ARRAY[('cash'::character varying)::text, ('bank_transfer'::character varying)::text, ('check'::character varying)::text, ('credit'::character varying)::text]))),
    CONSTRAINT sales_payment_status_check CHECK (((payment_status)::text = ANY (ARRAY[('pending'::character varying)::text, ('paid'::character varying)::text, ('partial'::character varying)::text, ('overdue'::character varying)::text])))
);


--
-- TOC entry 303 (class 1259 OID 351315)
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 303
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- TOC entry 304 (class 1259 OID 351316)
-- Name: scheduled_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scheduled_reports (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    farm_id bigint NOT NULL,
    report_type character varying(255) NOT NULL,
    frequency character varying(255) NOT NULL,
    email character varying(255),
    parameters json,
    is_active boolean DEFAULT true NOT NULL,
    last_sent_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 305 (class 1259 OID 351328)
-- Name: scheduled_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scheduled_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 305
-- Name: scheduled_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scheduled_reports_id_seq OWNED BY public.scheduled_reports.id;


--
-- TOC entry 306 (class 1259 OID 351329)
-- Name: seed_plantings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seed_plantings (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    rice_variety_id bigint NOT NULL,
    planting_date date NOT NULL,
    expected_transplant_date date,
    quantity numeric(10,2) NOT NULL,
    unit character varying(255) DEFAULT 'kg'::character varying NOT NULL,
    status character varying(255) DEFAULT 'sown'::character varying NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    batch_id character varying(255),
    CONSTRAINT seed_plantings_status_check CHECK (((status)::text = ANY (ARRAY[('sown'::character varying)::text, ('germinating'::character varying)::text, ('ready'::character varying)::text, ('transplanted'::character varying)::text, ('failed'::character varying)::text])))
);


--
-- TOC entry 307 (class 1259 OID 351344)
-- Name: seed_plantings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seed_plantings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 307
-- Name: seed_plantings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seed_plantings_id_seq OWNED BY public.seed_plantings.id;


--
-- TOC entry 308 (class 1259 OID 351345)
-- Name: task_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_templates (
    id bigint NOT NULL,
    rice_growth_stage_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    task_type character varying(255) NOT NULL,
    days_from_stage_start integer DEFAULT 0 NOT NULL,
    estimated_duration_hours integer DEFAULT 1 NOT NULL,
    priority character varying(255) DEFAULT 'medium'::character varying NOT NULL,
    weather_conditions json,
    required_materials json,
    instructions json,
    safety_notes json,
    is_mandatory boolean DEFAULT true NOT NULL,
    is_weather_dependent boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT task_templates_priority_check CHECK (((priority)::text = ANY (ARRAY[('low'::character varying)::text, ('medium'::character varying)::text, ('high'::character varying)::text, ('critical'::character varying)::text]))),
    CONSTRAINT task_templates_task_type_check CHECK (((task_type)::text = ANY (ARRAY[('watering'::character varying)::text, ('fertilizing'::character varying)::text, ('weeding'::character varying)::text, ('pest_control'::character varying)::text, ('harvesting'::character varying)::text, ('maintenance'::character varying)::text])))
);


--
-- TOC entry 309 (class 1259 OID 351369)
-- Name: task_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 309
-- Name: task_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_templates_id_seq OWNED BY public.task_templates.id;


--
-- TOC entry 310 (class 1259 OID 351370)
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    planting_id bigint NOT NULL,
    task_type character varying(255) NOT NULL,
    due_date timestamp(0) without time zone NOT NULL,
    description text,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    assigned_to bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    laborer_group_id bigint,
    payment_type character varying(255) DEFAULT 'wage'::character varying NOT NULL,
    revenue_share_percentage numeric(5,2),
    wage_amount numeric(10,2),
    unit character varying(255),
    quantity numeric(10,2),
    unit_price numeric(10,2),
    CONSTRAINT tasks_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('in_progress'::character varying)::text, ('completed'::character varying)::text, ('cancelled'::character varying)::text])))
);


--
-- TOC entry 311 (class 1259 OID 351384)
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 311
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 312 (class 1259 OID 351385)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255),
    email character varying(255),
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'farmer'::character varying NOT NULL,
    phone character varying(255) NOT NULL,
    address json,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    first_name character varying(255),
    middle_initial character varying(255),
    last_name character varying(255),
    phone_verified_at timestamp(0) without time zone,
    verification_code character varying(255),
    profile_picture character varying(255),
    bio text,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('farmer'::character varying)::text, ('buyer'::character varying)::text])))
);


--
-- TOC entry 313 (class 1259 OID 351396)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 313
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 314 (class 1259 OID 351397)
-- Name: weather_alerts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weather_alerts (
    id bigint NOT NULL,
    field_id bigint NOT NULL,
    planting_id bigint,
    alert_type character varying(255) NOT NULL,
    severity character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    weather_data json,
    recommendations json,
    alert_date timestamp(0) without time zone NOT NULL,
    expires_at timestamp(0) without time zone,
    is_active boolean DEFAULT true NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT weather_alerts_alert_type_check CHECK (((alert_type)::text = ANY (ARRAY[('drought'::character varying)::text, ('flood'::character varying)::text, ('extreme_heat'::character varying)::text, ('cold_stress'::character varying)::text, ('high_humidity'::character varying)::text, ('strong_wind'::character varying)::text, ('pest_risk'::character varying)::text, ('disease_risk'::character varying)::text]))),
    CONSTRAINT weather_alerts_severity_check CHECK (((severity)::text = ANY (ARRAY[('low'::character varying)::text, ('medium'::character varying)::text, ('high'::character varying)::text, ('critical'::character varying)::text])))
);


--
-- TOC entry 315 (class 1259 OID 351415)
-- Name: weather_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.weather_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 315
-- Name: weather_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.weather_alerts_id_seq OWNED BY public.weather_alerts.id;


--
-- TOC entry 316 (class 1259 OID 351416)
-- Name: weather_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weather_logs (
    id bigint NOT NULL,
    temperature numeric(5,1) NOT NULL,
    humidity numeric(5,1) NOT NULL,
    wind_speed numeric(5,1) NOT NULL,
    conditions character varying(255) NOT NULL,
    recorded_at timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    rainfall numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    farm_id bigint NOT NULL,
    CONSTRAINT weather_logs_conditions_check CHECK (((conditions)::text = ANY (ARRAY[('clear'::character varying)::text, ('cloudy'::character varying)::text, ('rainy'::character varying)::text, ('stormy'::character varying)::text, ('snowy'::character varying)::text, ('foggy'::character varying)::text])))
);


--
-- TOC entry 317 (class 1259 OID 351429)
-- Name: weather_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.weather_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 317
-- Name: weather_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.weather_logs_id_seq OWNED BY public.weather_logs.id;


--
-- TOC entry 3536 (class 2604 OID 351430)
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- TOC entry 3537 (class 2604 OID 351431)
-- Name: automated_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks ALTER COLUMN id SET DEFAULT nextval('public.automated_tasks_id_seq'::regclass);


--
-- TOC entry 3540 (class 2604 OID 351432)
-- Name: buyers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers ALTER COLUMN id SET DEFAULT nextval('public.buyers_id_seq'::regclass);


--
-- TOC entry 3543 (class 2604 OID 351433)
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- TOC entry 3544 (class 2604 OID 351434)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 3545 (class 2604 OID 351435)
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- TOC entry 3546 (class 2604 OID 351436)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3548 (class 2604 OID 351437)
-- Name: farms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms ALTER COLUMN id SET DEFAULT nextval('public.farms_id_seq'::regclass);


--
-- TOC entry 3550 (class 2604 OID 351438)
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- TOC entry 3551 (class 2604 OID 351439)
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);


--
-- TOC entry 3555 (class 2604 OID 351440)
-- Name: group_laborer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer ALTER COLUMN id SET DEFAULT nextval('public.group_laborer_id_seq'::regclass);


--
-- TOC entry 3556 (class 2604 OID 351441)
-- Name: harvests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests ALTER COLUMN id SET DEFAULT nextval('public.harvests_id_seq'::regclass);


--
-- TOC entry 3558 (class 2604 OID 351442)
-- Name: inventory_alerts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts ALTER COLUMN id SET DEFAULT nextval('public.inventory_alerts_id_seq'::regclass);


--
-- TOC entry 3561 (class 2604 OID 351443)
-- Name: inventory_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories ALTER COLUMN id SET DEFAULT nextval('public.inventory_categories_id_seq'::regclass);


--
-- TOC entry 3564 (class 2604 OID 351444)
-- Name: inventory_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items ALTER COLUMN id SET DEFAULT nextval('public.inventory_items_id_seq'::regclass);


--
-- TOC entry 3567 (class 2604 OID 351445)
-- Name: inventory_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions ALTER COLUMN id SET DEFAULT nextval('public.inventory_transactions_id_seq'::regclass);


--
-- TOC entry 3568 (class 2604 OID 351446)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3569 (class 2604 OID 351447)
-- Name: labor_wages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages ALTER COLUMN id SET DEFAULT nextval('public.labor_wages_id_seq'::regclass);


--
-- TOC entry 3570 (class 2604 OID 351448)
-- Name: laborer_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups ALTER COLUMN id SET DEFAULT nextval('public.laborer_groups_id_seq'::regclass);


--
-- TOC entry 3572 (class 2604 OID 351449)
-- Name: laborers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers ALTER COLUMN id SET DEFAULT nextval('public.laborers_id_seq'::regclass);


--
-- TOC entry 3574 (class 2604 OID 351450)
-- Name: marketplace_listings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings ALTER COLUMN id SET DEFAULT nextval('public.marketplace_listings_id_seq'::regclass);


--
-- TOC entry 3580 (class 2604 OID 351451)
-- Name: marketplace_orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders ALTER COLUMN id SET DEFAULT nextval('public.marketplace_orders_id_seq'::regclass);


--
-- TOC entry 3583 (class 2604 OID 351452)
-- Name: marketplace_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews ALTER COLUMN id SET DEFAULT nextval('public.marketplace_reviews_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 351453)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3587 (class 2604 OID 351454)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 3588 (class 2604 OID 351455)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 3589 (class 2604 OID 351456)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 3591 (class 2604 OID 351457)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 3592 (class 2604 OID 351458)
-- Name: pest_analytics_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules ALTER COLUMN id SET DEFAULT nextval('public.pest_analytics_rules_id_seq'::regclass);


--
-- TOC entry 3593 (class 2604 OID 351459)
-- Name: pest_incidents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents ALTER COLUMN id SET DEFAULT nextval('public.pest_incidents_id_seq'::regclass);


--
-- TOC entry 3595 (class 2604 OID 351460)
-- Name: pest_libraries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries ALTER COLUMN id SET DEFAULT nextval('public.pest_libraries_id_seq'::regclass);


--
-- TOC entry 3596 (class 2604 OID 351461)
-- Name: planting_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages ALTER COLUMN id SET DEFAULT nextval('public.planting_stages_id_seq'::regclass);


--
-- TOC entry 3599 (class 2604 OID 351462)
-- Name: plantings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings ALTER COLUMN id SET DEFAULT nextval('public.plantings_id_seq'::regclass);


--
-- TOC entry 3603 (class 2604 OID 351463)
-- Name: price_negotiations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations ALTER COLUMN id SET DEFAULT nextval('public.price_negotiations_id_seq'::regclass);


--
-- TOC entry 3605 (class 2604 OID 351464)
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- TOC entry 3610 (class 2604 OID 351465)
-- Name: rice_growth_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages ALTER COLUMN id SET DEFAULT nextval('public.rice_growth_stages_id_seq'::regclass);


--
-- TOC entry 3612 (class 2604 OID 351466)
-- Name: rice_order_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages ALTER COLUMN id SET DEFAULT nextval('public.rice_order_messages_id_seq'::regclass);


--
-- TOC entry 3613 (class 2604 OID 351467)
-- Name: rice_orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders ALTER COLUMN id SET DEFAULT nextval('public.rice_orders_id_seq'::regclass);


--
-- TOC entry 3620 (class 2604 OID 351468)
-- Name: rice_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products ALTER COLUMN id SET DEFAULT nextval('public.rice_products_id_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 351469)
-- Name: rice_varieties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties ALTER COLUMN id SET DEFAULT nextval('public.rice_varieties_id_seq'::regclass);


--
-- TOC entry 3628 (class 2604 OID 351470)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 3632 (class 2604 OID 351471)
-- Name: scheduled_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports ALTER COLUMN id SET DEFAULT nextval('public.scheduled_reports_id_seq'::regclass);


--
-- TOC entry 3634 (class 2604 OID 351472)
-- Name: seed_plantings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings ALTER COLUMN id SET DEFAULT nextval('public.seed_plantings_id_seq'::regclass);


--
-- TOC entry 3637 (class 2604 OID 351473)
-- Name: task_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates ALTER COLUMN id SET DEFAULT nextval('public.task_templates_id_seq'::regclass);


--
-- TOC entry 3644 (class 2604 OID 351474)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 3647 (class 2604 OID 351475)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3649 (class 2604 OID 351476)
-- Name: weather_alerts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts ALTER COLUMN id SET DEFAULT nextval('public.weather_alerts_id_seq'::regclass);


--
-- TOC entry 3652 (class 2604 OID 351477)
-- Name: weather_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs ALTER COLUMN id SET DEFAULT nextval('public.weather_logs_id_seq'::regclass);


--
-- TOC entry 4068 (class 0 OID 350708)
-- Dependencies: 219
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.activity_logs (id, user_id, action, model_type, model_id, old_values, new_values, description, ip_address, user_agent, created_at, updated_at) FROM stdin;
1	1	product.created	App\\Models\\RiceProduct	1	\N	{"rice_variety_id":1,"harvest_id":1,"name":"IR64","description":"wow","quantity_available":"255.00","unit":"sacks","price_per_unit":"1500.00","quality_grade":"premium","is_organic":false,"images":["\\/storage\\/products\\/33fef96b-a6e1-4fe6-b56d-ffb0a92fb667.webp"],"farmer_id":1,"is_available":true,"production_status":"available","updated_at":"2026-02-12T09:03:48.000000Z","created_at":"2026-02-12T09:03:48.000000Z","id":1}	New product listing published	143.44.193.223	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 OPR/127.0.0.0	2026-02-12 09:03:48	2026-02-12 09:03:48
2	\N	user.registered	App\\Models\\User	2	\N	{"first_name":"Janos","middle_initial":"A","last_name":"Panague","name":"Janos Panague","email":"janospanague1@gmail.com","role":"buyer","phone":"09624351441","address":null,"verification_code":"166912","updated_at":"2026-02-12T09:04:31.000000Z","created_at":"2026-02-12T09:04:31.000000Z","id":2}	New buyer registration	143.44.193.223	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 OPR/127.0.0.0	2026-02-12 09:04:34	2026-02-12 09:04:34
3	1	product.created	App\\Models\\RiceProduct	2	\N	{"rice_variety_id":2,"harvest_id":2,"name":"Thai Jasmine","description":"Bugas","quantity_available":"85.00","unit":"kg","price_per_unit":"1500.00","quality_grade":"premium","is_organic":false,"images":["\\/storage\\/products\\/14f68bb5-eac0-4bc0-998a-1884ed1cf12b.png"],"farmer_id":1,"is_available":true,"production_status":"available","updated_at":"2026-02-13T13:59:18.000000Z","created_at":"2026-02-13T13:59:18.000000Z","id":2,"inventory_item_id":4,"rice_variety":{"id":2,"name":"Thai Jasmine","variety_code":"RICE-JASMINE","description":"Premium fragrant rice valued for aroma and soft texture.","maturity_days":110,"average_yield_per_hectare":"4.90","season":"dry","grain_type":"long","resistance_level":"medium","characteristics":{"notes":"Requires consistent irrigation and well-drained fields."},"is_active":true,"created_at":"2026-02-12T08:44:24.000000Z","updated_at":"2026-02-12T08:44:24.000000Z"}}	New product listing published	143.44.193.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 OPR/127.0.0.0	2026-02-13 13:59:18	2026-02-13 13:59:18
4	1	product.created	App\\Models\\RiceProduct	3	\N	{"rice_variety_id":8,"harvest_id":5,"name":"Koshihikari","description":"rice","quantity_available":"127.50","unit":"sacks","price_per_unit":"1400.00","quality_grade":"premium","is_organic":false,"images":["\\/storage\\/products\\/124bd556-8719-42fe-b16d-3b1592619fce.jpg"],"farmer_id":1,"is_available":true,"production_status":"available","updated_at":"2026-02-13T14:48:46.000000Z","created_at":"2026-02-13T14:48:46.000000Z","id":3,"inventory_item_id":6,"rice_variety":{"id":8,"name":"Koshihikari","variety_code":"RICE-KOSHI","description":"Short-grain Japanese rice with excellent eating quality.","maturity_days":118,"average_yield_per_hectare":"5.30","season":"dry","grain_type":"short","resistance_level":"high","characteristics":{"notes":"Best grown in cooler climates; top choice for sushi-grade rice."},"is_active":true,"created_at":"2026-02-12T08:44:24.000000Z","updated_at":"2026-02-12T08:44:24.000000Z"}}	New product listing published	143.44.193.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 OPR/127.0.0.0	2026-02-13 14:48:46	2026-02-13 14:48:46
\.


--
-- TOC entry 4070 (class 0 OID 350716)
-- Dependencies: 221
-- Data for Name: automated_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.automated_tasks (id, planting_id, planting_stage_id, task_template_id, task_id, title, description, scheduled_date, due_date, status, weather_requirements, generated_instructions, delay_reason, completed_at, auto_generated, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4072 (class 0 OID 350735)
-- Dependencies: 223
-- Data for Name: buyers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.buyers (id, name, contact_info, address, created_at, updated_at, user_id, contact_person, email, phone, type, status, payment_terms, credit_limit, notes) FROM stdin;
1	Janos Panague	09624351441	Marketplace	2026-02-12 09:06:11	2026-02-12 09:06:11	1	\N	janospanague1@gmail.com	\N	individual	active	\N	\N	Created from Marketplace Order
\.


--
-- TOC entry 4074 (class 0 OID 350750)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache (key, value, expiration) FROM stdin;
farm-operations-management-system-cache-weather_forecast_8.03_125.19	a:1:{s:4:"list";a:7:{i:0;a:6:{s:2:"dt";i:1770940800;s:4:"main";a:4:{s:4:"temp";d:22.1;s:8:"temp_max";d:24.1;s:8:"temp_min";d:20.1;s:8:"humidity";i:100;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:5:"rainy";}}s:6:"dt_txt";s:19:"2026-02-13 12:00:00";s:3:"pop";d:0.94;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:21.3;s:3:"pop";d:0.63;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:21.5;s:3:"pop";d:0.6;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:21.6;s:3:"pop";d:0.61;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:21.5;s:3:"pop";d:0.71;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:21.3;s:3:"pop";d:0.85;s:4:"code";i:61;s:4:"icon";s:5:"rainy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:21.2;s:3:"pop";d:0.94;s:4:"code";i:63;s:4:"icon";s:5:"rainy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:21.2;s:3:"pop";d:0.94;s:4:"code";i:81;s:4:"icon";s:5:"rainy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:21.4;s:3:"pop";d:0.89;s:4:"code";i:63;s:4:"icon";s:5:"rainy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:21.9;s:3:"pop";d:0.84;s:4:"code";i:61;s:4:"icon";s:5:"rainy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:22;s:3:"pop";d:0.81;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:22.1;s:3:"pop";d:0.79;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:22.5;s:3:"pop";d:0.77;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:23;s:3:"pop";d:0.78;s:4:"code";i:55;s:4:"icon";s:5:"rainy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:22.7;s:3:"pop";d:0.79;s:4:"code";i:80;s:4:"icon";s:5:"rainy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:22.4;s:3:"pop";d:0.77;s:4:"code";i:61;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:23.5;s:3:"pop";d:0.7;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:24.1;s:3:"pop";d:0.6;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:23.1;s:3:"pop";d:0.48;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:21.9;s:3:"pop";d:0.33;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:21.5;s:3:"pop";d:0.17;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:21;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:20.7;s:3:"pop";d:0.04;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:20.4;s:3:"pop";d:0.08;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:20.1;s:3:"pop";d:0.1;s:4:"code";i:2;s:4:"icon";s:6:"cloudy";}}}i:1;a:6:{s:2:"dt";i:1771027200;s:4:"main";a:4:{s:4:"temp";d:24.25;s:8:"temp_max";d:30.2;s:8:"temp_min";d:18.3;s:8:"humidity";i:97;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:5:"rainy";}}s:6:"dt_txt";s:19:"2026-02-14 12:00:00";s:3:"pop";d:0.81;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:21;s:3:"pop";d:0.09;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:19.7;s:3:"pop";d:0.08;s:4:"code";i:2;s:4:"icon";s:6:"cloudy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:19.4;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:19.1;s:3:"pop";d:0.04;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:18.8;s:3:"pop";d:0.01;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:18.5;s:3:"pop";i:0;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:18.3;s:3:"pop";i:0;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:20;s:3:"pop";i:0;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:22.9;s:3:"pop";d:0.03;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:25.5;s:3:"pop";d:0.08;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:28;s:3:"pop";d:0.15;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:29.1;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:30;s:3:"pop";d:0.32;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:30.2;s:3:"pop";d:0.42;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:30.1;s:3:"pop";d:0.52;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:29.5;s:3:"pop";d:0.64;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:28.6;s:3:"pop";d:0.76;s:4:"code";i:2;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:26.6;s:3:"pop";d:0.81;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:23.6;s:3:"pop";d:0.74;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:22.4;s:3:"pop";d:0.59;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:21.8;s:3:"pop";d:0.45;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:21.4;s:3:"pop";d:0.34;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:21;s:3:"pop";d:0.24;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:20.6;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}}}i:2;a:6:{s:2:"dt";i:1771113600;s:4:"main";a:4:{s:4:"temp";d:24.85;s:8:"temp_max";d:30.8;s:8:"temp_min";d:18.9;s:8:"humidity";i:97;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:5:"rainy";}}s:6:"dt_txt";s:19:"2026-02-15 12:00:00";s:3:"pop";d:0.6;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:20.3;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:20.1;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:20;s:3:"pop";d:0.03;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:19.6;s:3:"pop";d:0.03;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:19.2;s:3:"pop";d:0.04;s:4:"code";i:2;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:19;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:18.9;s:3:"pop";d:0.08;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:20.5;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:23;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:25.8;s:3:"pop";d:0.28;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:27.8;s:3:"pop";d:0.44;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:29.1;s:3:"pop";d:0.55;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:30.2;s:3:"pop";d:0.59;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:30.7;s:3:"pop";d:0.6;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:30.8;s:3:"pop";d:0.58;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:30;s:3:"pop";d:0.55;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:26.9;s:3:"pop";d:0.51;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:24.2;s:3:"pop";d:0.45;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:22.5;s:3:"pop";d:0.38;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:21.7;s:3:"pop";d:0.3;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:21.2;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:20.7;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:20.4;s:3:"pop";d:0.17;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:19.8;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}}}i:3;a:6:{s:2:"dt";i:1771200000;s:4:"main";a:4:{s:4:"temp";d:24.3;s:8:"temp_max";d:31;s:8:"temp_min";d:17.6;s:8:"humidity";i:96;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:6:"cloudy";}}s:6:"dt_txt";s:19:"2026-02-16 12:00:00";s:3:"pop";d:0.57;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:18.9;s:3:"pop";d:0.17;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:17.9;s:3:"pop";d:0.19;s:4:"code";i:0;s:4:"icon";s:5:"clear";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:17.7;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:17.6;s:3:"pop";d:0.15;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:17.7;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:17.7;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:17.7;s:3:"pop";d:0.05;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:19.2;s:3:"pop";d:0.05;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:22;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:22.9;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:27.2;s:3:"pop";d:0.06;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:29.2;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:30.8;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:31;s:3:"pop";d:0.4;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:30.5;s:3:"pop";d:0.52;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:30;s:3:"pop";d:0.57;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:28.5;s:3:"pop";d:0.57;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:26.6;s:3:"pop";d:0.52;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:23.3;s:3:"pop";d:0.4;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:22.3;s:3:"pop";d:0.22;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:21.4;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:20.6;s:3:"pop";d:0.07;s:4:"code";i:1;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:20.1;s:3:"pop";d:0.08;s:4:"code";i:0;s:4:"icon";s:5:"clear";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:19.7;s:3:"pop";d:0.1;s:4:"code";i:0;s:4:"icon";s:5:"clear";}}}i:4;a:6:{s:2:"dt";i:1771286400;s:4:"main";a:4:{s:4:"temp";d:24;s:8:"temp_max";d:29.7;s:8:"temp_min";d:18.3;s:8:"humidity";i:97;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:5:"rainy";}}s:6:"dt_txt";s:19:"2026-02-17 12:00:00";s:3:"pop";d:0.68;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:19.3;s:3:"pop";d:0.12;s:4:"code";i:0;s:4:"icon";s:5:"clear";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:19.4;s:3:"pop";d:0.15;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:19.5;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:19;s:3:"pop";d:0.15;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:18.4;s:3:"pop";d:0.12;s:4:"code";i:1;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:18.3;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:18.4;s:3:"pop";d:0.08;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:20.6;s:3:"pop";d:0.07;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:23.9;s:3:"pop";d:0.1;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:26.3;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:28.4;s:3:"pop";d:0.32;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:29.3;s:3:"pop";d:0.42;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:29.7;s:3:"pop";d:0.48;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:29.2;s:3:"pop";d:0.51;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:28.9;s:3:"pop";d:0.55;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:27.7;s:3:"pop";d:0.61;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:26.7;s:3:"pop";d:0.68;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:23.6;s:3:"pop";d:0.68;s:4:"code";i:53;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:22.5;s:3:"pop";d:0.56;s:4:"code";i:51;s:4:"icon";s:5:"rainy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:22.1;s:3:"pop";d:0.37;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:21.8;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:21.5;s:3:"pop";d:0.2;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:21.4;s:3:"pop";d:0.22;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:21.4;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}}}i:5;a:6:{s:2:"dt";i:1771372800;s:4:"main";a:4:{s:4:"temp";d:25.049999999999997;s:8:"temp_max";d:29.4;s:8:"temp_min";d:20.7;s:8:"humidity";i:98;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:6:"cloudy";}}s:6:"dt_txt";s:19:"2026-02-18 12:00:00";s:3:"pop";d:0.81;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:21.3;s:3:"pop";d:0.2;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:21.2;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:21.1;s:3:"pop";d:0.13;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:20.9;s:3:"pop";d:0.14;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:20.7;s:3:"pop";d:0.16;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:20.8;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:21.5;s:3:"pop";d:0.22;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:22.4;s:3:"pop";d:0.25;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:23.7;s:3:"pop";d:0.29;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:25.7;s:3:"pop";d:0.36;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:28;s:3:"pop";d:0.44;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:29.4;s:3:"pop";d:0.52;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:29.2;s:3:"pop";d:0.61;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:28.1;s:3:"pop";d:0.7;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:27;s:3:"pop";d:0.77;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:26.1;s:3:"pop";d:0.81;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:25.2;s:3:"pop";d:0.81;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:24.4;s:3:"pop";d:0.77;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:23.6;s:3:"pop";d:0.63;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:22.8;s:3:"pop";d:0.44;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:22.2;s:3:"pop";d:0.29;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:21.9;s:3:"pop";d:0.24;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:21.8;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:21.7;s:3:"pop";d:0.23;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}}}i:6;a:6:{s:2:"dt";i:1771459200;s:4:"main";a:4:{s:4:"temp";d:24.85;s:8:"temp_max";d:28.7;s:8:"temp_min";d:21;s:8:"humidity";i:95;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:6:"cloudy";}}s:6:"dt_txt";s:19:"2026-02-19 12:00:00";s:3:"pop";d:0.71;s:6:"hourly";a:24:{i:0;a:5:{s:4:"time";s:5:"00:00";s:4:"temp";d:21.6;s:3:"pop";d:0.21;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:1;a:5:{s:4:"time";s:5:"01:00";s:4:"temp";d:21.7;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:2;a:5:{s:4:"time";s:5:"02:00";s:4:"temp";d:21.6;s:3:"pop";d:0.19;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:3;a:5:{s:4:"time";s:5:"03:00";s:4:"temp";d:21.4;s:3:"pop";d:0.22;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:4;a:5:{s:4:"time";s:5:"04:00";s:4:"temp";d:21;s:3:"pop";d:0.26;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:5;a:5:{s:4:"time";s:5:"05:00";s:4:"temp";d:21.1;s:3:"pop";d:0.29;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:6;a:5:{s:4:"time";s:5:"06:00";s:4:"temp";d:21.8;s:3:"pop";d:0.3;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:7;a:5:{s:4:"time";s:5:"07:00";s:4:"temp";d:22.9;s:3:"pop";d:0.29;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:8;a:5:{s:4:"time";s:5:"08:00";s:4:"temp";d:24.2;s:3:"pop";d:0.32;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:9;a:5:{s:4:"time";s:5:"09:00";s:4:"temp";d:25.9;s:3:"pop";d:0.4;s:4:"code";i:3;s:4:"icon";s:6:"cloudy";}i:10;a:5:{s:4:"time";s:5:"10:00";s:4:"temp";d:27.8;s:3:"pop";d:0.52;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:11;a:5:{s:4:"time";s:5:"11:00";s:4:"temp";d:28.7;s:3:"pop";d:0.61;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:12;a:5:{s:4:"time";s:5:"12:00";s:4:"temp";d:28;s:3:"pop";d:0.66;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:13;a:5:{s:4:"time";s:5:"13:00";s:4:"temp";d:26.4;s:3:"pop";d:0.7;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:14;a:5:{s:4:"time";s:5:"14:00";s:4:"temp";d:25.1;s:3:"pop";d:0.71;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:15;a:5:{s:4:"time";s:5:"15:00";s:4:"temp";d:25;s:3:"pop";d:0.68;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:16;a:5:{s:4:"time";s:5:"16:00";s:4:"temp";d:25.2;s:3:"pop";d:0.64;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:17;a:5:{s:4:"time";s:5:"17:00";s:4:"temp";d:25.1;s:3:"pop";d:0.61;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:18;a:5:{s:4:"time";s:5:"18:00";s:4:"temp";d:24.4;s:3:"pop";d:0.64;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:19;a:5:{s:4:"time";s:5:"19:00";s:4:"temp";d:23.4;s:3:"pop";d:0.69;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:20;a:5:{s:4:"time";s:5:"20:00";s:4:"temp";d:22.6;s:3:"pop";d:0.71;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:21;a:5:{s:4:"time";s:5:"21:00";s:4:"temp";d:22.2;s:3:"pop";d:0.68;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:22;a:5:{s:4:"time";s:5:"22:00";s:4:"temp";d:22.1;s:3:"pop";d:0.62;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}i:23;a:5:{s:4:"time";s:5:"23:00";s:4:"temp";d:21.9;s:3:"pop";d:0.58;s:4:"code";i:3;s:4:"icon";s:5:"rainy";}}}}}	1770937496
farm-operations-management-system-cache-weather_current_8.03_125.19	a:5:{s:4:"main";a:2:{s:4:"temp";d:24.9;s:8:"humidity";i:79;}s:4:"wind";a:1:{s:5:"speed";d:2.4166666666666665;}s:4:"rain";a:1:{s:2:"1h";d:0;}s:7:"weather";a:1:{i:0;a:1:{s:4:"main";s:6:"cloudy";}}s:2:"dt";i:1771015500;}	1770988501
farm-operations-management-system-cache-farmer_dashboard_1	YTo4OntzOjU6InN0YXRzIjthOjc6e3M6MTI6InRvdGFsX2ZpZWxkcyI7aTozO3M6MTY6ImFjdGl2ZV9wbGFudGluZ3MiO2k6MTtzOjIxOiJhY3RpdmVfc2VlZF9wbGFudGluZ3MiO2k6MDtzOjIwOiJyZWFkeV9zZWVkX3BsYW50aW5ncyI7aTowO3M6MTM6InBlbmRpbmdfdGFza3MiO2k6MDtzOjEzOiJvdmVyZHVlX3Rhc2tzIjtpOjA7czoxNToibG93X3N0b2NrX2l0ZW1zIjtpOjA7fXM6MTI6InJlY2VudF90YXNrcyI7TzozOToiSWxsdW1pbmF0ZVxEYXRhYmFzZVxFbG9xdWVudFxDb2xsZWN0aW9uIjoyOntzOjg6IgAqAGl0ZW1zIjthOjQ6e2k6MDtPOjE1OiJBcHBcTW9kZWxzXFRhc2siOjMzOntzOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6InBnc3FsIjtzOjg6IgAqAHRhYmxlIjtzOjU6InRhc2tzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTY6e3M6MjoiaWQiO2k6NDtzOjExOiJwbGFudGluZ19pZCI7aTozO3M6OToidGFza190eXBlIjtzOjEwOiJoYXJ2ZXN0aW5nIjtzOjg6ImR1ZV9kYXRlIjtzOjE5OiIyMDI2LTAyLTEzIDAwOjAwOjAwIjtzOjExOiJkZXNjcmlwdGlvbiI7czoxMDoiSGFydmVzdGluZyI7czo2OiJzdGF0dXMiO3M6OToiY29tcGxldGVkIjtzOjExOiJhc3NpZ25lZF90byI7aToxO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTQ6MDY6NDciO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTQ6MDc6MzEiO3M6MTY6ImxhYm9yZXJfZ3JvdXBfaWQiO047czoxMjoicGF5bWVudF90eXBlIjtzOjU6InNoYXJlIjtzOjI0OiJyZXZlbnVlX3NoYXJlX3BlcmNlbnRhZ2UiO3M6NToiMTUuMDAiO3M6MTE6IndhZ2VfYW1vdW50IjtOO3M6NDoidW5pdCI7TjtzOjg6InF1YW50aXR5IjtOO3M6MTA6InVuaXRfcHJpY2UiO047fXM6MTE6IgAqAG9yaWdpbmFsIjthOjE2OntzOjI6ImlkIjtpOjQ7czoxMToicGxhbnRpbmdfaWQiO2k6MztzOjk6InRhc2tfdHlwZSI7czoxMDoiaGFydmVzdGluZyI7czo4OiJkdWVfZGF0ZSI7czoxOToiMjAyNi0wMi0xMyAwMDowMDowMCI7czoxMToiZGVzY3JpcHRpb24iO3M6MTA6IkhhcnZlc3RpbmciO3M6Njoic3RhdHVzIjtzOjk6ImNvbXBsZXRlZCI7czoxMToiYXNzaWduZWRfdG8iO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDE0OjA2OjQ3IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDE0OjA3OjMxIjtzOjE2OiJsYWJvcmVyX2dyb3VwX2lkIjtOO3M6MTI6InBheW1lbnRfdHlwZSI7czo1OiJzaGFyZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtzOjU6IjE1LjAwIjtzOjExOiJ3YWdlX2Ftb3VudCI7TjtzOjQ6InVuaXQiO047czo4OiJxdWFudGl0eSI7TjtzOjEwOiJ1bml0X3ByaWNlIjtOO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTo3OntzOjg6ImR1ZV9kYXRlIjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjI0OiJyZXZlbnVlX3NoYXJlX3BlcmNlbnRhZ2UiO3M6OToiZGVjaW1hbDoyIjtzOjExOiJ3YWdlX2Ftb3VudCI7czo5OiJkZWNpbWFsOjIiO3M6ODoicXVhbnRpdHkiO3M6OToiZGVjaW1hbDoyIjtzOjEwOiJ1bml0X3ByaWNlIjtzOjk6ImRlY2ltYWw6MiI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToyOntzOjg6InBsYW50aW5nIjtPOjE5OiJBcHBcTW9kZWxzXFBsYW50aW5nIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo5OiJwbGFudGluZ3MiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxNzp7czoyOiJpZCI7aTozO3M6ODoiZmllbGRfaWQiO2k6MjtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MTtzOjk6ImNyb3BfdHlwZSI7czo0OiJSaWNlIjtzOjEzOiJwbGFudGluZ19kYXRlIjtzOjE5OiIyMDI1LTExLTExIDAwOjAwOjAwIjtzOjIxOiJleHBlY3RlZF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTMgMDA6MDA6MDAiO3M6MTk6ImFjdHVhbF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTMgMDA6MDA6MDAiO3M6Njoic3RhdHVzIjtzOjk6ImhhcnZlc3RlZCI7czoxNToicGxhbnRpbmdfbWV0aG9kIjtzOjE0OiJkaXJlY3Rfc2VlZGluZyI7czo5OiJzZWVkX3JhdGUiO3M6NToiNTAuMDAiO3M6MTI6ImFyZWFfcGxhbnRlZCI7czo0OiI1LjAwIjtzOjY6InNlYXNvbiI7czozOiJ3ZXQiO3M6NToibm90ZXMiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxNDowNDozNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxNDowNzozMSI7czoxNjoic2VlZF9wbGFudGluZ19pZCI7TjtzOjk6InNlZWRfdW5pdCI7czo3OiJwYWNrZXRzIjt9czoxMToiACoAb3JpZ2luYWwiO2E6MTc6e3M6MjoiaWQiO2k6MztzOjg6ImZpZWxkX2lkIjtpOjI7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjE7czo5OiJjcm9wX3R5cGUiO3M6NDoiUmljZSI7czoxMzoicGxhbnRpbmdfZGF0ZSI7czoxOToiMjAyNS0xMS0xMSAwMDowMDowMCI7czoyMToiZXhwZWN0ZWRfaGFydmVzdF9kYXRlIjtzOjE5OiIyMDI2LTAyLTEzIDAwOjAwOjAwIjtzOjE5OiJhY3R1YWxfaGFydmVzdF9kYXRlIjtzOjE5OiIyMDI2LTAyLTEzIDAwOjAwOjAwIjtzOjY6InN0YXR1cyI7czo5OiJoYXJ2ZXN0ZWQiO3M6MTU6InBsYW50aW5nX21ldGhvZCI7czoxNDoiZGlyZWN0X3NlZWRpbmciO3M6OToic2VlZF9yYXRlIjtzOjU6IjUwLjAwIjtzOjEyOiJhcmVhX3BsYW50ZWQiO3M6NDoiNS4wMCI7czo2OiJzZWFzb24iO3M6Mzoid2V0IjtzOjU6Im5vdGVzIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTQ6MDQ6MzQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTQ6MDc6MzEiO3M6MTY6InNlZWRfcGxhbnRpbmdfaWQiO047czo5OiJzZWVkX3VuaXQiO3M6NzoicGFja2V0cyI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjk6e3M6MTM6InBsYW50aW5nX2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6MjE6ImV4cGVjdGVkX2hhcnZlc3RfZGF0ZSI7czo4OiJkYXRldGltZSI7czoxOToiYWN0dWFsX2hhcnZlc3RfZGF0ZSI7czo4OiJkYXRldGltZSI7czo5OiJzZWVkX3JhdGUiO3M6OToiZGVjaW1hbDoyIjtzOjEyOiJhcmVhX3BsYW50ZWQiO3M6OToiZGVjaW1hbDoyIjtzOjE4OiJ3ZWF0aGVyX2NvbmRpdGlvbnMiO3M6NToiYXJyYXkiO3M6OToic2VlZF91bml0IjtzOjY6InN0cmluZyI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjU6ImZpZWxkIjtPOjE2OiJBcHBcTW9kZWxzXEZpZWxkIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo2OiJmaWVsZHMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyOTp7czoyOiJpZCI7aToyO3M6NzoidXNlcl9pZCI7aToxO3M6NzoiZmFybV9pZCI7aToxO3M6NDoibmFtZSI7czo1OiJCbG9jayI7czo4OiJsb2NhdGlvbiI7czoxNTQ6InsiYWRkcmVzcyI6Ik1hbmFnb2ssIENpdHkgb2YgTWFsYXliYWxheSwgQnVraWRub24iLCJsYXQiOjguMDI2ODE3LCJsb24iOjEyNS4xOTAzMjQsInByb3ZpbmNlIjoiQnVraWRub24iLCJjaXR5IjoiQ2l0eSBvZiBNYWxheWJhbGF5IiwiYmFyYW5nYXkiOiJNYW5hZ29rIn0iO3M6MTc6ImZpZWxkX2Nvb3JkaW5hdGVzIjtOO3M6OToic29pbF90eXBlIjtzOjQ6ImxvYW0iO3M6NDoic2l6ZSI7czo1OiIxMC4wMCI7czoxMjoid2F0ZXJfYWNjZXNzIjtzOjQ6Imdvb2QiO3M6MTY6ImRyYWluYWdlX3F1YWxpdHkiO3M6OToiZXhjZWxsZW50IjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ2OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ2OjI0IjtzOjc6InNvaWxfcGgiO047czoyMjoib3JnYW5pY19tYXR0ZXJfY29udGVudCI7TjtzOjE0OiJuaXRyb2dlbl9sZXZlbCI7TjtzOjE2OiJwaG9zcGhvcnVzX2xldmVsIjtOO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7TjtzOjk6ImVsZXZhdGlvbiI7TjtzOjEyOiJ3YXRlcl9zb3VyY2UiO3M6ODoicmFpbmZhbGwiO3M6MTU6ImlycmlnYXRpb25fdHlwZSI7czo1OiJmbG9vZCI7czoxMzoicHJldmlvdXNfY3JvcCI7czoxMjoiVGhhaSBKYXNtaW5lIjtzOjI0OiJmaWVsZF9wcmVwYXJhdGlvbl9zdGF0dXMiO3M6MTY6Im5lZWRzX2Fzc2Vzc21lbnQiO3M6NToic2xvcGUiO047czo1OiJub3RlcyI7TjtzOjg6Im5pY2tuYW1lIjtOO3M6MTU6InBsYW50aW5nX21ldGhvZCI7czoxMzoidHJhbnNwbGFudGluZyI7czoxNjoiY3JvcHBpbmdfc2Vhc29ucyI7aToxO3M6MTI6InRhcmdldF95aWVsZCI7czo0OiI1LjAwIjtzOjIwOiJpbmZyYXN0cnVjdHVyZV9ub3RlcyI7Tjt9czoxMToiACoAb3JpZ2luYWwiO2E6Mjk6e3M6MjoiaWQiO2k6MjtzOjc6InVzZXJfaWQiO2k6MTtzOjc6ImZhcm1faWQiO2k6MTtzOjQ6Im5hbWUiO3M6NToiQmxvY2siO3M6ODoibG9jYXRpb24iO3M6MTU0OiJ7ImFkZHJlc3MiOiJNYW5hZ29rLCBDaXR5IG9mIE1hbGF5YmFsYXksIEJ1a2lkbm9uIiwibGF0Ijo4LjAyNjgxNywibG9uIjoxMjUuMTkwMzI0LCJwcm92aW5jZSI6IkJ1a2lkbm9uIiwiY2l0eSI6IkNpdHkgb2YgTWFsYXliYWxheSIsImJhcmFuZ2F5IjoiTWFuYWdvayJ9IjtzOjE3OiJmaWVsZF9jb29yZGluYXRlcyI7TjtzOjk6InNvaWxfdHlwZSI7czo0OiJsb2FtIjtzOjQ6InNpemUiO3M6NToiMTAuMDAiO3M6MTI6IndhdGVyX2FjY2VzcyI7czo0OiJnb29kIjtzOjE2OiJkcmFpbmFnZV9xdWFsaXR5IjtzOjk6ImV4Y2VsbGVudCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NjoyNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NjoyNCI7czo3OiJzb2lsX3BoIjtOO3M6MjI6Im9yZ2FuaWNfbWF0dGVyX2NvbnRlbnQiO047czoxNDoibml0cm9nZW5fbGV2ZWwiO047czoxNjoicGhvc3Bob3J1c19sZXZlbCI7TjtzOjE1OiJwb3Rhc3NpdW1fbGV2ZWwiO047czo5OiJlbGV2YXRpb24iO047czoxMjoid2F0ZXJfc291cmNlIjtzOjg6InJhaW5mYWxsIjtzOjE1OiJpcnJpZ2F0aW9uX3R5cGUiO3M6NToiZmxvb2QiO3M6MTM6InByZXZpb3VzX2Nyb3AiO3M6MTI6IlRoYWkgSmFzbWluZSI7czoyNDoiZmllbGRfcHJlcGFyYXRpb25fc3RhdHVzIjtzOjE2OiJuZWVkc19hc3Nlc3NtZW50IjtzOjU6InNsb3BlIjtOO3M6NToibm90ZXMiO047czo4OiJuaWNrbmFtZSI7TjtzOjE1OiJwbGFudGluZ19tZXRob2QiO3M6MTM6InRyYW5zcGxhbnRpbmciO3M6MTY6ImNyb3BwaW5nX3NlYXNvbnMiO2k6MTtzOjEyOiJ0YXJnZXRfeWllbGQiO3M6NDoiNS4wMCI7czoyMDoiaW5mcmFzdHJ1Y3R1cmVfbm90ZXMiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjEzOntzOjg6ImxvY2F0aW9uIjtzOjU6ImFycmF5IjtzOjE3OiJmaWVsZF9jb29yZGluYXRlcyI7czo1OiJhcnJheSI7czo0OiJzaXplIjtzOjk6ImRlY2ltYWw6MiI7czo3OiJzb2lsX3BoIjtzOjk6ImRlY2ltYWw6MiI7czoyMjoib3JnYW5pY19tYXR0ZXJfY29udGVudCI7czo5OiJkZWNpbWFsOjIiO3M6MTQ6Im5pdHJvZ2VuX2xldmVsIjtzOjk6ImRlY2ltYWw6MiI7czoxNjoicGhvc3Bob3J1c19sZXZlbCI7czo5OiJkZWNpbWFsOjIiO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7czo5OiJkZWNpbWFsOjIiO3M6OToiZWxldmF0aW9uIjtzOjk6ImRlY2ltYWw6MiI7czo1OiJzbG9wZSI7czo5OiJkZWNpbWFsOjIiO3M6MTI6InRhcmdldF95aWVsZCI7czo5OiJkZWNpbWFsOjIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MTp7aTowO3M6MTQ6ImF2YWlsYWJsZV9hcmVhIjt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjI2OntpOjA7czo3OiJ1c2VyX2lkIjtpOjE7czo3OiJmYXJtX2lkIjtpOjI7czo0OiJuYW1lIjtpOjM7czo4OiJsb2NhdGlvbiI7aTo0O3M6MTc6ImZpZWxkX2Nvb3JkaW5hdGVzIjtpOjU7czo5OiJzb2lsX3R5cGUiO2k6NjtzOjc6InNvaWxfcGgiO2k6NztzOjIyOiJvcmdhbmljX21hdHRlcl9jb250ZW50IjtpOjg7czoxNDoibml0cm9nZW5fbGV2ZWwiO2k6OTtzOjE2OiJwaG9zcGhvcnVzX2xldmVsIjtpOjEwO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7aToxMTtzOjQ6InNpemUiO2k6MTI7czoxMjoid2F0ZXJfYWNjZXNzIjtpOjEzO3M6MTI6IndhdGVyX3NvdXJjZSI7aToxNDtzOjE1OiJpcnJpZ2F0aW9uX3R5cGUiO2k6MTU7czoxNjoiZHJhaW5hZ2VfcXVhbGl0eSI7aToxNjtzOjk6ImVsZXZhdGlvbiI7aToxNztzOjU6InNsb3BlIjtpOjE4O3M6MTM6InByZXZpb3VzX2Nyb3AiO2k6MTk7czoyNDoiZmllbGRfcHJlcGFyYXRpb25fc3RhdHVzIjtpOjIwO3M6NToibm90ZXMiO2k6MjE7czo4OiJuaWNrbmFtZSI7aToyMjtzOjE1OiJwbGFudGluZ19tZXRob2QiO2k6MjM7czoxNjoiY3JvcHBpbmdfc2Vhc29ucyI7aToyNDtzOjEyOiJ0YXJnZXRfeWllbGQiO2k6MjU7czoyMDoiaW5mcmFzdHJ1Y3R1cmVfbm90ZXMiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxNTp7aTowO3M6ODoiZmllbGRfaWQiO2k6MTtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtpOjI7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjM7czo5OiJjcm9wX3R5cGUiO2k6NDtzOjEzOiJwbGFudGluZ19kYXRlIjtpOjU7czoyMToiZXhwZWN0ZWRfaGFydmVzdF9kYXRlIjtpOjY7czoxOToiYWN0dWFsX2hhcnZlc3RfZGF0ZSI7aTo3O3M6Njoic3RhdHVzIjtpOjg7czoxNToicGxhbnRpbmdfbWV0aG9kIjtpOjk7czo5OiJzZWVkX3JhdGUiO2k6MTA7czoxMjoiYXJlYV9wbGFudGVkIjtpOjExO3M6Njoic2Vhc29uIjtpOjEyO3M6NToibm90ZXMiO2k6MTM7czoxODoid2VhdGhlcl9jb25kaXRpb25zIjtpOjE0O3M6OToic2VlZF91bml0Ijt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6NzoibGFib3JlciI7TzoxODoiQXBwXE1vZGVsc1xMYWJvcmVyIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo4OiJsYWJvcmVycyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjE4OntzOjI6ImlkIjtpOjE7czo0OiJuYW1lIjtzOjEzOiJKYW5vcyBQYW5hZ3VlIjtzOjQ6InJhdGUiO3M6NToiMTUuMDAiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDg6NDg6MzQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDg6NDg6MzQiO3M6NzoidXNlcl9pZCI7aToxO3M6NToicGhvbmUiO3M6MTE6IjA5NjI0MzUxNDQxIjtzOjU6ImVtYWlsIjtzOjIzOiJqYW5vc3BhbmFndWUxQGdtYWlsLmNvbSI7czo3OiJhZGRyZXNzIjtzOjE3OiJNYXJhbWFnLCBidWtpZG5vbiI7czoxMToic2tpbGxfbGV2ZWwiO3M6NjoiZXhwZXJ0IjtzOjE0OiJzcGVjaWFsaXphdGlvbiI7czo5OiJIYXJ2ZXN0ZXIiO3M6Njoic3RhdHVzIjtzOjY6ImFjdGl2ZSI7czo5OiJoaXJlX2RhdGUiO3M6MTA6IjIwMjYtMDItMTIiO3M6NToibm90ZXMiO047czoyMjoiZW1lcmdlbmN5X2NvbnRhY3RfbmFtZSI7czoxMzoiSmFub3MgUGFuYWd1ZSI7czoyMzoiZW1lcmdlbmN5X2NvbnRhY3RfcGhvbmUiO3M6MTE6IjA5NjI0MzUxNDQxIjtzOjk6InJhdGVfdHlwZSI7czo1OiJzaGFyZSI7czoxNToicHJvZmlsZV9waWN0dXJlIjtzOjEwOToiaHR0cHM6Ly9vbGVuLXBhcmF0YWN0aWNhbC1vdmVyaG90bHkubmdyb2stZnJlZS5kZXYvc3RvcmFnZS9sYWJvcmVycy8xZGNhOTI0OS0xN2U4LTRkZGItODRkOS01ZjU5NDQ0MzgyNWMud2VicCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjE4OntzOjI6ImlkIjtpOjE7czo0OiJuYW1lIjtzOjEzOiJKYW5vcyBQYW5hZ3VlIjtzOjQ6InJhdGUiO3M6NToiMTUuMDAiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDg6NDg6MzQiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDg6NDg6MzQiO3M6NzoidXNlcl9pZCI7aToxO3M6NToicGhvbmUiO3M6MTE6IjA5NjI0MzUxNDQxIjtzOjU6ImVtYWlsIjtzOjIzOiJqYW5vc3BhbmFndWUxQGdtYWlsLmNvbSI7czo3OiJhZGRyZXNzIjtzOjE3OiJNYXJhbWFnLCBidWtpZG5vbiI7czoxMToic2tpbGxfbGV2ZWwiO3M6NjoiZXhwZXJ0IjtzOjE0OiJzcGVjaWFsaXphdGlvbiI7czo5OiJIYXJ2ZXN0ZXIiO3M6Njoic3RhdHVzIjtzOjY6ImFjdGl2ZSI7czo5OiJoaXJlX2RhdGUiO3M6MTA6IjIwMjYtMDItMTIiO3M6NToibm90ZXMiO047czoyMjoiZW1lcmdlbmN5X2NvbnRhY3RfbmFtZSI7czoxMzoiSmFub3MgUGFuYWd1ZSI7czoyMzoiZW1lcmdlbmN5X2NvbnRhY3RfcGhvbmUiO3M6MTE6IjA5NjI0MzUxNDQxIjtzOjk6InJhdGVfdHlwZSI7czo1OiJzaGFyZSI7czoxNToicHJvZmlsZV9waWN0dXJlIjtzOjEwOToiaHR0cHM6Ly9vbGVuLXBhcmF0YWN0aWNhbC1vdmVyaG90bHkubmdyb2stZnJlZS5kZXYvc3RvcmFnZS9sYWJvcmVycy8xZGNhOTI0OS0xN2U4LTRkZGItODRkOS01ZjU5NDQ0MzgyNWMud2VicCI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjM6e3M6NDoicmF0ZSI7czo5OiJkZWNpbWFsOjIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxNjp7aTowO3M6NDoibmFtZSI7aToxO3M6MTU6InByb2ZpbGVfcGljdHVyZSI7aToyO3M6NToicGhvbmUiO2k6MztzOjU6ImVtYWlsIjtpOjQ7czo3OiJhZGRyZXNzIjtpOjU7czoxMToic2tpbGxfbGV2ZWwiO2k6NjtzOjE0OiJzcGVjaWFsaXphdGlvbiI7aTo3O3M6NDoicmF0ZSI7aTo4O3M6OToicmF0ZV90eXBlIjtpOjk7czo2OiJzdGF0dXMiO2k6MTA7czo5OiJoaXJlX2RhdGUiO2k6MTE7czo5OiJoaXJlX2RhdGUiO2k6MTI7czoyMjoiZW1lcmdlbmN5X2NvbnRhY3RfbmFtZSI7aToxMztzOjIzOiJlbWVyZ2VuY3lfY29udGFjdF9waG9uZSI7aToxNDtzOjU6Im5vdGVzIjtpOjE1O3M6NzoidXNlcl9pZCI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjEzOntpOjA7czoxMToicGxhbnRpbmdfaWQiO2k6MTtzOjk6InRhc2tfdHlwZSI7aToyO3M6ODoiZHVlX2RhdGUiO2k6MztzOjExOiJkZXNjcmlwdGlvbiI7aTo0O3M6Njoic3RhdHVzIjtpOjU7czoxMToiYXNzaWduZWRfdG8iO2k6NjtzOjE2OiJsYWJvcmVyX2dyb3VwX2lkIjtpOjc7czoxMjoicGF5bWVudF90eXBlIjtpOjg7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtpOjk7czoxMToid2FnZV9hbW91bnQiO2k6MTA7czo0OiJ1bml0IjtpOjExO3M6ODoicXVhbnRpdHkiO2k6MTI7czoxMDoidW5pdF9wcmljZSI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX1pOjE7TzoxNToiQXBwXE1vZGVsc1xUYXNrIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo1OiJ0YXNrcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjE2OntzOjI6ImlkIjtpOjM7czoxMToicGxhbnRpbmdfaWQiO2k6MjtzOjk6InRhc2tfdHlwZSI7czoxMDoiaGFydmVzdGluZyI7czo4OiJkdWVfZGF0ZSI7czoxOToiMjAyNi0wMi0xMyAwMDowMDowMCI7czoxMToiZGVzY3JpcHRpb24iO3M6MTA6IkhhcnZlc3RpbmciO3M6Njoic3RhdHVzIjtzOjk6ImNvbXBsZXRlZCI7czoxMToiYXNzaWduZWRfdG8iO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEzOjU4OjA4IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEzOjU4OjQwIjtzOjE2OiJsYWJvcmVyX2dyb3VwX2lkIjtOO3M6MTI6InBheW1lbnRfdHlwZSI7czo1OiJzaGFyZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtzOjU6IjE1LjAwIjtzOjExOiJ3YWdlX2Ftb3VudCI7TjtzOjQ6InVuaXQiO047czo4OiJxdWFudGl0eSI7TjtzOjEwOiJ1bml0X3ByaWNlIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToxNjp7czoyOiJpZCI7aTozO3M6MTE6InBsYW50aW5nX2lkIjtpOjI7czo5OiJ0YXNrX3R5cGUiO3M6MTA6ImhhcnZlc3RpbmciO3M6ODoiZHVlX2RhdGUiO3M6MTk6IjIwMjYtMDItMTMgMDA6MDA6MDAiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjEwOiJIYXJ2ZXN0aW5nIjtzOjY6InN0YXR1cyI7czo5OiJjb21wbGV0ZWQiO3M6MTE6ImFzc2lnbmVkX3RvIjtpOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMzo1ODowOCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMzo1ODo0MCI7czoxNjoibGFib3Jlcl9ncm91cF9pZCI7TjtzOjEyOiJwYXltZW50X3R5cGUiO3M6NToic2hhcmUiO3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7czo1OiIxNS4wMCI7czoxMToid2FnZV9hbW91bnQiO047czo0OiJ1bml0IjtOO3M6ODoicXVhbnRpdHkiO047czoxMDoidW5pdF9wcmljZSI7Tjt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6Nzp7czo4OiJkdWVfZGF0ZSI7czo4OiJkYXRldGltZSI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtzOjk6ImRlY2ltYWw6MiI7czoxMToid2FnZV9hbW91bnQiO3M6OToiZGVjaW1hbDoyIjtzOjg6InF1YW50aXR5IjtzOjk6ImRlY2ltYWw6MiI7czoxMDoidW5pdF9wcmljZSI7czo5OiJkZWNpbWFsOjIiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6Mjp7czo4OiJwbGFudGluZyI7TzoxOToiQXBwXE1vZGVsc1xQbGFudGluZyI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6OToicGxhbnRpbmdzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTc6e3M6MjoiaWQiO2k6MjtzOjg6ImZpZWxkX2lkIjtpOjI7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjI7czo5OiJjcm9wX3R5cGUiO3M6MTI6IlRoYWkgSmFzbWluZSI7czoxMzoicGxhbnRpbmdfZGF0ZSI7czoxOToiMjAyNS0wMi0xMSAwMDowMDowMCI7czoyMToiZXhwZWN0ZWRfaGFydmVzdF9kYXRlIjtzOjE5OiIyMDI2LTAyLTEyIDAwOjAwOjAwIjtzOjE5OiJhY3R1YWxfaGFydmVzdF9kYXRlIjtzOjE5OiIyMDI2LTAyLTEzIDAwOjAwOjAwIjtzOjY6InN0YXR1cyI7czo5OiJoYXJ2ZXN0ZWQiO3M6MTU6InBsYW50aW5nX21ldGhvZCI7czoxMzoidHJhbnNwbGFudGluZyI7czo5OiJzZWVkX3JhdGUiO3M6NjoiMTAwLjAwIjtzOjEyOiJhcmVhX3BsYW50ZWQiO3M6NToiMTAuMDAiO3M6Njoic2Vhc29uIjtzOjM6ImRyeSI7czo1OiJub3RlcyI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjUyOjA3IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEzOjU4OjM5IjtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtpOjE7czo5OiJzZWVkX3VuaXQiO3M6NzoicGFja2V0cyI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjE3OntzOjI6ImlkIjtpOjI7czo4OiJmaWVsZF9pZCI7aToyO3M6MTU6InJpY2VfdmFyaWV0eV9pZCI7aToyO3M6OToiY3JvcF90eXBlIjtzOjEyOiJUaGFpIEphc21pbmUiO3M6MTM6InBsYW50aW5nX2RhdGUiO3M6MTk6IjIwMjUtMDItMTEgMDA6MDA6MDAiO3M6MjE6ImV4cGVjdGVkX2hhcnZlc3RfZGF0ZSI7czoxOToiMjAyNi0wMi0xMiAwMDowMDowMCI7czoxOToiYWN0dWFsX2hhcnZlc3RfZGF0ZSI7czoxOToiMjAyNi0wMi0xMyAwMDowMDowMCI7czo2OiJzdGF0dXMiO3M6OToiaGFydmVzdGVkIjtzOjE1OiJwbGFudGluZ19tZXRob2QiO3M6MTM6InRyYW5zcGxhbnRpbmciO3M6OToic2VlZF9yYXRlIjtzOjY6IjEwMC4wMCI7czoxMjoiYXJlYV9wbGFudGVkIjtzOjU6IjEwLjAwIjtzOjY6InNlYXNvbiI7czozOiJkcnkiO3M6NToibm90ZXMiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo1MjowNyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMzo1ODozOSI7czoxNjoic2VlZF9wbGFudGluZ19pZCI7aToxO3M6OToic2VlZF91bml0IjtzOjc6InBhY2tldHMiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTo5OntzOjEzOiJwbGFudGluZ19kYXRlIjtzOjg6ImRhdGV0aW1lIjtzOjIxOiJleHBlY3RlZF9oYXJ2ZXN0X2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6MTk6ImFjdHVhbF9oYXJ2ZXN0X2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6OToic2VlZF9yYXRlIjtzOjk6ImRlY2ltYWw6MiI7czoxMjoiYXJlYV9wbGFudGVkIjtzOjk6ImRlY2ltYWw6MiI7czoxODoid2VhdGhlcl9jb25kaXRpb25zIjtzOjU6ImFycmF5IjtzOjk6InNlZWRfdW5pdCI7czo2OiJzdHJpbmciO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJmaWVsZCI7cjoxNDQ7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxNTp7aTowO3M6ODoiZmllbGRfaWQiO2k6MTtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtpOjI7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjM7czo5OiJjcm9wX3R5cGUiO2k6NDtzOjEzOiJwbGFudGluZ19kYXRlIjtpOjU7czoyMToiZXhwZWN0ZWRfaGFydmVzdF9kYXRlIjtpOjY7czoxOToiYWN0dWFsX2hhcnZlc3RfZGF0ZSI7aTo3O3M6Njoic3RhdHVzIjtpOjg7czoxNToicGxhbnRpbmdfbWV0aG9kIjtpOjk7czo5OiJzZWVkX3JhdGUiO2k6MTA7czoxMjoiYXJlYV9wbGFudGVkIjtpOjExO3M6Njoic2Vhc29uIjtpOjEyO3M6NToibm90ZXMiO2k6MTM7czoxODoid2VhdGhlcl9jb25kaXRpb25zIjtpOjE0O3M6OToic2VlZF91bml0Ijt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6NzoibGFib3JlciI7cjozMDI7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxMzp7aTowO3M6MTE6InBsYW50aW5nX2lkIjtpOjE7czo5OiJ0YXNrX3R5cGUiO2k6MjtzOjg6ImR1ZV9kYXRlIjtpOjM7czoxMToiZGVzY3JpcHRpb24iO2k6NDtzOjY6InN0YXR1cyI7aTo1O3M6MTE6ImFzc2lnbmVkX3RvIjtpOjY7czoxNjoibGFib3Jlcl9ncm91cF9pZCI7aTo3O3M6MTI6InBheW1lbnRfdHlwZSI7aTo4O3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7aTo5O3M6MTE6IndhZ2VfYW1vdW50IjtpOjEwO3M6NDoidW5pdCI7aToxMTtzOjg6InF1YW50aXR5IjtpOjEyO3M6MTA6InVuaXRfcHJpY2UiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aToyO086MTU6IkFwcFxNb2RlbHNcVGFzayI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6NToidGFza3MiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxNjp7czoyOiJpZCI7aToyO3M6MTE6InBsYW50aW5nX2lkIjtpOjE7czo5OiJ0YXNrX3R5cGUiO3M6MTA6ImhhcnZlc3RpbmciO3M6ODoiZHVlX2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjc6IkhhcnZlc3QiO3M6Njoic3RhdHVzIjtzOjk6ImNvbXBsZXRlZCI7czoxMToiYXNzaWduZWRfdG8iO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAxOjQzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAyOjE3IjtzOjE2OiJsYWJvcmVyX2dyb3VwX2lkIjtOO3M6MTI6InBheW1lbnRfdHlwZSI7czo1OiJzaGFyZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtzOjU6IjE1LjAwIjtzOjExOiJ3YWdlX2Ftb3VudCI7TjtzOjQ6InVuaXQiO047czo4OiJxdWFudGl0eSI7TjtzOjEwOiJ1bml0X3ByaWNlIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToxNjp7czoyOiJpZCI7aToyO3M6MTE6InBsYW50aW5nX2lkIjtpOjE7czo5OiJ0YXNrX3R5cGUiO3M6MTA6ImhhcnZlc3RpbmciO3M6ODoiZHVlX2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjc6IkhhcnZlc3QiO3M6Njoic3RhdHVzIjtzOjk6ImNvbXBsZXRlZCI7czoxMToiYXNzaWduZWRfdG8iO2k6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAxOjQzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAyOjE3IjtzOjE2OiJsYWJvcmVyX2dyb3VwX2lkIjtOO3M6MTI6InBheW1lbnRfdHlwZSI7czo1OiJzaGFyZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtzOjU6IjE1LjAwIjtzOjExOiJ3YWdlX2Ftb3VudCI7TjtzOjQ6InVuaXQiO047czo4OiJxdWFudGl0eSI7TjtzOjEwOiJ1bml0X3ByaWNlIjtOO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTo3OntzOjg6ImR1ZV9kYXRlIjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjI0OiJyZXZlbnVlX3NoYXJlX3BlcmNlbnRhZ2UiO3M6OToiZGVjaW1hbDoyIjtzOjExOiJ3YWdlX2Ftb3VudCI7czo5OiJkZWNpbWFsOjIiO3M6ODoicXVhbnRpdHkiO3M6OToiZGVjaW1hbDoyIjtzOjEwOiJ1bml0X3ByaWNlIjtzOjk6ImRlY2ltYWw6MiI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToyOntzOjg6InBsYW50aW5nIjtPOjE5OiJBcHBcTW9kZWxzXFBsYW50aW5nIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo5OiJwbGFudGluZ3MiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxNzp7czoyOiJpZCI7aToxO3M6ODoiZmllbGRfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MTtzOjk6ImNyb3BfdHlwZSI7czo0OiJJUjY0IjtzOjEzOiJwbGFudGluZ19kYXRlIjtzOjE5OiIyMDI1LTAyLTIyIDAwOjAwOjAwIjtzOjIxOiJleHBlY3RlZF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6MTk6ImFjdHVhbF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6Njoic3RhdHVzIjtzOjk6ImhhcnZlc3RlZCI7czoxNToicGxhbnRpbmdfbWV0aG9kIjtzOjE0OiJkaXJlY3Rfc2VlZGluZyI7czo5OiJzZWVkX3JhdGUiO3M6NjoiMTAwLjAwIjtzOjEyOiJhcmVhX3BsYW50ZWQiO3M6NToiMTAuMDAiO3M6Njoic2Vhc29uIjtzOjM6ImRyeSI7czo1OiJub3RlcyI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjUxOjEzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAyOjE2IjtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtOO3M6OToic2VlZF91bml0IjtzOjc6InBhY2tldHMiO31zOjExOiIAKgBvcmlnaW5hbCI7YToxNzp7czoyOiJpZCI7aToxO3M6ODoiZmllbGRfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MTtzOjk6ImNyb3BfdHlwZSI7czo0OiJJUjY0IjtzOjEzOiJwbGFudGluZ19kYXRlIjtzOjE5OiIyMDI1LTAyLTIyIDAwOjAwOjAwIjtzOjIxOiJleHBlY3RlZF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6MTk6ImFjdHVhbF9oYXJ2ZXN0X2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6Njoic3RhdHVzIjtzOjk6ImhhcnZlc3RlZCI7czoxNToicGxhbnRpbmdfbWV0aG9kIjtzOjE0OiJkaXJlY3Rfc2VlZGluZyI7czo5OiJzZWVkX3JhdGUiO3M6NjoiMTAwLjAwIjtzOjEyOiJhcmVhX3BsYW50ZWQiO3M6NToiMTAuMDAiO3M6Njoic2Vhc29uIjtzOjM6ImRyeSI7czo1OiJub3RlcyI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjUxOjEzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA5OjAyOjE2IjtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtOO3M6OToic2VlZF91bml0IjtzOjc6InBhY2tldHMiO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTo5OntzOjEzOiJwbGFudGluZ19kYXRlIjtzOjg6ImRhdGV0aW1lIjtzOjIxOiJleHBlY3RlZF9oYXJ2ZXN0X2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6MTk6ImFjdHVhbF9oYXJ2ZXN0X2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6OToic2VlZF9yYXRlIjtzOjk6ImRlY2ltYWw6MiI7czoxMjoiYXJlYV9wbGFudGVkIjtzOjk6ImRlY2ltYWw6MiI7czoxODoid2VhdGhlcl9jb25kaXRpb25zIjtzOjU6ImFycmF5IjtzOjk6InNlZWRfdW5pdCI7czo2OiJzdHJpbmciO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MTp7czo1OiJmaWVsZCI7TzoxNjoiQXBwXE1vZGVsc1xGaWVsZCI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6NjoiZmllbGRzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6Mjk6e3M6MjoiaWQiO2k6MTtzOjc6InVzZXJfaWQiO2k6MTtzOjc6ImZhcm1faWQiO2k6MTtzOjQ6Im5hbWUiO3M6NzoiQmxvY2sgMSI7czo4OiJsb2NhdGlvbiI7czoxNTQ6InsiYWRkcmVzcyI6Ik1hbmFnb2ssIENpdHkgb2YgTWFsYXliYWxheSwgQnVraWRub24iLCJsYXQiOjguMDI2ODE3LCJsb24iOjEyNS4xOTAzMjQsInByb3ZpbmNlIjoiQnVraWRub24iLCJjaXR5IjoiQ2l0eSBvZiBNYWxheWJhbGF5IiwiYmFyYW5nYXkiOiJNYW5hZ29rIn0iO3M6MTc6ImZpZWxkX2Nvb3JkaW5hdGVzIjtOO3M6OToic29pbF90eXBlIjtzOjQ6ImxvYW0iO3M6NDoic2l6ZSI7czo1OiIxMC4wMCI7czoxMjoid2F0ZXJfYWNjZXNzIjtzOjQ6Imdvb2QiO3M6MTY6ImRyYWluYWdlX3F1YWxpdHkiO3M6NDoiZ29vZCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NTozNyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NTozNyI7czo3OiJzb2lsX3BoIjtOO3M6MjI6Im9yZ2FuaWNfbWF0dGVyX2NvbnRlbnQiO047czoxNDoibml0cm9nZW5fbGV2ZWwiO047czoxNjoicGhvc3Bob3J1c19sZXZlbCI7TjtzOjE1OiJwb3Rhc3NpdW1fbGV2ZWwiO047czo5OiJlbGV2YXRpb24iO047czoxMjoid2F0ZXJfc291cmNlIjtzOjg6InJhaW5mYWxsIjtzOjE1OiJpcnJpZ2F0aW9uX3R5cGUiO3M6NToiZmxvb2QiO3M6MTM6InByZXZpb3VzX2Nyb3AiO3M6NDoiSVI2NCI7czoyNDoiZmllbGRfcHJlcGFyYXRpb25fc3RhdHVzIjtzOjE2OiJuZWVkc19hc3Nlc3NtZW50IjtzOjU6InNsb3BlIjtOO3M6NToibm90ZXMiO047czo4OiJuaWNrbmFtZSI7TjtzOjE1OiJwbGFudGluZ19tZXRob2QiO3M6MTQ6ImRpcmVjdF9zZWVkaW5nIjtzOjE2OiJjcm9wcGluZ19zZWFzb25zIjtpOjE7czoxMjoidGFyZ2V0X3lpZWxkIjtzOjQ6IjUuMDAiO3M6MjA6ImluZnJhc3RydWN0dXJlX25vdGVzIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToyOTp7czoyOiJpZCI7aToxO3M6NzoidXNlcl9pZCI7aToxO3M6NzoiZmFybV9pZCI7aToxO3M6NDoibmFtZSI7czo3OiJCbG9jayAxIjtzOjg6ImxvY2F0aW9uIjtzOjE1NDoieyJhZGRyZXNzIjoiTWFuYWdvaywgQ2l0eSBvZiBNYWxheWJhbGF5LCBCdWtpZG5vbiIsImxhdCI6OC4wMjY4MTcsImxvbiI6MTI1LjE5MDMyNCwicHJvdmluY2UiOiJCdWtpZG5vbiIsImNpdHkiOiJDaXR5IG9mIE1hbGF5YmFsYXkiLCJiYXJhbmdheSI6Ik1hbmFnb2sifSI7czoxNzoiZmllbGRfY29vcmRpbmF0ZXMiO047czo5OiJzb2lsX3R5cGUiO3M6NDoibG9hbSI7czo0OiJzaXplIjtzOjU6IjEwLjAwIjtzOjEyOiJ3YXRlcl9hY2Nlc3MiO3M6NDoiZ29vZCI7czoxNjoiZHJhaW5hZ2VfcXVhbGl0eSI7czo0OiJnb29kIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ1OjM3IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ1OjM3IjtzOjc6InNvaWxfcGgiO047czoyMjoib3JnYW5pY19tYXR0ZXJfY29udGVudCI7TjtzOjE0OiJuaXRyb2dlbl9sZXZlbCI7TjtzOjE2OiJwaG9zcGhvcnVzX2xldmVsIjtOO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7TjtzOjk6ImVsZXZhdGlvbiI7TjtzOjEyOiJ3YXRlcl9zb3VyY2UiO3M6ODoicmFpbmZhbGwiO3M6MTU6ImlycmlnYXRpb25fdHlwZSI7czo1OiJmbG9vZCI7czoxMzoicHJldmlvdXNfY3JvcCI7czo0OiJJUjY0IjtzOjI0OiJmaWVsZF9wcmVwYXJhdGlvbl9zdGF0dXMiO3M6MTY6Im5lZWRzX2Fzc2Vzc21lbnQiO3M6NToic2xvcGUiO047czo1OiJub3RlcyI7TjtzOjg6Im5pY2tuYW1lIjtOO3M6MTU6InBsYW50aW5nX21ldGhvZCI7czoxNDoiZGlyZWN0X3NlZWRpbmciO3M6MTY6ImNyb3BwaW5nX3NlYXNvbnMiO2k6MTtzOjEyOiJ0YXJnZXRfeWllbGQiO3M6NDoiNS4wMCI7czoyMDoiaW5mcmFzdHJ1Y3R1cmVfbm90ZXMiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjEzOntzOjg6ImxvY2F0aW9uIjtzOjU6ImFycmF5IjtzOjE3OiJmaWVsZF9jb29yZGluYXRlcyI7czo1OiJhcnJheSI7czo0OiJzaXplIjtzOjk6ImRlY2ltYWw6MiI7czo3OiJzb2lsX3BoIjtzOjk6ImRlY2ltYWw6MiI7czoyMjoib3JnYW5pY19tYXR0ZXJfY29udGVudCI7czo5OiJkZWNpbWFsOjIiO3M6MTQ6Im5pdHJvZ2VuX2xldmVsIjtzOjk6ImRlY2ltYWw6MiI7czoxNjoicGhvc3Bob3J1c19sZXZlbCI7czo5OiJkZWNpbWFsOjIiO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7czo5OiJkZWNpbWFsOjIiO3M6OToiZWxldmF0aW9uIjtzOjk6ImRlY2ltYWw6MiI7czo1OiJzbG9wZSI7czo5OiJkZWNpbWFsOjIiO3M6MTI6InRhcmdldF95aWVsZCI7czo5OiJkZWNpbWFsOjIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO31zOjE3OiIAKgBjbGFzc0Nhc3RDYWNoZSI7YTowOnt9czoyMToiACoAYXR0cmlidXRlQ2FzdENhY2hlIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MTp7aTowO3M6MTQ6ImF2YWlsYWJsZV9hcmVhIjt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjI2OntpOjA7czo3OiJ1c2VyX2lkIjtpOjE7czo3OiJmYXJtX2lkIjtpOjI7czo0OiJuYW1lIjtpOjM7czo4OiJsb2NhdGlvbiI7aTo0O3M6MTc6ImZpZWxkX2Nvb3JkaW5hdGVzIjtpOjU7czo5OiJzb2lsX3R5cGUiO2k6NjtzOjc6InNvaWxfcGgiO2k6NztzOjIyOiJvcmdhbmljX21hdHRlcl9jb250ZW50IjtpOjg7czoxNDoibml0cm9nZW5fbGV2ZWwiO2k6OTtzOjE2OiJwaG9zcGhvcnVzX2xldmVsIjtpOjEwO3M6MTU6InBvdGFzc2l1bV9sZXZlbCI7aToxMTtzOjQ6InNpemUiO2k6MTI7czoxMjoid2F0ZXJfYWNjZXNzIjtpOjEzO3M6MTI6IndhdGVyX3NvdXJjZSI7aToxNDtzOjE1OiJpcnJpZ2F0aW9uX3R5cGUiO2k6MTU7czoxNjoiZHJhaW5hZ2VfcXVhbGl0eSI7aToxNjtzOjk6ImVsZXZhdGlvbiI7aToxNztzOjU6InNsb3BlIjtpOjE4O3M6MTM6InByZXZpb3VzX2Nyb3AiO2k6MTk7czoyNDoiZmllbGRfcHJlcGFyYXRpb25fc3RhdHVzIjtpOjIwO3M6NToibm90ZXMiO2k6MjE7czo4OiJuaWNrbmFtZSI7aToyMjtzOjE1OiJwbGFudGluZ19tZXRob2QiO2k6MjM7czoxNjoiY3JvcHBpbmdfc2Vhc29ucyI7aToyNDtzOjEyOiJ0YXJnZXRfeWllbGQiO2k6MjU7czoyMDoiaW5mcmFzdHJ1Y3R1cmVfbm90ZXMiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxNTp7aTowO3M6ODoiZmllbGRfaWQiO2k6MTtzOjE2OiJzZWVkX3BsYW50aW5nX2lkIjtpOjI7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjM7czo5OiJjcm9wX3R5cGUiO2k6NDtzOjEzOiJwbGFudGluZ19kYXRlIjtpOjU7czoyMToiZXhwZWN0ZWRfaGFydmVzdF9kYXRlIjtpOjY7czoxOToiYWN0dWFsX2hhcnZlc3RfZGF0ZSI7aTo3O3M6Njoic3RhdHVzIjtpOjg7czoxNToicGxhbnRpbmdfbWV0aG9kIjtpOjk7czo5OiJzZWVkX3JhdGUiO2k6MTA7czoxMjoiYXJlYV9wbGFudGVkIjtpOjExO3M6Njoic2Vhc29uIjtpOjEyO3M6NToibm90ZXMiO2k6MTM7czoxODoid2VhdGhlcl9jb25kaXRpb25zIjtpOjE0O3M6OToic2VlZF91bml0Ijt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6NzoibGFib3JlciI7cjozMDI7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxMzp7aTowO3M6MTE6InBsYW50aW5nX2lkIjtpOjE7czo5OiJ0YXNrX3R5cGUiO2k6MjtzOjg6ImR1ZV9kYXRlIjtpOjM7czoxMToiZGVzY3JpcHRpb24iO2k6NDtzOjY6InN0YXR1cyI7aTo1O3M6MTE6ImFzc2lnbmVkX3RvIjtpOjY7czoxNjoibGFib3Jlcl9ncm91cF9pZCI7aTo3O3M6MTI6InBheW1lbnRfdHlwZSI7aTo4O3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7aTo5O3M6MTE6IndhZ2VfYW1vdW50IjtpOjEwO3M6NDoidW5pdCI7aToxMTtzOjg6InF1YW50aXR5IjtpOjEyO3M6MTA6InVuaXRfcHJpY2UiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319aTozO086MTU6IkFwcFxNb2RlbHNcVGFzayI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6NToidGFza3MiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxNjp7czoyOiJpZCI7aToxO3M6MTE6InBsYW50aW5nX2lkIjtpOjI7czo5OiJ0YXNrX3R5cGUiO3M6MTM6InRyYW5zcGxhbnRpbmciO3M6ODoiZHVlX2RhdGUiO3M6MTk6IjIwMjYtMDItMTIgMDA6MDA6MDAiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjEwOiJUcmFuc3BsYW50IjtzOjY6InN0YXR1cyI7czo5OiJjb21wbGV0ZWQiO3M6MTE6ImFzc2lnbmVkX3RvIjtpOjI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwOTowMTowNyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwOTowMToxMCI7czoxNjoibGFib3Jlcl9ncm91cF9pZCI7TjtzOjEyOiJwYXltZW50X3R5cGUiO3M6NDoid2FnZSI7czoyNDoicmV2ZW51ZV9zaGFyZV9wZXJjZW50YWdlIjtOO3M6MTE6IndhZ2VfYW1vdW50IjtzOjY6IjMwMC4wMCI7czo0OiJ1bml0IjtOO3M6ODoicXVhbnRpdHkiO047czoxMDoidW5pdF9wcmljZSI7Tjt9czoxMToiACoAb3JpZ2luYWwiO2E6MTY6e3M6MjoiaWQiO2k6MTtzOjExOiJwbGFudGluZ19pZCI7aToyO3M6OToidGFza190eXBlIjtzOjEzOiJ0cmFuc3BsYW50aW5nIjtzOjg6ImR1ZV9kYXRlIjtzOjE5OiIyMDI2LTAyLTEyIDAwOjAwOjAwIjtzOjExOiJkZXNjcmlwdGlvbiI7czoxMDoiVHJhbnNwbGFudCI7czo2OiJzdGF0dXMiO3M6OToiY29tcGxldGVkIjtzOjExOiJhc3NpZ25lZF90byI7aToyO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDk6MDE6MDciO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDk6MDE6MTAiO3M6MTY6ImxhYm9yZXJfZ3JvdXBfaWQiO047czoxMjoicGF5bWVudF90eXBlIjtzOjQ6IndhZ2UiO3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7TjtzOjExOiJ3YWdlX2Ftb3VudCI7czo2OiIzMDAuMDAiO3M6NDoidW5pdCI7TjtzOjg6InF1YW50aXR5IjtOO3M6MTA6InVuaXRfcHJpY2UiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjc6e3M6ODoiZHVlX2RhdGUiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6ODoiZGF0ZXRpbWUiO3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7czo5OiJkZWNpbWFsOjIiO3M6MTE6IndhZ2VfYW1vdW50IjtzOjk6ImRlY2ltYWw6MiI7czo4OiJxdWFudGl0eSI7czo5OiJkZWNpbWFsOjIiO3M6MTA6InVuaXRfcHJpY2UiO3M6OToiZGVjaW1hbDoyIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjI6e3M6ODoicGxhbnRpbmciO3I6NDc5O3M6NzoibGFib3JlciI7TzoxODoiQXBwXE1vZGVsc1xMYWJvcmVyIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo4OiJsYWJvcmVycyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjE4OntzOjI6ImlkIjtpOjI7czo0OiJuYW1lIjtzOjY6IkFTRFNBRCI7czo0OiJyYXRlIjtzOjY6IjMwMC4wMCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0OToxMyI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0OToxNCI7czo3OiJ1c2VyX2lkIjtpOjE7czo1OiJwaG9uZSI7czoxMToiMDk2MjQzNTE0NDEiO3M6NToiZW1haWwiO3M6MjM6Imphbm9zcGFuYWd1ZTFAZ21haWwuY29tIjtzOjc6ImFkZHJlc3MiO3M6MTc6Ik1hcmFtYWcsIGJ1a2lkbm9uIjtzOjExOiJza2lsbF9sZXZlbCI7czo2OiJleHBlcnQiO3M6MTQ6InNwZWNpYWxpemF0aW9uIjtzOjc6IlBsYW50ZXIiO3M6Njoic3RhdHVzIjtzOjY6ImFjdGl2ZSI7czo5OiJoaXJlX2RhdGUiO3M6MTA6IjIwMjYtMDItMTIiO3M6NToibm90ZXMiO047czoyMjoiZW1lcmdlbmN5X2NvbnRhY3RfbmFtZSI7czoxMzoiSmFub3MgUGFuYWd1ZSI7czoyMzoiZW1lcmdlbmN5X2NvbnRhY3RfcGhvbmUiO3M6MTE6IjA5NjI0MzUxNDQxIjtzOjk6InJhdGVfdHlwZSI7czo1OiJkYWlseSI7czoxNToicHJvZmlsZV9waWN0dXJlIjtzOjEwODoiaHR0cHM6Ly9vbGVuLXBhcmF0YWN0aWNhbC1vdmVyaG90bHkubmdyb2stZnJlZS5kZXYvc3RvcmFnZS9sYWJvcmVycy80ODZiYjc4Mi0yNzgwLTQ2YTktOWViOC0wODMwNWRiNzg2MjcuanBnIjt9czoxMToiACoAb3JpZ2luYWwiO2E6MTg6e3M6MjoiaWQiO2k6MjtzOjQ6Im5hbWUiO3M6NjoiQVNEU0FEIjtzOjQ6InJhdGUiO3M6NjoiMzAwLjAwIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ5OjEzIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ5OjE0IjtzOjc6InVzZXJfaWQiO2k6MTtzOjU6InBob25lIjtzOjExOiIwOTYyNDM1MTQ0MSI7czo1OiJlbWFpbCI7czoyMzoiamFub3NwYW5hZ3VlMUBnbWFpbC5jb20iO3M6NzoiYWRkcmVzcyI7czoxNzoiTWFyYW1hZywgYnVraWRub24iO3M6MTE6InNraWxsX2xldmVsIjtzOjY6ImV4cGVydCI7czoxNDoic3BlY2lhbGl6YXRpb24iO3M6NzoiUGxhbnRlciI7czo2OiJzdGF0dXMiO3M6NjoiYWN0aXZlIjtzOjk6ImhpcmVfZGF0ZSI7czoxMDoiMjAyNi0wMi0xMiI7czo1OiJub3RlcyI7TjtzOjIyOiJlbWVyZ2VuY3lfY29udGFjdF9uYW1lIjtzOjEzOiJKYW5vcyBQYW5hZ3VlIjtzOjIzOiJlbWVyZ2VuY3lfY29udGFjdF9waG9uZSI7czoxMToiMDk2MjQzNTE0NDEiO3M6OToicmF0ZV90eXBlIjtzOjU6ImRhaWx5IjtzOjE1OiJwcm9maWxlX3BpY3R1cmUiO3M6MTA4OiJodHRwczovL29sZW4tcGFyYXRhY3RpY2FsLW92ZXJob3RseS5uZ3Jvay1mcmVlLmRldi9zdG9yYWdlL2xhYm9yZXJzLzQ4NmJiNzgyLTI3ODAtNDZhOS05ZWI4LTA4MzA1ZGI3ODYyNy5qcGciO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTozOntzOjQ6InJhdGUiO3M6OToiZGVjaW1hbDoyIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjI3OiIAKgByZWxhdGlvbkF1dG9sb2FkQ2FsbGJhY2siO047czoyNjoiACoAcmVsYXRpb25BdXRvbG9hZENvbnRleHQiO047czoxMDoidGltZXN0YW1wcyI7YjoxO3M6MTM6InVzZXNVbmlxdWVJZHMiO2I6MDtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMToiACoAZmlsbGFibGUiO2E6MTY6e2k6MDtzOjQ6Im5hbWUiO2k6MTtzOjE1OiJwcm9maWxlX3BpY3R1cmUiO2k6MjtzOjU6InBob25lIjtpOjM7czo1OiJlbWFpbCI7aTo0O3M6NzoiYWRkcmVzcyI7aTo1O3M6MTE6InNraWxsX2xldmVsIjtpOjY7czoxNDoic3BlY2lhbGl6YXRpb24iO2k6NztzOjQ6InJhdGUiO2k6ODtzOjk6InJhdGVfdHlwZSI7aTo5O3M6Njoic3RhdHVzIjtpOjEwO3M6OToiaGlyZV9kYXRlIjtpOjExO3M6OToiaGlyZV9kYXRlIjtpOjEyO3M6MjI6ImVtZXJnZW5jeV9jb250YWN0X25hbWUiO2k6MTM7czoyMzoiZW1lcmdlbmN5X2NvbnRhY3RfcGhvbmUiO2k6MTQ7czo1OiJub3RlcyI7aToxNTtzOjc6InVzZXJfaWQiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6Mjc6IgAqAHJlbGF0aW9uQXV0b2xvYWRDYWxsYmFjayI7TjtzOjI2OiIAKgByZWxhdGlvbkF1dG9sb2FkQ29udGV4dCI7TjtzOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czoxMzoidXNlc1VuaXF1ZUlkcyI7YjowO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjExOiIAKgBmaWxsYWJsZSI7YToxMzp7aTowO3M6MTE6InBsYW50aW5nX2lkIjtpOjE7czo5OiJ0YXNrX3R5cGUiO2k6MjtzOjg6ImR1ZV9kYXRlIjtpOjM7czoxMToiZGVzY3JpcHRpb24iO2k6NDtzOjY6InN0YXR1cyI7aTo1O3M6MTE6ImFzc2lnbmVkX3RvIjtpOjY7czoxNjoibGFib3Jlcl9ncm91cF9pZCI7aTo3O3M6MTI6InBheW1lbnRfdHlwZSI7aTo4O3M6MjQ6InJldmVudWVfc2hhcmVfcGVyY2VudGFnZSI7aTo5O3M6MTE6IndhZ2VfYW1vdW50IjtpOjEwO3M6NDoidW5pdCI7aToxMTtzOjg6InF1YW50aXR5IjtpOjEyO3M6MTA6InVuaXRfcHJpY2UiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fXM6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDt9czoxNDoidXBjb21pbmdfdGFza3MiO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6Mjp7czo4OiIAKgBpdGVtcyI7YTowOnt9czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO31zOjEyOiJ3ZWF0aGVyX2RhdGEiO086Mjk6IklsbHVtaW5hdGVcU3VwcG9ydFxDb2xsZWN0aW9uIjoyOntzOjg6IgAqAGl0ZW1zIjthOjE6e2k6MDthOjI6e3M6NDoiZmFybSI7TzoxNToiQXBwXE1vZGVsc1xGYXJtIjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czo1OiJmYXJtcyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjE5OntzOjI6ImlkIjtpOjE7czo3OiJ1c2VyX2lkIjtpOjE7czo0OiJuYW1lIjtzOjc6Ik1hbmFnb2siO3M6ODoibG9jYXRpb24iO3M6Mzc6Ik1hbmFnb2ssIENpdHkgb2YgTWFsYXliYWxheSwgQnVraWRub24iO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjk6InRlc3QgZmFybSI7czoxMDoidG90YWxfYXJlYSI7czo1OiI1MC4wMCI7czoxNToiY3VsdGl2YXRlZF9hcmVhIjtzOjU6IjQwLjAwIjtzOjk6InNvaWxfdHlwZSI7czo0OiJsb2FtIjtzOjc6InNvaWxfcGgiO3M6MzoiNi40IjtzOjEyOiJ3YXRlcl9zb3VyY2UiO3M6NDoid2VsbCI7czoxNToiaXJyaWdhdGlvbl90eXBlIjtzOjk6InNwcmlua2xlciI7czoyMzoicHJpbWFyeV9yaWNlX3ZhcmlldHlfaWQiO047czoxNjoiZmFybV9jb29yZGluYXRlcyI7czoyOToieyJsYXQiOjguMDI3NiwibG9uIjoxMjUuMTg4NX0iO3M6OToiZWxldmF0aW9uIjtOO3M6NToic2xvcGUiO047czoxNToiZHJhaW5hZ2Vfc3lzdGVtIjtOO3M6MTc6ImlzX3NldHVwX2NvbXBsZXRlIjtiOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDoyNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDo1NSI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjE5OntzOjI6ImlkIjtpOjE7czo3OiJ1c2VyX2lkIjtpOjE7czo0OiJuYW1lIjtzOjc6Ik1hbmFnb2siO3M6ODoibG9jYXRpb24iO3M6Mzc6Ik1hbmFnb2ssIENpdHkgb2YgTWFsYXliYWxheSwgQnVraWRub24iO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjk6InRlc3QgZmFybSI7czoxMDoidG90YWxfYXJlYSI7czo1OiI1MC4wMCI7czoxNToiY3VsdGl2YXRlZF9hcmVhIjtzOjU6IjQwLjAwIjtzOjk6InNvaWxfdHlwZSI7czo0OiJsb2FtIjtzOjc6InNvaWxfcGgiO3M6MzoiNi40IjtzOjEyOiJ3YXRlcl9zb3VyY2UiO3M6NDoid2VsbCI7czoxNToiaXJyaWdhdGlvbl90eXBlIjtzOjk6InNwcmlua2xlciI7czoyMzoicHJpbWFyeV9yaWNlX3ZhcmlldHlfaWQiO047czoxNjoiZmFybV9jb29yZGluYXRlcyI7czoyOToieyJsYXQiOjguMDI3NiwibG9uIjoxMjUuMTg4NX0iO3M6OToiZWxldmF0aW9uIjtOO3M6NToic2xvcGUiO047czoxNToiZHJhaW5hZ2Vfc3lzdGVtIjtOO3M6MTc6ImlzX3NldHVwX2NvbXBsZXRlIjtiOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDoyNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDo1NSI7fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6MTE6IgAqAHByZXZpb3VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjc6e3M6MTY6ImZhcm1fY29vcmRpbmF0ZXMiO3M6NToiYXJyYXkiO3M6MTA6InRvdGFsX2FyZWEiO3M6OToiZGVjaW1hbDoyIjtzOjE1OiJjdWx0aXZhdGVkX2FyZWEiO3M6OToiZGVjaW1hbDoyIjtzOjc6InNvaWxfcGgiO3M6OToiZGVjaW1hbDoxIjtzOjk6ImVsZXZhdGlvbiI7czo5OiJkZWNpbWFsOjIiO3M6NToic2xvcGUiO3M6OToiZGVjaW1hbDoyIjtzOjE3OiJpc19zZXR1cF9jb21wbGV0ZSI7czo3OiJib29sZWFuIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6MTM6ImxhdGVzdFdlYXRoZXIiO086MjE6IkFwcFxNb2RlbHNcV2VhdGhlckxvZyI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6MTI6IndlYXRoZXJfbG9ncyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjEwOntzOjI6ImlkIjtpOjQ1NTY7czoxMToidGVtcGVyYXR1cmUiO3M6NDoiMjQuOSI7czo4OiJodW1pZGl0eSI7czo0OiI3OS4wIjtzOjEwOiJ3aW5kX3NwZWVkIjtzOjM6IjguNyI7czoxMDoiY29uZGl0aW9ucyI7czo2OiJjbG91ZHkiO3M6MTE6InJlY29yZGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDIwOjQ1OjAwIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEyOjQ1OjAyIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEyOjQ1OjAyIjtzOjg6InJhaW5mYWxsIjtzOjQ6IjAuMDAiO3M6NzoiZmFybV9pZCI7aToxO31zOjExOiIAKgBvcmlnaW5hbCI7YToxMDp7czoyOiJpZCI7aTo0NTU2O3M6MTE6InRlbXBlcmF0dXJlIjtzOjQ6IjI0LjkiO3M6ODoiaHVtaWRpdHkiO3M6NDoiNzkuMCI7czoxMDoid2luZF9zcGVlZCI7czozOiI4LjciO3M6MTA6ImNvbmRpdGlvbnMiO3M6NjoiY2xvdWR5IjtzOjExOiJyZWNvcmRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAyMDo0NTowMCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMjo0NTowMiI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMjo0NTowMiI7czo4OiJyYWluZmFsbCI7czo0OiIwLjAwIjtzOjc6ImZhcm1faWQiO2k6MTt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6Nzp7czoxMToidGVtcGVyYXR1cmUiO3M6OToiZGVjaW1hbDoxIjtzOjg6Imh1bWlkaXR5IjtzOjk6ImRlY2ltYWw6MSI7czoxMDoid2luZF9zcGVlZCI7czo5OiJkZWNpbWFsOjEiO3M6ODoicmFpbmZhbGwiO3M6OToiZGVjaW1hbDoyIjtzOjExOiJyZWNvcmRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjc6e2k6MDtzOjc6ImZhcm1faWQiO2k6MTtzOjExOiJ0ZW1wZXJhdHVyZSI7aToyO3M6ODoiaHVtaWRpdHkiO2k6MztzOjEwOiJ3aW5kX3NwZWVkIjtpOjQ7czo4OiJyYWluZmFsbCI7aTo1O3M6MTA6ImNvbmRpdGlvbnMiO2k6NjtzOjExOiJyZWNvcmRlZF9hdCI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjE2OntpOjA7czo3OiJ1c2VyX2lkIjtpOjE7czo0OiJuYW1lIjtpOjI7czo4OiJsb2NhdGlvbiI7aTozO3M6MTE6ImRlc2NyaXB0aW9uIjtpOjQ7czoxMDoidG90YWxfYXJlYSI7aTo1O3M6MTU6ImN1bHRpdmF0ZWRfYXJlYSI7aTo2O3M6OToic29pbF90eXBlIjtpOjc7czo3OiJzb2lsX3BoIjtpOjg7czoxMjoid2F0ZXJfc291cmNlIjtpOjk7czoxNToiaXJyaWdhdGlvbl90eXBlIjtpOjEwO3M6MjM6InByaW1hcnlfcmljZV92YXJpZXR5X2lkIjtpOjExO3M6MTY6ImZhcm1fY29vcmRpbmF0ZXMiO2k6MTI7czo5OiJlbGV2YXRpb24iO2k6MTM7czo1OiJzbG9wZSI7aToxNDtzOjE1OiJkcmFpbmFnZV9zeXN0ZW0iO2k6MTU7czoxNzoiaXNfc2V0dXBfY29tcGxldGUiO31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319czo3OiJ3ZWF0aGVyIjtyOjExNjY7fX1zOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7fXM6MTY6Im1vbnRobHlfZXhwZW5zZXMiO3M6NjoiMzQ1LjAwIjtzOjEzOiJtb250aGx5X3NhbGVzIjtzOjk6IjIyNTAwMC4wMCI7czoxNzoibWFya2V0cGxhY2Vfc3RhdHMiO2E6Njp7czoxNDoidG90YWxfcHJvZHVjdHMiO2k6MjtzOjE1OiJhY3RpdmVfbGlzdGluZ3MiO2k6MjtzOjE0OiJwZW5kaW5nX29yZGVycyI7aToyO3M6MTM6InRvdGFsX3JldmVudWUiO2Q6MjI1MDAwO3M6MTk6Im1hcmtldHBsYWNlX3JldmVudWUiO2k6MDtzOjIwOiJkaXJlY3Rfc2FsZXNfcmV2ZW51ZSI7czo5OiIyMjUwMDAuMDAiO31zOjE1OiJyZWNlbnRfcHJvZHVjdHMiO086Mzk6IklsbHVtaW5hdGVcRGF0YWJhc2VcRWxvcXVlbnRcQ29sbGVjdGlvbiI6Mjp7czo4OiIAKgBpdGVtcyI7YToyOntpOjA7TzoyMjoiQXBwXE1vZGVsc1xSaWNlUHJvZHVjdCI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6MTM6InJpY2VfcHJvZHVjdHMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YTozMTp7czoyOiJpZCI7aToyO3M6OToiZmFybWVyX2lkIjtpOjE7czoxNToicmljZV92YXJpZXR5X2lkIjtpOjI7czoxMDoiaGFydmVzdF9pZCI7aToyO3M6NDoibmFtZSI7czoxMjoiVGhhaSBKYXNtaW5lIjtzOjExOiJkZXNjcmlwdGlvbiI7czo1OiJCdWdhcyI7czoxODoicXVhbnRpdHlfYXZhaWxhYmxlIjtzOjU6Ijc5LjAwIjtzOjQ6InVuaXQiO3M6Mjoia2ciO3M6MTQ6InByaWNlX3Blcl91bml0IjtzOjc6IjE1MDAuMDAiO3M6MTM6InF1YWxpdHlfZ3JhZGUiO3M6NzoicHJlbWl1bSI7czoxNjoibW9pc3R1cmVfY29udGVudCI7TjtzOjE3OiJwdXJpdHlfcGVyY2VudGFnZSI7TjtzOjEyOiJoYXJ2ZXN0X2RhdGUiO047czoxNzoicHJvY2Vzc2luZ19tZXRob2QiO047czoxODoic3RvcmFnZV9jb25kaXRpb25zIjtOO3M6MTM6ImNlcnRpZmljYXRpb24iO047czo2OiJpbWFnZXMiO3M6NjU6IlsiXC9zdG9yYWdlXC9wcm9kdWN0c1wvMTRmNjhiYjUtZWFjMC00YmMwLTk5OGEtMTg4NGVkMWNmMTJiLnBuZyJdIjtzOjg6ImxvY2F0aW9uIjtOO3M6MTA6ImlzX29yZ2FuaWMiO2I6MDtzOjEyOiJpc19hdmFpbGFibGUiO2I6MTtzOjIyOiJtaW5pbXVtX29yZGVyX3F1YW50aXR5IjtOO3M6MTc6InBhY2thZ2luZ19vcHRpb25zIjtOO3M6MTY6ImRlbGl2ZXJ5X29wdGlvbnMiO047czoxMzoicGF5bWVudF90ZXJtcyI7TjtzOjEyOiJjb250YWN0X2luZm8iO047czo1OiJub3RlcyI7TjtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDEzOjU5OjE4IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEzIDE0OjAyOjQ3IjtzOjE3OiJwcm9kdWN0aW9uX3N0YXR1cyI7czo5OiJhdmFpbGFibGUiO3M6MTQ6ImF2YWlsYWJsZV9mcm9tIjtOO3M6MTc6ImludmVudG9yeV9pdGVtX2lkIjtpOjQ7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjMxOntzOjI6ImlkIjtpOjI7czo5OiJmYXJtZXJfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MjtzOjEwOiJoYXJ2ZXN0X2lkIjtpOjI7czo0OiJuYW1lIjtzOjEyOiJUaGFpIEphc21pbmUiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjU6IkJ1Z2FzIjtzOjE4OiJxdWFudGl0eV9hdmFpbGFibGUiO3M6NToiNzkuMDAiO3M6NDoidW5pdCI7czoyOiJrZyI7czoxNDoicHJpY2VfcGVyX3VuaXQiO3M6NzoiMTUwMC4wMCI7czoxMzoicXVhbGl0eV9ncmFkZSI7czo3OiJwcmVtaXVtIjtzOjE2OiJtb2lzdHVyZV9jb250ZW50IjtOO3M6MTc6InB1cml0eV9wZXJjZW50YWdlIjtOO3M6MTI6ImhhcnZlc3RfZGF0ZSI7TjtzOjE3OiJwcm9jZXNzaW5nX21ldGhvZCI7TjtzOjE4OiJzdG9yYWdlX2NvbmRpdGlvbnMiO047czoxMzoiY2VydGlmaWNhdGlvbiI7TjtzOjY6ImltYWdlcyI7czo2NToiWyJcL3N0b3JhZ2VcL3Byb2R1Y3RzXC8xNGY2OGJiNS1lYWMwLTRiYzAtOTk4YS0xODg0ZWQxY2YxMmIucG5nIl0iO3M6ODoibG9jYXRpb24iO047czoxMDoiaXNfb3JnYW5pYyI7YjowO3M6MTI6ImlzX2F2YWlsYWJsZSI7YjoxO3M6MjI6Im1pbmltdW1fb3JkZXJfcXVhbnRpdHkiO047czoxNzoicGFja2FnaW5nX29wdGlvbnMiO047czoxNjoiZGVsaXZlcnlfb3B0aW9ucyI7TjtzOjEzOiJwYXltZW50X3Rlcm1zIjtOO3M6MTI6ImNvbnRhY3RfaW5mbyI7TjtzOjU6Im5vdGVzIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTM6NTk6MTgiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTQ6MDI6NDciO3M6MTc6InByb2R1Y3Rpb25fc3RhdHVzIjtzOjk6ImF2YWlsYWJsZSI7czoxNDoiYXZhaWxhYmxlX2Zyb20iO047czoxNzoiaW52ZW50b3J5X2l0ZW1faWQiO2k6NDt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MTY6e3M6MTg6InF1YW50aXR5X2F2YWlsYWJsZSI7czo5OiJkZWNpbWFsOjIiO3M6MTQ6InByaWNlX3Blcl91bml0IjtzOjk6ImRlY2ltYWw6MiI7czoxNjoibW9pc3R1cmVfY29udGVudCI7czo5OiJkZWNpbWFsOjIiO3M6MTc6InB1cml0eV9wZXJjZW50YWdlIjtzOjk6ImRlY2ltYWw6MiI7czoyMjoibWluaW11bV9vcmRlcl9xdWFudGl0eSI7czo5OiJkZWNpbWFsOjIiO3M6MTI6ImhhcnZlc3RfZGF0ZSI7czo0OiJkYXRlIjtzOjE0OiJhdmFpbGFibGVfZnJvbSI7czo0OiJkYXRlIjtzOjY6ImltYWdlcyI7czo1OiJhcnJheSI7czo4OiJsb2NhdGlvbiI7czo1OiJhcnJheSI7czoxNzoicGFja2FnaW5nX29wdGlvbnMiO3M6NToiYXJyYXkiO3M6MTY6ImRlbGl2ZXJ5X29wdGlvbnMiO3M6NToiYXJyYXkiO3M6MTI6ImNvbnRhY3RfaW5mbyI7czo1OiJhcnJheSI7czoxMDoiaXNfb3JnYW5pYyI7czo3OiJib29sZWFuIjtzOjEyOiJpc19hdmFpbGFibGUiO3M6NzoiYm9vbGVhbiI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YToxOntzOjExOiJyaWNlVmFyaWV0eSI7TzoyMjoiQXBwXE1vZGVsc1xSaWNlVmFyaWV0eSI6MzM6e3M6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToicGdzcWwiO3M6ODoiACoAdGFibGUiO3M6MTQ6InJpY2VfdmFyaWV0aWVzIjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTk6InByZXZlbnRzTGF6eUxvYWRpbmciO2I6MDtzOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MTM6e3M6MjoiaWQiO2k6MjtzOjQ6Im5hbWUiO3M6MTI6IlRoYWkgSmFzbWluZSI7czoxMjoidmFyaWV0eV9jb2RlIjtzOjEyOiJSSUNFLUpBU01JTkUiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjU2OiJQcmVtaXVtIGZyYWdyYW50IHJpY2UgdmFsdWVkIGZvciBhcm9tYSBhbmQgc29mdCB0ZXh0dXJlLiI7czoxMzoibWF0dXJpdHlfZGF5cyI7aToxMTA7czoyNToiYXZlcmFnZV95aWVsZF9wZXJfaGVjdGFyZSI7czo0OiI0LjkwIjtzOjY6InNlYXNvbiI7czozOiJkcnkiO3M6MTA6ImdyYWluX3R5cGUiO3M6NDoibG9uZyI7czoxNjoicmVzaXN0YW5jZV9sZXZlbCI7czo2OiJtZWRpdW0iO3M6MTU6ImNoYXJhY3RlcmlzdGljcyI7czo2NzoieyJub3RlcyI6IlJlcXVpcmVzIGNvbnNpc3RlbnQgaXJyaWdhdGlvbiBhbmQgd2VsbC1kcmFpbmVkIGZpZWxkcy4ifSI7czo5OiJpc19hY3RpdmUiO2I6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0Ijt9czoxMToiACoAb3JpZ2luYWwiO2E6MTM6e3M6MjoiaWQiO2k6MjtzOjQ6Im5hbWUiO3M6MTI6IlRoYWkgSmFzbWluZSI7czoxMjoidmFyaWV0eV9jb2RlIjtzOjEyOiJSSUNFLUpBU01JTkUiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjU2OiJQcmVtaXVtIGZyYWdyYW50IHJpY2UgdmFsdWVkIGZvciBhcm9tYSBhbmQgc29mdCB0ZXh0dXJlLiI7czoxMzoibWF0dXJpdHlfZGF5cyI7aToxMTA7czoyNToiYXZlcmFnZV95aWVsZF9wZXJfaGVjdGFyZSI7czo0OiI0LjkwIjtzOjY6InNlYXNvbiI7czozOiJkcnkiO3M6MTA6ImdyYWluX3R5cGUiO3M6NDoibG9uZyI7czoxNjoicmVzaXN0YW5jZV9sZXZlbCI7czo2OiJtZWRpdW0iO3M6MTU6ImNoYXJhY3RlcmlzdGljcyI7czo2NzoieyJub3RlcyI6IlJlcXVpcmVzIGNvbnNpc3RlbnQgaXJyaWdhdGlvbiBhbmQgd2VsbC1kcmFpbmVkIGZpZWxkcy4ifSI7czo5OiJpc19hY3RpdmUiO2I6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6NTp7czoxNToiY2hhcmFjdGVyaXN0aWNzIjtzOjU6ImFycmF5IjtzOjI1OiJhdmVyYWdlX3lpZWxkX3Blcl9oZWN0YXJlIjtzOjk6ImRlY2ltYWw6MiI7czo5OiJpc19hY3RpdmUiO3M6NzoiYm9vbGVhbiI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjEwOntpOjA7czo0OiJuYW1lIjtpOjE7czoxMjoidmFyaWV0eV9jb2RlIjtpOjI7czoxMToiZGVzY3JpcHRpb24iO2k6MztzOjEzOiJtYXR1cml0eV9kYXlzIjtpOjQ7czoyNToiYXZlcmFnZV95aWVsZF9wZXJfaGVjdGFyZSI7aTo1O3M6Njoic2Vhc29uIjtpOjY7czoxMDoiZ3JhaW5fdHlwZSI7aTo3O3M6MTY6InJlc2lzdGFuY2VfbGV2ZWwiO2k6ODtzOjE1OiJjaGFyYWN0ZXJpc3RpY3MiO2k6OTtzOjk6ImlzX2FjdGl2ZSI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjI4OntpOjA7czo5OiJmYXJtZXJfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MjtzOjEwOiJoYXJ2ZXN0X2lkIjtpOjM7czoxNzoiaW52ZW50b3J5X2l0ZW1faWQiO2k6NDtzOjQ6Im5hbWUiO2k6NTtzOjExOiJkZXNjcmlwdGlvbiI7aTo2O3M6MTg6InF1YW50aXR5X2F2YWlsYWJsZSI7aTo3O3M6NDoidW5pdCI7aTo4O3M6MTQ6InByaWNlX3Blcl91bml0IjtpOjk7czoxMzoicXVhbGl0eV9ncmFkZSI7aToxMDtzOjE2OiJtb2lzdHVyZV9jb250ZW50IjtpOjExO3M6MTc6InB1cml0eV9wZXJjZW50YWdlIjtpOjEyO3M6MTI6ImhhcnZlc3RfZGF0ZSI7aToxMztzOjE3OiJwcm9jZXNzaW5nX21ldGhvZCI7aToxNDtzOjE4OiJzdG9yYWdlX2NvbmRpdGlvbnMiO2k6MTU7czoxMzoiY2VydGlmaWNhdGlvbiI7aToxNjtzOjY6ImltYWdlcyI7aToxNztzOjg6ImxvY2F0aW9uIjtpOjE4O3M6MTA6ImlzX29yZ2FuaWMiO2k6MTk7czoxMjoiaXNfYXZhaWxhYmxlIjtpOjIwO3M6MTc6InByb2R1Y3Rpb25fc3RhdHVzIjtpOjIxO3M6MTQ6ImF2YWlsYWJsZV9mcm9tIjtpOjIyO3M6MjI6Im1pbmltdW1fb3JkZXJfcXVhbnRpdHkiO2k6MjM7czoxNzoicGFja2FnaW5nX29wdGlvbnMiO2k6MjQ7czoxNjoiZGVsaXZlcnlfb3B0aW9ucyI7aToyNTtzOjEzOiJwYXltZW50X3Rlcm1zIjtpOjI2O3M6MTI6ImNvbnRhY3RfaW5mbyI7aToyNztzOjU6Im5vdGVzIjt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fWk6MTtPOjIyOiJBcHBcTW9kZWxzXFJpY2VQcm9kdWN0IjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czoxMzoicmljZV9wcm9kdWN0cyI7czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjE5OiJwcmV2ZW50c0xhenlMb2FkaW5nIjtiOjA7czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjMxOntzOjI6ImlkIjtpOjE7czo5OiJmYXJtZXJfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MTtzOjEwOiJoYXJ2ZXN0X2lkIjtpOjE7czo0OiJuYW1lIjtzOjQ6IklSNjQiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjM6IndvdyI7czoxODoicXVhbnRpdHlfYXZhaWxhYmxlIjtzOjY6IjEwMi4wMCI7czo0OiJ1bml0IjtzOjU6InNhY2tzIjtzOjE0OiJwcmljZV9wZXJfdW5pdCI7czo3OiIxNTAwLjAwIjtzOjEzOiJxdWFsaXR5X2dyYWRlIjtzOjc6InByZW1pdW0iO3M6MTY6Im1vaXN0dXJlX2NvbnRlbnQiO047czoxNzoicHVyaXR5X3BlcmNlbnRhZ2UiO047czoxMjoiaGFydmVzdF9kYXRlIjtOO3M6MTc6InByb2Nlc3NpbmdfbWV0aG9kIjtOO3M6MTg6InN0b3JhZ2VfY29uZGl0aW9ucyI7TjtzOjEzOiJjZXJ0aWZpY2F0aW9uIjtOO3M6NjoiaW1hZ2VzIjtzOjY2OiJbIlwvc3RvcmFnZVwvcHJvZHVjdHNcLzhmNTgyZWZmLThiOTUtNGU3Ny1iNmRiLTYwN2EyODdlZWJkYi53ZWJwIl0iO3M6ODoibG9jYXRpb24iO047czoxMDoiaXNfb3JnYW5pYyI7YjowO3M6MTI6ImlzX2F2YWlsYWJsZSI7YjoxO3M6MjI6Im1pbmltdW1fb3JkZXJfcXVhbnRpdHkiO047czoxNzoicGFja2FnaW5nX29wdGlvbnMiO047czoxNjoiZGVsaXZlcnlfb3B0aW9ucyI7TjtzOjEzOiJwYXltZW50X3Rlcm1zIjtOO3M6MTI6ImNvbnRhY3RfaW5mbyI7TjtzOjU6Im5vdGVzIjtOO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTIgMDk6MDM6NDgiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjYtMDItMTMgMTM6NTA6MDQiO3M6MTc6InByb2R1Y3Rpb25fc3RhdHVzIjtzOjk6ImF2YWlsYWJsZSI7czoxNDoiYXZhaWxhYmxlX2Zyb20iO047czoxNzoiaW52ZW50b3J5X2l0ZW1faWQiO2k6Mzt9czoxMToiACoAb3JpZ2luYWwiO2E6MzE6e3M6MjoiaWQiO2k6MTtzOjk6ImZhcm1lcl9pZCI7aToxO3M6MTU6InJpY2VfdmFyaWV0eV9pZCI7aToxO3M6MTA6ImhhcnZlc3RfaWQiO2k6MTtzOjQ6Im5hbWUiO3M6NDoiSVI2NCI7czoxMToiZGVzY3JpcHRpb24iO3M6Mzoid293IjtzOjE4OiJxdWFudGl0eV9hdmFpbGFibGUiO3M6NjoiMTAyLjAwIjtzOjQ6InVuaXQiO3M6NToic2Fja3MiO3M6MTQ6InByaWNlX3Blcl91bml0IjtzOjc6IjE1MDAuMDAiO3M6MTM6InF1YWxpdHlfZ3JhZGUiO3M6NzoicHJlbWl1bSI7czoxNjoibW9pc3R1cmVfY29udGVudCI7TjtzOjE3OiJwdXJpdHlfcGVyY2VudGFnZSI7TjtzOjEyOiJoYXJ2ZXN0X2RhdGUiO047czoxNzoicHJvY2Vzc2luZ19tZXRob2QiO047czoxODoic3RvcmFnZV9jb25kaXRpb25zIjtOO3M6MTM6ImNlcnRpZmljYXRpb24iO047czo2OiJpbWFnZXMiO3M6NjY6IlsiXC9zdG9yYWdlXC9wcm9kdWN0c1wvOGY1ODJlZmYtOGI5NS00ZTc3LWI2ZGItNjA3YTI4N2VlYmRiLndlYnAiXSI7czo4OiJsb2NhdGlvbiI7TjtzOjEwOiJpc19vcmdhbmljIjtiOjA7czoxMjoiaXNfYXZhaWxhYmxlIjtiOjE7czoyMjoibWluaW11bV9vcmRlcl9xdWFudGl0eSI7TjtzOjE3OiJwYWNrYWdpbmdfb3B0aW9ucyI7TjtzOjE2OiJkZWxpdmVyeV9vcHRpb25zIjtOO3M6MTM6InBheW1lbnRfdGVybXMiO047czoxMjoiY29udGFjdF9pbmZvIjtOO3M6NToibm90ZXMiO047czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwOTowMzo0OCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMyAxMzo1MDowNCI7czoxNzoicHJvZHVjdGlvbl9zdGF0dXMiO3M6OToiYXZhaWxhYmxlIjtzOjE0OiJhdmFpbGFibGVfZnJvbSI7TjtzOjE3OiJpbnZlbnRvcnlfaXRlbV9pZCI7aTozO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjExOiIAKgBwcmV2aW91cyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YToxNjp7czoxODoicXVhbnRpdHlfYXZhaWxhYmxlIjtzOjk6ImRlY2ltYWw6MiI7czoxNDoicHJpY2VfcGVyX3VuaXQiO3M6OToiZGVjaW1hbDoyIjtzOjE2OiJtb2lzdHVyZV9jb250ZW50IjtzOjk6ImRlY2ltYWw6MiI7czoxNzoicHVyaXR5X3BlcmNlbnRhZ2UiO3M6OToiZGVjaW1hbDoyIjtzOjIyOiJtaW5pbXVtX29yZGVyX3F1YW50aXR5IjtzOjk6ImRlY2ltYWw6MiI7czoxMjoiaGFydmVzdF9kYXRlIjtzOjQ6ImRhdGUiO3M6MTQ6ImF2YWlsYWJsZV9mcm9tIjtzOjQ6ImRhdGUiO3M6NjoiaW1hZ2VzIjtzOjU6ImFycmF5IjtzOjg6ImxvY2F0aW9uIjtzOjU6ImFycmF5IjtzOjE3OiJwYWNrYWdpbmdfb3B0aW9ucyI7czo1OiJhcnJheSI7czoxNjoiZGVsaXZlcnlfb3B0aW9ucyI7czo1OiJhcnJheSI7czoxMjoiY29udGFjdF9pbmZvIjtzOjU6ImFycmF5IjtzOjEwOiJpc19vcmdhbmljIjtzOjc6ImJvb2xlYW4iO3M6MTI6ImlzX2F2YWlsYWJsZSI7czo3OiJib29sZWFuIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjg6ImRhdGV0aW1lIjt9czoxNzoiACoAY2xhc3NDYXN0Q2FjaGUiO2E6MDp7fXM6MjE6IgAqAGF0dHJpYnV0ZUNhc3RDYWNoZSI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjE6e3M6MTE6InJpY2VWYXJpZXR5IjtPOjIyOiJBcHBcTW9kZWxzXFJpY2VWYXJpZXR5IjozMzp7czoxMzoiACoAY29ubmVjdGlvbiI7czo1OiJwZ3NxbCI7czo4OiIAKgB0YWJsZSI7czoxNDoicmljZV92YXJpZXRpZXMiO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxOToicHJldmVudHNMYXp5TG9hZGluZyI7YjowO3M6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MTtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToxMzp7czoyOiJpZCI7aToxO3M6NDoibmFtZSI7czo0OiJJUjY0IjtzOjEyOiJ2YXJpZXR5X2NvZGUiO3M6OToiUklDRS1JUjY0IjtzOjExOiJkZXNjcmlwdGlvbiI7czo2NzoiSGlnaC15aWVsZGluZywgc2VtaS1kd2FyZiBJbmRpY2EgdmFyaWV0eSB3aWRlbHkgcGxhbnRlZCBpbiBTRSBBc2lhLiI7czoxMzoibWF0dXJpdHlfZGF5cyI7aToxMjA7czoyNToiYXZlcmFnZV95aWVsZF9wZXJfaGVjdGFyZSI7czo0OiI1LjYwIjtzOjY6InNlYXNvbiI7czozOiJ3ZXQiO3M6MTA6ImdyYWluX3R5cGUiO3M6NDoibG9uZyI7czoxNjoicmVzaXN0YW5jZV9sZXZlbCI7czo2OiJtZWRpdW0iO3M6MTU6ImNoYXJhY3RlcmlzdGljcyI7czo3NDoieyJub3RlcyI6IlBlcmZvcm1zIGJlc3QgaW4gaXJyaWdhdGVkIGxvd2xhbmQgZmllbGRzIHdpdGggZ29vZCBmZXJ0aWxpdHkuIn0iO3M6OToiaXNfYWN0aXZlIjtiOjE7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDoyNCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyNi0wMi0xMiAwODo0NDoyNCI7fXM6MTE6IgAqAG9yaWdpbmFsIjthOjEzOntzOjI6ImlkIjtpOjE7czo0OiJuYW1lIjtzOjQ6IklSNjQiO3M6MTI6InZhcmlldHlfY29kZSI7czo5OiJSSUNFLUlSNjQiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjY3OiJIaWdoLXlpZWxkaW5nLCBzZW1pLWR3YXJmIEluZGljYSB2YXJpZXR5IHdpZGVseSBwbGFudGVkIGluIFNFIEFzaWEuIjtzOjEzOiJtYXR1cml0eV9kYXlzIjtpOjEyMDtzOjI1OiJhdmVyYWdlX3lpZWxkX3Blcl9oZWN0YXJlIjtzOjQ6IjUuNjAiO3M6Njoic2Vhc29uIjtzOjM6IndldCI7czoxMDoiZ3JhaW5fdHlwZSI7czo0OiJsb25nIjtzOjE2OiJyZXNpc3RhbmNlX2xldmVsIjtzOjY6Im1lZGl1bSI7czoxNToiY2hhcmFjdGVyaXN0aWNzIjtzOjc0OiJ7Im5vdGVzIjoiUGVyZm9ybXMgYmVzdCBpbiBpcnJpZ2F0ZWQgbG93bGFuZCBmaWVsZHMgd2l0aCBnb29kIGZlcnRpbGl0eS4ifSI7czo5OiJpc19hY3RpdmUiO2I6MTtzOjEwOiJjcmVhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0IjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjE5OiIyMDI2LTAyLTEyIDA4OjQ0OjI0Ijt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czoxMToiACoAcHJldmlvdXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6NTp7czoxNToiY2hhcmFjdGVyaXN0aWNzIjtzOjU6ImFycmF5IjtzOjI1OiJhdmVyYWdlX3lpZWxkX3Blcl9oZWN0YXJlIjtzOjk6ImRlY2ltYWw6MiI7czo5OiJpc19hY3RpdmUiO3M6NzoiYm9vbGVhbiI7czoxMDoiY3JlYXRlZF9hdCI7czo4OiJkYXRldGltZSI7czoxMDoidXBkYXRlZF9hdCI7czo4OiJkYXRldGltZSI7fXM6MTc6IgAqAGNsYXNzQ2FzdENhY2hlIjthOjA6e31zOjIxOiIAKgBhdHRyaWJ1dGVDYXN0Q2FjaGUiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjEwOntpOjA7czo0OiJuYW1lIjtpOjE7czoxMjoidmFyaWV0eV9jb2RlIjtpOjI7czoxMToiZGVzY3JpcHRpb24iO2k6MztzOjEzOiJtYXR1cml0eV9kYXlzIjtpOjQ7czoyNToiYXZlcmFnZV95aWVsZF9wZXJfaGVjdGFyZSI7aTo1O3M6Njoic2Vhc29uIjtpOjY7czoxMDoiZ3JhaW5fdHlwZSI7aTo3O3M6MTY6InJlc2lzdGFuY2VfbGV2ZWwiO2k6ODtzOjE1OiJjaGFyYWN0ZXJpc3RpY3MiO2k6OTtzOjk6ImlzX2FjdGl2ZSI7fXM6MTA6IgAqAGd1YXJkZWQiO2E6MTp7aTowO3M6MToiKiI7fX19czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoyNzoiACoAcmVsYXRpb25BdXRvbG9hZENhbGxiYWNrIjtOO3M6MjY6IgAqAHJlbGF0aW9uQXV0b2xvYWRDb250ZXh0IjtOO3M6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjEzOiJ1c2VzVW5pcXVlSWRzIjtiOjA7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjI4OntpOjA7czo5OiJmYXJtZXJfaWQiO2k6MTtzOjE1OiJyaWNlX3ZhcmlldHlfaWQiO2k6MjtzOjEwOiJoYXJ2ZXN0X2lkIjtpOjM7czoxNzoiaW52ZW50b3J5X2l0ZW1faWQiO2k6NDtzOjQ6Im5hbWUiO2k6NTtzOjExOiJkZXNjcmlwdGlvbiI7aTo2O3M6MTg6InF1YW50aXR5X2F2YWlsYWJsZSI7aTo3O3M6NDoidW5pdCI7aTo4O3M6MTQ6InByaWNlX3Blcl91bml0IjtpOjk7czoxMzoicXVhbGl0eV9ncmFkZSI7aToxMDtzOjE2OiJtb2lzdHVyZV9jb250ZW50IjtpOjExO3M6MTc6InB1cml0eV9wZXJjZW50YWdlIjtpOjEyO3M6MTI6ImhhcnZlc3RfZGF0ZSI7aToxMztzOjE3OiJwcm9jZXNzaW5nX21ldGhvZCI7aToxNDtzOjE4OiJzdG9yYWdlX2NvbmRpdGlvbnMiO2k6MTU7czoxMzoiY2VydGlmaWNhdGlvbiI7aToxNjtzOjY6ImltYWdlcyI7aToxNztzOjg6ImxvY2F0aW9uIjtpOjE4O3M6MTA6ImlzX29yZ2FuaWMiO2k6MTk7czoxMjoiaXNfYXZhaWxhYmxlIjtpOjIwO3M6MTc6InByb2R1Y3Rpb25fc3RhdHVzIjtpOjIxO3M6MTQ6ImF2YWlsYWJsZV9mcm9tIjtpOjIyO3M6MjI6Im1pbmltdW1fb3JkZXJfcXVhbnRpdHkiO2k6MjM7czoxNzoicGFja2FnaW5nX29wdGlvbnMiO2k6MjQ7czoxNjoiZGVsaXZlcnlfb3B0aW9ucyI7aToyNTtzOjEzOiJwYXltZW50X3Rlcm1zIjtpOjI2O3M6MTI6ImNvbnRhY3RfaW5mbyI7aToyNztzOjU6Im5vdGVzIjt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fX1zOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7fX0=	1770994286
farm-operations-management-system-cache-farmer_order_stats_1	a:10:{s:13:"total_revenue";d:225000;s:12:"total_orders";i:11;s:7:"pending";i:2;s:9:"confirmed";i:1;s:10:"processing";i:0;s:7:"shipped";i:0;s:9:"delivered";i:3;s:9:"cancelled";i:3;s:13:"active_orders";i:3;s:13:"revenue_trend";a:7:{i:0;a:3:{s:4:"date";s:10:"2026-02-07";s:3:"day";s:3:"Sat";s:7:"revenue";d:0;}i:1;a:3:{s:4:"date";s:10:"2026-02-08";s:3:"day";s:3:"Sun";s:7:"revenue";d:0;}i:2;a:3:{s:4:"date";s:10:"2026-02-09";s:3:"day";s:3:"Mon";s:7:"revenue";d:0;}i:3;a:3:{s:4:"date";s:10:"2026-02-10";s:3:"day";s:3:"Tue";s:7:"revenue";d:0;}i:4;a:3:{s:4:"date";s:10:"2026-02-11";s:3:"day";s:3:"Wed";s:7:"revenue";d:0;}i:5;a:3:{s:4:"date";s:10:"2026-02-12";s:3:"day";s:3:"Thu";s:7:"revenue";d:225000;}i:6;a:3:{s:4:"date";s:10:"2026-02-13";s:3:"day";s:3:"Fri";s:7:"revenue";d:0;}}}	1770996619
\.


--
-- TOC entry 4075 (class 0 OID 350758)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 4076 (class 0 OID 350766)
-- Dependencies: 227
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items (id, buyer_id, rice_product_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4078 (class 0 OID 350774)
-- Dependencies: 229
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, description, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4080 (class 0 OID 350782)
-- Dependencies: 231
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.expenses (id, description, amount, category, date, planting_id, created_at, updated_at, user_id, payment_method, receipt_number, notes, related_entity_type, related_entity_id) FROM stdin;
1	Initial Stock: Thai Jasmine (300 packets)	30000.00	seeds	2026-02-12 08:47:02	\N	2026-02-12 08:47:02	2026-02-12 08:47:02	1	cash	\N	Auto-generated from inventory item creation	inventory_item	1
2	Initial Stock: IR64 (300 packets)	30000.00	seeds	2026-02-12 08:47:36	\N	2026-02-12 08:47:36	2026-02-12 08:47:36	1	cash	\N	Auto-generated from inventory item creation	inventory_item	2
3	Labor: ASDSAD - transplanting task	300.00	labor	2026-02-12 09:01:10	2	2026-02-12 09:01:10	2026-02-12 09:01:10	1	cash	\N	Auto-generated from task completion. Task ID: 1, Laborer: ASDSAD	task	1
4	Labor: Janos Panague - harvesting task	15.00	labor	2026-02-12 09:02:17	1	2026-02-12 09:02:17	2026-02-12 09:02:17	1	revenue_share	\N	Auto-generated from task completion. Task ID: 2, Laborer: Janos Panague	task	2
5	Labor: Janos Panague - harvesting task	15.00	labor	2026-02-13 13:58:40	2	2026-02-13 13:58:40	2026-02-13 13:58:40	1	revenue_share	\N	Auto-generated from task completion. Task ID: 3, Laborer: Janos Panague	task	3
6	Labor: Janos Panague - harvesting task	15.00	labor	2026-02-13 14:07:31	3	2026-02-13 14:07:31	2026-02-13 14:07:31	1	revenue_share	\N	Auto-generated from task completion. Task ID: 4, Laborer: Janos Panague	task	4
7	Initial Stock: Koshihikari (200 packets)	20000.00	seeds	2026-02-13 14:11:28	\N	2026-02-13 14:11:28	2026-02-13 14:11:28	1	cash	\N	Auto-generated from inventory item creation	inventory_item	5
9	Labor: Janos Panague - harvesting task	15.00	labor	2026-02-13 14:47:37	5	2026-02-13 14:47:37	2026-02-13 14:47:37	1	revenue_share	\N	Auto-generated from task completion. Task ID: 6, Laborer: Janos Panague	task	6
\.


--
-- TOC entry 4082 (class 0 OID 350795)
-- Dependencies: 233
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 4084 (class 0 OID 350809)
-- Dependencies: 235
-- Data for Name: farms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.farms (id, user_id, name, location, description, total_area, cultivated_area, soil_type, soil_ph, water_source, irrigation_type, primary_rice_variety_id, farm_coordinates, elevation, slope, drainage_system, is_setup_complete, created_at, updated_at) FROM stdin;
1	1	Managok	Managok, City of Malaybalay, Bukidnon	test farm	50.00	40.00	loam	6.4	well	sprinkler	\N	{"lat":8.0276,"lon":125.1885}	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:55
\.


--
-- TOC entry 4086 (class 0 OID 350825)
-- Dependencies: 237
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.favorites (id, user_id, rice_product_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4088 (class 0 OID 350832)
-- Dependencies: 239
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fields (id, user_id, farm_id, name, location, field_coordinates, soil_type, size, water_access, drainage_quality, created_at, updated_at, soil_ph, organic_matter_content, nitrogen_level, phosphorus_level, potassium_level, elevation, water_source, irrigation_type, previous_crop, field_preparation_status, slope, notes, nickname, planting_method, cropping_seasons, target_yield, infrastructure_notes) FROM stdin;
1	1	1	Block 1	{"address":"Managok, City of Malaybalay, Bukidnon","lat":8.026817,"lon":125.190324,"province":"Bukidnon","city":"City of Malaybalay","barangay":"Managok"}	\N	loam	10.00	good	good	2026-02-12 08:45:37	2026-02-12 08:45:37	\N	\N	\N	\N	\N	\N	rainfall	flood	IR64	needs_assessment	\N	\N	\N	direct_seeding	1	5.00	\N
2	1	1	Block	{"address":"Managok, City of Malaybalay, Bukidnon","lat":8.026817,"lon":125.190324,"province":"Bukidnon","city":"City of Malaybalay","barangay":"Managok"}	\N	loam	10.00	good	excellent	2026-02-12 08:46:24	2026-02-12 08:46:24	\N	\N	\N	\N	\N	\N	rainfall	flood	Thai Jasmine	needs_assessment	\N	\N	\N	transplanting	1	5.00	\N
3	1	1	Block 2	{"address":"Managok, City of Malaybalay, Bukidnon","lat":8.026817,"lon":125.190324,"province":"Bukidnon","city":"City of Malaybalay","barangay":"Managok"}	\N	loam	5.00	good	good	2026-02-13 14:10:47	2026-02-13 14:10:47	\N	\N	\N	\N	\N	\N	rainfall	flood	\N	needs_assessment	\N	\N	\N	direct_seeding	1	4.00	\N
\.


--
-- TOC entry 4090 (class 0 OID 350848)
-- Dependencies: 241
-- Data for Name: group_laborer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_laborer (id, laborer_group_id, laborer_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4092 (class 0 OID 350855)
-- Dependencies: 243
-- Data for Name: harvests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.harvests (id, planting_id, yield, harvest_date, quality, created_at, updated_at, quantity, unit, quality_grade, price_per_unit, total_value, notes, harvester_share, harvester_share_percentage) FROM stdin;
1	1	300.00	2026-02-12 00:00:00	excellent	2026-02-12 09:02:16	2026-02-12 09:02:16	300.00	sacks	A	1500.00	450000.00	\N	45.00	15.00
2	2	100.00	2026-02-13 00:00:00	excellent	2026-02-13 13:58:39	2026-02-13 13:58:39	100.00	kg	A	1500.00	150000.00	\N	15.00	15.00
3	3	100.00	2026-02-13 00:00:00	excellent	2026-02-13 14:07:31	2026-02-13 14:07:31	100.00	sacks	A	1399.97	139997.00	\N	15.00	15.00
5	5	150.00	2026-02-13 00:00:00	excellent	2026-02-13 14:47:36	2026-02-13 14:47:36	150.00	sacks	A	1400.00	210000.00	\N	22.50	15.00
\.


--
-- TOC entry 4094 (class 0 OID 350869)
-- Dependencies: 245
-- Data for Name: inventory_alerts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_alerts (id, inventory_item_id, alert_type, severity, title, message, alert_data, recommendations, is_active, is_read, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4096 (class 0 OID 350887)
-- Dependencies: 247
-- Data for Name: inventory_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_categories (id, name, code, description, icon, color, is_active, metadata, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4098 (class 0 OID 350900)
-- Dependencies: 249
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_items (id, name, category, quantity, price, unit, min_stock, created_at, updated_at, category_id, sku, brand, reorder_point, max_stock, cost_per_unit, expiry_date, shelf_life_days, storage_requirements, usage_instructions, safety_data, supplier, supplier_contact, lead_time_days, is_active, metadata, user_id, current_stock, unit_price, minimum_stock, location, notes, description) FROM stdin;
1	Thai Jasmine	seeds	\N	\N	packets	\N	2026-02-12 08:47:02	2026-02-12 08:49:38	\N	\N	\N	\N	\N	\N	2030-02-22	\N	\N	\N	\N	test	\N	7.0	t	\N	1	200.00	100.00	100.00	test	\N	\N
4	Thai Jasmine (Grade A)	produce	\N	\N	kg	\N	2026-02-13 13:58:39	2026-02-13 13:58:39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7.0	t	\N	1	85.00	1500.00	0.00	\N	Auto-created from harvest	Harvested from Block
2	IR64	seeds	\N	\N	packets	\N	2026-02-12 08:47:36	2026-02-13 14:04:34	\N	\N	\N	\N	\N	\N	2030-02-10	\N	\N	\N	\N	test	\N	7.0	t	\N	1	150.00	100.00	100.00	test	\N	\N
3	IR64 (Grade A)	produce	\N	\N	sacks	\N	2026-02-12 09:02:16	2026-02-13 14:07:31	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7.0	t	\N	1	289.00	1399.97	0.00	\N	Auto-created from harvest	Harvested from Block 1
5	Koshihikari	seeds	\N	\N	packets	\N	2026-02-13 14:11:28	2026-02-13 14:19:15	\N	\N	\N	\N	\N	\N	2026-02-20	\N	\N	\N	\N	test	\N	7.0	t	\N	1	100.00	100.00	50.00	test	\N	\N
6	Koshihikari (Grade A)	produce	\N	\N	sacks	\N	2026-02-13 14:16:47	2026-02-13 14:47:36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7.0	t	\N	1	212.50	1400.00	0.00	\N	Auto-created from harvest	Harvested from Block 2
\.


--
-- TOC entry 4100 (class 0 OID 350914)
-- Dependencies: 251
-- Data for Name: inventory_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_transactions (id, inventory_item_id, user_id, transaction_type, quantity, unit_cost, total_cost, reference_type, reference_id, notes, transaction_date, created_at, updated_at) FROM stdin;
1	1	1	in	300.00	100.00	30000.00	Initial Stock	\N	Initial stock on item creation	2026-02-12 08:47:02	2026-02-12 08:47:02	2026-02-12 08:47:02
2	2	1	in	300.00	100.00	30000.00	Initial Stock	\N	Initial stock on item creation	2026-02-12 08:47:36	2026-02-12 08:47:36	2026-02-12 08:47:36
3	1	1	out	100.00	100.00	10000.00	SeedPlanting	1	Used for nursery batch	2026-02-12 08:49:38	2026-02-12 08:49:38	2026-02-12 08:49:38
4	2	1	out	100.00	100.00	10000.00	Planting	1	Used for direct planting: 	2026-02-12 08:51:13	2026-02-12 08:51:13	2026-02-12 08:51:13
5	3	1	out	50.00	1500.00	75000.00	RiceOrder	2	Manual deduction for historic order #2	2026-02-12 09:51:45	2026-02-12 12:48:51	2026-02-12 12:48:51
6	2	1	out	50.00	100.00	5000.00	Planting	3	Used for direct planting: 	2026-02-13 14:04:34	2026-02-13 14:04:34	2026-02-13 14:04:34
7	5	1	in	200.00	100.00	20000.00	Initial Stock	\N	Initial stock on item creation	2026-02-13 14:11:28	2026-02-13 14:11:28	2026-02-13 14:11:28
8	5	1	out	50.00	100.00	5000.00	Planting	4	Used for direct planting: 	2026-02-13 14:12:30	2026-02-13 14:12:30	2026-02-13 14:12:30
9	5	1	out	50.00	100.00	5000.00	Planting	5	Used for direct planting: 	2026-02-13 14:19:15	2026-02-13 14:19:15	2026-02-13 14:19:15
\.


--
-- TOC entry 4102 (class 0 OID 350927)
-- Dependencies: 253
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 4103 (class 0 OID 350939)
-- Dependencies: 254
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 4105 (class 0 OID 350951)
-- Dependencies: 256
-- Data for Name: labor_wages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.labor_wages (id, laborer_id, task_id, hours_worked, wage_amount, date, created_at, updated_at) FROM stdin;
1	2	1	8.00	300.00	2026-02-12 09:01:10	2026-02-12 09:01:10	2026-02-12 09:01:10
2	1	2	8.00	15.00	2026-02-12 09:02:17	2026-02-12 09:02:17	2026-02-12 09:02:17
3	1	3	8.00	15.00	2026-02-13 13:58:40	2026-02-13 13:58:40	2026-02-13 13:58:40
4	1	4	8.00	15.00	2026-02-13 14:07:31	2026-02-13 14:07:31	2026-02-13 14:07:31
6	1	6	8.00	15.00	2026-02-13 14:47:37	2026-02-13 14:47:37	2026-02-13 14:47:37
\.


--
-- TOC entry 4107 (class 0 OID 350961)
-- Dependencies: 258
-- Data for Name: laborer_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.laborer_groups (id, user_id, name, description, color, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4109 (class 0 OID 350971)
-- Dependencies: 260
-- Data for Name: laborers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.laborers (id, name, rate, created_at, updated_at, user_id, phone, email, address, skill_level, specialization, status, hire_date, notes, emergency_contact_name, emergency_contact_phone, rate_type, profile_picture) FROM stdin;
1	Janos Panague	15.00	2026-02-12 08:48:34	2026-02-12 08:48:34	1	09624351441	janospanague1@gmail.com	Maramag, bukidnon	expert	Harvester	active	2026-02-12	\N	Janos Panague	09624351441	share	https://olen-paratactical-overhotly.ngrok-free.dev/storage/laborers/1dca9249-17e8-4ddb-84d9-5f594443825c.webp
2	ASDSAD	300.00	2026-02-12 08:49:13	2026-02-12 08:49:14	1	09624351441	janospanague1@gmail.com	Maramag, bukidnon	expert	Planter	active	2026-02-12	\N	Janos Panague	09624351441	daily	https://olen-paratactical-overhotly.ngrok-free.dev/storage/laborers/486bb782-2780-46a9-9eb8-08305db78627.jpg
\.


--
-- TOC entry 4111 (class 0 OID 350981)
-- Dependencies: 262
-- Data for Name: marketplace_listings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.marketplace_listings (id, farmer_id, harvest_id, rice_variety_id, title, description, quantity_available, price_per_kg, unit, quality_grade, moisture_content, harvest_details, images, status, available_from, available_until, location, delivery_options, minimum_order, terms_conditions, is_featured, views_count, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4113 (class 0 OID 351008)
-- Dependencies: 264
-- Data for Name: marketplace_orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.marketplace_orders (id, order_number, buyer_id, farmer_id, listing_id, quantity, unit_price, total_amount, status, payment_status, delivery_method, delivery_address, buyer_notes, farmer_notes, requested_delivery_date, confirmed_at, delivered_at, tracking_info, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4115 (class 0 OID 351030)
-- Dependencies: 266
-- Data for Name: marketplace_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.marketplace_reviews (id, order_id, buyer_id, farmer_id, listing_id, rating, review_text, review_categories, images, is_verified_purchase, farmer_response, farmer_responded_at, is_featured, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4117 (class 0 OID 351046)
-- Dependencies: 268
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2024_01_01_000001_create_users_table	1
2	2024_01_01_000002_create_cache_table	1
3	2024_01_01_000003_create_jobs_table	1
4	2025_08_26_084319_create_farms_table	1
5	2025_08_26_084354_create_fields_table	1
6	2025_08_26_084435_create_plantings_table	1
7	2025_08_26_084459_create_tasks_table	1
8	2025_08_26_084510_create_harvests_table	1
9	2025_08_26_084521_create_laborers_table	1
10	2025_08_26_084545_create_labor_wages_table	1
11	2025_08_26_084600_add_foreign_keys	1
12	2025_08_26_084605_create_inventory_items_table	1
13	2025_08_26_084623_create_orders_table	1
14	2025_08_26_084637_create_order_items_table	1
15	2025_08_26_084659_create_expenses_table	1
16	2025_08_26_084734_create_weather_logs_table	1
17	2025_08_26_084835_create_sales_table	1
18	2025_08_26_084850_create_buyers_table	1
19	2025_08_26_090001_create_rice_varieties_table	1
20	2025_08_26_090002_create_rice_growth_stages_table	1
21	2025_08_26_090003_create_planting_stages_table	1
22	2025_08_26_090004_add_rice_foreign_keys	1
23	2025_08_26_090005_create_weather_alerts_table	1
24	2025_08_26_090006_create_marketplace_listings_table	1
25	2025_08_26_090007_create_marketplace_orders_table	1
26	2025_08_26_090008_create_marketplace_reviews_table	1
27	2025_08_26_090009_create_task_templates_table	1
28	2025_08_26_090010_create_automated_tasks_table	1
29	2025_08_26_090011_create_inventory_categories_table	1
30	2025_08_26_090012_create_inventory_transactions_table	1
31	2025_08_26_090013_create_inventory_alerts_table	1
32	2025_08_26_090014_enhance_inventory_items_table	1
33	2025_08_26_100501_create_categories_table	1
34	2025_10_02_100934_create_personal_access_tokens_table	1
35	2025_11_02_124309_add_soil_details_to_fields_table	1
36	2025_11_02_124558_add_water_and_misc_to_fields_table	1
37	2025_11_02_134643_add_notes_to_fields_table	1
38	2025_11_02_144121_add_user_id_to_inventory_items_table	1
39	2025_11_02_144419_add_order_date_to_orders_table	1
40	2025_11_02_144433_add_user_id_to_inventory_items_table	1
41	2025_11_02_144444_add_user_id_to_laborers_table	1
42	2025_11_10_070000_create_rice_products_table	1
43	2025_11_10_070100_create_rice_orders_table	1
44	2025_11_10_070200_create_product_reviews_table	1
45	2025_11_10_070400_add_production_status_to_rice_products	1
46	2025_11_10_070500_add_pre_order_to_rice_orders	1
47	2025_11_10_090000_update_planting_status_enum	1
48	2025_11_12_000001_update_inventory_items_table	1
49	2025_11_12_000002_update_laborers_table	1
50	2025_11_12_000003_update_harvests_table	1
51	2025_11_14_063357_add_reporting_fields_to_sales_and_expenses_tables	1
52	2025_11_18_000000_create_rice_order_messages_table	1
53	2025_11_18_201909_add_description_to_inventory_items_table	1
54	2025_11_18_202125_make_legacy_columns_nullable_in_inventory_items_table	1
55	2025_11_19_000001_add_approval_status_to_users	1
56	2025_11_19_000002_add_approval_status_to_rice_products	1
57	2025_11_19_000003_create_activity_logs_table	1
58	2025_11_21_135813_add_missing_columns_to_harvests_table	1
59	2025_11_26_110930_remove_approval_columns_from_users_table	1
60	2025_11_26_111134_remove_approval_columns_from_rice_products_table	1
61	2025_12_07_091119_update_users_table_for_phone_auth	1
62	2025_12_07_091544_add_phone_verification_to_users_table	1
63	2025_12_18_125053_create_laborer_groups_table	1
64	2025_12_18_135102_add_laborer_group_id_to_tasks_table	1
65	2025_12_18_140500_split_emergency_contact_in_laborers_table	1
66	2025_12_18_143000_update_laborer_rate_structure	1
67	2025_12_18_145000_drop_contact_from_laborers	1
68	2025_12_19_124528_create_seed_plantings_table	1
69	2025_12_19_124530_add_seed_planting_id_to_plantings_table	1
70	2025_12_19_173000_remove_hourly_rate_type	1
71	2025_12_21_084825_add_batch_id_to_seed_plantings_table	1
72	2025_12_24_134142_add_seed_unit_to_plantings_table	1
73	2026_01_07_130021_create_scheduled_reports_table	1
74	2026_01_07_132451_add_order_workflow_fields_to_rice_orders_table	1
75	2026_01_07_170834_create_notifications_table	1
76	2026_01_07_171743_create_pest_incidents_table	1
77	2026_01_07_172759_create_cart_items_table	1
78	2026_01_08_062450_fix_quality_grade_column_size_in_harvests	1
79	2026_01_08_090000_add_profile_picture_to_laborers_table	1
80	2026_01_09_010000_create_favorites_table	1
81	2026_01_09_010100_add_profile_picture_to_users_table	1
82	2026_01_11_172114_add_share_columns_to_tasks_and_harvests	1
83	2026_01_12_155444_add_cultivation_details_to_fields_table	1
84	2026_01_13_000000_update_rice_orders_status_enum	1
85	2026_01_14_124927_add_wage_amount_to_tasks_table	1
86	2026_01_18_140039_add_offer_price_to_rice_orders_table	1
87	2026_01_18_143000_add_negotiating_to_rice_orders_status_check	1
88	2026_01_19_033753_add_piece_rate_columns_to_tasks_table	1
89	2026_01_19_042144_add_rainfall_to_weather_logs_table	1
90	2026_01_22_105650_add_rice_order_id_to_sales_table	1
91	2026_01_22_143243_make_fields_columns_nullable	1
92	2026_01_28_110000_add_inventory_purchase_to_expenses_category	1
93	2026_01_29_001000_add_bio_to_users_table	1
94	2026_01_29_045240_modify_task_type_in_tasks_table	1
95	2026_01_29_045428_drop_task_type_check_constraint	1
96	2026_01_30_135936_make_harvest_id_nullable_in_sales_table	1
97	2026_02_03_000000_create_price_negotiations_table	1
98	2026_02_03_224600_add_pickup_deadline_to_rice_orders_table	1
99	2026_02_04_160251_add_pickup_dates_to_rice_orders_table	1
100	2026_02_04_184525_create_pest_library_tables	1
101	2026_02_05_000000_add_checkout_group_to_rice_orders_table	1
102	2026_02_11_191241_add_farm_id_to_weather_logs_and_drop_field_id	1
105	2026_02_12_081503_add_inventory_item_id_to_rice_products_table	2
\.


--
-- TOC entry 4119 (class 0 OID 351053)
-- Dependencies: 270
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, type, title, message, data, link, read_at, created_at, updated_at) FROM stdin;
1	1	order_placed	New Order Received	You have a new order for 100.00 kg of IR64	{"order_id":1}	/farmer/orders/1	\N	2026-02-12 09:05:12	2026-02-12 09:05:12
2	2	order_status	Order Accepted	Your order #1 has been accepted by the farmer.	{"order_id":1}	/orders/1	\N	2026-02-12 09:06:04	2026-02-12 09:06:04
3	2	order_status	Order Ready for Pickup	Your order #1 is ready for pickup	{"order_id":1}	/orders/1	\N	2026-02-12 09:06:07	2026-02-12 09:06:07
4	2	order_delivered	Order Picked Up	Your order #1 has been marked as picked up	{"order_id":1}	/orders/1	\N	2026-02-12 09:06:11	2026-02-12 09:06:11
5	1	order_placed	New Order Received	You have a new order for 50.00 kg of IR64	{"order_id":2}	/farmer/orders/2	\N	2026-02-12 09:51:45	2026-02-12 09:51:45
6	2	order_status	Order Accepted	Your order #2 has been accepted by the farmer.	{"order_id":2}	/orders/2	\N	2026-02-12 09:51:59	2026-02-12 09:51:59
7	2	order_status	Order Ready for Pickup	Your order #2 is ready for pickup	{"order_id":2}	/orders/2	\N	2026-02-12 09:52:03	2026-02-12 09:52:03
8	2	order_delivered	Order Picked Up	Your order #2 has been marked as picked up	{"order_id":2}	/orders/2	\N	2026-02-12 09:52:06	2026-02-12 09:52:06
9	1	order_placed	New Price Negotiation	You have a new price negotiation for 2.00 kg of IR64. Offered: ₱1000/kg	{"order_id":3}	/farmer/orders/3	\N	2026-02-13 12:50:23	2026-02-13 12:50:23
10	1	order_placed	New Order Received	You have a new order for 1.00 kg of IR64	{"order_id":4}	/farmer/orders/4	\N	2026-02-13 12:51:00	2026-02-13 12:51:00
11	1	order_status	Order Cancelled	Order #3 for IR64 has been cancelled by the buyer.	{"order_id":3}	/farmer/orders	\N	2026-02-13 12:56:27	2026-02-13 12:56:27
12	1	order_placed	New Order Received	You have a new order for 1.00 kg of IR64	{"order_id":5}	/farmer/orders/5	\N	2026-02-13 13:09:43	2026-02-13 13:09:43
13	1	order_placed	New Order Received	You have a new order for 1.00 kg of IR64	{"order_id":6}	/farmer/orders/6	\N	2026-02-13 13:50:04	2026-02-13 13:50:04
14	2	order_status	Order Accepted	Your order #5 has been accepted by the farmer.	{"order_id":5}	/orders/5	\N	2026-02-13 13:51:22	2026-02-13 13:51:22
15	2	order_status	Order Ready for Pickup	Your order #5 is ready for pickup	{"order_id":5}	/orders/5	\N	2026-02-13 13:51:26	2026-02-13 13:51:26
16	1	order_placed	New Order Received	You have a new order for 6.00 kg of Thai Jasmine	{"order_id":7}	/farmer/orders/7	\N	2026-02-13 14:00:27	2026-02-13 14:00:27
17	2	order_status	Order Accepted	Your order #7 has been accepted by the farmer.	{"order_id":7}	/orders/7	\N	2026-02-13 14:01:38	2026-02-13 14:01:38
18	2	order_status	Order Ready for Pickup	Your order #7 is ready for pickup	{"order_id":7}	/orders/7	\N	2026-02-13 14:01:47	2026-02-13 14:01:47
19	1	order_placed	New Order Received	You have a new order for 6.00 kg of Thai Jasmine	{"order_id":8}	/farmer/orders/8	\N	2026-02-13 14:02:33	2026-02-13 14:02:33
20	1	order_status	Order Cancelled	Order #8 for Thai Jasmine has been cancelled by the buyer.	{"order_id":8}	/farmer/orders	\N	2026-02-13 14:02:47	2026-02-13 14:02:47
21	1	order_placed	New Order Received	You have a new order for 6.00 kg of Koshihikari	{"order_id":9}	/farmer/orders/9	\N	2026-02-13 14:50:39	2026-02-13 14:50:39
22	2	order_status	Order Accepted	Your order #9 has been accepted by the farmer.	{"order_id":9}	/orders/9	\N	2026-02-13 14:52:01	2026-02-13 14:52:01
23	2	order_status	Order Ready for Pickup	Your order #9 is ready for pickup	{"order_id":9}	/orders/9	\N	2026-02-13 14:52:05	2026-02-13 14:52:05
24	2	order_delivered	Order Picked Up	Your order #9 has been marked as picked up	{"order_id":9}	/orders/9	\N	2026-02-13 14:52:30	2026-02-13 14:52:30
25	1	order_placed	New Order Received	You have a new order for 4.00 kg of Koshihikari	{"order_id":10}	/farmer/orders/10	\N	2026-02-13 14:52:58	2026-02-13 14:52:58
26	1	order_status	Order Cancelled	Order #10 for Koshihikari has been cancelled by the buyer.	{"order_id":10}	/farmer/orders	\N	2026-02-13 14:53:10	2026-02-13 14:53:10
27	1	order_placed	New Order Received	You have a new order for 6.00 kg of Koshihikari	{"order_id":11}	/farmer/orders/11	\N	2026-02-13 14:53:51	2026-02-13 14:53:51
28	2	order_status	Order Accepted	Your order #11 has been accepted by the farmer.	{"order_id":11}	/orders/11	\N	2026-02-13 14:54:07	2026-02-13 14:54:07
\.


--
-- TOC entry 4121 (class 0 OID 351064)
-- Dependencies: 272
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (id, order_id, inventory_item_id, quantity, unit_price, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4123 (class 0 OID 351073)
-- Dependencies: 274
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, buyer_id, status, total_amount, created_at, updated_at, order_date) FROM stdin;
\.


--
-- TOC entry 4125 (class 0 OID 351083)
-- Dependencies: 276
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
9	App\\Models\\User	2	auth-token	2cf9eee314eae88942070baf93228d4e59d590491b999983a881f82898ed38bb	["*"]	2026-02-13 15:13:54	\N	2026-02-13 12:46:25	2026-02-13 15:13:54
8	App\\Models\\User	1	auth-token	1fbd542ea8fc4712a753dcd5991eb8f4397c4de2fa4d6baccde31a58b640cb5f	["*"]	2026-02-13 15:15:19	\N	2026-02-13 12:45:57	2026-02-13 15:15:19
7	App\\Models\\User	1	auth-token	6647f3e64d8545455e5cb592b3fd80b9a003e52cfd7edfc0d6af959991ccebb0	["*"]	2026-02-12 20:06:36	\N	2026-02-12 18:22:44	2026-02-12 20:06:36
5	App\\Models\\User	1	auth-token	bc07c741d85d9749164f1911f1d3ab6dd129a8ad4b500dfa9e3184f9ff5ec9f8	["*"]	2026-02-12 12:57:27	\N	2026-02-12 09:51:50	2026-02-12 12:57:27
6	App\\Models\\User	1	auth-token	0e6226d51691636bb022f73012fa953fec3c260c3d0b5f29a2314ea7038b3e0a	["*"]	2026-02-13 14:06:52	\N	2026-02-12 18:09:23	2026-02-13 14:06:52
\.


--
-- TOC entry 4127 (class 0 OID 351094)
-- Dependencies: 278
-- Data for Name: pest_analytics_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pest_analytics_rules (id, pest_library_id, metric, condition, value_min, value_max, duration_hours, risk_level, risk_message, created_at, updated_at) FROM stdin;
1	1	humidity	>	90.00	\N	\N	high	High humidity (>90%) strongly favors Rice Blast spore germination.	2026-02-12 08:44:24	2026-02-12 08:44:24
2	1	temperature	between	25.00	28.00	\N	high	Temperatures between 25-28°C are optimal for Rice Blast development.	2026-02-12 08:44:24	2026-02-12 08:44:24
3	1	rainfall	>	80.00	\N	\N	moderate	Frequent rainfall can spread blast spores.	2026-02-12 08:44:24	2026-02-12 08:44:24
4	2	temperature	between	28.00	30.00	\N	high	Temperatures of 28-30°C accelerate BPH reproduction.	2026-02-12 08:44:24	2026-02-12 08:44:24
5	2	humidity	>	80.00	\N	\N	high	High humidity (>80%) at plant base supports BPH survival.	2026-02-12 08:44:24	2026-02-12 08:44:24
6	3	temperature	between	28.00	32.00	\N	high	Warm temperatures (28-32°C) favor Stem Borer moth activity.	2026-02-12 08:44:24	2026-02-12 08:44:24
7	3	humidity	>	90.00	\N	\N	moderate	High humidity increases egg hatching rates for stem borers.	2026-02-12 08:44:24	2026-02-12 08:44:24
8	4	temperature	between	32.00	34.00	\N	high	Hot temperatures (32-34°C) trigger peak GLH population.	2026-02-12 08:44:24	2026-02-12 08:44:24
9	4	humidity	>	90.00	\N	\N	high	Morning humidity >90% favors GLH activity.	2026-02-12 08:44:24	2026-02-12 08:44:24
10	5	temperature	between	24.00	32.00	\N	high	Temperatures of 24-32°C facilitate rapid Tungro Virus transmission.	2026-02-12 08:44:24	2026-02-12 08:44:24
11	5	humidity	>	85.00	\N	\N	moderate	Humid conditions support the vector (GLH) lifespan.	2026-02-12 08:44:24	2026-02-12 08:44:24
12	6	lunar_phase	equals	\N	\N	\N	high	Full Moon phase triggers massive Rice Black Bug flight activity.	2026-02-12 08:44:24	2026-02-12 08:44:24
13	6	humidity	>	85.00	\N	\N	moderate	High humidity increases RBB survival.	2026-02-12 08:44:24	2026-02-12 08:44:24
\.


--
-- TOC entry 4129 (class 0 OID 351106)
-- Dependencies: 280
-- Data for Name: pest_incidents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pest_incidents (id, planting_id, user_id, pest_type, pest_name, severity, affected_area, detected_date, symptoms, treatment_applied, treatment_date, treatment_cost, status, notes, images, created_at, updated_at) FROM stdin;
1	2	1	disease	talomtom	medium	3.00	2026-02-12	\N	was	2026-02-12	\N	resolved	\N	\N	2026-02-12 08:55:17	2026-02-12 08:55:30
2	1	1	insect	,kmjny	medium	\N	2026-02-13	wadsd	sadasd	2026-02-13	\N	resolved	\N	\N	2026-02-13 14:17:27	2026-02-13 14:17:32
3	1	1	insect	sadsa	medium	\N	2026-02-13	asd	asd	2026-02-13	\N	resolved	\N	\N	2026-02-13 14:45:02	2026-02-13 14:45:06
4	1	1	insect	asd	medium	\N	2026-02-13	asd	asd	2026-02-13	\N	resolved	\N	\N	2026-02-13 14:48:00	2026-02-13 14:48:05
\.


--
-- TOC entry 4131 (class 0 OID 351121)
-- Dependencies: 282
-- Data for Name: pest_libraries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pest_libraries (id, name, slug, type, scientific_name, description, symptoms, treatment_guidance, images, created_at, updated_at) FROM stdin;
1	Rice Blast	rice-blast	disease	\N	A fungal disease affecting all parts of the rice plant, causing spindle-shaped lesions.	Diamond/spindle-shaped lesions with gray centers on leaves; neck rot causing panicles to fall over.	Use fungicides (e.g., Tricyclazole, Isoprothiolane). Avoid excessive nitrogen fertilizer. Keep field flooded.	["https:\\/\\/www.irri.org\\/sites\\/default\\/files\\/styles\\/science_standard\\/public\\/Rice%20blast%20symptoms%20on%20leaves.jpg"]	2026-02-12 08:44:24	2026-02-12 08:44:24
2	Brown Plant Hopper	brown-plant-hopper	insect	Nilaparvata lugens	Sucking pests that remove plant sap, causing "hopper burn" where plants turn brown and die.	Yellowing and browning of leaves (Hopper burn), sooty mold at base of stems.	Drain field for 3-4 days. Use resistant varieties. Avoid indiscriminant insecticide use which kills natural enemies.	["https:\\/\\/live.staticflickr.com\\/65535\\/51234567890_abcdef1234_b.jpg"]	2026-02-12 08:44:24	2026-02-12 08:44:24
3	Yellow Stem Borer	yellow-stem-borer	insect	Scirpophaga incertulas	Larvae bore into stems, causing "Deadheart" in vegetative stage and "Whitehead" in reproductive stage.	Deadhearts (drying central shoot) and Whiteheads (empty, white panicles).	Install pheromone traps. Biological control (Trichogramma). Early planting.	["https:\\/\\/upload.wikimedia.org\\/wikipedia\\/commons\\/thumb\\/c\\/c5\\/Stem_borer_adult.jpg\\/640px-Stem_borer_adult.jpg"]	2026-02-12 08:44:24	2026-02-12 08:44:24
4	Green Leafhopper	green-leafhopper	insect	Nephotettix virescens	Major vector for Rice Tungro Virus. Feeds on sap.	Stunted growth, yellowing leaves. Main damage is virus transmission.	Use resistant varieties. Manage weeds. Light traps.	["https:\\/\\/knowledgebank.irri.org\\/images\\/stories\\/pests-and-diseases\\/insects\\/glh\\/GLH_adult.jpg"]	2026-02-12 08:44:24	2026-02-12 08:44:24
5	Rice Tungro Virus	rice-tungro-virus	disease	\N	Most destructive virus disease of rice in SE Asia. Transmitted by Green Leafhopper.	Stunted plants, yellow to orange-red discoloration of leaves, twisting of leaves.	Control the vector (GLH). Rogue infected plants immediately. Synchronous planting.	["https:\\/\\/knowledgebank.irri.org\\/images\\/stories\\/pests-and-diseases\\/diseases\\/tungro\\/tungro1.jpg"]	2026-02-12 08:44:24	2026-02-12 08:44:24
6	Rice Black Bug	rice-black-bug	insect	Scotinophara coarctata	Sapsucking bugs that attack base of stems. Cause "bugburn". Strongly attracted to light during full moon.	Reddish-brown leaves, dead plants, empty grains.	Light traps during full moon. Raise water level to submerge eggs. Biological controls (Metarhizium).	["https:\\/\\/encrypted-tbn0.gstatic.com\\/images?q=tbn:ANd9GcR_x_example_check_url"]	2026-02-12 08:44:24	2026-02-12 08:44:24
\.


--
-- TOC entry 4133 (class 0 OID 351131)
-- Dependencies: 284
-- Data for Name: planting_stages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.planting_stages (id, planting_id, rice_growth_stage_id, started_at, completed_at, status, notes, stage_data, completion_percentage, created_at, updated_at) FROM stdin;
9	2	4	\N	\N	pending	\N	\N	0.00	2026-02-12 08:52:07	2026-02-12 08:52:07
10	2	5	\N	\N	pending	\N	\N	0.00	2026-02-12 08:52:07	2026-02-12 08:52:07
6	2	1	\N	2026-02-12 08:52:07	completed	Completed in nursery (Transplanting)	\N	100.00	2026-02-12 08:52:07	2026-02-12 08:52:07
1	1	1	2026-02-12 08:51:13	2026-02-12 08:52:17	completed	\N	\N	100.00	2026-02-12 08:51:13	2026-02-12 08:52:17
2	1	2	2026-02-12 08:52:17	2026-02-12 08:52:19	completed	\N	\N	100.00	2026-02-12 08:51:13	2026-02-12 08:52:19
3	1	3	2026-02-12 08:52:19	2026-02-12 08:52:20	completed	\N	\N	100.00	2026-02-12 08:51:13	2026-02-12 08:52:20
4	1	4	2026-02-12 08:52:20	2026-02-12 08:52:21	completed	\N	\N	100.00	2026-02-12 08:51:13	2026-02-12 08:52:21
5	1	5	2026-02-12 08:52:21	2026-02-12 08:52:23	completed	\N	\N	100.00	2026-02-12 08:51:13	2026-02-12 08:52:23
7	2	2	2026-02-12 08:52:07	2026-02-12 08:52:48	completed	\N	\N	100.00	2026-02-12 08:52:07	2026-02-12 08:52:48
8	2	3	2026-02-12 08:52:48	\N	in_progress	\N	\N	0.00	2026-02-12 08:52:07	2026-02-12 08:52:48
12	3	2	\N	\N	pending	\N	\N	0.00	2026-02-13 14:04:34	2026-02-13 14:04:34
13	3	3	\N	\N	pending	\N	\N	0.00	2026-02-13 14:04:34	2026-02-13 14:04:34
14	3	4	\N	\N	pending	\N	\N	0.00	2026-02-13 14:04:34	2026-02-13 14:04:34
15	3	5	\N	\N	pending	\N	\N	0.00	2026-02-13 14:04:34	2026-02-13 14:04:34
11	3	1	2026-02-13 14:04:34	\N	in_progress	\N	\N	0.00	2026-02-13 14:04:34	2026-02-13 14:04:34
22	5	2	\N	\N	pending	\N	\N	0.00	2026-02-13 14:19:15	2026-02-13 14:19:15
23	5	3	\N	\N	pending	\N	\N	0.00	2026-02-13 14:19:15	2026-02-13 14:19:15
24	5	4	\N	\N	pending	\N	\N	0.00	2026-02-13 14:19:15	2026-02-13 14:19:15
25	5	5	\N	\N	pending	\N	\N	0.00	2026-02-13 14:19:15	2026-02-13 14:19:15
21	5	1	2026-02-13 14:19:15	\N	in_progress	\N	\N	0.00	2026-02-13 14:19:15	2026-02-13 14:19:15
\.


--
-- TOC entry 4135 (class 0 OID 351145)
-- Dependencies: 286
-- Data for Name: plantings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.plantings (id, field_id, rice_variety_id, crop_type, planting_date, expected_harvest_date, actual_harvest_date, status, planting_method, seed_rate, area_planted, season, notes, created_at, updated_at, seed_planting_id, seed_unit) FROM stdin;
1	1	1	IR64	2025-02-22 00:00:00	2026-02-12 00:00:00	2026-02-12 00:00:00	harvested	direct_seeding	100.00	10.00	dry	\N	2026-02-12 08:51:13	2026-02-12 09:02:16	\N	packets
2	2	2	Thai Jasmine	2025-02-11 00:00:00	2026-02-12 00:00:00	2026-02-13 00:00:00	harvested	transplanting	100.00	10.00	dry	\N	2026-02-12 08:52:07	2026-02-13 13:58:39	1	packets
3	2	1	Rice	2025-11-11 00:00:00	2026-02-13 00:00:00	2026-02-13 00:00:00	harvested	direct_seeding	50.00	5.00	wet	\N	2026-02-13 14:04:34	2026-02-13 14:07:31	\N	packets
5	2	8	Koshihikari	2025-02-12 00:00:00	2026-02-13 00:00:00	2026-02-13 00:00:00	harvested	direct_seeding	50.00	5.00	dry	\N	2026-02-13 14:19:15	2026-02-13 14:47:36	\N	packets
\.


--
-- TOC entry 4137 (class 0 OID 351167)
-- Dependencies: 288
-- Data for Name: price_negotiations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_negotiations (id, rice_order_id, proposer_id, proposed_price, status, response_message, responded_at, created_at, updated_at) FROM stdin;
1	4	2	1200.00	accepted	\N	2026-02-13 13:06:15	2026-02-13 12:52:07	2026-02-13 13:06:15
2	5	2	1200.00	accepted	\N	2026-02-13 13:51:00	2026-02-13 13:10:07	2026-02-13 13:51:00
3	7	2	1000.00	superseded	\N	2026-02-13 14:01:10	2026-02-13 14:00:41	2026-02-13 14:01:10
4	7	1	1400.00	accepted	\N	2026-02-13 14:01:24	2026-02-13 14:01:10	2026-02-13 14:01:24
5	9	2	1000.00	superseded	\N	2026-02-13 14:51:29	2026-02-13 14:50:54	2026-02-13 14:51:29
6	9	1	1300.00	accepted	\N	2026-02-13 14:51:44	2026-02-13 14:51:29	2026-02-13 14:51:44
\.


--
-- TOC entry 4139 (class 0 OID 351180)
-- Dependencies: 290
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_reviews (id, rice_product_id, buyer_id, rice_order_id, rating, title, review_text, quality_rating, delivery_rating, farmer_rating, would_recommend, verified_purchase, images, helpful_votes, is_approved, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4141 (class 0 OID 351198)
-- Dependencies: 292
-- Data for Name: rice_growth_stages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rice_growth_stages (id, name, stage_code, description, typical_duration_days, order_sequence, key_activities, weather_requirements, nutrient_requirements, water_requirements, common_problems, is_active, created_at, updated_at) FROM stdin;
1	Germination & Seedling	stage_1_seedling	From soaking seeds to transplanting.	20	1	["watering"]	["warm"]	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:24
2	Tillering	stage_2_tillering	Development of tillers.	30	2	["watering"]	["warm"]	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:24
3	Panicle Initiation	stage_3_panicle	Start of reproductive phase.	15	3	["watering"]	["warm"]	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:24
4	Flowering	stage_4_flowering	Pollination and grain formation.	15	4	["watering"]	["warm"]	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:24
5	Ripening	stage_5_ripening	Grain filling and maturation.	30	5	["watering"]	["warm"]	\N	\N	\N	t	2026-02-12 08:44:24	2026-02-12 08:44:24
\.


--
-- TOC entry 4143 (class 0 OID 351211)
-- Dependencies: 294
-- Data for Name: rice_order_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rice_order_messages (id, rice_order_id, sender_id, message, attachments, read_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4145 (class 0 OID 351221)
-- Dependencies: 296
-- Data for Name: rice_orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rice_orders (id, buyer_id, rice_product_id, quantity, unit_price, total_amount, status, delivery_address, delivery_method, payment_method, payment_status, notes, order_date, expected_delivery_date, actual_delivery_date, tracking_number, farmer_notes, buyer_notes, created_at, updated_at, is_pre_order, available_date, notification_sent_available, notification_sent_day_before, shipped_at, auto_confirm_at, dispute_reason, offer_price, pickup_deadline, preferred_pickup_date, confirmed_pickup_date, checkout_group_id) FROM stdin;
1	2	1	100.00	1500.00	150000.00	picked_up	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	paid	\N	2026-02-12 09:05:12	\N	2026-02-12	\N	\N	\N	2026-02-12 09:05:12	2026-02-12 09:06:14	f	\N	f	f	\N	\N	\N	\N	2026-02-15 09:06:07	\N	\N	46f4a367-dc80-481c-b950-81091fa3c364
2	2	1	50.00	1500.00	75000.00	picked_up	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	paid	\N	2026-02-12 09:51:45	\N	2026-02-12	\N	\N	\N	2026-02-12 09:51:45	2026-02-12 09:52:09	f	\N	f	f	\N	\N	\N	\N	2026-02-15 09:52:03	\N	\N	e54c21f6-106d-4db6-9282-d01069d5b1ba
3	2	1	2.00	1000.00	2000.00	cancelled	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 12:50:23	\N	\N	\N	0258kmjnhbg	\N	2026-02-13 12:50:23	2026-02-13 12:56:26	f	\N	f	f	\N	\N	\N	1000.00	\N	\N	\N	182fe2b6-e5aa-477c-adb6-a981697cb39e
4	2	1	1.00	1200.00	1200.00	pending	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 12:51:00	\N	\N	\N	\N	\N	2026-02-13 12:51:00	2026-02-13 13:06:15	f	\N	f	f	\N	\N	\N	\N	\N	\N	\N	658bf4d3-da04-4861-bacc-bce1c4e74c62
6	2	1	1.00	1500.00	1500.00	pending	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 13:50:04	\N	\N	\N	\N	\N	2026-02-13 13:50:04	2026-02-13 13:50:04	f	\N	f	f	\N	\N	\N	\N	\N	\N	\N	7632110a-1335-4954-98ee-472bbc7cc3ee
5	2	1	1.00	1200.00	1200.00	ready_for_pickup	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 13:09:43	\N	\N	\N	\N	\N	2026-02-13 13:09:43	2026-02-13 13:51:26	f	\N	f	f	\N	2026-03-15 13:51:26	\N	\N	2026-02-16 13:51:26	\N	\N	d70fa74c-2858-4b2c-b036-0ccae009e61b
7	2	2	6.00	1400.00	8400.00	ready_for_pickup	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 14:00:27	\N	\N	\N	\N	\N	2026-02-13 14:00:27	2026-02-13 14:01:47	f	\N	f	f	\N	2026-03-15 14:01:47	\N	\N	2026-02-16 14:01:47	\N	\N	cd67b0d7-ff83-45bb-a764-ef2dffa7551f
8	2	2	6.00	1500.00	9000.00	cancelled	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 14:02:33	\N	\N	\N	asdsadsa	\N	2026-02-13 14:02:33	2026-02-13 14:02:47	f	\N	f	f	\N	\N	\N	\N	\N	\N	\N	c21852ca-08e0-4e10-b7a8-b0aa91a04233
9	2	3	6.00	1300.00	7800.00	picked_up	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 14:50:39	\N	2026-02-13	\N	\N	\N	2026-02-13 14:50:39	2026-02-13 14:52:30	f	\N	f	f	\N	\N	\N	\N	2026-02-16 14:52:05	\N	\N	2ea74612-de2b-4c34-b08d-33a3cf9084e8
10	2	3	4.00	1400.00	5600.00	cancelled	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 14:52:58	\N	\N	\N	asdasd	\N	2026-02-13 14:52:58	2026-02-13 14:53:10	f	\N	f	f	\N	\N	\N	\N	\N	\N	\N	f7a16612-e526-4829-b10f-10ca9ed08570
11	2	3	6.00	1400.00	8400.00	confirmed	{"street":"Pickup from farmer","city":null,"state":null,"postal_code":null,"country":"Philippines"}	pickup	cod	pending	\N	2026-02-13 14:53:51	\N	\N	\N	\N	\N	2026-02-13 14:53:51	2026-02-13 14:54:07	f	\N	f	f	\N	\N	\N	\N	\N	\N	\N	48c4dbbf-f509-43bd-8ebf-5df6d7948436
\.


--
-- TOC entry 4147 (class 0 OID 351251)
-- Dependencies: 298
-- Data for Name: rice_products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rice_products (id, farmer_id, rice_variety_id, harvest_id, name, description, quantity_available, unit, price_per_unit, quality_grade, moisture_content, purity_percentage, harvest_date, processing_method, storage_conditions, certification, images, location, is_organic, is_available, minimum_order_quantity, packaging_options, delivery_options, payment_terms, contact_info, notes, created_at, updated_at, production_status, available_from, inventory_item_id) FROM stdin;
1	1	1	1	IR64	wow	102.00	sacks	1500.00	premium	\N	\N	\N	\N	\N	\N	["\\/storage\\/products\\/8f582eff-8b95-4e77-b6db-607a287eebdb.webp"]	\N	f	t	\N	\N	\N	\N	\N	\N	2026-02-12 09:03:48	2026-02-13 13:50:04	available	\N	3
2	1	2	2	Thai Jasmine	Bugas	79.00	kg	1500.00	premium	\N	\N	\N	\N	\N	\N	["\\/storage\\/products\\/14f68bb5-eac0-4bc0-998a-1884ed1cf12b.png"]	\N	f	t	\N	\N	\N	\N	\N	\N	2026-02-13 13:59:18	2026-02-13 14:02:47	available	\N	4
3	1	8	5	Koshihikari	rice	115.50	sacks	1400.00	premium	\N	\N	\N	\N	\N	\N	["\\/storage\\/products\\/124bd556-8719-42fe-b16d-3b1592619fce.jpg"]	\N	f	t	\N	\N	\N	\N	\N	\N	2026-02-13 14:48:46	2026-02-13 14:53:51	available	\N	6
\.


--
-- TOC entry 4149 (class 0 OID 351277)
-- Dependencies: 300
-- Data for Name: rice_varieties; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rice_varieties (id, name, variety_code, description, maturity_days, average_yield_per_hectare, season, grain_type, resistance_level, characteristics, is_active, created_at, updated_at) FROM stdin;
1	IR64	RICE-IR64	High-yielding, semi-dwarf Indica variety widely planted in SE Asia.	120	5.60	wet	long	medium	{"notes":"Performs best in irrigated lowland fields with good fertility."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
2	Thai Jasmine	RICE-JASMINE	Premium fragrant rice valued for aroma and soft texture.	110	4.90	dry	long	medium	{"notes":"Requires consistent irrigation and well-drained fields."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
3	Basmati 370	RICE-BASMATI	Traditional aromatic Basmati with elongated grains.	135	4.30	dry	long	medium	{"notes":"Prefers cool nights; suited for river-fed plains."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
4	Glutinous Sticky Rice	RICE-STICKY	Round-grain sticky rice used for traditional delicacies.	105	4.60	wet	short	high	{"notes":"Can tolerate temporary flooding; harvest promptly to retain stickiness."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
5	Wholegrain Brown Rice	RICE-BROWN	Nutritious variety harvested and milled for brown rice.	125	5.10	wet	medium	medium	{"notes":"Responds well to organic fertilisation; ideal for health-conscious markets."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
6	Swarna	RICE-SWARNA	High-yielding variety with strong disease resistance.	130	6.30	wet	medium	high	{"notes":"Handles flood-prone paddies; staple in South Asian production."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
7	Heirloom Red Cargo	RICE-RED	Deep-red wholegrain rice prized for antioxidants.	140	3.90	dry	medium	medium	{"notes":"Requires careful drying; fetches premium prices in niche markets."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
8	Koshihikari	RICE-KOSHI	Short-grain Japanese rice with excellent eating quality.	118	5.30	dry	short	high	{"notes":"Best grown in cooler climates; top choice for sushi-grade rice."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
9	NSIC Rc 222 (Tubigan 18)	RICE-NSIC-RC222	High-yielding variety capable of surviving flash floods, also known as Tubigan 18.	114	6.10	wet	long	high	{"notes":"Resistant to stem borer and green leafhopper. Moderate resistance to brown planthopper."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
10	NSIC Rc 216 (Tubigan 17)	RICE-NSIC-RC216	Popular inbred variety known for good eating quality and high yield potential.	112	6.00	dry	long	medium	{"notes":"Moderately resistant to brown planthopper and green leafhopper."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
11	NSIC Rc 160 (Tubigan 14)	RICE-NSIC-RC160	Known for its premium eating quality, soft and moist when cooked.	122	5.60	wet	long	medium	{"notes":"Highly favored by millers and traders due to high head rice recovery."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
12	Dinorado	RICE-DINORADO	Indigenous upland rice variety from Mindanao, known for its pinkish grain and aroma.	130	3.50	dry	medium	low	{"notes":"Aromatic and sticky when cooked. Often grown in upland areas."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
13	Sinandomeng	RICE-SINANDOMENG	Traditional variety popular for domestic consumption, soft and white.	115	4.50	wet	long	medium	{"notes":"Good eating quality, remains soft even when cold."}	t	2026-02-12 08:44:24	2026-02-12 08:44:24
\.


--
-- TOC entry 4151 (class 0 OID 351296)
-- Dependencies: 302
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sales (id, harvest_id, buyer_id, quantity, total_amount, sale_date, created_at, updated_at, user_id, unit_price, payment_method, payment_status, delivery_date, delivery_address, notes, rice_order_id) FROM stdin;
1	1	1	100.00	150000.00	2026-02-12 09:06:11	2026-02-12 09:06:11	2026-02-12 09:06:11	1	1500.00	cash	pending	\N	\N	Marketplace order #1	1
2	1	1	50.00	75000.00	2026-02-12 09:52:06	2026-02-12 09:52:06	2026-02-12 09:52:06	1	1500.00	cash	pending	\N	\N	Marketplace order #2	2
3	5	1	6.00	7800.00	2026-02-13 14:52:30	2026-02-13 14:52:30	2026-02-13 14:52:30	1	1300.00	cash	pending	\N	\N	Marketplace order #9	9
\.


--
-- TOC entry 4153 (class 0 OID 351316)
-- Dependencies: 304
-- Data for Name: scheduled_reports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scheduled_reports (id, user_id, farm_id, report_type, frequency, email, parameters, is_active, last_sent_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4155 (class 0 OID 351329)
-- Dependencies: 306
-- Data for Name: seed_plantings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seed_plantings (id, user_id, rice_variety_id, planting_date, expected_transplant_date, quantity, unit, status, notes, created_at, updated_at, batch_id) FROM stdin;
1	1	2	2026-01-12	2026-03-02	100.00	packets	transplanted	\N	2026-02-12 08:49:38	2026-02-12 08:52:07	\N
\.


--
-- TOC entry 4157 (class 0 OID 351345)
-- Dependencies: 308
-- Data for Name: task_templates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_templates (id, rice_growth_stage_id, name, description, task_type, days_from_stage_start, estimated_duration_hours, priority, weather_conditions, required_materials, instructions, safety_notes, is_mandatory, is_weather_dependent, is_active, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4159 (class 0 OID 351370)
-- Dependencies: 310
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tasks (id, planting_id, task_type, due_date, description, status, assigned_to, created_at, updated_at, laborer_group_id, payment_type, revenue_share_percentage, wage_amount, unit, quantity, unit_price) FROM stdin;
1	2	transplanting	2026-02-12 00:00:00	Transplant	completed	2	2026-02-12 09:01:07	2026-02-12 09:01:10	\N	wage	\N	300.00	\N	\N	\N
2	1	harvesting	2026-02-12 00:00:00	Harvest	completed	1	2026-02-12 09:01:43	2026-02-12 09:02:17	\N	share	15.00	\N	\N	\N	\N
3	2	harvesting	2026-02-13 00:00:00	Harvesting	completed	1	2026-02-13 13:58:08	2026-02-13 13:58:40	\N	share	15.00	\N	\N	\N	\N
4	3	harvesting	2026-02-13 00:00:00	Harvesting	completed	1	2026-02-13 14:06:47	2026-02-13 14:07:31	\N	share	15.00	\N	\N	\N	\N
6	5	harvesting	2026-02-13 00:00:00	Harvesting	completed	1	2026-02-13 14:47:13	2026-02-13 14:47:37	\N	share	15.00	\N	\N	\N	\N
\.


--
-- TOC entry 4161 (class 0 OID 351385)
-- Dependencies: 312
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, email_verified_at, password, role, phone, address, remember_token, created_at, updated_at, first_name, middle_initial, last_name, phone_verified_at, verification_code, profile_picture, bio) FROM stdin;
1	John Farmer	john@farmops.com	\N	$2y$12$LyJ5h11RHWVCaW8Tmcf04OI3Hcj9E20EW4t7WuPb9D4tO84j.KjMe	farmer	+1-555-0101	{"farm_location":"Managok, City of Malaybalay, Bukidnon","total_area":50,"rice_area":50,"farming_experience":30}	\N	2026-02-12 08:44:24	2026-02-12 08:44:55	John	\N	Farmer	2026-02-12 08:44:24	\N	\N	\N
2	Janos Panague	janospanague1@gmail.com	2026-02-12 09:04:41	$2y$12$fhQZUpvqBzCOPSLH0qECM.AAZqY63yCvFT40vcpkGI31p3X4Qv/OK	buyer	09624351441	\N	\N	2026-02-12 09:04:31	2026-02-12 09:04:41	Janos	A	Panague	\N	\N	\N	\N
\.


--
-- TOC entry 4163 (class 0 OID 351397)
-- Dependencies: 314
-- Data for Name: weather_alerts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.weather_alerts (id, field_id, planting_id, alert_type, severity, title, description, weather_data, recommendations, alert_date, expires_at, is_active, is_read, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4165 (class 0 OID 351416)
-- Dependencies: 316
-- Data for Name: weather_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.weather_logs (id, temperature, humidity, wind_speed, conditions, recorded_at, created_at, updated_at, rainfall, farm_id) FROM stdin;
1	22.0	95.0	2.2	cloudy	2023-01-01 00:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.00	1
2	20.0	94.0	2.5	cloudy	2023-01-01 06:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.00	1
3	26.5	71.0	7.6	rainy	2023-01-01 12:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.50	1
4	23.8	93.0	3.7	rainy	2023-01-01 18:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.20	1
5	23.5	87.0	2.6	cloudy	2023-01-02 00:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.00	1
6	21.4	90.0	2.9	rainy	2023-01-02 06:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.10	1
7	25.5	81.0	4.7	rainy	2023-01-02 12:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	1.10	1
8	23.2	92.0	3.7	rainy	2023-01-02 18:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	1.40	1
9	22.5	95.0	2.3	rainy	2023-01-03 00:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	2.00	1
10	21.5	95.0	3.9	rainy	2023-01-03 06:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	1.30	1
11	27.3	73.0	9.7	rainy	2023-01-03 12:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.20	1
12	23.0	92.0	1.8	rainy	2023-01-03 18:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	2.20	1
13	23.1	90.0	1.3	rainy	2023-01-04 00:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.50	1
14	22.0	92.0	3.5	rainy	2023-01-04 06:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	0.20	1
15	26.5	80.0	8.7	rainy	2023-01-04 12:00:00	2026-02-12 08:44:28	2026-02-12 08:44:28	1.80	1
16	24.1	92.0	2.3	rainy	2023-01-04 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
17	22.5	93.0	2.9	rainy	2023-01-05 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
18	20.5	92.0	2.3	cloudy	2023-01-05 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
19	28.2	71.0	9.5	rainy	2023-01-05 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
20	23.2	93.0	3.4	rainy	2023-01-05 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
21	22.0	96.0	2.2	cloudy	2023-01-06 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
22	21.0	91.0	3.7	cloudy	2023-01-06 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
23	29.0	56.0	11.2	cloudy	2023-01-06 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
24	24.9	78.0	11.2	cloudy	2023-01-06 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
25	23.3	93.0	3.7	rainy	2023-01-07 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.60	1
26	22.5	92.0	2.2	rainy	2023-01-07 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.70	1
27	25.0	82.0	9.0	rainy	2023-01-07 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
28	22.2	89.0	6.1	cloudy	2023-01-07 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
29	21.4	89.0	4.7	cloudy	2023-01-08 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
30	20.8	91.0	2.2	rainy	2023-01-08 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
31	23.5	89.0	3.4	rainy	2023-01-08 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.10	1
32	23.4	89.0	4.9	cloudy	2023-01-08 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
33	22.1	87.0	4.4	rainy	2023-01-09 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
34	21.8	90.0	4.6	cloudy	2023-01-09 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
35	27.5	74.0	6.5	rainy	2023-01-09 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
36	23.5	92.0	4.0	rainy	2023-01-09 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
37	22.2	97.0	2.3	rainy	2023-01-10 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
38	21.5	97.0	3.1	rainy	2023-01-10 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.30	1
39	27.0	79.0	0.5	rainy	2023-01-10 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
40	22.6	95.0	7.4	rainy	2023-01-10 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
41	21.6	98.0	3.7	rainy	2023-01-11 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
42	21.1	98.0	1.9	cloudy	2023-01-11 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
43	25.6	82.0	9.9	cloudy	2023-01-11 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
44	22.8	94.0	2.8	rainy	2023-01-11 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
45	22.3	94.0	3.6	rainy	2023-01-12 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.60	1
46	22.1	94.0	3.1	cloudy	2023-01-12 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
47	27.2	73.0	7.8	cloudy	2023-01-12 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
48	24.2	84.0	4.5	cloudy	2023-01-12 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
49	23.2	94.0	0.7	rainy	2023-01-13 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
50	21.9	97.0	3.4	rainy	2023-01-13 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
51	27.0	80.0	3.5	rainy	2023-01-13 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
52	24.1	90.0	1.6	rainy	2023-01-13 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.90	1
53	22.5	96.0	5.4	rainy	2023-01-14 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.70	1
54	21.7	97.0	2.9	rainy	2023-01-14 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
55	25.9	83.0	2.1	rainy	2023-01-14 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.90	1
56	22.9	93.0	3.6	rainy	2023-01-14 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.90	1
57	22.5	98.0	2.3	rainy	2023-01-15 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.50	1
58	21.6	100.0	2.2	cloudy	2023-01-15 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
59	27.5	76.0	4.3	cloudy	2023-01-15 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
60	23.4	94.0	2.6	rainy	2023-01-15 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
61	22.0	95.0	3.6	cloudy	2023-01-16 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
62	21.9	96.0	1.6	cloudy	2023-01-16 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
63	27.5	78.0	2.8	cloudy	2023-01-16 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
64	22.8	95.0	3.1	cloudy	2023-01-16 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
65	22.9	90.0	3.8	cloudy	2023-01-17 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
66	20.8	95.0	3.3	cloudy	2023-01-17 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
67	27.8	71.0	3.7	rainy	2023-01-17 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
68	24.0	92.0	1.8	rainy	2023-01-17 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
69	21.5	96.0	2.9	cloudy	2023-01-18 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
70	20.0	98.0	3.2	cloudy	2023-01-18 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
71	28.2	71.0	10.4	rainy	2023-01-18 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
72	24.4	82.0	0.8	cloudy	2023-01-18 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
73	21.8	93.0	3.9	cloudy	2023-01-19 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
74	20.2	93.0	4.0	cloudy	2023-01-19 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
75	29.2	61.0	12.6	rainy	2023-01-19 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
76	23.5	84.0	6.0	rainy	2023-01-19 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.90	1
154	18.7	90.0	4.0	cloudy	2023-02-08 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
77	22.8	93.0	3.6	cloudy	2023-01-20 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
78	21.0	93.0	4.8	rainy	2023-01-20 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
79	26.9	76.0	11.8	rainy	2023-01-20 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
80	24.5	75.0	11.9	cloudy	2023-01-20 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
81	21.0	90.0	2.6	cloudy	2023-01-21 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
82	21.7	88.0	2.0	rainy	2023-01-21 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
83	26.5	77.0	12.3	rainy	2023-01-21 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
84	23.5	88.0	3.3	rainy	2023-01-21 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
85	22.6	93.0	2.4	rainy	2023-01-22 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
86	21.8	95.0	1.8	rainy	2023-01-22 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	8.40	1
87	24.2	83.0	6.4	rainy	2023-01-22 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.10	1
88	23.0	91.0	3.4	rainy	2023-01-22 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.30	1
89	22.1	92.0	1.9	rainy	2023-01-23 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.40	1
90	22.8	85.0	2.8	cloudy	2023-01-23 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
91	25.8	80.0	7.0	rainy	2023-01-23 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
92	23.5	90.0	3.7	rainy	2023-01-23 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
93	22.6	91.0	1.5	rainy	2023-01-24 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	3.30	1
94	22.8	83.0	3.2	cloudy	2023-01-24 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
95	25.3	82.0	7.1	rainy	2023-01-24 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.30	1
96	23.2	91.0	3.3	rainy	2023-01-24 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
97	21.7	93.0	5.6	cloudy	2023-01-25 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
98	19.4	92.0	4.7	cloudy	2023-01-25 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
99	26.5	62.0	17.7	cloudy	2023-01-25 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
100	23.5	75.0	5.0	cloudy	2023-01-25 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
101	21.7	93.0	1.9	rainy	2023-01-26 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	9.00	1
102	21.6	93.0	3.3	rainy	2023-01-26 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.20	1
103	26.0	79.0	0.5	cloudy	2023-01-26 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
104	23.6	91.0	4.7	cloudy	2023-01-26 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
105	23.8	87.0	0.8	cloudy	2023-01-27 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
106	22.6	92.0	2.7	cloudy	2023-01-27 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
107	28.8	67.0	6.9	rainy	2023-01-27 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
108	23.0	87.0	5.4	rainy	2023-01-27 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
109	23.0	88.0	1.5	cloudy	2023-01-28 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
110	19.8	94.0	2.2	cloudy	2023-01-28 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
111	28.5	67.0	8.2	cloudy	2023-01-28 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
112	25.6	76.0	8.4	cloudy	2023-01-28 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
113	22.2	94.0	4.3	cloudy	2023-01-29 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
114	20.9	94.0	2.9	cloudy	2023-01-29 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
115	25.8	78.0	7.0	rainy	2023-01-29 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.50	1
116	24.0	91.0	3.6	rainy	2023-01-29 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.10	1
117	23.2	88.0	0.7	cloudy	2023-01-30 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
118	22.4	86.0	3.6	cloudy	2023-01-30 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
119	26.5	80.0	11.7	rainy	2023-01-30 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
120	24.0	87.0	4.0	rainy	2023-01-30 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
121	23.1	89.0	0.7	cloudy	2023-01-31 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
122	22.9	86.0	3.1	cloudy	2023-01-31 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
123	27.5	72.0	13.0	rainy	2023-01-31 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
124	24.4	89.0	4.7	cloudy	2023-01-31 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
125	21.8	95.0	3.3	rainy	2023-02-01 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.80	1
126	23.0	86.0	1.8	cloudy	2023-02-01 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
127	27.4	70.0	8.7	rainy	2023-02-01 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
128	25.1	77.0	7.4	cloudy	2023-02-01 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
129	22.8	91.0	4.7	rainy	2023-02-02 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
130	21.6	94.0	0.8	cloudy	2023-02-02 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
131	28.4	66.0	18.4	rainy	2023-02-02 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
132	24.8	73.0	7.4	cloudy	2023-02-02 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
133	22.0	86.0	2.3	cloudy	2023-02-03 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
134	21.6	88.0	3.6	cloudy	2023-02-03 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
135	28.5	65.0	18.0	rainy	2023-02-03 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
136	24.5	81.0	5.3	cloudy	2023-02-03 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
137	20.5	90.0	4.7	cloudy	2023-02-04 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
138	18.6	85.0	4.0	cloudy	2023-02-04 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
139	29.0	60.0	9.6	cloudy	2023-02-04 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
140	24.2	88.0	3.7	cloudy	2023-02-04 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
141	22.2	91.0	3.8	rainy	2023-02-05 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
142	20.9	87.0	2.6	cloudy	2023-02-05 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
143	28.0	62.0	6.8	rainy	2023-02-05 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
144	23.9	89.0	4.0	rainy	2023-02-05 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.00	1
145	22.6	87.0	1.9	cloudy	2023-02-06 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
146	20.1	92.0	4.9	cloudy	2023-02-06 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
147	28.6	61.0	6.8	rainy	2023-02-06 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
148	24.4	84.0	4.9	rainy	2023-02-06 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	3.40	1
149	23.1	91.0	0.4	cloudy	2023-02-07 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
150	22.0	90.0	2.0	cloudy	2023-02-07 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
151	27.1	68.0	10.6	rainy	2023-02-07 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
152	23.5	90.0	4.3	cloudy	2023-02-07 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
153	22.3	87.0	1.8	cloudy	2023-02-08 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
155	27.5	62.0	10.3	cloudy	2023-02-08 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
156	23.2	87.0	4.8	cloudy	2023-02-08 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
157	21.0	93.0	3.5	cloudy	2023-02-09 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
158	19.9	92.0	2.9	cloudy	2023-02-09 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
159	27.5	73.0	10.7	rainy	2023-02-09 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
160	23.6	90.0	4.1	cloudy	2023-02-09 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
161	22.6	88.0	1.4	cloudy	2023-02-10 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
162	22.4	83.0	0.8	cloudy	2023-02-10 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
163	28.1	67.0	9.3	rainy	2023-02-10 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
164	24.9	75.0	8.8	cloudy	2023-02-10 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
165	22.2	89.0	4.4	cloudy	2023-02-11 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
166	21.4	89.0	3.2	cloudy	2023-02-11 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
167	28.1	68.0	11.0	rainy	2023-02-11 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
168	23.5	89.0	5.2	cloudy	2023-02-11 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
169	21.4	92.0	5.5	cloudy	2023-02-12 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
170	19.7	90.0	4.0	cloudy	2023-02-12 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
171	27.7	63.0	13.0	cloudy	2023-02-12 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
172	25.0	75.0	6.7	cloudy	2023-02-12 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
173	22.5	86.0	4.0	cloudy	2023-02-13 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
174	22.3	96.0	1.3	rainy	2023-02-13 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.90	1
175	23.9	90.0	3.5	rainy	2023-02-13 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.10	1
176	24.4	90.0	1.1	rainy	2023-02-13 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
177	22.0	98.0	3.1	cloudy	2023-02-14 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
178	21.6	98.0	2.4	cloudy	2023-02-14 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
179	24.4	87.0	2.6	rainy	2023-02-14 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
180	22.1	96.0	3.1	rainy	2023-02-14 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.00	1
181	21.4	95.0	2.7	rainy	2023-02-15 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.40	1
182	21.6	92.0	3.3	rainy	2023-02-15 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.50	1
183	26.5	73.0	13.4	cloudy	2023-02-15 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
184	22.7	93.0	2.9	rainy	2023-02-15 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
185	22.6	88.0	5.2	cloudy	2023-02-16 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
186	19.6	90.0	4.3	cloudy	2023-02-16 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
187	27.9	65.0	13.4	rainy	2023-02-16 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
188	23.4	87.0	4.7	rainy	2023-02-16 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
189	20.7	93.0	6.6	cloudy	2023-02-17 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
190	20.1	87.0	6.5	cloudy	2023-02-17 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
191	27.0	64.0	13.1	cloudy	2023-02-17 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
192	23.8	89.0	4.1	cloudy	2023-02-17 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
193	22.5	94.0	2.1	rainy	2023-02-18 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	4.70	1
194	21.1	99.0	3.9	rainy	2023-02-18 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.10	1
195	26.2	78.0	3.4	rainy	2023-02-18 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
196	23.0	96.0	2.9	rainy	2023-02-18 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
197	21.7	97.0	2.9	cloudy	2023-02-19 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
198	21.1	93.0	1.9	cloudy	2023-02-19 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
199	25.9	87.0	12.5	rainy	2023-02-19 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
200	23.4	93.0	2.2	rainy	2023-02-19 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
201	23.5	91.0	0.0	cloudy	2023-02-20 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
202	21.5	96.0	3.9	cloudy	2023-02-20 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
203	28.0	71.0	8.9	cloudy	2023-02-20 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
204	23.9	90.0	2.5	rainy	2023-02-20 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
205	22.1	96.0	1.9	rainy	2023-02-21 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
206	20.8	100.0	3.1	cloudy	2023-02-21 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
207	28.4	73.0	6.0	rainy	2023-02-21 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.50	1
208	23.9	93.0	5.2	rainy	2023-02-21 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
209	22.5	97.0	4.3	rainy	2023-02-22 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
210	21.0	97.0	4.8	cloudy	2023-02-22 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
211	28.5	71.0	8.1	rainy	2023-02-22 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
212	24.0	92.0	3.7	cloudy	2023-02-22 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
213	21.9	95.0	3.5	clear	2023-02-23 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
214	20.0	95.0	2.9	cloudy	2023-02-23 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
215	28.9	65.0	9.4	rainy	2023-02-23 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
216	25.6	76.0	6.5	cloudy	2023-02-23 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
217	22.1	88.0	3.7	clear	2023-02-24 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
218	20.4	89.0	3.8	clear	2023-02-24 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
219	28.9	68.0	9.9	rainy	2023-02-24 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
220	24.1	90.0	4.0	rainy	2023-02-24 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
221	22.8	94.0	1.5	rainy	2023-02-25 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
222	20.5	92.0	4.2	cloudy	2023-02-25 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
223	29.4	58.0	11.2	cloudy	2023-02-25 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
224	24.5	82.0	7.3	rainy	2023-02-25 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
225	21.2	94.0	5.1	cloudy	2023-02-26 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
226	20.0	87.0	4.3	cloudy	2023-02-26 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
227	28.8	63.0	15.0	rainy	2023-02-26 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
228	24.5	82.0	8.1	rainy	2023-02-26 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
229	23.0	86.0	4.3	cloudy	2023-02-27 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
230	22.2	90.0	5.3	cloudy	2023-02-27 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
231	27.3	73.0	14.2	rainy	2023-02-27 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.70	1
232	24.6	83.0	5.2	cloudy	2023-02-27 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
233	22.5	91.0	3.9	rainy	2023-02-28 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
234	22.4	90.0	3.6	cloudy	2023-02-28 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
235	27.5	73.0	13.7	rainy	2023-02-28 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
236	24.5	84.0	5.0	rainy	2023-02-28 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
237	22.5	91.0	1.8	cloudy	2023-03-01 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
238	23.6	82.0	0.8	cloudy	2023-03-01 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
239	28.5	66.0	11.4	rainy	2023-03-01 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
240	24.4	89.0	4.9	cloudy	2023-03-01 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
241	21.9	94.0	4.3	cloudy	2023-03-02 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
242	22.5	90.0	2.0	rainy	2023-03-02 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
243	27.5	70.0	16.6	rainy	2023-03-02 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
244	24.2	79.0	9.4	cloudy	2023-03-02 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
245	20.7	81.0	6.4	cloudy	2023-03-03 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
246	18.8	86.0	6.1	cloudy	2023-03-03 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
247	28.0	55.0	12.7	cloudy	2023-03-03 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
248	23.7	78.0	7.3	cloudy	2023-03-03 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
249	21.0	90.0	4.0	cloudy	2023-03-04 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
250	20.4	84.0	4.5	cloudy	2023-03-04 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
251	28.3	64.0	8.8	cloudy	2023-03-04 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
252	24.0	92.0	4.6	rainy	2023-03-04 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
253	21.5	92.0	4.6	cloudy	2023-03-05 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
254	20.0	91.0	4.7	cloudy	2023-03-05 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
255	30.0	57.0	8.4	rainy	2023-03-05 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
256	25.2	82.0	2.9	cloudy	2023-03-05 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
257	22.0	90.0	4.7	cloudy	2023-03-06 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
258	18.9	95.0	4.7	cloudy	2023-03-06 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
259	29.5	58.0	5.4	rainy	2023-03-06 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
260	24.7	83.0	4.7	rainy	2023-03-06 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
261	22.4	92.0	4.4	cloudy	2023-03-07 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
262	20.8	92.0	4.6	clear	2023-03-07 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
263	27.7	73.0	11.5	rainy	2023-03-07 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	5.80	1
264	23.9	89.0	5.4	cloudy	2023-03-07 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
265	21.5	95.0	4.4	cloudy	2023-03-08 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
266	20.5	92.0	2.5	cloudy	2023-03-08 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
267	30.4	55.0	7.3	clear	2023-03-08 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
268	25.0	83.0	6.3	cloudy	2023-03-08 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
269	21.9	95.0	4.1	cloudy	2023-03-09 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
270	20.4	92.0	3.3	clear	2023-03-09 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
271	29.2	62.0	11.1	cloudy	2023-03-09 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
272	25.0	84.0	3.6	cloudy	2023-03-09 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
273	21.9	97.0	5.0	cloudy	2023-03-10 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
274	20.5	95.0	4.0	clear	2023-03-10 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
275	29.4	58.0	7.6	rainy	2023-03-10 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
276	24.9	66.0	14.1	cloudy	2023-03-10 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
277	21.3	78.0	5.9	clear	2023-03-11 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
278	19.3	86.0	5.8	clear	2023-03-11 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
279	31.1	51.0	8.4	cloudy	2023-03-11 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
280	26.2	77.0	6.0	cloudy	2023-03-11 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
281	22.7	88.0	4.6	cloudy	2023-03-12 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
282	21.2	92.0	4.7	cloudy	2023-03-12 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
283	30.0	55.0	11.0	rainy	2023-03-12 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
284	25.5	81.0	3.9	cloudy	2023-03-12 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
285	22.5	90.0	5.0	cloudy	2023-03-13 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
286	20.9	89.0	5.6	clear	2023-03-13 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
287	26.9	74.0	13.0	rainy	2023-03-13 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	12.30	1
288	23.6	92.0	5.5	rainy	2023-03-13 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	1.00	1
289	21.9	97.0	7.0	rainy	2023-03-14 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.60	1
290	21.2	95.0	4.1	cloudy	2023-03-14 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
291	24.8	80.0	5.8	rainy	2023-03-14 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.80	1
292	23.3	91.0	4.3	rainy	2023-03-14 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
293	21.2	96.0	5.0	cloudy	2023-03-15 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
294	20.8	92.0	3.2	cloudy	2023-03-15 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
295	29.4	59.0	5.5	rainy	2023-03-15 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
296	23.5	90.0	5.4	rainy	2023-03-15 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
297	22.9	91.0	3.6	rainy	2023-03-16 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
298	20.7	93.0	5.0	cloudy	2023-03-16 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
299	28.9	70.0	5.4	rainy	2023-03-16 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
300	25.2	82.0	3.1	cloudy	2023-03-16 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
301	22.5	94.0	4.0	rainy	2023-03-17 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	2.70	1
302	20.5	94.0	2.5	cloudy	2023-03-17 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
303	29.4	66.0	8.7	cloudy	2023-03-17 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
304	25.2	84.0	5.0	cloudy	2023-03-17 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
305	23.0	94.0	2.3	rainy	2023-03-18 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
306	21.0	94.0	3.7	cloudy	2023-03-18 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
307	26.8	76.0	7.6	rainy	2023-03-18 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
308	24.6	84.0	4.8	cloudy	2023-03-18 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
309	23.6	89.0	2.2	rainy	2023-03-19 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.40	1
310	21.6	93.0	2.9	cloudy	2023-03-19 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
311	28.6	71.0	9.1	rainy	2023-03-19 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
312	24.0	89.0	3.7	rainy	2023-03-19 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
313	22.0	94.0	4.4	cloudy	2023-03-20 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
314	21.5	90.0	1.5	cloudy	2023-03-20 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
315	28.5	65.0	13.4	cloudy	2023-03-20 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
316	25.4	78.0	9.5	cloudy	2023-03-20 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
317	22.3	89.0	5.4	cloudy	2023-03-21 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
318	17.8	95.0	5.5	cloudy	2023-03-21 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
319	29.2	58.0	7.1	cloudy	2023-03-21 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
320	25.5	73.0	6.8	clear	2023-03-21 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
321	21.8	92.0	3.3	cloudy	2023-03-22 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
322	20.2	92.0	2.2	cloudy	2023-03-22 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
323	28.6	66.0	13.4	rainy	2023-03-22 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
324	24.8	85.0	2.2	rainy	2023-03-22 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.20	1
325	22.7	85.0	3.6	cloudy	2023-03-23 00:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
326	19.7	85.0	4.3	cloudy	2023-03-23 06:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.00	1
327	29.7	62.0	9.0	rainy	2023-03-23 12:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.10	1
328	24.1	91.0	3.4	rainy	2023-03-23 18:00:00	2026-02-12 08:44:29	2026-02-12 08:44:29	0.30	1
329	24.0	85.0	1.8	cloudy	2023-03-24 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
330	21.2	96.0	4.7	cloudy	2023-03-24 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
331	29.8	63.0	7.3	cloudy	2023-03-24 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
332	25.0	84.0	4.7	cloudy	2023-03-24 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
333	23.4	91.0	3.5	cloudy	2023-03-25 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
334	21.4	90.0	2.6	cloudy	2023-03-25 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
335	29.6	65.0	14.8	rainy	2023-03-25 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
336	25.6	80.0	9.7	cloudy	2023-03-25 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
337	24.0	85.0	3.4	cloudy	2023-03-26 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
338	20.8	93.0	1.8	cloudy	2023-03-26 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
339	29.9	58.0	11.7	cloudy	2023-03-26 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
340	26.0	76.0	7.5	cloudy	2023-03-26 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
341	23.5	88.0	3.4	cloudy	2023-03-27 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
342	20.8	89.0	4.0	cloudy	2023-03-27 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
343	28.8	66.0	14.6	cloudy	2023-03-27 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
344	24.5	86.0	4.6	rainy	2023-03-27 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
345	23.0	90.0	4.0	cloudy	2023-03-28 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
346	21.2	90.0	3.5	cloudy	2023-03-28 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
347	28.4	69.0	12.6	rainy	2023-03-28 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
348	24.6	83.0	7.3	rainy	2023-03-28 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
349	22.1	95.0	10.4	rainy	2023-03-29 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.30	1
350	22.0	90.0	1.8	cloudy	2023-03-29 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
351	28.0	72.0	7.4	rainy	2023-03-29 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
352	24.8	82.0	0.4	rainy	2023-03-29 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
353	24.2	85.0	1.9	cloudy	2023-03-30 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
354	21.7	92.0	2.5	cloudy	2023-03-30 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
355	28.7	69.0	10.7	rainy	2023-03-30 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
356	24.8	82.0	7.0	rainy	2023-03-30 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
357	23.5	90.0	4.0	cloudy	2023-03-31 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
358	22.0	91.0	2.9	cloudy	2023-03-31 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
359	27.4	78.0	2.7	rainy	2023-03-31 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
360	24.4	89.0	3.5	cloudy	2023-03-31 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
361	23.4	93.0	3.6	cloudy	2023-04-01 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
362	22.5	95.0	4.0	rainy	2023-04-01 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
363	27.2	75.0	10.0	rainy	2023-04-01 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.30	1
364	23.8	88.0	3.9	rainy	2023-04-01 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	5.60	1
365	22.7	95.0	3.9	cloudy	2023-04-02 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
366	22.2	94.0	2.3	cloudy	2023-04-02 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
367	28.7	72.0	7.9	rainy	2023-04-02 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
368	25.0	81.0	3.5	cloudy	2023-04-02 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
369	22.4	92.0	2.9	rainy	2023-04-03 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
370	20.4	95.0	0.5	cloudy	2023-04-03 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
371	29.4	58.0	10.4	cloudy	2023-04-03 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
372	24.1	88.0	2.8	cloudy	2023-04-03 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
373	21.8	95.0	3.3	cloudy	2023-04-04 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
374	18.6	91.0	4.5	cloudy	2023-04-04 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
375	30.5	52.0	9.7	cloudy	2023-04-04 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
376	25.2	75.0	5.9	cloudy	2023-04-04 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
377	22.4	92.0	4.3	cloudy	2023-04-05 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
378	22.0	90.0	3.2	cloudy	2023-04-05 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
379	27.5	74.0	3.3	rainy	2023-04-05 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
380	24.0	86.0	4.8	cloudy	2023-04-05 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
381	22.0	93.0	4.2	cloudy	2023-04-06 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
382	20.4	90.0	4.9	cloudy	2023-04-06 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
383	30.1	48.0	5.2	cloudy	2023-04-06 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
384	24.5	79.0	5.9	cloudy	2023-04-06 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
385	22.3	87.0	3.3	cloudy	2023-04-07 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
386	19.6	89.0	2.5	cloudy	2023-04-07 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
387	29.4	59.0	3.3	cloudy	2023-04-07 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
388	25.2	79.0	5.4	rainy	2023-04-07 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
389	23.3	85.0	4.5	cloudy	2023-04-08 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
390	22.0	86.0	2.9	cloudy	2023-04-08 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
391	29.0	65.0	9.5	rainy	2023-04-08 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
392	23.0	89.0	5.1	rainy	2023-04-08 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
393	23.2	86.0	6.9	cloudy	2023-04-09 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
394	21.0	94.0	3.1	cloudy	2023-04-09 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
395	26.2	77.0	13.4	rainy	2023-04-09 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	4.30	1
396	23.2	92.0	7.2	rainy	2023-04-09 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.70	1
397	21.6	96.0	3.7	cloudy	2023-04-10 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
398	19.4	90.0	0.4	cloudy	2023-04-10 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
399	27.4	72.0	5.5	cloudy	2023-04-10 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
400	23.8	93.0	4.0	rainy	2023-04-10 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
401	23.0	82.0	5.4	cloudy	2023-04-11 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
402	21.4	90.0	1.6	cloudy	2023-04-11 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
403	28.5	65.0	1.4	cloudy	2023-04-11 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
404	24.5	90.0	2.3	rainy	2023-04-11 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
405	22.0	88.0	4.5	cloudy	2023-04-12 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
406	21.4	89.0	1.9	cloudy	2023-04-12 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
407	29.0	68.0	8.7	rainy	2023-04-12 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
408	25.6	79.0	7.6	cloudy	2023-04-12 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
409	23.5	88.0	4.5	clear	2023-04-13 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
410	21.2	95.0	3.8	clear	2023-04-13 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
411	28.8	67.0	5.0	clear	2023-04-13 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
412	27.5	69.0	2.9	cloudy	2023-04-13 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
413	23.9	90.0	4.0	cloudy	2023-04-14 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
414	23.1	92.0	1.8	cloudy	2023-04-14 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
415	29.0	64.0	3.6	cloudy	2023-04-14 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
416	25.0	87.0	4.0	cloudy	2023-04-14 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
417	23.5	91.0	1.8	rainy	2023-04-15 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
418	22.5	96.0	1.4	cloudy	2023-04-15 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
419	29.0	72.0	5.4	rainy	2023-04-15 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
420	24.1	89.0	3.0	rainy	2023-04-15 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
421	21.9	97.0	2.1	cloudy	2023-04-16 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
422	21.4	92.0	4.8	cloudy	2023-04-16 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
423	29.7	61.0	4.2	clear	2023-04-16 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
424	25.4	81.0	6.0	rainy	2023-04-16 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
425	22.7	96.0	2.9	cloudy	2023-04-17 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
426	22.2	97.0	3.1	cloudy	2023-04-17 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
427	29.9	68.0	5.8	rainy	2023-04-17 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
428	25.0	84.0	4.7	cloudy	2023-04-17 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
429	22.8	94.0	2.9	cloudy	2023-04-18 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
430	21.4	94.0	6.2	cloudy	2023-04-18 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
431	30.0	66.0	6.8	cloudy	2023-04-18 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
432	25.9	77.0	0.8	rainy	2023-04-18 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.70	1
433	23.0	94.0	2.3	clear	2023-04-19 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
434	21.1	94.0	3.1	cloudy	2023-04-19 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
435	30.4	59.0	4.0	clear	2023-04-19 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
436	27.1	76.0	6.3	cloudy	2023-04-19 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
437	23.5	93.0	1.8	rainy	2023-04-20 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.40	1
438	22.0	97.0	2.4	rainy	2023-04-20 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
439	29.4	70.0	3.7	rainy	2023-04-20 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
440	27.2	75.0	2.9	cloudy	2023-04-20 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
441	25.0	85.0	1.6	rainy	2023-04-21 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
442	23.0	93.0	2.3	cloudy	2023-04-21 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
443	29.8	67.0	4.9	cloudy	2023-04-21 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
444	24.8	89.0	3.1	cloudy	2023-04-21 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
445	23.1	91.0	4.1	rainy	2023-04-22 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
446	21.5	94.0	6.3	cloudy	2023-04-22 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
447	30.2	62.0	7.6	cloudy	2023-04-22 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
448	24.0	89.0	4.3	cloudy	2023-04-22 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
449	22.8	93.0	4.2	cloudy	2023-04-23 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
450	21.3	97.0	4.7	cloudy	2023-04-23 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
451	30.4	64.0	9.1	rainy	2023-04-23 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
452	24.9	89.0	3.1	cloudy	2023-04-23 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
453	24.4	86.0	2.8	cloudy	2023-04-24 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
454	22.0	88.0	5.0	cloudy	2023-04-24 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
455	29.8	66.0	7.1	cloudy	2023-04-24 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
456	25.8	78.0	5.0	cloudy	2023-04-24 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
457	24.7	81.0	1.1	cloudy	2023-04-25 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
458	21.8	95.0	6.2	cloudy	2023-04-25 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
459	31.0	54.0	8.3	cloudy	2023-04-25 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
460	27.2	67.0	8.3	cloudy	2023-04-25 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
461	24.5	83.0	4.6	cloudy	2023-04-26 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
462	22.4	94.0	5.2	cloudy	2023-04-26 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
463	30.5	58.0	8.0	rainy	2023-04-26 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
464	26.2	77.0	5.8	cloudy	2023-04-26 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
465	25.0	82.0	2.2	cloudy	2023-04-27 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
466	21.3	95.0	6.6	cloudy	2023-04-27 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
467	29.8	61.0	14.8	rainy	2023-04-27 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
468	26.3	77.0	5.8	cloudy	2023-04-27 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
469	22.8	92.0	2.6	cloudy	2023-04-28 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
470	22.2	87.0	4.0	cloudy	2023-04-28 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
471	30.8	55.0	12.3	cloudy	2023-04-28 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
472	27.2	69.0	7.9	cloudy	2023-04-28 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
473	23.6	90.0	2.7	cloudy	2023-04-29 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
474	23.0	87.0	4.1	cloudy	2023-04-29 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
475	30.6	64.0	11.2	cloudy	2023-04-29 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
476	26.0	80.0	6.8	cloudy	2023-04-29 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
477	24.0	94.0	1.5	rainy	2023-04-30 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.90	1
478	23.8	93.0	1.8	rainy	2023-04-30 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
479	27.1	77.0	14.6	rainy	2023-04-30 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	5.00	1
480	25.3	89.0	2.0	rainy	2023-04-30 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.60	1
481	23.2	93.0	0.5	cloudy	2023-05-01 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
482	23.0	90.0	1.5	cloudy	2023-05-01 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
483	30.5	56.0	13.7	cloudy	2023-05-01 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
484	26.5	77.0	12.7	rainy	2023-05-01 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
485	23.4	92.0	4.7	cloudy	2023-05-02 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
486	23.5	89.0	2.7	cloudy	2023-05-02 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
487	26.1	80.0	4.0	rainy	2023-05-02 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
488	25.1	90.0	3.6	rainy	2023-05-02 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.20	1
489	23.0	94.0	3.0	cloudy	2023-05-03 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
490	22.4	97.0	2.3	cloudy	2023-05-03 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
491	28.2	76.0	14.5	rainy	2023-05-03 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
492	24.9	87.0	0.7	rainy	2023-05-03 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
493	23.1	95.0	5.1	rainy	2023-05-04 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.60	1
494	22.6	93.0	3.5	cloudy	2023-05-04 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
495	30.7	65.0	3.8	cloudy	2023-05-04 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
496	24.2	90.0	3.6	rainy	2023-05-04 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.10	1
497	22.8	98.0	3.1	cloudy	2023-05-05 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
498	23.6	91.0	1.8	cloudy	2023-05-05 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
499	28.9	74.0	9.6	rainy	2023-05-05 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
500	24.5	88.0	2.2	rainy	2023-05-05 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.10	1
501	23.5	94.0	6.6	rainy	2023-05-06 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.40	1
502	23.8	88.0	2.3	cloudy	2023-05-06 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
503	30.2	65.0	4.8	cloudy	2023-05-06 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
504	24.8	88.0	2.5	rainy	2023-05-06 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
505	23.6	92.0	2.5	cloudy	2023-05-07 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
506	22.5	92.0	4.3	cloudy	2023-05-07 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
507	30.2	67.0	5.9	cloudy	2023-05-07 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
508	25.1	87.0	4.2	cloudy	2023-05-07 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
509	23.3	95.0	4.7	clear	2023-05-08 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
510	22.0	91.0	5.8	cloudy	2023-05-08 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
511	30.8	59.0	3.7	cloudy	2023-05-08 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
512	26.0	86.0	5.7	cloudy	2023-05-08 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
513	23.4	94.0	2.3	clear	2023-05-09 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
514	22.1	95.0	4.1	cloudy	2023-05-09 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
515	31.2	55.0	6.5	rainy	2023-05-09 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
516	26.8	76.0	5.8	cloudy	2023-05-09 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
517	23.0	89.0	1.9	clear	2023-05-10 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
518	22.5	84.0	3.6	cloudy	2023-05-10 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
519	31.1	56.0	7.2	clear	2023-05-10 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
520	27.8	69.0	5.0	rainy	2023-05-10 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
521	21.8	94.0	3.0	cloudy	2023-05-11 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
522	21.6	95.0	4.0	cloudy	2023-05-11 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
523	30.4	57.0	2.4	cloudy	2023-05-11 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
524	26.1	77.0	4.1	cloudy	2023-05-11 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
525	24.9	83.0	3.6	cloudy	2023-05-12 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
526	23.2	89.0	5.4	cloudy	2023-05-12 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
527	30.4	61.0	3.1	rainy	2023-05-12 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
528	25.8	81.0	5.8	cloudy	2023-05-12 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
529	23.1	94.0	3.7	clear	2023-05-13 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
530	23.4	87.0	4.0	clear	2023-05-13 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
531	30.9	63.0	8.2	cloudy	2023-05-13 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
532	25.2	89.0	1.8	cloudy	2023-05-13 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
533	23.1	97.0	2.1	cloudy	2023-05-14 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
534	22.0	98.0	1.9	cloudy	2023-05-14 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
535	30.0	65.0	3.3	rainy	2023-05-14 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
536	25.2	85.0	5.9	rainy	2023-05-14 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
537	23.2	96.0	2.9	cloudy	2023-05-15 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
538	22.4	96.0	2.8	cloudy	2023-05-15 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
539	29.1	72.0	4.7	rainy	2023-05-15 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
540	24.2	91.0	7.3	rainy	2023-05-15 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
541	22.8	98.0	3.3	cloudy	2023-05-16 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
542	22.3	95.0	2.1	cloudy	2023-05-16 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
543	30.6	64.0	3.8	cloudy	2023-05-16 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
544	22.5	93.0	9.6	rainy	2023-05-16 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	6.10	1
545	22.7	94.0	2.6	rainy	2023-05-17 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
546	22.5	88.0	3.6	cloudy	2023-05-17 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
547	30.1	62.0	7.2	cloudy	2023-05-17 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
548	24.4	87.0	3.3	rainy	2023-05-17 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	4.30	1
549	22.4	95.0	2.6	rainy	2023-05-18 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
550	22.5	92.0	4.2	cloudy	2023-05-18 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
551	30.2	64.0	3.0	cloudy	2023-05-18 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
552	23.2	85.0	1.6	rainy	2023-05-18 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.10	1
553	22.6	93.0	2.5	rainy	2023-05-19 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
554	22.4	94.0	2.5	cloudy	2023-05-19 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
555	28.0	72.0	4.9	cloudy	2023-05-19 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
556	24.0	86.0	3.1	rainy	2023-05-19 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
557	22.4	96.0	3.3	rainy	2023-05-20 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
558	21.6	97.0	2.3	cloudy	2023-05-20 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
559	26.6	75.0	7.0	rainy	2023-05-20 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
560	23.4	95.0	4.4	rainy	2023-05-20 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.60	1
561	22.6	95.0	1.6	cloudy	2023-05-21 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
562	21.9	97.0	1.5	rainy	2023-05-21 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
563	28.4	67.0	5.2	cloudy	2023-05-21 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
564	23.7	93.0	6.5	rainy	2023-05-21 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	5.20	1
565	23.0	96.0	1.3	rainy	2023-05-22 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
566	22.4	96.0	1.5	cloudy	2023-05-22 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
567	28.4	75.0	7.6	rainy	2023-05-22 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
568	23.8	94.0	3.7	rainy	2023-05-22 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
569	22.6	96.0	3.4	rainy	2023-05-23 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
570	22.1	97.0	3.4	cloudy	2023-05-23 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
571	26.3	81.0	5.8	cloudy	2023-05-23 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
572	23.5	93.0	7.2	rainy	2023-05-23 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.10	1
573	21.6	96.0	1.5	rainy	2023-05-24 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.90	1
574	21.8	98.0	5.2	cloudy	2023-05-24 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
575	26.6	84.0	2.7	rainy	2023-05-24 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
576	23.9	94.0	5.2	rainy	2023-05-24 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
577	23.0	96.0	3.8	rainy	2023-05-25 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	3.30	1
578	21.8	98.0	3.2	rainy	2023-05-25 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.60	1
579	25.0	89.0	2.4	rainy	2023-05-25 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.60	1
580	23.2	96.0	4.3	rainy	2023-05-25 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
581	21.6	99.0	4.3	cloudy	2023-05-26 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
582	22.2	95.0	4.4	rainy	2023-05-26 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
583	27.1	82.0	6.6	rainy	2023-05-26 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
584	23.6	93.0	3.8	cloudy	2023-05-26 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
585	22.3	98.0	5.5	rainy	2023-05-27 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
586	22.3	98.0	6.5	rainy	2023-05-27 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
587	27.0	80.0	6.9	rainy	2023-05-27 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	3.70	1
588	23.8	96.0	2.5	rainy	2023-05-27 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
589	22.8	98.0	4.3	rainy	2023-05-28 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
590	22.4	100.0	7.1	rainy	2023-05-28 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.80	1
591	25.9	90.0	18.2	rainy	2023-05-28 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.80	1
592	24.0	91.0	8.9	rainy	2023-05-28 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
593	22.4	97.0	11.0	rainy	2023-05-29 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
594	22.6	98.0	13.6	rainy	2023-05-29 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
595	26.8	86.0	18.4	rainy	2023-05-29 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
596	24.9	86.0	6.9	rainy	2023-05-29 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
597	23.1	92.0	4.5	cloudy	2023-05-30 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
598	22.5	96.0	5.9	cloudy	2023-05-30 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
599	28.2	75.0	11.5	cloudy	2023-05-30 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
600	25.8	85.0	3.9	cloudy	2023-05-30 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
601	23.1	90.0	5.1	cloudy	2023-05-31 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
602	22.9	95.0	7.3	cloudy	2023-05-31 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
603	28.2	77.0	17.0	rainy	2023-05-31 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
604	24.1	91.0	2.9	rainy	2023-05-31 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
605	23.1	94.0	5.2	cloudy	2023-06-01 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
606	22.7	96.0	2.6	cloudy	2023-06-01 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
607	27.4	79.0	8.2	rainy	2023-06-01 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
608	25.1	88.0	3.5	cloudy	2023-06-01 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
609	23.2	89.0	2.9	cloudy	2023-06-02 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
610	23.4	87.0	1.4	cloudy	2023-06-02 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
611	27.9	75.0	6.6	cloudy	2023-06-02 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
612	25.1	90.0	3.0	cloudy	2023-06-02 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
613	23.2	92.0	2.6	cloudy	2023-06-03 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
614	23.2	82.0	1.4	cloudy	2023-06-03 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
615	29.0	72.0	6.9	rainy	2023-06-03 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
616	24.4	95.0	2.6	cloudy	2023-06-03 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
617	22.6	97.0	3.1	cloudy	2023-06-04 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
618	22.2	86.0	1.9	cloudy	2023-06-04 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
619	29.0	73.0	8.0	rainy	2023-06-04 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
620	23.4	96.0	7.1	rainy	2023-06-04 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
621	23.0	98.0	4.7	rainy	2023-06-05 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.70	1
622	21.9	99.0	3.1	cloudy	2023-06-05 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
623	27.5	77.0	6.8	rainy	2023-06-05 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
624	23.2	97.0	4.2	rainy	2023-06-05 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
625	22.5	96.0	2.3	rainy	2023-06-06 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
626	21.6	97.0	8.8	cloudy	2023-06-06 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
627	27.4	78.0	5.8	rainy	2023-06-06 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
628	23.2	96.0	4.6	rainy	2023-06-06 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
629	22.4	97.0	2.6	rainy	2023-06-07 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
630	22.0	98.0	4.3	cloudy	2023-06-07 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
631	25.8	86.0	4.9	rainy	2023-06-07 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
632	23.2	94.0	2.7	rainy	2023-06-07 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.00	1
633	22.0	97.0	1.1	cloudy	2023-06-08 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
634	21.9	99.0	4.1	rainy	2023-06-08 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
635	27.1	84.0	10.2	rainy	2023-06-08 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.50	1
636	23.0	95.0	4.3	rainy	2023-06-08 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.30	1
637	21.9	96.0	3.1	cloudy	2023-06-09 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
638	21.6	98.0	2.4	rainy	2023-06-09 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
639	27.0	85.0	11.2	rainy	2023-06-09 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.40	1
640	23.5	94.0	2.1	rainy	2023-06-09 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.50	1
641	22.9	91.0	2.6	cloudy	2023-06-10 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
642	22.4	97.0	3.7	cloudy	2023-06-10 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
643	27.1	81.0	12.8	rainy	2023-06-10 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
644	24.2	93.0	3.9	cloudy	2023-06-10 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
645	23.6	89.0	4.7	cloudy	2023-06-11 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
646	22.1	95.0	3.7	cloudy	2023-06-11 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
647	28.7	72.0	11.3	cloudy	2023-06-11 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
648	24.9	82.0	5.0	rainy	2023-06-11 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
649	23.6	91.0	0.5	cloudy	2023-06-12 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
650	22.9	91.0	1.8	cloudy	2023-06-12 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
651	29.2	70.0	6.0	cloudy	2023-06-12 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
652	24.5	87.0	1.5	rainy	2023-06-12 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
653	22.9	93.0	2.3	rainy	2023-06-13 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.10	1
654	22.6	89.0	3.8	cloudy	2023-06-13 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
655	29.6	69.0	3.1	clear	2023-06-13 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
656	23.9	92.0	2.8	rainy	2023-06-13 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
657	22.9	94.0	3.8	cloudy	2023-06-14 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
658	23.2	90.0	1.5	rainy	2023-06-14 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	1.10	1
659	26.8	81.0	8.3	rainy	2023-06-14 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	17.10	1
660	23.2	93.0	3.7	rainy	2023-06-14 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.30	1
661	24.0	87.0	2.0	cloudy	2023-06-15 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
662	22.5	97.0	1.5	rainy	2023-06-15 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
663	25.9	86.0	3.3	rainy	2023-06-15 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
664	23.8	94.0	1.8	cloudy	2023-06-15 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
665	23.4	93.0	4.0	cloudy	2023-06-16 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
666	22.5	95.0	1.1	cloudy	2023-06-16 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
667	26.6	84.0	7.6	rainy	2023-06-16 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
668	24.1	92.0	2.2	rainy	2023-06-16 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
669	22.4	92.0	4.4	cloudy	2023-06-17 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
670	22.3	87.0	2.9	cloudy	2023-06-17 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
671	28.8	69.0	6.2	cloudy	2023-06-17 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
672	23.5	89.0	2.9	rainy	2023-06-17 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	5.20	1
673	22.7	95.0	3.4	cloudy	2023-06-18 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
674	22.6	89.0	2.3	cloudy	2023-06-18 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
675	28.5	75.0	3.9	rainy	2023-06-18 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
676	24.3	89.0	4.8	rainy	2023-06-18 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
677	23.2	92.0	1.4	rainy	2023-06-19 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.60	1
678	22.5	88.0	3.6	clear	2023-06-19 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
679	28.6	75.0	5.4	rainy	2023-06-19 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
680	22.9	92.0	2.8	rainy	2023-06-19 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	4.20	1
681	23.2	94.0	1.9	rainy	2023-06-20 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
682	22.0	98.0	3.8	cloudy	2023-06-20 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
683	27.2	80.0	4.7	rainy	2023-06-20 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
684	23.3	90.0	2.5	rainy	2023-06-20 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.10	1
685	22.5	96.0	1.8	rainy	2023-06-21 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
686	21.8	97.0	1.8	cloudy	2023-06-21 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
687	26.7	80.0	7.0	rainy	2023-06-21 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
688	22.9	94.0	8.9	rainy	2023-06-21 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.70	1
689	23.0	94.0	2.8	rainy	2023-06-22 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.90	1
690	21.8	97.0	5.4	rainy	2023-06-22 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
691	25.6	85.0	1.8	rainy	2023-06-22 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
692	23.5	93.0	1.8	rainy	2023-06-22 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.20	1
693	22.4	96.0	1.9	cloudy	2023-06-23 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
694	21.4	97.0	1.4	cloudy	2023-06-23 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
695	26.2	83.0	4.7	rainy	2023-06-23 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
696	23.4	95.0	4.1	rainy	2023-06-23 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
697	22.8	95.0	3.8	cloudy	2023-06-24 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
698	22.0	95.0	1.8	cloudy	2023-06-24 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
699	28.0	77.0	6.6	rainy	2023-06-24 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
700	23.2	94.0	9.1	rainy	2023-06-24 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	2.50	1
701	21.6	97.0	4.4	rainy	2023-06-25 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
702	21.3	98.0	3.3	rainy	2023-06-25 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
703	26.3	80.0	5.9	rainy	2023-06-25 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
704	23.5	94.0	2.2	rainy	2023-06-25 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.80	1
705	22.6	94.0	2.4	rainy	2023-06-26 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
706	22.1	93.0	3.1	rainy	2023-06-26 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
707	26.2	88.0	6.1	rainy	2023-06-26 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.60	1
708	23.0	95.0	2.2	rainy	2023-06-26 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.30	1
709	22.4	95.0	2.4	cloudy	2023-06-27 00:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
710	22.5	92.0	1.5	cloudy	2023-06-27 06:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.00	1
711	28.2	78.0	6.2	rainy	2023-06-27 12:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	0.10	1
712	23.4	91.0	4.0	rainy	2023-06-27 18:00:00	2026-02-12 08:44:30	2026-02-12 08:44:30	4.10	1
713	22.9	96.0	2.5	rainy	2023-06-28 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.80	1
714	22.3	96.0	2.1	cloudy	2023-06-28 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
715	27.9	78.0	5.4	rainy	2023-06-28 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
716	23.8	92.0	4.2	rainy	2023-06-28 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.50	1
717	22.0	94.0	2.9	rainy	2023-06-29 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
718	21.5	94.0	1.8	cloudy	2023-06-29 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
719	27.1	76.0	9.4	cloudy	2023-06-29 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
720	24.7	89.0	4.0	rainy	2023-06-29 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
721	22.5	96.0	3.5	cloudy	2023-06-30 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
722	21.5	95.0	3.4	cloudy	2023-06-30 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
723	29.2	71.0	3.2	rainy	2023-06-30 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
724	24.5	88.0	2.6	rainy	2023-06-30 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
725	24.2	90.0	2.1	rainy	2023-07-01 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
726	22.5	94.0	3.4	cloudy	2023-07-01 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
727	28.9	76.0	4.3	rainy	2023-07-01 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
728	24.8	89.0	4.0	cloudy	2023-07-01 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
729	23.0	93.0	3.5	cloudy	2023-07-02 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
730	22.7	92.0	2.6	cloudy	2023-07-02 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
731	28.0	76.0	7.6	rainy	2023-07-02 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.00	1
732	25.7	87.0	6.0	cloudy	2023-07-02 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
733	23.5	89.0	2.6	rainy	2023-07-03 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
734	22.8	91.0	1.8	cloudy	2023-07-03 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
735	26.5	83.0	5.8	rainy	2023-07-03 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
736	24.3	91.0	3.1	rainy	2023-07-03 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
737	23.1	93.0	2.3	cloudy	2023-07-04 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
738	22.9	92.0	1.9	rainy	2023-07-04 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.20	1
739	28.2	76.0	9.7	rainy	2023-07-04 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
740	24.7	89.0	1.3	rainy	2023-07-04 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
741	22.3	94.0	4.3	cloudy	2023-07-05 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
742	21.0	95.0	5.2	cloudy	2023-07-05 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
743	29.2	68.0	4.3	cloudy	2023-07-05 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
744	27.1	77.0	2.5	cloudy	2023-07-05 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
745	25.0	87.0	1.9	cloudy	2023-07-06 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
746	23.2	96.0	2.7	cloudy	2023-07-06 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
747	29.9	69.0	5.6	cloudy	2023-07-06 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
748	24.5	92.0	4.0	cloudy	2023-07-06 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
749	22.9	97.0	3.7	cloudy	2023-07-07 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
750	22.8	96.0	1.8	cloudy	2023-07-07 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
751	29.5	68.0	9.6	cloudy	2023-07-07 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
752	25.7	84.0	5.9	rainy	2023-07-07 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
753	24.0	88.0	1.8	cloudy	2023-07-08 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
754	22.2	88.0	0.4	cloudy	2023-07-08 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
755	28.5	76.0	5.6	rainy	2023-07-08 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.80	1
756	24.1	89.0	4.6	rainy	2023-07-08 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	13.60	1
757	22.6	96.0	1.8	cloudy	2023-07-09 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
758	22.2	97.0	2.5	cloudy	2023-07-09 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
759	27.5	81.0	8.3	rainy	2023-07-09 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
760	23.0	94.0	5.4	rainy	2023-07-09 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	6.80	1
761	22.2	98.0	3.6	cloudy	2023-07-10 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
762	21.6	98.0	3.1	rainy	2023-07-10 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
763	27.1	86.0	4.8	rainy	2023-07-10 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.80	1
764	23.5	94.0	3.7	rainy	2023-07-10 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
765	22.1	97.0	3.2	cloudy	2023-07-11 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
766	22.0	96.0	0.7	cloudy	2023-07-11 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
767	28.5	74.0	8.5	rainy	2023-07-11 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
768	24.0	92.0	3.4	rainy	2023-07-11 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
769	21.9	99.0	2.5	rainy	2023-07-12 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.50	1
770	22.3	97.0	3.9	rainy	2023-07-12 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
771	25.6	88.0	6.8	rainy	2023-07-12 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
772	23.4	95.0	4.6	rainy	2023-07-12 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
773	22.2	98.0	6.1	rainy	2023-07-13 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
774	21.8	99.0	5.4	cloudy	2023-07-13 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
775	24.6	88.0	8.2	rainy	2023-07-13 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
776	23.4	96.0	7.4	rainy	2023-07-13 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.60	1
777	22.2	97.0	5.3	cloudy	2023-07-14 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
778	21.5	99.0	3.1	cloudy	2023-07-14 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
779	26.4	80.0	11.4	cloudy	2023-07-14 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
780	24.5	90.0	5.7	cloudy	2023-07-14 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
781	22.2	96.0	1.3	cloudy	2023-07-15 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
782	21.0	95.0	1.0	cloudy	2023-07-15 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
783	26.0	80.0	7.8	rainy	2023-07-15 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
784	24.5	84.0	6.6	rainy	2023-07-15 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
785	22.8	92.0	5.0	cloudy	2023-07-16 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
786	21.5	98.0	4.8	cloudy	2023-07-16 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
787	25.5	87.0	7.4	rainy	2023-07-16 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
788	23.6	94.0	1.8	rainy	2023-07-16 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
789	22.9	94.0	1.8	cloudy	2023-07-17 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
790	22.2	89.0	3.1	cloudy	2023-07-17 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
791	27.0	73.0	7.2	cloudy	2023-07-17 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
792	22.8	92.0	3.0	rainy	2023-07-17 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	6.10	1
793	22.7	94.0	0.7	cloudy	2023-07-18 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
794	22.0	95.0	1.5	rainy	2023-07-18 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	3.10	1
795	25.1	83.0	7.3	rainy	2023-07-18 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
796	22.7	95.0	4.8	rainy	2023-07-18 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.90	1
797	22.4	100.0	3.7	rainy	2023-07-19 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
798	21.6	100.0	4.7	rainy	2023-07-19 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
799	25.4	86.0	6.5	rainy	2023-07-19 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
800	23.2	95.0	4.2	rainy	2023-07-19 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.60	1
801	22.0	99.0	1.8	cloudy	2023-07-20 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
802	21.9	97.0	0.5	rainy	2023-07-20 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
803	26.8	83.0	8.7	rainy	2023-07-20 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
804	23.1	88.0	4.4	rainy	2023-07-20 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	3.70	1
805	22.2	96.0	3.5	cloudy	2023-07-21 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
806	21.8	93.0	1.3	cloudy	2023-07-21 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
807	27.1	78.0	7.4	rainy	2023-07-21 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
808	23.5	93.0	2.7	rainy	2023-07-21 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.30	1
809	22.8	96.0	2.5	rainy	2023-07-22 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
810	22.1	96.0	0.8	rainy	2023-07-22 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
811	24.9	92.0	7.9	rainy	2023-07-22 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
812	23.0	95.0	3.6	rainy	2023-07-22 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.10	1
813	22.4	97.0	4.7	rainy	2023-07-23 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
814	21.5	99.0	7.6	rainy	2023-07-23 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
815	25.1	85.0	8.6	rainy	2023-07-23 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
816	24.3	94.0	1.8	rainy	2023-07-23 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.40	1
817	22.1	98.0	5.8	rainy	2023-07-24 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.60	1
818	21.6	98.0	11.3	rainy	2023-07-24 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
819	24.1	92.0	16.7	rainy	2023-07-24 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
820	23.0	95.0	11.0	rainy	2023-07-24 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
821	21.5	98.0	9.3	rainy	2023-07-25 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
822	21.0	99.0	5.9	cloudy	2023-07-25 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
823	26.9	77.0	20.1	rainy	2023-07-25 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
824	23.6	92.0	7.9	rainy	2023-07-25 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
825	22.0	99.0	5.6	cloudy	2023-07-26 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
826	21.2	100.0	5.1	cloudy	2023-07-26 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
827	26.1	79.0	13.4	rainy	2023-07-26 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
828	24.6	88.0	5.1	rainy	2023-07-26 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
829	23.1	91.0	2.7	cloudy	2023-07-27 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
830	22.0	93.0	2.3	cloudy	2023-07-27 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
831	27.2	78.0	13.0	rainy	2023-07-27 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
832	23.7	95.0	2.4	rainy	2023-07-27 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
833	22.6	93.0	3.3	rainy	2023-07-28 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
834	21.8	96.0	2.2	cloudy	2023-07-28 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
835	26.5	83.0	5.3	rainy	2023-07-28 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
836	23.3	94.0	2.6	rainy	2023-07-28 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
837	22.0	96.0	3.0	rainy	2023-07-29 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
838	21.5	99.0	2.8	rainy	2023-07-29 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
839	25.5	86.0	5.2	rainy	2023-07-29 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
840	23.3	94.0	1.5	rainy	2023-07-29 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
841	22.8	96.0	2.2	rainy	2023-07-30 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
842	22.0	98.0	3.3	cloudy	2023-07-30 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
843	26.1	91.0	7.9	rainy	2023-07-30 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
844	23.5	93.0	2.7	rainy	2023-07-30 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
845	22.0	96.0	2.6	cloudy	2023-07-31 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
846	21.4	95.0	1.8	cloudy	2023-07-31 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
847	27.3	76.0	5.7	rainy	2023-07-31 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
848	24.8	83.0	5.3	rainy	2023-07-31 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.80	1
849	23.6	89.0	0.5	cloudy	2023-08-01 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
850	21.4	95.0	2.3	clear	2023-08-01 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
851	27.9	72.0	10.3	cloudy	2023-08-01 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
852	25.7	84.0	3.3	rainy	2023-08-01 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
853	22.2	92.0	2.6	cloudy	2023-08-02 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
854	21.0	90.0	2.5	clear	2023-08-02 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
855	28.1	72.0	8.9	cloudy	2023-08-02 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
856	25.5	83.0	4.6	cloudy	2023-08-02 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
857	22.4	88.0	2.7	cloudy	2023-08-03 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
858	21.0	85.0	2.5	cloudy	2023-08-03 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
859	28.1	73.0	7.8	cloudy	2023-08-03 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
860	25.0	85.0	4.1	cloudy	2023-08-03 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
861	23.0	91.0	2.2	cloudy	2023-08-04 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
862	21.8	92.0	1.8	clear	2023-08-04 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
863	28.6	72.0	5.9	clear	2023-08-04 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
864	25.4	90.0	2.6	rainy	2023-08-04 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.30	1
865	23.0	95.0	3.7	cloudy	2023-08-05 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
866	21.9	96.0	1.5	cloudy	2023-08-05 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
867	28.3	77.0	7.3	rainy	2023-08-05 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
868	26.0	91.0	3.9	clear	2023-08-05 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
869	22.8	91.0	2.7	cloudy	2023-08-06 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
870	21.9	84.0	2.1	cloudy	2023-08-06 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
871	26.9	84.0	8.9	rainy	2023-08-06 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
872	24.4	94.0	2.8	rainy	2023-08-06 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
873	22.1	95.0	1.6	cloudy	2023-08-07 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
874	22.0	92.0	0.5	rainy	2023-08-07 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
875	26.5	79.0	8.5	rainy	2023-08-07 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	3.30	1
876	24.0	88.0	1.8	rainy	2023-08-07 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
877	21.8	99.0	4.1	cloudy	2023-08-08 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
878	21.7	96.0	1.9	rainy	2023-08-08 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
879	27.6	77.0	8.7	rainy	2023-08-08 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
880	26.0	79.0	2.9	cloudy	2023-08-08 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
881	22.0	98.0	3.5	cloudy	2023-08-09 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
882	22.0	96.0	2.5	cloudy	2023-08-09 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
883	27.2	80.0	7.7	rainy	2023-08-09 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
884	23.5	94.0	3.6	cloudy	2023-08-09 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
885	21.8	99.0	3.4	cloudy	2023-08-10 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
886	21.5	98.0	3.5	cloudy	2023-08-10 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
887	25.7	87.0	8.3	rainy	2023-08-10 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	4.80	1
888	23.3	95.0	4.7	rainy	2023-08-10 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
889	22.4	98.0	4.8	rainy	2023-08-11 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.20	1
890	21.5	99.0	6.2	cloudy	2023-08-11 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
891	24.0	95.0	5.1	rainy	2023-08-11 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.20	1
892	23.5	92.0	1.9	rainy	2023-08-11 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.10	1
893	22.0	97.0	5.0	rainy	2023-08-12 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
894	21.6	98.0	2.5	rainy	2023-08-12 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
895	26.2	86.0	5.7	rainy	2023-08-12 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.50	1
896	22.9	95.0	4.4	rainy	2023-08-12 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
897	22.3	97.0	3.1	rainy	2023-08-13 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
898	21.7	98.0	3.0	rainy	2023-08-13 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
899	27.0	80.0	6.6	rainy	2023-08-13 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
900	23.0	95.0	2.3	rainy	2023-08-13 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
901	21.9	98.0	3.4	rainy	2023-08-14 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
902	21.0	98.0	2.8	cloudy	2023-08-14 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
903	26.0	86.0	3.6	rainy	2023-08-14 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
904	23.3	95.0	3.2	rainy	2023-08-14 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
905	22.5	97.0	0.8	rainy	2023-08-15 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
906	21.7	98.0	3.7	cloudy	2023-08-15 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
907	26.3	86.0	5.1	rainy	2023-08-15 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
908	22.7	98.0	4.7	rainy	2023-08-15 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.50	1
909	22.0	97.0	2.7	rainy	2023-08-16 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
910	21.2	97.0	1.8	rainy	2023-08-16 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
911	26.6	86.0	3.6	rainy	2023-08-16 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
912	22.8	97.0	4.3	rainy	2023-08-16 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.80	1
913	22.3	95.0	2.9	rainy	2023-08-17 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.80	1
914	21.8	98.0	5.5	rainy	2023-08-17 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
915	25.7	86.0	8.4	rainy	2023-08-17 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
916	23.1	94.0	1.6	rainy	2023-08-17 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
917	22.0	96.0	1.6	rainy	2023-08-18 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
918	21.0	98.0	1.4	rainy	2023-08-18 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
919	26.3	81.0	7.1	cloudy	2023-08-18 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
920	23.1	91.0	4.5	rainy	2023-08-18 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	3.70	1
921	21.6	97.0	2.3	rainy	2023-08-19 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.20	1
922	21.1	97.0	0.7	cloudy	2023-08-19 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
923	26.8	82.0	1.8	rainy	2023-08-19 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
924	23.0	94.0	1.4	rainy	2023-08-19 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.10	1
925	21.5	97.0	0.0	rainy	2023-08-20 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	5.40	1
926	21.0	98.0	3.1	cloudy	2023-08-20 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
927	26.4	84.0	4.8	rainy	2023-08-20 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
928	23.5	95.0	4.5	rainy	2023-08-20 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
929	22.2	98.0	1.8	cloudy	2023-08-21 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
930	21.4	99.0	1.8	cloudy	2023-08-21 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
931	26.7	78.0	5.3	rainy	2023-08-21 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
932	23.3	95.0	6.7	rainy	2023-08-21 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
933	21.9	99.0	2.5	cloudy	2023-08-22 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
934	21.5	100.0	3.2	cloudy	2023-08-22 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
935	25.9	86.0	4.6	rainy	2023-08-22 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
936	22.2	95.0	5.9	rainy	2023-08-22 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
937	22.0	98.0	2.2	rainy	2023-08-23 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
938	21.5	98.0	4.7	cloudy	2023-08-23 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
939	25.0	89.0	5.1	rainy	2023-08-23 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.10	1
940	22.8	97.0	0.7	rainy	2023-08-23 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
941	22.9	97.0	0.5	rainy	2023-08-24 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
942	22.2	97.0	0.4	cloudy	2023-08-24 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
943	28.5	74.0	8.1	cloudy	2023-08-24 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
944	23.5	91.0	1.5	rainy	2023-08-24 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
945	22.5	97.0	1.5	cloudy	2023-08-25 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
946	21.4	98.0	1.3	cloudy	2023-08-25 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
947	28.6	67.0	8.7	cloudy	2023-08-25 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
948	23.1	95.0	1.8	rainy	2023-08-25 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
949	22.5	98.0	1.9	rainy	2023-08-26 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
950	22.4	97.0	2.3	rainy	2023-08-26 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
951	27.1	83.0	9.8	rainy	2023-08-26 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.90	1
952	23.5	94.0	3.1	rainy	2023-08-26 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.60	1
953	22.2	96.0	2.7	cloudy	2023-08-27 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
954	21.6	99.0	4.1	rainy	2023-08-27 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
955	26.2	88.0	9.3	rainy	2023-08-27 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
956	23.4	95.0	4.0	rainy	2023-08-27 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
957	21.9	99.0	4.3	cloudy	2023-08-28 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
958	21.4	100.0	6.4	cloudy	2023-08-28 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
959	26.5	80.0	19.2	rainy	2023-08-28 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.90	1
960	23.4	94.0	10.2	rainy	2023-08-28 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
961	22.1	98.0	3.9	cloudy	2023-08-29 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
962	21.6	99.0	1.6	cloudy	2023-08-29 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
963	26.5	77.0	14.7	rainy	2023-08-29 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
964	24.2	90.0	5.1	cloudy	2023-08-29 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
965	22.2	91.0	4.3	cloudy	2023-08-30 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
966	21.2	96.0	3.7	cloudy	2023-08-30 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
967	27.0	78.0	12.0	rainy	2023-08-30 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
968	25.3	87.0	3.6	rainy	2023-08-30 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
969	22.6	90.0	4.0	cloudy	2023-08-31 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
970	22.0	91.0	2.8	cloudy	2023-08-31 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
971	27.5	78.0	9.2	rainy	2023-08-31 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
972	25.0	82.0	8.0	rainy	2023-08-31 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
973	24.4	85.0	3.3	cloudy	2023-09-01 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
974	21.6	90.0	2.4	cloudy	2023-09-01 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
975	27.2	80.0	10.9	rainy	2023-09-01 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
976	25.4	84.0	6.4	cloudy	2023-09-01 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
977	23.4	88.0	4.3	cloudy	2023-09-02 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
978	21.8	90.0	2.1	cloudy	2023-09-02 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
979	27.0	79.0	11.0	rainy	2023-09-02 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
980	25.1	89.0	2.9	rainy	2023-09-02 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.60	1
981	23.0	93.0	4.0	cloudy	2023-09-03 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
982	22.1	92.0	2.4	cloudy	2023-09-03 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
983	27.8	77.0	7.7	cloudy	2023-09-03 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
984	23.8	90.0	2.1	rainy	2023-09-03 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.80	1
985	22.2	96.0	2.1	cloudy	2023-09-04 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
986	21.9	96.0	4.0	cloudy	2023-09-04 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
987	28.9	71.0	9.0	cloudy	2023-09-04 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
988	24.1	92.0	3.3	cloudy	2023-09-04 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
989	22.6	94.0	1.6	cloudy	2023-09-05 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
990	21.6	91.0	2.6	cloudy	2023-09-05 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
991	29.7	67.0	1.5	cloudy	2023-09-05 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
992	25.9	79.0	2.6	cloudy	2023-09-05 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
993	24.0	89.0	2.3	cloudy	2023-09-06 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
994	23.0	89.0	1.1	cloudy	2023-09-06 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
995	29.0	73.0	5.9	rainy	2023-09-06 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
996	25.1	86.0	3.0	cloudy	2023-09-06 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
997	23.4	90.0	4.1	rainy	2023-09-07 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.50	1
998	22.0	91.0	1.5	cloudy	2023-09-07 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
999	28.9	71.0	6.5	cloudy	2023-09-07 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1000	23.3	92.0	3.1	cloudy	2023-09-07 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1001	22.5	96.0	3.2	cloudy	2023-09-08 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1002	21.8	97.0	3.1	cloudy	2023-09-08 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1003	27.5	76.0	5.0	rainy	2023-09-08 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1004	23.6	93.0	1.9	rainy	2023-09-08 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1005	23.0	96.0	0.8	cloudy	2023-09-09 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1006	22.0	95.0	2.1	cloudy	2023-09-09 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1007	28.1	74.0	6.4	rainy	2023-09-09 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1008	24.3	89.0	2.3	rainy	2023-09-09 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1009	23.2	92.0	2.4	cloudy	2023-09-10 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1010	22.3	91.0	1.6	cloudy	2023-09-10 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1011	27.0	81.0	5.4	rainy	2023-09-10 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1012	22.8	98.0	2.6	rainy	2023-09-10 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1013	22.6	99.0	1.3	rainy	2023-09-11 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1014	21.5	93.0	1.8	rainy	2023-09-11 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	3.70	1
1015	28.0	76.0	9.7	rainy	2023-09-11 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1016	23.6	92.0	3.1	rainy	2023-09-11 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	5.50	1
1017	21.5	97.0	6.4	rainy	2023-09-12 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1018	21.1	98.0	2.9	cloudy	2023-09-12 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1019	27.5	78.0	8.2	rainy	2023-09-12 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1020	22.6	96.0	5.9	rainy	2023-09-12 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.80	1
1021	22.5	98.0	5.1	rainy	2023-09-13 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.80	1
1022	21.8	100.0	5.0	rainy	2023-09-13 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
1023	26.7	84.0	7.0	rainy	2023-09-13 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1024	23.0	93.0	0.0	rainy	2023-09-13 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.30	1
1025	22.4	94.0	5.0	rainy	2023-09-14 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	11.80	1
1026	22.0	97.0	3.6	cloudy	2023-09-14 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1027	26.5	83.0	11.3	rainy	2023-09-14 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1028	23.5	93.0	1.6	rainy	2023-09-14 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1029	22.8	94.0	0.8	rainy	2023-09-15 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1030	22.3	96.0	1.5	cloudy	2023-09-15 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1031	26.4	78.0	3.3	rainy	2023-09-15 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1032	23.8	92.0	3.3	rainy	2023-09-15 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.80	1
1033	22.9	96.0	1.6	rainy	2023-09-16 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1034	21.6	97.0	2.2	cloudy	2023-09-16 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1035	28.5	74.0	4.9	rainy	2023-09-16 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.10	1
1036	24.3	90.0	4.0	rainy	2023-09-16 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.40	1
1037	22.5	94.0	1.8	rainy	2023-09-17 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1038	21.9	91.0	2.5	cloudy	2023-09-17 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1039	29.2	70.0	6.6	rainy	2023-09-17 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1040	24.2	90.0	1.8	rainy	2023-09-17 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.20	1
1041	21.8	95.0	4.1	cloudy	2023-09-18 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1042	21.9	90.0	2.1	clear	2023-09-18 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1043	29.1	68.0	10.1	rainy	2023-09-18 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1044	24.0	93.0	1.0	rainy	2023-09-18 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1045	22.4	93.0	2.3	clear	2023-09-19 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1046	21.8	91.0	1.9	cloudy	2023-09-19 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1047	29.0	71.0	5.0	rainy	2023-09-19 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1048	23.6	92.0	3.8	rainy	2023-09-19 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1049	23.0	94.0	1.4	cloudy	2023-09-20 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1050	21.9	96.0	2.5	cloudy	2023-09-20 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1051	28.0	76.0	6.2	rainy	2023-09-20 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1052	23.4	93.0	1.6	cloudy	2023-09-20 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1053	22.9	95.0	1.1	rainy	2023-09-21 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
1054	21.7	98.0	2.0	cloudy	2023-09-21 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1055	26.3	85.0	3.4	rainy	2023-09-21 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1056	23.1	96.0	4.1	rainy	2023-09-21 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.20	1
1057	22.2	95.0	1.3	rainy	2023-09-22 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1058	22.0	97.0	1.5	rainy	2023-09-22 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1059	27.0	81.0	8.7	rainy	2023-09-22 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	2.80	1
1060	23.6	93.0	2.1	rainy	2023-09-22 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1061	22.3	97.0	2.0	cloudy	2023-09-23 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1062	21.8	97.0	1.5	rainy	2023-09-23 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1063	27.5	80.0	8.5	rainy	2023-09-23 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1064	24.5	89.0	1.8	rainy	2023-09-23 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1065	21.5	96.0	3.6	cloudy	2023-09-24 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1066	21.6	96.0	0.4	rainy	2023-09-24 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1067	26.6	80.0	5.0	rainy	2023-09-24 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.70	1
1068	24.1	93.0	0.5	rainy	2023-09-24 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1069	22.4	95.0	3.3	cloudy	2023-09-25 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1070	22.1	92.0	3.0	cloudy	2023-09-25 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1071	26.6	83.0	6.9	rainy	2023-09-25 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1072	23.0	95.0	4.4	cloudy	2023-09-25 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1073	22.4	98.0	1.8	cloudy	2023-09-26 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1074	21.6	100.0	3.6	rainy	2023-09-26 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1075	26.7	82.0	6.2	rainy	2023-09-26 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	5.20	1
1076	22.9	92.0	5.2	rainy	2023-09-26 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.30	1
1077	21.3	100.0	3.6	cloudy	2023-09-27 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.00	1
1078	21.6	98.0	3.1	rainy	2023-09-27 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1079	25.5	86.0	9.2	rainy	2023-09-27 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
1080	23.4	92.0	3.1	rainy	2023-09-27 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	1.10	1
1081	22.5	95.0	0.0	rainy	2023-09-28 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.30	1
1082	21.6	98.0	3.4	rainy	2023-09-28 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.20	1
1083	27.0	80.0	8.4	rainy	2023-09-28 12:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.40	1
1084	24.1	93.0	2.5	rainy	2023-09-28 18:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.50	1
1085	23.0	95.0	2.3	rainy	2023-09-29 00:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1086	22.1	99.0	4.0	rainy	2023-09-29 06:00:00	2026-02-12 08:44:31	2026-02-12 08:44:31	0.10	1
1087	27.2	80.0	7.2	rainy	2023-09-29 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.30	1
1088	23.6	97.0	2.5	cloudy	2023-09-29 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1089	23.0	98.0	1.1	rainy	2023-09-30 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1090	22.2	97.0	2.9	rainy	2023-09-30 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1091	26.5	85.0	12.3	rainy	2023-09-30 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1092	23.9	91.0	0.8	rainy	2023-09-30 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.10	1
1093	22.6	96.0	1.9	rainy	2023-10-01 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1094	21.7	99.0	3.1	cloudy	2023-10-01 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1095	26.2	82.0	13.5	rainy	2023-10-01 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1096	24.4	92.0	2.6	cloudy	2023-10-01 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1097	22.2	92.0	2.5	cloudy	2023-10-02 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1098	22.1	93.0	2.5	cloudy	2023-10-02 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1099	27.8	80.0	11.0	rainy	2023-10-02 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1100	26.3	75.0	4.3	cloudy	2023-10-02 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1101	24.4	80.0	2.6	cloudy	2023-10-03 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1102	22.2	92.0	1.8	cloudy	2023-10-03 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1103	28.1	78.0	6.1	rainy	2023-10-03 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1104	24.1	87.0	1.1	cloudy	2023-10-03 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1105	23.3	91.0	1.6	cloudy	2023-10-04 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1106	22.4	92.0	1.9	clear	2023-10-04 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1107	29.1	73.0	6.3	rainy	2023-10-04 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1108	25.2	90.0	3.9	cloudy	2023-10-04 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1109	23.3	98.0	2.3	cloudy	2023-10-05 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1110	21.8	88.0	0.7	cloudy	2023-10-05 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1111	29.2	70.0	6.3	cloudy	2023-10-05 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1112	24.4	92.0	4.6	rainy	2023-10-05 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.50	1
1113	22.1	95.0	3.3	cloudy	2023-10-06 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1114	21.7	86.0	2.3	cloudy	2023-10-06 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1115	29.0	69.0	6.5	cloudy	2023-10-06 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1116	24.1	92.0	4.7	cloudy	2023-10-06 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1117	22.8	95.0	2.8	cloudy	2023-10-07 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1118	22.1	89.0	1.0	clear	2023-10-07 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1119	26.8	78.0	8.4	rainy	2023-10-07 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1120	25.4	87.0	2.3	cloudy	2023-10-07 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1121	23.0	98.0	0.7	cloudy	2023-10-08 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1122	22.3	96.0	1.1	cloudy	2023-10-08 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1123	28.2	81.0	5.8	rainy	2023-10-08 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.80	1
1124	24.4	96.0	2.8	cloudy	2023-10-08 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1125	22.4	98.0	4.3	cloudy	2023-10-09 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1126	22.4	93.0	2.6	cloudy	2023-10-09 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1127	27.5	82.0	1.8	rainy	2023-10-09 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1128	23.5	97.0	2.6	rainy	2023-10-09 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1129	22.1	99.0	2.9	cloudy	2023-10-10 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1130	22.5	97.0	2.7	cloudy	2023-10-10 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1131	24.4	90.0	4.4	rainy	2023-10-10 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1132	23.1	95.0	2.6	rainy	2023-10-10 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.80	1
1133	22.0	98.0	4.3	rainy	2023-10-11 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1134	21.8	98.0	1.6	rainy	2023-10-11 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.50	1
1135	25.5	89.0	6.3	rainy	2023-10-11 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1136	22.9	96.0	1.5	rainy	2023-10-11 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1137	22.1	96.0	2.2	cloudy	2023-10-12 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1138	22.4	94.0	4.0	cloudy	2023-10-12 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1139	27.5	78.0	7.5	rainy	2023-10-12 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1140	23.3	92.0	7.0	rainy	2023-10-12 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.60	1
1141	22.8	97.0	1.1	cloudy	2023-10-13 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1142	22.6	94.0	1.8	cloudy	2023-10-13 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1143	27.3	81.0	5.1	rainy	2023-10-13 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1144	23.7	94.0	0.0	cloudy	2023-10-13 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1145	22.3	96.0	2.3	rainy	2023-10-14 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1146	21.6	96.0	1.8	cloudy	2023-10-14 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1147	27.6	76.0	7.7	cloudy	2023-10-14 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1148	23.1	95.0	4.1	rainy	2023-10-14 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.70	1
1149	21.8	96.0	2.5	cloudy	2023-10-15 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1150	22.3	89.0	3.8	cloudy	2023-10-15 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1151	28.8	68.0	7.0	cloudy	2023-10-15 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1152	24.6	88.0	4.7	cloudy	2023-10-15 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1153	22.5	96.0	3.2	rainy	2023-10-16 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1154	22.4	92.0	3.2	cloudy	2023-10-16 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1155	28.4	71.0	4.7	rainy	2023-10-16 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1156	23.7	93.0	3.3	rainy	2023-10-16 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1157	21.9	93.0	3.2	cloudy	2023-10-17 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1158	21.1	89.0	4.0	cloudy	2023-10-17 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1159	28.5	76.0	2.9	rainy	2023-10-17 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.90	1
1160	23.5	93.0	4.2	cloudy	2023-10-17 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1161	22.1	94.0	3.3	clear	2023-10-18 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1162	21.2	92.0	4.0	cloudy	2023-10-18 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1163	30.1	61.0	6.4	cloudy	2023-10-18 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1164	23.6	90.0	1.8	rainy	2023-10-18 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1165	22.5	92.0	2.7	cloudy	2023-10-19 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1166	21.0	94.0	4.0	cloudy	2023-10-19 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1167	29.0	68.0	3.6	cloudy	2023-10-19 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1168	22.5	96.0	2.8	cloudy	2023-10-19 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1169	23.0	94.0	1.8	cloudy	2023-10-20 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1170	21.9	97.0	3.1	cloudy	2023-10-20 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1171	28.9	71.0	2.4	cloudy	2023-10-20 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1172	24.5	87.0	1.8	cloudy	2023-10-20 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1173	23.1	89.0	4.0	cloudy	2023-10-21 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1174	21.8	89.0	3.5	cloudy	2023-10-21 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1175	28.1	78.0	5.2	rainy	2023-10-21 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.50	1
1176	23.0	96.0	4.1	rainy	2023-10-21 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.30	1
1177	21.6	96.0	2.5	clear	2023-10-22 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1178	21.4	89.0	3.2	cloudy	2023-10-22 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1179	29.0	72.0	5.2	rainy	2023-10-22 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.30	1
1180	24.1	91.0	2.4	rainy	2023-10-22 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.00	1
1181	21.0	94.0	3.9	clear	2023-10-23 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1182	21.4	91.0	3.4	cloudy	2023-10-23 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1183	29.4	68.0	3.4	cloudy	2023-10-23 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1184	23.0	94.0	3.4	cloudy	2023-10-23 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1185	22.5	93.0	4.2	cloudy	2023-10-24 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1186	22.1	87.0	1.8	clear	2023-10-24 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1187	29.4	67.0	2.3	rainy	2023-10-24 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1188	23.5	94.0	3.9	cloudy	2023-10-24 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1189	23.0	94.0	3.7	cloudy	2023-10-25 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1190	21.6	90.0	1.6	cloudy	2023-10-25 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1191	28.1	76.0	8.4	clear	2023-10-25 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1192	23.5	93.0	4.7	rainy	2023-10-25 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1193	22.7	94.0	2.3	cloudy	2023-10-26 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1194	22.1	92.0	1.5	cloudy	2023-10-26 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1195	26.5	79.0	1.4	cloudy	2023-10-26 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1196	23.1	96.0	2.9	cloudy	2023-10-26 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1197	22.5	97.0	3.3	cloudy	2023-10-27 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1198	22.1	95.0	2.6	cloudy	2023-10-27 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1199	28.2	74.0	6.1	rainy	2023-10-27 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1200	22.9	96.0	3.8	cloudy	2023-10-27 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1201	22.7	96.0	0.5	cloudy	2023-10-28 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1202	20.8	93.0	3.7	cloudy	2023-10-28 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1203	29.0	65.0	3.9	cloudy	2023-10-28 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1204	27.5	65.0	5.6	cloudy	2023-10-28 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1205	22.4	90.0	3.2	rainy	2023-10-29 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.60	1
1206	21.8	93.0	2.7	cloudy	2023-10-29 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1207	27.5	78.0	6.2	rainy	2023-10-29 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1208	24.0	93.0	3.4	cloudy	2023-10-29 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1209	23.5	87.0	3.3	cloudy	2023-10-30 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1210	22.4	87.0	0.8	cloudy	2023-10-30 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1211	28.5	74.0	3.4	rainy	2023-10-30 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1212	23.2	93.0	2.3	rainy	2023-10-30 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1213	21.7	97.0	4.0	cloudy	2023-10-31 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1214	21.7	92.0	2.5	cloudy	2023-10-31 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1215	28.6	72.0	6.7	cloudy	2023-10-31 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1216	24.9	91.0	5.9	rainy	2023-10-31 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1217	23.2	96.0	2.5	cloudy	2023-11-01 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1218	21.9	93.0	4.0	cloudy	2023-11-01 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1219	29.3	72.0	0.5	cloudy	2023-11-01 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1220	24.5	86.0	0.4	cloudy	2023-11-01 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1221	21.6	97.0	4.2	cloudy	2023-11-02 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1222	21.9	88.0	2.5	cloudy	2023-11-02 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1223	29.8	63.0	6.5	rainy	2023-11-02 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1224	27.0	73.0	4.4	cloudy	2023-11-02 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1225	22.6	94.0	3.2	rainy	2023-11-03 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1226	21.5	91.0	3.3	cloudy	2023-11-03 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1227	25.6	83.0	9.7	rainy	2023-11-03 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	7.70	1
1228	24.3	91.0	3.2	cloudy	2023-11-03 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1229	22.9	96.0	3.8	cloudy	2023-11-04 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1230	22.1	89.0	1.4	cloudy	2023-11-04 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1231	29.6	66.0	7.3	rainy	2023-11-04 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1232	24.9	86.0	1.9	rainy	2023-11-04 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1233	22.6	92.0	3.8	cloudy	2023-11-05 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1234	23.0	87.0	1.9	cloudy	2023-11-05 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1235	29.1	71.0	8.6	rainy	2023-11-05 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1236	24.5	91.0	4.0	rainy	2023-11-05 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1237	22.8	93.0	2.1	clear	2023-11-06 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1238	21.5	90.0	3.3	cloudy	2023-11-06 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1239	30.2	58.0	9.7	cloudy	2023-11-06 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1240	25.3	87.0	6.2	cloudy	2023-11-06 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1241	23.5	90.0	3.4	rainy	2023-11-07 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1242	22.9	93.0	2.5	cloudy	2023-11-07 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1243	29.0	73.0	7.2	rainy	2023-11-07 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1244	24.3	92.0	4.3	rainy	2023-11-07 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	3.40	1
1245	23.9	92.0	1.6	cloudy	2023-11-08 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1246	23.0	93.0	2.4	cloudy	2023-11-08 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1247	29.0	70.0	9.4	cloudy	2023-11-08 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1248	24.3	91.0	3.2	cloudy	2023-11-08 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1249	22.2	92.0	2.5	cloudy	2023-11-09 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1250	22.3	85.0	1.5	cloudy	2023-11-09 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1251	29.6	63.0	11.5	clear	2023-11-09 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1252	25.0	82.0	7.3	cloudy	2023-11-09 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1253	23.0	91.0	1.9	cloudy	2023-11-10 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1254	21.1	91.0	6.3	cloudy	2023-11-10 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1255	29.9	62.0	7.4	cloudy	2023-11-10 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1256	25.0	83.0	3.3	cloudy	2023-11-10 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1257	22.6	96.0	4.7	cloudy	2023-11-11 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1258	22.0	93.0	2.9	clear	2023-11-11 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1259	29.7	63.0	8.2	clear	2023-11-11 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1260	25.2	84.0	5.5	cloudy	2023-11-11 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1261	22.3	97.0	2.6	cloudy	2023-11-12 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1262	21.9	94.0	3.0	cloudy	2023-11-12 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1263	29.5	69.0	5.0	cloudy	2023-11-12 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1264	27.0	68.0	4.0	cloudy	2023-11-12 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1265	22.4	90.0	3.8	cloudy	2023-11-13 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1266	20.8	91.0	4.3	cloudy	2023-11-13 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1267	30.6	57.0	9.0	clear	2023-11-13 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1268	24.3	89.0	4.8	clear	2023-11-13 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1269	22.1	93.0	2.2	clear	2023-11-14 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1270	20.8	85.0	4.0	cloudy	2023-11-14 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1271	30.9	57.0	7.6	cloudy	2023-11-14 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1272	26.0	78.0	5.9	cloudy	2023-11-14 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1273	23.0	91.0	2.5	cloudy	2023-11-15 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1274	21.6	88.0	3.0	clear	2023-11-15 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1275	30.1	57.0	16.0	cloudy	2023-11-15 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1276	25.0	79.0	5.6	cloudy	2023-11-15 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1277	22.9	89.0	3.3	cloudy	2023-11-16 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1278	22.8	92.0	1.9	cloudy	2023-11-16 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1279	28.1	71.0	8.8	rainy	2023-11-16 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1280	24.3	93.0	3.3	cloudy	2023-11-16 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1281	23.1	94.0	3.2	rainy	2023-11-17 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1282	23.2	91.0	1.1	cloudy	2023-11-17 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1283	26.7	80.0	1.1	cloudy	2023-11-17 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1284	24.5	93.0	2.2	rainy	2023-11-17 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.40	1
1285	23.3	91.0	2.5	cloudy	2023-11-18 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1286	22.9	89.0	3.3	cloudy	2023-11-18 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1287	29.5	66.0	4.6	cloudy	2023-11-18 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1288	25.0	86.0	3.8	cloudy	2023-11-18 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1289	23.0	95.0	4.4	cloudy	2023-11-19 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1290	22.9	87.0	1.9	cloudy	2023-11-19 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1291	27.1	76.0	6.1	cloudy	2023-11-19 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1292	24.8	90.0	3.3	cloudy	2023-11-19 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1293	23.1	96.0	1.8	rainy	2023-11-20 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1294	22.8	96.0	3.1	cloudy	2023-11-20 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1295	27.0	80.0	5.4	rainy	2023-11-20 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1296	23.5	96.0	3.1	rainy	2023-11-20 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1297	23.6	95.0	2.6	cloudy	2023-11-21 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1298	23.0	94.0	3.3	cloudy	2023-11-21 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1299	28.4	76.0	6.9	rainy	2023-11-21 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1300	23.6	95.0	3.6	cloudy	2023-11-21 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1301	23.2	96.0	1.9	cloudy	2023-11-22 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1302	22.4	96.0	2.9	cloudy	2023-11-22 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1303	28.5	71.0	5.5	cloudy	2023-11-22 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1304	24.8	87.0	2.3	cloudy	2023-11-22 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1305	23.3	95.0	2.9	rainy	2023-11-23 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1306	22.1	95.0	4.5	cloudy	2023-11-23 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1307	28.7	72.0	6.9	rainy	2023-11-23 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1308	24.4	94.0	4.3	cloudy	2023-11-23 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1309	22.6	98.0	2.9	cloudy	2023-11-24 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1310	22.5	92.0	3.8	rainy	2023-11-24 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1311	28.1	72.0	7.9	rainy	2023-11-24 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1312	24.5	88.0	4.2	cloudy	2023-11-24 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1313	21.7	91.0	1.8	cloudy	2023-11-25 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1314	20.8	82.0	2.7	cloudy	2023-11-25 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1315	27.7	71.0	12.8	rainy	2023-11-25 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1316	24.0	91.0	3.1	cloudy	2023-11-25 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1317	21.7	96.0	2.2	cloudy	2023-11-26 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1318	20.8	89.0	3.3	clear	2023-11-26 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1319	30.0	57.0	16.1	cloudy	2023-11-26 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1320	25.6	78.0	4.2	clear	2023-11-26 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1321	23.5	94.0	2.7	rainy	2023-11-27 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1322	22.4	90.0	2.9	clear	2023-11-27 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1323	29.2	67.0	10.1	rainy	2023-11-27 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1324	24.8	86.0	3.1	clear	2023-11-27 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1325	24.2	84.0	1.1	cloudy	2023-11-28 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1326	22.1	87.0	2.9	cloudy	2023-11-28 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1327	29.0	69.0	11.4	rainy	2023-11-28 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1328	24.5	90.0	4.3	cloudy	2023-11-28 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1329	23.0	92.0	2.0	cloudy	2023-11-29 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1330	23.1	89.0	1.5	rainy	2023-11-29 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1331	27.8	75.0	9.0	rainy	2023-11-29 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1332	24.6	87.0	1.8	rainy	2023-11-29 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.50	1
1333	23.4	95.0	7.2	rainy	2023-11-30 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.80	1
1334	22.7	93.0	1.8	cloudy	2023-11-30 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1335	28.1	69.0	11.4	rainy	2023-11-30 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1336	26.1	74.0	4.4	cloudy	2023-11-30 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1337	22.4	92.0	4.0	cloudy	2023-12-01 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1338	22.0	86.0	1.8	clear	2023-12-01 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1339	29.5	65.0	15.6	cloudy	2023-12-01 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1340	24.3	90.0	4.8	cloudy	2023-12-01 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1341	23.6	92.0	2.3	cloudy	2023-12-02 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1342	21.5	90.0	2.6	clear	2023-12-02 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1343	30.5	58.0	9.5	cloudy	2023-12-02 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1344	24.9	83.0	5.5	cloudy	2023-12-02 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1345	23.1	94.0	1.1	rainy	2023-12-03 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1346	22.4	94.0	0.5	cloudy	2023-12-03 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1347	29.9	55.0	16.0	rainy	2023-12-03 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1348	25.0	84.0	6.2	cloudy	2023-12-03 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1349	22.7	91.0	2.5	cloudy	2023-12-04 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1350	22.0	88.0	2.2	cloudy	2023-12-04 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1351	29.5	65.0	12.2	cloudy	2023-12-04 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1352	25.1	88.0	4.7	cloudy	2023-12-04 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1353	23.1	91.0	2.9	cloudy	2023-12-05 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1354	21.8	91.0	2.6	cloudy	2023-12-05 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1355	29.6	66.0	3.2	rainy	2023-12-05 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1356	26.5	77.0	1.6	rainy	2023-12-05 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1357	22.9	94.0	2.3	rainy	2023-12-06 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1358	22.5	93.0	1.9	rainy	2023-12-06 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1359	27.5	77.0	7.6	rainy	2023-12-06 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1360	25.8	81.0	1.9	cloudy	2023-12-06 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1361	22.5	92.0	2.2	cloudy	2023-12-07 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1362	22.0	87.0	2.7	cloudy	2023-12-07 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1363	28.4	71.0	13.4	cloudy	2023-12-07 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1364	24.2	89.0	3.8	cloudy	2023-12-07 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1365	22.6	95.0	2.6	cloudy	2023-12-08 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1366	21.2	87.0	3.2	cloudy	2023-12-08 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1367	29.2	67.0	7.5	rainy	2023-12-08 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1368	25.3	82.0	0.7	cloudy	2023-12-08 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1369	22.9	92.0	2.9	clear	2023-12-09 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1370	21.0	93.0	2.2	clear	2023-12-09 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1371	28.8	66.0	10.9	rainy	2023-12-09 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1372	24.8	87.0	5.5	clear	2023-12-09 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1373	22.2	95.0	3.4	cloudy	2023-12-10 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1374	20.6	92.0	3.6	cloudy	2023-12-10 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1375	29.8	59.0	15.9	rainy	2023-12-10 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1376	25.0	79.0	5.7	clear	2023-12-10 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1377	22.8	89.0	2.5	cloudy	2023-12-11 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1378	21.0	90.0	2.2	cloudy	2023-12-11 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1379	30.4	51.0	12.6	cloudy	2023-12-11 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1380	25.8	69.0	7.3	clear	2023-12-11 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1381	22.8	87.0	2.5	cloudy	2023-12-12 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1382	19.7	88.0	3.2	clear	2023-12-12 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1383	29.8	57.0	9.0	rainy	2023-12-12 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1384	25.8	78.0	5.2	clear	2023-12-12 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1385	22.5	90.0	2.4	cloudy	2023-12-13 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1386	20.7	87.0	3.7	clear	2023-12-13 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1387	29.6	57.0	20.1	rainy	2023-12-13 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1388	24.7	83.0	3.6	cloudy	2023-12-13 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1389	22.2	90.0	1.8	cloudy	2023-12-14 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1390	20.3	85.0	3.7	cloudy	2023-12-14 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1391	29.8	56.0	17.9	cloudy	2023-12-14 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1392	24.8	78.0	6.5	clear	2023-12-14 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1393	21.7	89.0	2.5	cloudy	2023-12-15 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1394	21.5	82.0	2.6	cloudy	2023-12-15 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1395	30.2	53.0	16.6	cloudy	2023-12-15 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1396	25.5	78.0	4.7	rainy	2023-12-15 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1397	21.4	92.0	5.4	cloudy	2023-12-16 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1398	20.5	78.0	3.6	cloudy	2023-12-16 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1399	32.0	41.0	11.6	cloudy	2023-12-16 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1400	26.0	70.0	6.3	cloudy	2023-12-16 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1401	21.9	86.0	6.5	cloudy	2023-12-17 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1402	22.0	77.0	6.6	cloudy	2023-12-17 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1403	29.8	56.0	7.1	cloudy	2023-12-17 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1404	26.0	71.0	8.4	cloudy	2023-12-17 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1405	23.4	96.0	5.0	rainy	2023-12-18 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1406	23.0	93.0	2.6	rainy	2023-12-18 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	2.40	1
1407	25.6	81.0	6.6	rainy	2023-12-18 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.20	1
1408	24.3	89.0	4.0	rainy	2023-12-18 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.30	1
1409	23.4	92.0	0.8	rainy	2023-12-19 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	1.20	1
1410	22.3	96.0	1.8	cloudy	2023-12-19 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1411	25.8	80.0	5.4	rainy	2023-12-19 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	5.00	1
1412	23.5	93.0	5.7	rainy	2023-12-19 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.60	1
1413	23.6	91.0	2.7	rainy	2023-12-20 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.30	1
1414	22.3	95.0	2.6	clear	2023-12-20 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1415	29.5	62.0	5.9	clear	2023-12-20 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1416	25.6	77.0	6.2	clear	2023-12-20 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1417	21.8	91.0	2.5	cloudy	2023-12-21 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1418	20.2	88.0	3.3	cloudy	2023-12-21 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1419	28.5	66.0	1.5	rainy	2023-12-21 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1420	24.9	84.0	3.6	cloudy	2023-12-21 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1421	22.6	93.0	4.1	cloudy	2023-12-22 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1422	21.4	91.0	3.2	cloudy	2023-12-22 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1423	26.1	78.0	8.5	rainy	2023-12-22 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.90	1
1424	24.2	86.0	5.4	clear	2023-12-22 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1425	21.3	94.0	3.8	clear	2023-12-23 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1426	21.0	83.0	2.1	cloudy	2023-12-23 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1427	29.0	61.0	14.0	cloudy	2023-12-23 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1428	24.5	84.0	5.8	cloudy	2023-12-23 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1429	22.3	88.0	0.0	rainy	2023-12-24 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1430	21.2	89.0	2.9	cloudy	2023-12-24 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1431	28.3	67.0	15.7	rainy	2023-12-24 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.40	1
1432	24.6	87.0	5.9	cloudy	2023-12-24 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1433	23.5	87.0	1.1	rainy	2023-12-25 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.10	1
1434	23.4	83.0	0.5	cloudy	2023-12-25 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1435	24.9	89.0	1.0	rainy	2023-12-25 12:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.70	1
1436	24.5	84.0	0.4	cloudy	2023-12-25 18:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1437	23.0	90.0	1.9	clear	2023-12-26 00:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1438	21.5	89.0	2.4	cloudy	2023-12-26 06:00:00	2026-02-12 08:44:32	2026-02-12 08:44:32	0.00	1
1439	28.5	71.0	11.9	rainy	2023-12-26 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1440	25.8	78.0	2.3	cloudy	2023-12-26 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1441	23.5	90.0	1.6	rainy	2023-12-27 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.60	1
1442	22.1	94.0	2.1	cloudy	2023-12-27 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1443	29.6	60.0	12.5	cloudy	2023-12-27 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1444	25.5	80.0	1.6	cloudy	2023-12-27 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1445	22.2	92.0	2.5	cloudy	2023-12-28 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1446	22.0	87.0	1.5	clear	2023-12-28 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1447	28.7	67.0	15.0	rainy	2023-12-28 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1448	24.7	82.0	5.5	cloudy	2023-12-28 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1449	22.6	90.0	4.0	cloudy	2023-12-29 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1450	21.0	84.0	3.2	cloudy	2023-12-29 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1451	29.1	70.0	8.4	clear	2023-12-29 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1452	24.5	91.0	3.1	cloudy	2023-12-29 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1453	23.6	93.0	2.3	cloudy	2023-12-30 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1454	22.9	94.0	2.5	cloudy	2023-12-30 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1455	28.5	72.0	9.5	rainy	2023-12-30 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1456	24.6	90.0	2.5	rainy	2023-12-30 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1457	23.0	94.0	3.3	cloudy	2023-12-31 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1458	21.1	96.0	5.0	cloudy	2023-12-31 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1459	29.8	63.0	4.4	rainy	2023-12-31 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1460	26.8	77.0	3.4	cloudy	2023-12-31 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1461	22.9	96.0	3.2	cloudy	2024-01-01 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1462	21.9	89.0	2.9	cloudy	2024-01-01 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1463	28.0	78.0	9.0	rainy	2024-01-01 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1464	24.8	89.0	3.9	cloudy	2024-01-01 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1465	22.8	97.0	4.1	cloudy	2024-01-02 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1466	22.4	94.0	6.8	rainy	2024-01-02 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	2.50	1
1467	26.9	75.0	6.5	rainy	2024-01-02 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1468	24.4	91.0	6.1	cloudy	2024-01-02 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1469	22.5	95.0	2.5	rainy	2024-01-03 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1470	21.8	89.0	2.9	cloudy	2024-01-03 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1471	28.2	75.0	7.1	rainy	2024-01-03 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1472	25.6	87.0	6.1	cloudy	2024-01-03 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1473	24.0	89.0	1.6	cloudy	2024-01-04 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1474	21.5	96.0	3.8	cloudy	2024-01-04 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1475	29.7	60.0	7.0	clear	2024-01-04 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1476	25.8	77.0	7.9	cloudy	2024-01-04 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1477	21.8	94.0	3.3	cloudy	2024-01-05 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1478	20.4	88.0	3.6	cloudy	2024-01-05 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1479	30.2	52.0	6.5	cloudy	2024-01-05 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1480	26.1	72.0	9.2	cloudy	2024-01-05 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1481	21.9	90.0	4.4	cloudy	2024-01-06 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1482	21.5	86.0	2.5	cloudy	2024-01-06 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1483	28.6	64.0	13.1	rainy	2024-01-06 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1484	25.1	83.0	1.5	cloudy	2024-01-06 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1485	22.6	95.0	3.1	cloudy	2024-01-07 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1486	21.1	91.0	2.9	cloudy	2024-01-07 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1487	29.1	65.0	11.8	rainy	2024-01-07 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1488	25.2	80.0	5.1	cloudy	2024-01-07 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1489	22.1	92.0	2.9	cloudy	2024-01-08 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1490	21.8	87.0	3.2	rainy	2024-01-08 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1491	29.0	60.0	18.1	cloudy	2024-01-08 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1492	26.0	69.0	8.5	cloudy	2024-01-08 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1493	23.2	94.0	3.2	cloudy	2024-01-09 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1494	23.0	92.0	1.8	cloudy	2024-01-09 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1495	27.7	70.0	13.0	rainy	2024-01-09 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1496	25.0	86.0	5.5	cloudy	2024-01-09 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1497	23.9	88.0	1.5	cloudy	2024-01-10 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1498	24.4	79.0	0.8	clear	2024-01-10 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1499	29.3	65.0	6.6	rainy	2024-01-10 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1500	25.9	75.0	6.1	clear	2024-01-10 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1501	22.2	93.0	4.0	cloudy	2024-01-11 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1502	21.0	90.0	5.4	cloudy	2024-01-11 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1503	30.2	57.0	15.0	cloudy	2024-01-11 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1504	26.2	70.0	8.7	cloudy	2024-01-11 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1505	21.9	90.0	3.4	cloudy	2024-01-12 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1506	20.7	86.0	3.6	cloudy	2024-01-12 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1507	29.6	55.0	14.2	cloudy	2024-01-12 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1508	25.4	76.0	9.6	cloudy	2024-01-12 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1509	22.2	93.0	2.9	cloudy	2024-01-13 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1510	20.2	87.0	3.3	cloudy	2024-01-13 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1511	29.0	61.0	18.5	rainy	2024-01-13 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1512	24.9	77.0	7.6	cloudy	2024-01-13 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1513	21.2	91.0	2.3	cloudy	2024-01-14 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1514	22.5	87.0	3.4	rainy	2024-01-14 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1515	28.5	63.0	19.3	rainy	2024-01-14 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1516	25.0	78.0	7.4	cloudy	2024-01-14 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1517	23.0	87.0	3.3	cloudy	2024-01-15 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1518	22.4	90.0	5.2	cloudy	2024-01-15 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1519	28.7	68.0	11.8	cloudy	2024-01-15 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1520	24.2	91.0	3.8	rainy	2024-01-15 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1521	23.4	95.0	3.2	rainy	2024-01-16 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	4.40	1
1522	23.0	93.0	2.9	rainy	2024-01-16 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.70	1
1523	25.4	77.0	8.7	rainy	2024-01-16 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1524	23.8	81.0	7.1	cloudy	2024-01-16 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1525	23.0	88.0	3.8	cloudy	2024-01-17 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1526	23.0	87.0	3.8	cloudy	2024-01-17 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1527	26.0	76.0	16.4	rainy	2024-01-17 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1528	24.3	79.0	6.5	cloudy	2024-01-17 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1529	22.5	94.0	3.4	cloudy	2024-01-18 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1530	21.9	91.0	3.8	rainy	2024-01-18 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1531	26.9	78.0	8.7	rainy	2024-01-18 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1532	23.6	90.0	4.0	rainy	2024-01-18 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1533	23.1	89.0	3.3	cloudy	2024-01-19 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1534	21.6	91.0	2.5	cloudy	2024-01-19 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1535	28.1	73.0	10.1	cloudy	2024-01-19 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1536	24.2	86.0	4.4	cloudy	2024-01-19 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1537	21.5	95.0	3.5	cloudy	2024-01-20 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1538	20.2	88.0	3.3	cloudy	2024-01-20 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1539	28.3	64.0	10.6	cloudy	2024-01-20 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1540	24.6	78.0	6.2	cloudy	2024-01-20 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1541	22.2	94.0	2.5	cloudy	2024-01-21 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1542	21.1	91.0	3.8	cloudy	2024-01-21 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1543	29.5	56.0	10.6	cloudy	2024-01-21 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1544	26.3	69.0	12.2	cloudy	2024-01-21 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1545	22.1	95.0	2.9	cloudy	2024-01-22 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1546	20.5	94.0	2.7	cloudy	2024-01-22 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1547	29.6	57.0	12.2	cloudy	2024-01-22 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1548	24.7	79.0	6.2	cloudy	2024-01-22 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1549	22.0	92.0	3.3	cloudy	2024-01-23 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1550	20.3	89.0	2.9	cloudy	2024-01-23 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1551	28.3	67.0	12.6	rainy	2024-01-23 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1552	24.8	77.0	7.1	cloudy	2024-01-23 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1553	20.9	93.0	3.6	cloudy	2024-01-24 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1554	17.8	91.0	5.8	clear	2024-01-24 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1555	30.0	51.0	7.9	cloudy	2024-01-24 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1556	25.2	75.0	9.4	cloudy	2024-01-24 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1557	22.2	94.0	1.6	rainy	2024-01-25 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	2.30	1
1558	22.2	91.0	3.9	cloudy	2024-01-25 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1559	29.0	55.0	16.7	cloudy	2024-01-25 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1560	25.0	67.0	8.9	cloudy	2024-01-25 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1561	20.5	89.0	4.3	cloudy	2024-01-26 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1562	19.4	86.0	3.7	cloudy	2024-01-26 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1563	26.8	70.0	11.8	cloudy	2024-01-26 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1564	24.0	79.0	12.3	rainy	2024-01-26 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1565	20.3	82.0	5.1	cloudy	2024-01-27 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1566	18.6	84.0	6.5	cloudy	2024-01-27 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1567	28.1	50.0	14.8	cloudy	2024-01-27 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1568	24.0	66.0	11.0	cloudy	2024-01-27 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1569	20.4	85.0	4.8	cloudy	2024-01-28 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1570	19.0	83.0	5.5	cloudy	2024-01-28 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1571	29.2	53.0	17.1	cloudy	2024-01-28 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1572	24.7	71.0	10.5	cloudy	2024-01-28 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1573	21.5	88.0	2.5	cloudy	2024-01-29 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1574	21.1	88.0	4.7	cloudy	2024-01-29 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1575	27.4	68.0	10.5	cloudy	2024-01-29 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1576	24.5	79.0	9.9	rainy	2024-01-29 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1577	23.0	90.0	4.1	rainy	2024-01-30 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1578	22.2	95.0	1.8	rainy	2024-01-30 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	10.60	1
1579	25.9	79.0	10.7	rainy	2024-01-30 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1580	24.2	90.0	4.0	rainy	2024-01-30 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1581	23.4	93.0	2.8	rainy	2024-01-31 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1582	22.6	91.0	2.2	rainy	2024-01-31 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1583	25.4	78.0	6.0	rainy	2024-01-31 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	1.20	1
1584	23.5	94.0	3.1	rainy	2024-01-31 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.50	1
1585	22.8	94.0	1.5	rainy	2024-02-01 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1586	22.3	93.0	2.7	rainy	2024-02-01 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	1.70	1
1587	27.0	81.0	8.4	rainy	2024-02-01 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.40	1
1588	23.9	91.0	4.8	rainy	2024-02-01 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1589	23.4	96.0	1.3	rainy	2024-02-02 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1590	22.4	95.0	1.5	cloudy	2024-02-02 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1591	27.1	72.0	15.0	cloudy	2024-02-02 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1592	23.9	90.0	4.0	cloudy	2024-02-02 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1593	23.2	91.0	2.9	cloudy	2024-02-03 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1594	19.2	97.0	3.3	clear	2024-02-03 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1595	29.2	58.0	16.1	cloudy	2024-02-03 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1596	24.5	85.0	2.5	rainy	2024-02-03 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1597	23.1	94.0	3.5	rainy	2024-02-04 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.60	1
1598	23.5	87.0	4.0	cloudy	2024-02-04 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1599	28.3	66.0	13.7	cloudy	2024-02-04 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1600	23.8	93.0	3.9	rainy	2024-02-04 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.50	1
1601	23.1	92.0	3.1	rainy	2024-02-05 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1602	19.5	95.0	3.7	cloudy	2024-02-05 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1603	28.7	55.0	8.3	cloudy	2024-02-05 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1604	24.0	75.0	7.9	cloudy	2024-02-05 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1605	20.5	87.0	2.9	cloudy	2024-02-06 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1606	18.8	86.0	2.6	cloudy	2024-02-06 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1607	25.8	75.0	0.4	cloudy	2024-02-06 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1608	26.1	62.0	4.8	cloudy	2024-02-06 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1609	21.9	91.0	3.1	cloudy	2024-02-07 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1610	21.0	92.0	2.9	cloudy	2024-02-07 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1611	26.3	80.0	2.6	rainy	2024-02-07 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1612	24.1	89.0	1.5	rainy	2024-02-07 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.80	1
1613	22.1	96.0	3.8	cloudy	2024-02-08 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1614	21.4	92.0	3.6	cloudy	2024-02-08 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1615	25.4	80.0	2.6	cloudy	2024-02-08 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1616	24.5	85.0	5.4	cloudy	2024-02-08 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1617	23.5	93.0	2.7	rainy	2024-02-09 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1618	21.4	97.0	3.7	cloudy	2024-02-09 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1619	28.3	69.0	9.4	cloudy	2024-02-09 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1620	24.9	76.0	12.1	cloudy	2024-02-09 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1621	20.9	91.0	5.1	cloudy	2024-02-10 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1622	19.1	90.0	4.1	clear	2024-02-10 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1623	28.7	60.0	17.7	cloudy	2024-02-10 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1624	24.9	72.0	10.9	cloudy	2024-02-10 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1625	23.2	86.0	3.4	cloudy	2024-02-11 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1626	20.8	86.0	4.2	cloudy	2024-02-11 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1627	27.0	64.0	19.0	cloudy	2024-02-11 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1628	24.5	74.0	13.0	clear	2024-02-11 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1629	21.1	85.0	4.7	cloudy	2024-02-12 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1630	20.5	86.0	7.4	cloudy	2024-02-12 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1631	28.4	62.0	19.5	cloudy	2024-02-12 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1632	24.3	76.0	12.7	cloudy	2024-02-12 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1633	19.4	94.0	4.0	cloudy	2024-02-13 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1634	19.4	79.0	2.4	cloudy	2024-02-13 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1635	28.5	53.0	19.6	cloudy	2024-02-13 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1636	24.6	67.0	12.8	cloudy	2024-02-13 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1637	21.6	88.0	3.7	cloudy	2024-02-14 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1638	20.5	85.0	2.9	clear	2024-02-14 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1639	28.1	61.0	21.0	cloudy	2024-02-14 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1640	24.6	68.0	11.5	clear	2024-02-14 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1641	20.5	89.0	0.5	cloudy	2024-02-15 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1642	19.5	79.0	6.6	clear	2024-02-15 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1643	28.9	57.0	14.8	cloudy	2024-02-15 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1644	25.0	73.0	6.0	clear	2024-02-15 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1645	23.8	84.0	2.3	cloudy	2024-02-16 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1646	22.2	88.0	2.9	cloudy	2024-02-16 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1647	28.5	64.0	9.6	cloudy	2024-02-16 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1648	25.0	77.0	6.8	cloudy	2024-02-16 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1649	21.9	90.0	2.6	clear	2024-02-17 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1650	19.6	91.0	2.5	cloudy	2024-02-17 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1651	28.9	54.0	13.9	cloudy	2024-02-17 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1652	25.1	79.0	5.1	cloudy	2024-02-17 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1653	22.4	89.0	1.9	cloudy	2024-02-18 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1654	22.8	91.0	2.6	rainy	2024-02-18 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1655	28.5	69.0	17.2	rainy	2024-02-18 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1656	25.4	74.0	9.7	cloudy	2024-02-18 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1657	22.0	89.0	4.4	clear	2024-02-19 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1658	19.0	90.0	3.1	cloudy	2024-02-19 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1659	28.8	60.0	14.9	cloudy	2024-02-19 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1660	25.0	77.0	5.4	cloudy	2024-02-19 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1661	22.8	94.0	1.5	rainy	2024-02-20 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1662	21.2	90.0	1.9	rainy	2024-02-20 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1663	29.2	59.0	16.0	cloudy	2024-02-20 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1664	24.4	79.0	7.3	clear	2024-02-20 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1665	21.1	89.0	2.3	clear	2024-02-21 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1666	20.8	89.0	2.9	cloudy	2024-02-21 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1667	27.4	77.0	7.3	rainy	2024-02-21 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1668	24.9	85.0	3.7	cloudy	2024-02-21 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1669	24.1	92.0	1.1	rainy	2024-02-22 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1670	23.6	95.0	2.2	rainy	2024-02-22 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1671	27.0	80.0	8.0	rainy	2024-02-22 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1672	25.5	82.0	4.7	cloudy	2024-02-22 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1673	22.9	92.0	1.8	rainy	2024-02-23 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1674	23.1	90.0	0.4	rainy	2024-02-23 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1675	25.7	84.0	8.5	rainy	2024-02-23 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1676	25.0	82.0	4.7	cloudy	2024-02-23 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1677	23.6	90.0	1.9	cloudy	2024-02-24 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1678	21.8	93.0	2.7	clear	2024-02-24 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1679	30.6	54.0	12.3	clear	2024-02-24 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1680	26.0	76.0	8.7	cloudy	2024-02-24 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1681	21.6	96.0	5.3	clear	2024-02-25 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1682	20.0	90.0	2.6	cloudy	2024-02-25 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1683	29.1	57.0	14.6	cloudy	2024-02-25 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1684	25.0	77.0	9.5	cloudy	2024-02-25 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1685	23.0	88.0	3.9	clear	2024-02-26 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1686	19.5	94.0	4.7	cloudy	2024-02-26 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1687	29.6	51.0	14.7	cloudy	2024-02-26 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1764	26.0	68.0	13.0	cloudy	2024-03-16 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1688	24.9	75.0	8.7	cloudy	2024-02-26 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1689	22.8	86.0	4.3	cloudy	2024-02-27 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1690	22.0	90.0	3.7	cloudy	2024-02-27 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1691	29.3	53.0	20.4	cloudy	2024-02-27 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1692	25.0	70.0	12.4	cloudy	2024-02-27 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1693	21.2	87.0	4.8	clear	2024-02-28 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1694	20.4	78.0	2.9	cloudy	2024-02-28 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1695	27.9	59.0	17.1	cloudy	2024-02-28 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1696	24.5	75.0	7.6	cloudy	2024-02-28 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1697	23.5	78.0	3.7	cloudy	2024-02-29 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1698	23.1	86.0	5.6	cloudy	2024-02-29 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1699	28.4	65.0	18.0	rainy	2024-02-29 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1700	24.6	82.0	9.1	rainy	2024-02-29 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1701	24.1	83.0	2.6	cloudy	2024-03-01 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1702	23.3	86.0	1.1	cloudy	2024-03-01 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1703	29.1	60.0	15.0	cloudy	2024-03-01 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1704	25.4	75.0	14.0	cloudy	2024-03-01 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1705	23.0	87.0	2.9	cloudy	2024-03-02 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1706	20.2	95.0	6.6	cloudy	2024-03-02 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1707	31.2	45.0	12.9	cloudy	2024-03-02 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1708	25.8	71.0	15.5	cloudy	2024-03-02 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1709	22.9	88.0	2.9	cloudy	2024-03-03 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1710	19.5	95.0	6.5	cloudy	2024-03-03 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1711	29.7	48.0	12.6	cloudy	2024-03-03 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1712	25.8	59.0	10.4	cloudy	2024-03-03 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1713	21.4	92.0	3.1	cloudy	2024-03-04 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1714	19.3	88.0	6.6	cloudy	2024-03-04 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1715	29.4	55.0	13.0	cloudy	2024-03-04 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1716	25.9	69.0	12.3	cloudy	2024-03-04 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1717	22.2	85.0	2.5	clear	2024-03-05 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1718	20.5	87.0	4.3	clear	2024-03-05 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1719	29.5	57.0	11.5	rainy	2024-03-05 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1720	26.1	75.0	12.2	cloudy	2024-03-05 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1721	23.6	91.0	4.0	cloudy	2024-03-06 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1722	21.1	94.0	7.2	cloudy	2024-03-06 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1723	31.2	52.0	9.5	rainy	2024-03-06 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1724	27.2	70.0	12.6	clear	2024-03-06 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1725	23.5	89.0	2.5	cloudy	2024-03-07 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1726	21.1	93.0	4.5	cloudy	2024-03-07 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1727	31.8	42.0	15.2	cloudy	2024-03-07 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1728	27.0	65.0	15.9	cloudy	2024-03-07 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1729	22.5	84.0	4.2	cloudy	2024-03-08 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1730	19.0	92.0	6.6	cloudy	2024-03-08 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1731	31.5	44.0	20.5	cloudy	2024-03-08 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1732	26.1	72.0	10.1	cloudy	2024-03-08 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1733	24.1	84.0	2.2	cloudy	2024-03-09 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1734	20.5	96.0	3.3	cloudy	2024-03-09 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1735	30.7	47.0	20.3	cloudy	2024-03-09 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1736	25.9	68.0	15.2	clear	2024-03-09 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1737	22.4	88.0	1.8	cloudy	2024-03-10 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1738	20.2	88.0	1.3	cloudy	2024-03-10 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1739	31.4	45.0	19.9	cloudy	2024-03-10 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1740	26.6	61.0	16.3	clear	2024-03-10 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1741	20.4	91.0	3.6	clear	2024-03-11 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1742	18.5	81.0	4.0	cloudy	2024-03-11 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1743	29.4	47.0	17.4	cloudy	2024-03-11 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1744	26.0	60.0	5.6	cloudy	2024-03-11 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1745	21.0	86.0	5.5	cloudy	2024-03-12 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1746	21.1	75.0	3.0	cloudy	2024-03-12 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1747	29.5	61.0	12.2	cloudy	2024-03-12 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1748	25.3	83.0	2.6	rainy	2024-03-12 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.20	1
1749	23.8	90.0	1.5	rainy	2024-03-13 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1750	23.2	88.0	1.9	cloudy	2024-03-13 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1751	31.0	48.0	18.2	cloudy	2024-03-13 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1752	26.8	62.0	13.4	cloudy	2024-03-13 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1753	20.2	93.0	5.4	cloudy	2024-03-14 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1754	19.1	78.0	4.0	cloudy	2024-03-14 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1755	29.9	52.0	19.3	cloudy	2024-03-14 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1756	26.6	62.0	10.5	cloudy	2024-03-14 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1757	22.9	87.0	1.8	cloudy	2024-03-15 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1758	22.7	79.0	1.5	cloudy	2024-03-15 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1759	30.5	50.0	20.8	cloudy	2024-03-15 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1760	26.1	65.0	9.7	cloudy	2024-03-15 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1761	21.5	83.0	2.9	cloudy	2024-03-16 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1762	20.5	77.0	2.2	cloudy	2024-03-16 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1763	32.1	41.0	17.6	cloudy	2024-03-16 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1765	22.1	88.0	2.4	clear	2024-03-17 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1766	19.8	87.0	5.1	clear	2024-03-17 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1767	32.0	38.0	16.1	cloudy	2024-03-17 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1768	27.2	57.0	15.4	clear	2024-03-17 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1769	21.2	89.0	4.3	cloudy	2024-03-18 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1770	18.9	87.0	6.9	cloudy	2024-03-18 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1771	31.5	40.0	13.9	cloudy	2024-03-18 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1772	27.5	54.0	14.0	cloudy	2024-03-18 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1773	22.8	84.0	2.9	cloudy	2024-03-19 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1774	20.5	85.0	4.3	cloudy	2024-03-19 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1775	32.1	39.0	7.1	cloudy	2024-03-19 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1776	27.5	58.0	8.6	rainy	2024-03-19 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1777	24.0	82.0	3.2	cloudy	2024-03-20 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1778	20.9	92.0	3.8	cloudy	2024-03-20 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1779	32.7	39.0	12.2	cloudy	2024-03-20 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1780	27.4	64.0	13.7	cloudy	2024-03-20 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1781	23.4	86.0	2.5	cloudy	2024-03-21 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1782	21.4	85.0	5.1	cloudy	2024-03-21 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1783	31.5	51.0	13.0	rainy	2024-03-21 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1784	25.5	73.0	10.8	rainy	2024-03-21 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1785	23.7	83.0	2.7	rainy	2024-03-22 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.10	1
1786	21.4	93.0	3.1	cloudy	2024-03-22 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1787	31.5	41.0	14.1	clear	2024-03-22 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1788	27.5	52.0	16.2	clear	2024-03-22 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1789	22.1	79.0	3.0	clear	2024-03-23 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1790	20.1	80.0	4.4	clear	2024-03-23 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1791	31.4	44.0	17.7	cloudy	2024-03-23 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1792	26.9	60.0	14.8	cloudy	2024-03-23 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1793	21.9	86.0	2.2	cloudy	2024-03-24 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1794	21.9	77.0	2.3	cloudy	2024-03-24 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1795	31.5	49.0	19.4	rainy	2024-03-24 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1796	26.8	59.0	14.0	cloudy	2024-03-24 18:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1797	23.6	81.0	1.1	cloudy	2024-03-25 00:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1798	23.9	76.0	3.6	cloudy	2024-03-25 06:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.00	1
1799	31.8	50.0	17.3	rainy	2024-03-25 12:00:00	2026-02-12 08:44:33	2026-02-12 08:44:33	0.30	1
1800	27.6	69.0	10.5	cloudy	2024-03-25 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1801	24.9	85.0	1.6	cloudy	2024-03-26 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1802	23.4	89.0	5.0	cloudy	2024-03-26 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1803	32.5	49.0	12.6	rainy	2024-03-26 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1804	28.3	64.0	4.3	cloudy	2024-03-26 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1805	24.2	91.0	1.8	cloudy	2024-03-27 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1806	22.6	82.0	4.3	cloudy	2024-03-27 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1807	33.1	45.0	17.7	rainy	2024-03-27 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1808	27.6	67.0	12.3	cloudy	2024-03-27 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1809	24.2	88.0	1.9	cloudy	2024-03-28 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1810	22.6	82.0	4.0	cloudy	2024-03-28 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1811	31.6	52.0	16.4	rainy	2024-03-28 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1812	27.0	73.0	10.1	cloudy	2024-03-28 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1813	23.9	88.0	0.8	cloudy	2024-03-29 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1814	22.5	86.0	5.8	clear	2024-03-29 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1815	31.4	52.0	16.3	cloudy	2024-03-29 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1816	26.1	71.0	11.3	cloudy	2024-03-29 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1817	23.5	86.0	0.8	clear	2024-03-30 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1818	21.0	90.0	4.0	clear	2024-03-30 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1819	32.5	41.0	11.6	cloudy	2024-03-30 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1820	27.5	64.0	16.7	clear	2024-03-30 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1821	23.0	91.0	2.5	clear	2024-03-31 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1822	24.0	81.0	1.5	cloudy	2024-03-31 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1823	31.9	49.0	16.2	cloudy	2024-03-31 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1824	27.5	62.0	14.8	clear	2024-03-31 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1825	21.1	91.0	5.4	cloudy	2024-04-01 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1826	20.9	71.0	4.8	cloudy	2024-04-01 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1827	33.2	39.0	16.4	cloudy	2024-04-01 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1828	27.9	57.0	15.0	cloudy	2024-04-01 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1829	22.8	80.0	2.2	cloudy	2024-04-02 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1830	22.0	78.0	2.2	cloudy	2024-04-02 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1831	32.0	44.0	18.2	cloudy	2024-04-02 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1832	27.0	64.0	13.8	cloudy	2024-04-02 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1833	23.0	87.0	1.6	clear	2024-04-03 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1834	21.2	80.0	6.2	cloudy	2024-04-03 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1835	32.3	39.0	15.9	cloudy	2024-04-03 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1836	29.1	49.0	9.8	clear	2024-04-03 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1837	24.1	84.0	5.2	cloudy	2024-04-04 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1838	22.8	78.0	3.0	cloudy	2024-04-04 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1839	32.2	46.0	16.0	rainy	2024-04-04 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1840	27.7	60.0	14.6	cloudy	2024-04-04 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1841	24.0	84.0	2.6	cloudy	2024-04-05 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1842	23.0	79.0	1.9	cloudy	2024-04-05 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1843	32.2	48.0	19.2	rainy	2024-04-05 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1844	27.5	65.0	13.5	cloudy	2024-04-05 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1845	24.4	84.0	2.3	cloudy	2024-04-06 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1846	24.5	74.0	0.8	cloudy	2024-04-06 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1847	28.7	67.0	14.0	rainy	2024-04-06 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1848	26.8	67.0	14.2	cloudy	2024-04-06 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1849	23.9	84.0	0.0	cloudy	2024-04-07 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1850	21.9	90.0	0.4	clear	2024-04-07 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1851	31.8	43.0	19.6	cloudy	2024-04-07 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1852	27.5	61.0	11.7	clear	2024-04-07 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1853	21.1	88.0	5.4	cloudy	2024-04-08 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1854	19.9	70.0	5.1	clear	2024-04-08 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1855	32.5	43.0	13.1	rainy	2024-04-08 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1856	26.8	71.0	5.5	cloudy	2024-04-08 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1857	22.8	94.0	2.5	clear	2024-04-09 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1858	20.6	77.0	4.4	cloudy	2024-04-09 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1859	32.7	42.0	15.8	rainy	2024-04-09 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1860	28.0	61.0	16.7	clear	2024-04-09 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1861	24.3	84.0	2.1	cloudy	2024-04-10 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1862	23.2	86.0	3.6	rainy	2024-04-10 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1863	32.0	48.0	15.4	rainy	2024-04-10 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1864	26.5	70.0	14.1	cloudy	2024-04-10 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1865	23.5	86.0	5.8	cloudy	2024-04-11 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1866	20.0	93.0	5.2	cloudy	2024-04-11 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1867	33.2	36.0	14.7	cloudy	2024-04-11 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1868	28.4	60.0	15.5	cloudy	2024-04-11 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1869	24.0	85.0	1.8	cloudy	2024-04-12 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1870	21.5	86.0	6.4	cloudy	2024-04-12 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1871	33.2	38.0	15.5	cloudy	2024-04-12 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1872	28.2	59.0	15.5	clear	2024-04-12 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1873	24.5	81.0	6.1	cloudy	2024-04-13 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1874	21.5	93.0	6.5	cloudy	2024-04-13 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1875	32.5	42.0	13.5	rainy	2024-04-13 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1876	28.1	62.0	18.1	clear	2024-04-13 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1877	24.5	81.0	3.4	cloudy	2024-04-14 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1878	22.0	83.0	3.6	cloudy	2024-04-14 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1879	32.9	42.0	15.1	cloudy	2024-04-14 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1880	28.5	61.0	12.8	clear	2024-04-14 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1881	23.8	89.0	1.9	cloudy	2024-04-15 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1882	23.2	74.0	4.5	clear	2024-04-15 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1883	33.0	50.0	15.8	cloudy	2024-04-15 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1884	27.6	66.0	12.7	cloudy	2024-04-15 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1885	23.9	90.0	2.5	cloudy	2024-04-16 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1886	22.0	87.0	4.2	cloudy	2024-04-16 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1887	33.3	40.0	12.9	cloudy	2024-04-16 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1888	27.6	67.0	14.4	cloudy	2024-04-16 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1889	25.0	83.0	1.5	cloudy	2024-04-17 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1890	22.9	87.0	4.7	cloudy	2024-04-17 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1891	34.1	35.0	16.1	cloudy	2024-04-17 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1892	29.1	57.0	16.5	cloudy	2024-04-17 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1893	23.9	87.0	1.9	cloudy	2024-04-18 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1894	21.8	86.0	6.7	cloudy	2024-04-18 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1895	34.1	37.0	13.4	cloudy	2024-04-18 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1896	29.6	54.0	15.3	cloudy	2024-04-18 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1897	25.0	81.0	3.3	cloudy	2024-04-19 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1898	22.9	86.0	5.2	cloudy	2024-04-19 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1899	33.0	44.0	15.9	cloudy	2024-04-19 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1900	28.4	60.0	18.5	clear	2024-04-19 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1901	23.0	85.0	3.8	cloudy	2024-04-20 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1902	21.4	78.0	5.5	cloudy	2024-04-20 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1903	34.8	35.0	21.0	cloudy	2024-04-20 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1904	27.8	59.0	17.7	cloudy	2024-04-20 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1905	24.0	82.0	2.2	cloudy	2024-04-21 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1906	24.5	74.0	3.2	cloudy	2024-04-21 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1907	29.4	67.0	12.4	rainy	2024-04-21 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1908	26.5	78.0	4.2	cloudy	2024-04-21 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1909	24.4	92.0	1.4	cloudy	2024-04-22 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1910	24.0	90.0	5.8	cloudy	2024-04-22 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1911	34.0	43.0	16.9	cloudy	2024-04-22 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1912	28.0	69.0	13.0	cloudy	2024-04-22 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1913	25.5	79.0	2.3	rainy	2024-04-23 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1914	25.1	82.0	1.1	cloudy	2024-04-23 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1915	34.0	42.0	21.3	cloudy	2024-04-23 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1916	27.3	68.0	10.1	cloudy	2024-04-23 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1917	25.6	80.0	1.1	cloudy	2024-04-24 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1918	25.7	77.0	1.8	cloudy	2024-04-24 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1919	33.5	47.0	16.9	cloudy	2024-04-24 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1920	28.0	67.0	9.8	cloudy	2024-04-24 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1921	24.0	86.0	1.0	cloudy	2024-04-25 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1922	23.1	77.0	4.4	clear	2024-04-25 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1923	35.3	29.0	11.6	cloudy	2024-04-25 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1924	30.5	51.0	13.8	clear	2024-04-25 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1925	25.7	80.0	1.6	clear	2024-04-26 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1926	24.9	81.0	3.6	cloudy	2024-04-26 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1927	34.5	43.0	18.8	clear	2024-04-26 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1928	26.8	75.0	4.3	rainy	2024-04-26 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.50	1
1929	24.8	92.0	2.5	cloudy	2024-04-27 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1930	24.4	91.0	3.3	cloudy	2024-04-27 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1931	32.3	54.0	15.0	cloudy	2024-04-27 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1932	26.4	79.0	3.9	cloudy	2024-04-27 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1933	24.4	89.0	1.0	cloudy	2024-04-28 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1934	24.9	78.0	1.5	cloudy	2024-04-28 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1935	33.2	45.0	16.9	cloudy	2024-04-28 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1936	28.5	60.0	13.1	cloudy	2024-04-28 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1937	23.5	88.0	5.2	cloudy	2024-04-29 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1938	24.3	70.0	1.8	cloudy	2024-04-29 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1939	32.8	50.0	15.8	cloudy	2024-04-29 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1940	27.6	70.0	14.2	cloudy	2024-04-29 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1941	24.5	90.0	1.9	rainy	2024-04-30 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.10	1
1942	24.1	92.0	2.4	cloudy	2024-04-30 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1943	27.9	72.0	15.5	rainy	2024-04-30 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.80	1
1944	26.1	83.0	1.1	rainy	2024-04-30 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1945	24.0	92.0	0.4	cloudy	2024-05-01 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1946	22.4	88.0	5.1	cloudy	2024-05-01 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1947	32.7	48.0	13.3	cloudy	2024-05-01 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1948	26.8	74.0	10.9	rainy	2024-05-01 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.00	1
1949	24.8	86.0	2.5	cloudy	2024-05-02 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1950	22.5	93.0	5.2	cloudy	2024-05-02 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1951	33.8	40.0	11.6	cloudy	2024-05-02 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1952	27.9	65.0	19.4	cloudy	2024-05-02 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1953	23.5	86.0	3.1	cloudy	2024-05-03 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1954	21.9	82.0	5.1	clear	2024-05-03 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1955	33.7	36.0	12.7	cloudy	2024-05-03 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1956	28.2	60.0	19.4	cloudy	2024-05-03 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1957	25.3	74.0	0.4	cloudy	2024-05-04 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1958	24.5	76.0	2.5	cloudy	2024-05-04 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1959	31.9	49.0	10.8	cloudy	2024-05-04 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1960	26.4	73.0	3.2	rainy	2024-05-04 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1961	24.3	89.0	2.8	cloudy	2024-05-05 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1962	22.2	91.0	5.1	cloudy	2024-05-05 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1963	34.0	41.0	16.7	cloudy	2024-05-05 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1964	29.0	56.0	18.1	cloudy	2024-05-05 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1965	25.2	84.0	1.5	cloudy	2024-05-06 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1966	24.1	83.0	3.4	cloudy	2024-05-06 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1967	34.5	39.0	14.5	cloudy	2024-05-06 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1968	27.3	72.0	6.8	rainy	2024-05-06 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1969	24.6	85.0	2.4	rainy	2024-05-07 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1970	23.6	94.0	2.4	cloudy	2024-05-07 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1971	33.3	43.0	7.6	cloudy	2024-05-07 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1972	28.5	66.0	13.7	cloudy	2024-05-07 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1973	24.6	86.0	3.7	cloudy	2024-05-08 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1974	22.7	95.0	5.2	cloudy	2024-05-08 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1975	34.0	39.0	10.1	rainy	2024-05-08 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1976	26.9	71.0	8.0	cloudy	2024-05-08 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1977	24.0	87.0	2.9	cloudy	2024-05-09 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1978	23.3	89.0	4.4	clear	2024-05-09 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1979	32.7	48.0	13.4	rainy	2024-05-09 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
1980	24.6	88.0	4.3	rainy	2024-05-09 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	2.30	1
1981	23.7	90.0	1.3	clear	2024-05-10 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1982	23.4	90.0	2.9	clear	2024-05-10 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1983	31.1	57.0	11.5	cloudy	2024-05-10 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1984	24.6	84.0	6.5	rainy	2024-05-10 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	2.40	1
1985	24.6	86.0	0.8	clear	2024-05-11 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1986	23.5	87.0	2.6	clear	2024-05-11 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1987	33.2	46.0	11.2	cloudy	2024-05-11 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1988	27.2	75.0	4.2	rainy	2024-05-11 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1989	24.4	92.0	2.2	clear	2024-05-12 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1990	24.1	87.0	2.0	cloudy	2024-05-12 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1991	30.6	60.0	8.4	rainy	2024-05-12 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1992	26.2	87.0	2.0	rainy	2024-05-12 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1993	24.5	93.0	1.8	cloudy	2024-05-13 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1994	23.7	86.0	3.7	cloudy	2024-05-13 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1995	31.7	57.0	15.9	cloudy	2024-05-13 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1996	27.0	75.0	2.9	rainy	2024-05-13 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
1997	24.4	94.0	2.3	cloudy	2024-05-14 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1998	23.2	90.0	2.6	cloudy	2024-05-14 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
1999	32.8	48.0	10.5	rainy	2024-05-14 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2000	28.8	63.0	12.8	cloudy	2024-05-14 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2001	25.0	86.0	2.2	rainy	2024-05-15 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2002	23.8	91.0	4.0	cloudy	2024-05-15 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2003	33.7	44.0	9.4	cloudy	2024-05-15 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2004	28.5	67.0	15.0	cloudy	2024-05-15 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2005	25.7	80.0	1.0	cloudy	2024-05-16 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2006	24.6	84.0	0.8	cloudy	2024-05-16 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2007	33.5	44.0	5.5	cloudy	2024-05-16 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2008	25.7	82.0	3.6	rainy	2024-05-16 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.90	1
2009	24.7	87.0	2.2	cloudy	2024-05-17 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2010	22.5	95.0	6.2	cloudy	2024-05-17 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2011	33.3	45.0	13.2	cloudy	2024-05-17 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2012	29.4	52.0	9.4	cloudy	2024-05-17 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2013	23.7	81.0	3.3	cloudy	2024-05-18 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2014	22.9	83.0	4.3	clear	2024-05-18 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2015	33.8	39.0	8.2	clear	2024-05-18 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2016	30.5	51.0	3.7	rainy	2024-05-18 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.30	1
2017	25.3	81.0	2.1	cloudy	2024-05-19 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2018	23.0	95.0	2.3	cloudy	2024-05-19 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2019	33.4	45.0	6.8	cloudy	2024-05-19 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2020	29.3	62.0	10.6	cloudy	2024-05-19 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2021	25.3	84.0	2.9	cloudy	2024-05-20 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2022	23.7	89.0	3.2	cloudy	2024-05-20 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2023	31.1	61.0	15.0	rainy	2024-05-20 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.60	1
2024	28.4	65.0	6.2	cloudy	2024-05-20 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2025	25.6	84.0	1.0	cloudy	2024-05-21 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2026	24.9	82.0	2.2	cloudy	2024-05-21 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2027	33.5	49.0	11.2	cloudy	2024-05-21 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2028	27.8	72.0	6.8	cloudy	2024-05-21 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2029	24.8	88.0	6.5	cloudy	2024-05-22 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2030	24.5	90.0	3.4	cloudy	2024-05-22 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2031	34.0	44.0	3.6	rainy	2024-05-22 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2032	25.2	83.0	16.1	rainy	2024-05-22 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.00	1
2033	25.0	86.0	0.8	cloudy	2024-05-23 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2034	23.9	92.0	4.2	cloudy	2024-05-23 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2035	34.1	39.0	13.1	cloudy	2024-05-23 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2036	28.0	72.0	8.7	cloudy	2024-05-23 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2037	24.9	90.0	1.1	cloudy	2024-05-24 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2038	24.1	92.0	2.5	rainy	2024-05-24 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2039	30.6	62.0	9.1	cloudy	2024-05-24 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2040	24.6	93.0	6.1	rainy	2024-05-24 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.70	1
2041	24.3	92.0	0.0	rainy	2024-05-25 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2042	23.6	95.0	2.7	cloudy	2024-05-25 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2043	29.2	71.0	7.4	rainy	2024-05-25 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2044	28.3	71.0	2.6	cloudy	2024-05-25 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2045	24.0	94.0	2.9	cloudy	2024-05-26 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2046	24.2	87.0	1.0	cloudy	2024-05-26 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2047	31.2	57.0	8.0	cloudy	2024-05-26 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2048	25.0	89.0	4.5	rainy	2024-05-26 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.40	1
2049	23.7	97.0	2.1	cloudy	2024-05-27 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2050	23.6	93.0	4.1	cloudy	2024-05-27 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2051	30.6	64.0	4.2	cloudy	2024-05-27 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2052	24.6	91.0	1.8	rainy	2024-05-27 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2053	23.5	99.0	1.5	cloudy	2024-05-28 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2054	23.7	92.0	3.3	cloudy	2024-05-28 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2055	29.9	69.0	8.2	cloudy	2024-05-28 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2056	25.5	91.0	2.9	cloudy	2024-05-28 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2057	23.5	96.0	2.2	cloudy	2024-05-29 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2058	23.0	91.0	3.3	cloudy	2024-05-29 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2059	30.5	60.0	1.6	cloudy	2024-05-29 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2060	24.0	90.0	4.5	rainy	2024-05-29 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.40	1
2061	25.0	87.0	2.1	cloudy	2024-05-30 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2062	23.9	89.0	3.4	cloudy	2024-05-30 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2063	31.1	60.0	4.8	cloudy	2024-05-30 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2064	25.7	89.0	3.0	rainy	2024-05-30 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2065	24.0	95.0	2.2	cloudy	2024-05-31 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2066	23.5	90.0	4.3	clear	2024-05-31 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2067	31.2	62.0	15.2	cloudy	2024-05-31 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2068	26.2	86.0	3.9	cloudy	2024-05-31 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2069	24.3	91.0	5.1	rainy	2024-06-01 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.30	1
2070	24.5	89.0	2.2	cloudy	2024-06-01 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2071	31.1	61.0	17.3	rainy	2024-06-01 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2072	26.9	80.0	4.8	rainy	2024-06-01 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2073	23.5	94.0	3.7	cloudy	2024-06-02 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2074	23.2	87.0	4.7	cloudy	2024-06-02 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2075	31.5	57.0	5.4	cloudy	2024-06-02 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2076	27.1	80.0	4.1	cloudy	2024-06-02 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2077	22.6	97.0	5.8	rainy	2024-06-03 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.20	1
2078	22.8	94.0	2.0	cloudy	2024-06-03 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2079	29.8	68.0	10.0	cloudy	2024-06-03 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2080	25.7	82.0	6.5	rainy	2024-06-03 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2081	23.8	95.0	3.7	rainy	2024-06-04 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2082	22.6	96.0	5.0	cloudy	2024-06-04 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2083	28.1	73.0	4.4	rainy	2024-06-04 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2084	25.4	91.0	1.9	cloudy	2024-06-04 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2085	24.0	94.0	1.1	cloudy	2024-06-05 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2086	22.9	95.0	1.0	cloudy	2024-06-05 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2087	30.1	64.0	8.5	cloudy	2024-06-05 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2088	26.8	78.0	1.6	cloudy	2024-06-05 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2089	23.9	91.0	4.3	cloudy	2024-06-06 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2090	23.2	89.0	2.2	cloudy	2024-06-06 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2091	29.4	64.0	7.4	cloudy	2024-06-06 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2092	23.6	90.0	9.1	rainy	2024-06-06 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.50	1
2093	23.6	92.0	2.5	cloudy	2024-06-07 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2094	23.4	89.0	1.1	cloudy	2024-06-07 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2095	29.6	65.0	3.2	cloudy	2024-06-07 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2096	25.6	84.0	3.3	rainy	2024-06-07 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2097	23.5	91.0	1.5	cloudy	2024-06-08 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2098	23.4	89.0	2.7	cloudy	2024-06-08 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2099	30.0	66.0	2.4	rainy	2024-06-08 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2100	24.3	89.0	2.6	rainy	2024-06-08 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.40	1
2101	22.9	97.0	3.6	cloudy	2024-06-09 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2102	22.9	96.0	3.6	cloudy	2024-06-09 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2103	30.3	63.0	5.8	cloudy	2024-06-09 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2104	24.5	91.0	3.4	rainy	2024-06-09 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.00	1
2105	24.0	89.0	2.9	cloudy	2024-06-10 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2106	23.4	89.0	0.8	cloudy	2024-06-10 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2107	26.3	83.0	3.9	rainy	2024-06-10 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	7.60	1
2108	24.6	92.0	2.5	rainy	2024-06-10 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2109	22.8	98.0	3.1	cloudy	2024-06-11 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2110	22.4	97.0	2.0	cloudy	2024-06-11 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2111	30.1	70.0	7.9	rainy	2024-06-11 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2112	24.4	87.0	0.0	rainy	2024-06-11 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.50	1
2113	22.4	98.0	2.6	cloudy	2024-06-12 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2114	22.6	92.0	2.1	cloudy	2024-06-12 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2115	29.5	71.0	2.8	rainy	2024-06-12 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2116	24.6	87.0	0.4	rainy	2024-06-12 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2117	24.1	92.0	2.3	cloudy	2024-06-13 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2118	22.9	97.0	0.4	cloudy	2024-06-13 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2119	27.3	76.0	2.7	rainy	2024-06-13 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2120	23.8	93.0	1.8	rainy	2024-06-13 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2121	22.5	98.0	1.8	cloudy	2024-06-14 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2122	22.1	97.0	1.6	cloudy	2024-06-14 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2123	28.1	75.0	9.2	cloudy	2024-06-14 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2124	24.6	89.0	1.5	rainy	2024-06-14 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.50	1
2125	23.4	92.0	1.6	cloudy	2024-06-15 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2126	22.1	94.0	2.6	cloudy	2024-06-15 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2127	28.0	73.0	4.8	cloudy	2024-06-15 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2128	23.8	91.0	2.4	rainy	2024-06-15 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.00	1
2129	23.0	94.0	2.9	rainy	2024-06-16 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.50	1
2130	22.8	94.0	1.5	cloudy	2024-06-16 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2131	30.1	66.0	2.1	rainy	2024-06-16 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2132	24.0	93.0	5.9	rainy	2024-06-16 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.90	1
2133	22.1	95.0	2.2	rainy	2024-06-17 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2134	22.5	92.0	2.3	cloudy	2024-06-17 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2135	28.8	67.0	2.9	cloudy	2024-06-17 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2136	24.4	90.0	4.1	rainy	2024-06-17 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.30	1
2137	23.6	96.0	1.3	cloudy	2024-06-18 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2138	22.1	93.0	1.9	cloudy	2024-06-18 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2139	29.1	69.0	0.7	cloudy	2024-06-18 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2140	22.6	96.0	2.8	rainy	2024-06-18 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	5.80	1
2141	22.6	96.0	1.5	rainy	2024-06-19 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2142	22.9	96.0	2.5	cloudy	2024-06-19 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2143	23.9	92.0	5.1	rainy	2024-06-19 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.70	1
2144	22.6	99.0	5.5	rainy	2024-06-19 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.90	1
2145	22.4	95.0	1.6	rainy	2024-06-20 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.30	1
2146	22.1	97.0	1.3	rainy	2024-06-20 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2147	25.1	82.0	9.7	rainy	2024-06-20 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2148	23.3	96.0	4.7	rainy	2024-06-20 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.60	1
2149	23.4	92.0	1.3	rainy	2024-06-21 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2150	22.5	92.0	2.5	cloudy	2024-06-21 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2151	28.5	71.0	9.1	cloudy	2024-06-21 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2152	25.1	88.0	2.1	rainy	2024-06-21 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2153	23.6	94.0	2.0	rainy	2024-06-22 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2154	23.0	96.0	2.5	cloudy	2024-06-22 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2155	27.4	79.0	10.1	rainy	2024-06-22 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	3.90	1
2156	25.1	83.0	1.3	cloudy	2024-06-22 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2157	23.5	96.0	0.8	rainy	2024-06-23 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2158	22.0	96.0	2.7	cloudy	2024-06-23 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2159	29.5	69.0	8.9	rainy	2024-06-23 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2160	24.0	91.0	1.8	rainy	2024-06-23 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2161	22.9	96.0	2.4	cloudy	2024-06-24 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2162	21.8	95.0	2.6	cloudy	2024-06-24 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2163	28.5	74.0	6.9	rainy	2024-06-24 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2164	24.3	88.0	1.9	rainy	2024-06-24 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	1.30	1
2165	24.0	94.0	2.1	rainy	2024-06-25 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.30	1
2166	23.1	90.0	3.8	cloudy	2024-06-25 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2167	29.8	64.0	9.7	rainy	2024-06-25 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2168	24.6	85.0	1.3	rainy	2024-06-25 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.20	1
2169	24.5	86.0	2.9	cloudy	2024-06-26 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2170	23.4	85.0	2.5	cloudy	2024-06-26 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2171	27.0	77.0	6.1	rainy	2024-06-26 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2172	23.4	94.0	3.3	rainy	2024-06-26 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.90	1
2173	22.2	95.0	2.5	cloudy	2024-06-27 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2174	21.8	93.0	3.4	cloudy	2024-06-27 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2175	29.0	70.0	2.9	cloudy	2024-06-27 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2176	25.4	84.0	0.5	cloudy	2024-06-27 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2177	22.9	95.0	3.7	cloudy	2024-06-28 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2178	22.5	88.0	2.6	cloudy	2024-06-28 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2179	29.4	66.0	12.0	cloudy	2024-06-28 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2180	26.7	79.0	4.0	cloudy	2024-06-28 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2181	23.1	95.0	3.7	rainy	2024-06-29 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2182	23.0	89.0	2.2	cloudy	2024-06-29 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2183	30.0	64.0	5.6	cloudy	2024-06-29 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2184	26.5	74.0	9.3	cloudy	2024-06-29 18:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2185	23.4	89.0	3.3	cloudy	2024-06-30 00:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2186	22.6	89.0	3.7	cloudy	2024-06-30 06:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.00	1
2187	28.6	72.0	4.2	rainy	2024-06-30 12:00:00	2026-02-12 08:44:34	2026-02-12 08:44:34	0.10	1
2188	23.2	94.0	3.7	rainy	2024-06-30 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.90	1
2189	22.6	96.0	1.6	cloudy	2024-07-01 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2190	22.3	97.0	3.6	rainy	2024-07-01 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2191	25.7	87.0	4.4	rainy	2024-07-01 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2192	23.9	92.0	3.4	rainy	2024-07-01 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2193	22.4	96.0	2.6	rainy	2024-07-02 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2194	22.8	94.0	0.8	rainy	2024-07-02 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2195	28.5	73.0	1.6	rainy	2024-07-02 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2196	23.0	93.0	3.7	rainy	2024-07-02 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.60	1
2197	23.5	92.0	1.3	cloudy	2024-07-03 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2198	22.0	92.0	1.6	cloudy	2024-07-03 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2199	29.2	70.0	3.3	clear	2024-07-03 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2200	24.4	86.0	3.7	rainy	2024-07-03 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2201	22.8	94.0	3.6	cloudy	2024-07-04 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2202	21.9	99.0	2.5	cloudy	2024-07-04 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2203	27.0	82.0	2.3	rainy	2024-07-04 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2204	23.8	92.0	5.1	rainy	2024-07-04 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2205	23.0	91.0	1.8	cloudy	2024-07-05 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2206	21.6	97.0	5.2	cloudy	2024-07-05 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2207	27.8	72.0	2.1	cloudy	2024-07-05 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2208	24.0	89.0	3.1	rainy	2024-07-05 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2209	23.4	93.0	0.7	cloudy	2024-07-06 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2210	21.8	97.0	4.7	cloudy	2024-07-06 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2211	28.4	73.0	2.5	rainy	2024-07-06 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2212	23.4	90.0	5.9	rainy	2024-07-06 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2213	23.3	94.0	1.8	cloudy	2024-07-07 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2214	21.9	95.0	4.8	cloudy	2024-07-07 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2215	29.3	69.0	2.8	cloudy	2024-07-07 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2216	24.6	87.0	1.6	rainy	2024-07-07 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.40	1
2217	22.6	96.0	3.1	cloudy	2024-07-08 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2218	22.4	94.0	1.1	cloudy	2024-07-08 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2219	27.0	80.0	7.0	rainy	2024-07-08 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2220	23.8	95.0	2.3	rainy	2024-07-08 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2221	23.0	96.0	2.9	rainy	2024-07-09 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2222	22.0	98.0	2.5	rainy	2024-07-09 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2223	26.9	84.0	3.4	rainy	2024-07-09 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2224	23.6	92.0	2.4	rainy	2024-07-09 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.30	1
2225	23.3	96.0	3.3	rainy	2024-07-10 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2226	22.1	98.0	2.0	cloudy	2024-07-10 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2227	29.0	71.0	6.3	rainy	2024-07-10 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2228	24.2	89.0	3.1	rainy	2024-07-10 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.30	1
2229	22.9	95.0	3.2	rainy	2024-07-11 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2230	22.2	97.0	1.1	cloudy	2024-07-11 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2231	27.6	80.0	2.7	rainy	2024-07-11 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2232	23.4	94.0	3.3	rainy	2024-07-11 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	4.50	1
2233	22.8	98.0	2.9	rainy	2024-07-12 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2234	22.1	99.0	4.0	rainy	2024-07-12 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2235	26.9	84.0	5.0	rainy	2024-07-12 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2236	22.8	96.0	1.3	rainy	2024-07-12 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.10	1
2237	22.9	95.0	3.8	rainy	2024-07-13 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2238	22.4	96.0	2.7	cloudy	2024-07-13 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2239	26.3	86.0	10.1	rainy	2024-07-13 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.90	1
2240	23.3	94.0	2.5	rainy	2024-07-13 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2241	22.1	97.0	3.8	rainy	2024-07-14 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2242	21.4	97.0	2.3	cloudy	2024-07-14 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2243	25.1	81.0	3.3	cloudy	2024-07-14 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2244	22.8	93.0	2.6	rainy	2024-07-14 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2245	21.5	96.0	1.9	rainy	2024-07-15 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.00	1
2246	21.5	97.0	4.4	rainy	2024-07-15 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2247	26.3	85.0	3.9	rainy	2024-07-15 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2248	23.5	96.0	4.1	rainy	2024-07-15 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.20	1
2249	22.4	99.0	4.5	rainy	2024-07-16 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2250	21.6	99.0	2.9	cloudy	2024-07-16 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2251	25.6	84.0	7.3	rainy	2024-07-16 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2252	22.8	95.0	1.5	rainy	2024-07-16 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2253	22.0	96.0	2.4	rainy	2024-07-17 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2254	21.8	99.0	4.1	rainy	2024-07-17 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.90	1
2255	25.4	87.0	12.9	rainy	2024-07-17 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.30	1
2256	23.5	92.0	1.5	rainy	2024-07-17 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2257	22.9	96.0	2.2	rainy	2024-07-18 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2258	22.1	99.0	4.2	rainy	2024-07-18 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2259	23.8	95.0	7.2	rainy	2024-07-18 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2260	22.9	96.0	3.9	rainy	2024-07-18 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.70	1
2261	22.2	98.0	3.2	rainy	2024-07-19 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2262	21.4	99.0	5.1	cloudy	2024-07-19 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2263	23.9	93.0	6.4	rainy	2024-07-19 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2264	23.1	95.0	2.2	rainy	2024-07-19 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.70	1
2265	22.4	98.0	2.3	cloudy	2024-07-20 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2266	22.0	99.0	2.6	cloudy	2024-07-20 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2267	27.2	79.0	7.2	cloudy	2024-07-20 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2268	23.7	92.0	4.0	rainy	2024-07-20 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.30	1
2269	22.6	97.0	1.5	rainy	2024-07-21 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2270	22.2	97.0	0.8	rainy	2024-07-21 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2271	26.3	84.0	7.7	cloudy	2024-07-21 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2272	23.1	94.0	3.4	rainy	2024-07-21 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.70	1
2273	22.8	93.0	2.9	cloudy	2024-07-22 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2274	22.1	95.0	1.9	cloudy	2024-07-22 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2275	26.6	78.0	14.5	rainy	2024-07-22 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2276	24.0	92.0	4.0	rainy	2024-07-22 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.40	1
2277	22.1	95.0	3.4	cloudy	2024-07-23 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2278	22.0	98.0	4.2	cloudy	2024-07-23 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2279	25.6	82.0	7.8	rainy	2024-07-23 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2280	24.9	86.0	3.7	cloudy	2024-07-23 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2281	22.8	91.0	3.3	cloudy	2024-07-24 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2282	21.6	98.0	2.3	cloudy	2024-07-24 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2283	25.5	85.0	6.3	rainy	2024-07-24 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2284	25.0	91.0	2.6	cloudy	2024-07-24 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2285	23.5	90.0	4.4	cloudy	2024-07-25 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2286	22.1	90.0	4.0	cloudy	2024-07-25 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2287	26.9	77.0	4.3	rainy	2024-07-25 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2288	25.1	92.0	3.2	rainy	2024-07-25 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2289	24.0	94.0	1.5	cloudy	2024-07-26 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2290	22.7	96.0	1.9	cloudy	2024-07-26 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2291	28.9	69.0	5.5	cloudy	2024-07-26 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2292	25.0	86.0	4.6	rainy	2024-07-26 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.60	1
2293	24.1	88.0	2.6	cloudy	2024-07-27 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2294	22.5	90.0	1.5	cloudy	2024-07-27 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2295	25.3	83.0	5.0	rainy	2024-07-27 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2296	23.8	93.0	1.8	rainy	2024-07-27 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2297	22.6	89.0	2.5	cloudy	2024-07-28 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2298	21.5	91.0	2.2	cloudy	2024-07-28 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2299	27.5	79.0	6.2	rainy	2024-07-28 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2300	23.9	91.0	2.3	rainy	2024-07-28 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2301	22.2	98.0	1.3	cloudy	2024-07-29 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2302	21.7	98.0	1.1	cloudy	2024-07-29 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2303	29.0	67.0	2.6	cloudy	2024-07-29 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2304	24.6	89.0	5.2	rainy	2024-07-29 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.50	1
2305	22.6	96.0	1.8	rainy	2024-07-30 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2306	22.6	93.0	2.5	cloudy	2024-07-30 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2307	29.2	70.0	5.9	cloudy	2024-07-30 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2308	24.2	93.0	3.6	cloudy	2024-07-30 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2309	22.3	99.0	5.2	rainy	2024-07-31 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.10	1
2310	21.7	98.0	2.3	cloudy	2024-07-31 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2311	27.8	79.0	4.5	rainy	2024-07-31 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2312	23.3	91.0	2.6	rainy	2024-07-31 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2313	22.3	95.0	1.5	cloudy	2024-08-01 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2314	21.6	94.0	2.3	cloudy	2024-08-01 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2315	27.6	76.0	4.2	rainy	2024-08-01 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2316	22.9	94.0	4.7	rainy	2024-08-01 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2317	21.8	98.0	2.1	cloudy	2024-08-02 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2318	21.5	98.0	1.1	cloudy	2024-08-02 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2319	27.8	76.0	7.7	rainy	2024-08-02 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2320	23.2	91.0	1.4	rainy	2024-08-02 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.90	1
2321	22.5	93.0	2.6	cloudy	2024-08-03 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2322	21.9	96.0	2.3	cloudy	2024-08-03 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2323	27.6	77.0	8.5	rainy	2024-08-03 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2324	22.0	99.0	2.1	rainy	2024-08-03 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	4.70	1
2325	22.3	96.0	2.8	cloudy	2024-08-04 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2326	21.9	96.0	1.6	rainy	2024-08-04 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2327	26.6	80.0	11.8	cloudy	2024-08-04 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2328	24.4	89.0	2.9	rainy	2024-08-04 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2329	22.5	93.0	4.0	cloudy	2024-08-05 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2330	21.9	94.0	2.6	cloudy	2024-08-05 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2331	26.9	76.0	11.4	cloudy	2024-08-05 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2332	24.5	91.0	3.7	cloudy	2024-08-05 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2333	23.2	96.0	2.3	cloudy	2024-08-06 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2334	21.5	99.0	2.6	cloudy	2024-08-06 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2335	28.1	74.0	7.6	cloudy	2024-08-06 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2336	24.9	90.0	3.2	rainy	2024-08-06 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2337	23.2	95.0	1.3	cloudy	2024-08-07 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2338	21.4	97.0	4.3	cloudy	2024-08-07 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2339	28.8	71.0	2.8	cloudy	2024-08-07 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2340	23.9	92.0	2.7	cloudy	2024-08-07 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2341	23.5	94.0	3.4	cloudy	2024-08-08 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2342	22.2	93.0	4.5	cloudy	2024-08-08 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2343	29.3	69.0	3.3	cloudy	2024-08-08 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2344	24.0	91.0	1.8	cloudy	2024-08-08 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2345	23.4	94.0	1.5	cloudy	2024-08-09 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2346	22.6	93.0	1.0	cloudy	2024-08-09 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2347	28.9	71.0	4.8	cloudy	2024-08-09 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2348	23.5	90.0	1.8	rainy	2024-08-09 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2349	22.6	98.0	1.1	cloudy	2024-08-10 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2350	22.2	98.0	3.6	cloudy	2024-08-10 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2351	27.9	76.0	6.0	cloudy	2024-08-10 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2352	25.3	87.0	1.5	rainy	2024-08-10 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.30	1
2353	22.8	97.0	4.3	cloudy	2024-08-11 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2354	22.8	90.0	1.5	cloudy	2024-08-11 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2355	28.1	76.0	8.5	cloudy	2024-08-11 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2356	23.8	91.0	3.8	rainy	2024-08-11 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	6.50	1
2357	22.4	98.0	1.6	cloudy	2024-08-12 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2358	21.9	99.0	1.9	cloudy	2024-08-12 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2359	28.5	77.0	6.8	rainy	2024-08-12 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2360	23.1	93.0	0.7	rainy	2024-08-12 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.50	1
2361	23.1	92.0	2.2	cloudy	2024-08-13 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2362	22.0	91.0	1.3	cloudy	2024-08-13 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2363	27.5	76.0	1.1	rainy	2024-08-13 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2364	23.5	90.0	7.6	rainy	2024-08-13 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	5.60	1
2365	23.0	96.0	1.8	cloudy	2024-08-14 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2366	21.5	93.0	0.8	cloudy	2024-08-14 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2367	29.0	71.0	6.6	cloudy	2024-08-14 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2368	23.8	91.0	4.8	rainy	2024-08-14 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2369	23.6	91.0	0.7	cloudy	2024-08-15 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2370	22.1	93.0	2.4	cloudy	2024-08-15 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2371	29.5	66.0	1.1	rainy	2024-08-15 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2372	24.7	86.0	4.1	rainy	2024-08-15 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2373	23.0	92.0	3.1	cloudy	2024-08-16 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2374	21.5	91.0	3.0	cloudy	2024-08-16 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2375	29.4	68.0	1.8	cloudy	2024-08-16 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2376	24.7	89.0	4.6	rainy	2024-08-16 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2377	23.8	91.0	2.5	cloudy	2024-08-17 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2378	22.2	92.0	3.0	cloudy	2024-08-17 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2379	29.2	75.0	4.3	rainy	2024-08-17 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2380	25.4	88.0	3.3	rainy	2024-08-17 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2381	23.5	93.0	4.7	rainy	2024-08-18 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.20	1
2382	21.9	96.0	1.9	cloudy	2024-08-18 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2383	29.6	68.0	4.6	cloudy	2024-08-18 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2384	24.0	89.0	2.1	rainy	2024-08-18 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.90	1
2385	23.6	88.0	1.5	cloudy	2024-08-19 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2386	21.6	93.0	2.3	cloudy	2024-08-19 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2387	29.4	66.0	2.0	rainy	2024-08-19 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2388	25.8	87.0	3.3	cloudy	2024-08-19 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2389	23.1	93.0	4.8	cloudy	2024-08-20 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2390	22.2	91.0	3.1	clear	2024-08-20 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2391	29.5	68.0	5.5	cloudy	2024-08-20 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2392	24.6	91.0	1.8	rainy	2024-08-20 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2393	22.6	96.0	3.5	cloudy	2024-08-21 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2394	22.5	90.0	2.3	cloudy	2024-08-21 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2395	29.6	71.0	10.3	rainy	2024-08-21 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2396	24.9	89.0	3.6	cloudy	2024-08-21 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2397	23.4	93.0	3.2	cloudy	2024-08-22 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2398	22.4	89.0	2.9	cloudy	2024-08-22 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2399	29.8	63.0	8.6	cloudy	2024-08-22 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2400	25.0	90.0	4.6	cloudy	2024-08-22 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2401	23.1	95.0	3.5	rainy	2024-08-23 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2402	22.1	97.0	2.8	cloudy	2024-08-23 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2403	28.1	72.0	6.4	cloudy	2024-08-23 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2404	24.4	89.0	4.7	rainy	2024-08-23 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.20	1
2405	22.6	94.0	3.1	cloudy	2024-08-24 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2406	22.4	97.0	4.1	cloudy	2024-08-24 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2407	26.5	80.0	6.3	cloudy	2024-08-24 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2408	23.8	91.0	3.7	rainy	2024-08-24 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.40	1
2409	22.7	98.0	0.8	cloudy	2024-08-25 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2410	22.0	98.0	2.3	rainy	2024-08-25 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2411	26.8	81.0	8.4	cloudy	2024-08-25 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2412	23.6	96.0	1.8	rainy	2024-08-25 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2413	23.0	95.0	2.3	rainy	2024-08-26 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2414	21.6	98.0	2.7	cloudy	2024-08-26 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2415	26.5	85.0	9.9	rainy	2024-08-26 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2416	23.2	92.0	1.5	rainy	2024-08-26 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.10	1
2417	22.6	97.0	0.8	cloudy	2024-08-27 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2418	22.2	96.0	0.5	cloudy	2024-08-27 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2419	27.8	81.0	5.6	rainy	2024-08-27 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2420	24.0	91.0	2.9	rainy	2024-08-27 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2421	22.5	96.0	1.0	cloudy	2024-08-28 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2422	22.5	96.0	1.5	cloudy	2024-08-28 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2423	27.9	82.0	7.5	rainy	2024-08-28 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2424	23.6	95.0	2.9	rainy	2024-08-28 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2425	22.8	96.0	3.3	rainy	2024-08-29 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2426	22.2	95.0	2.1	cloudy	2024-08-29 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2427	25.2	88.0	3.7	rainy	2024-08-29 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.20	1
2428	23.5	93.0	2.2	rainy	2024-08-29 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.90	1
2429	22.4	97.0	2.2	rainy	2024-08-30 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	3.20	1
2430	22.1	98.0	3.2	cloudy	2024-08-30 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2431	26.4	81.0	6.8	rainy	2024-08-30 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2432	23.4	94.0	5.6	rainy	2024-08-30 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2433	22.5	96.0	2.1	cloudy	2024-08-31 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2434	22.0	97.0	3.1	rainy	2024-08-31 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2435	24.8	87.0	6.5	rainy	2024-08-31 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2436	23.5	93.0	1.3	rainy	2024-08-31 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.30	1
2437	22.4	97.0	3.6	rainy	2024-09-01 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2438	22.0	98.0	2.4	rainy	2024-09-01 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2439	25.6	87.0	6.2	rainy	2024-09-01 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2440	23.5	92.0	6.1	rainy	2024-09-01 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2441	21.8	98.0	4.9	cloudy	2024-09-02 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2442	21.1	99.0	2.4	cloudy	2024-09-02 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2443	27.5	76.0	12.7	rainy	2024-09-02 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2444	24.5	88.0	3.3	rainy	2024-09-02 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2445	23.1	90.0	2.3	cloudy	2024-09-03 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2446	21.6	92.0	3.7	cloudy	2024-09-03 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2447	27.9	73.0	6.1	rainy	2024-09-03 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2448	24.9	88.0	3.4	cloudy	2024-09-03 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2449	23.3	98.0	2.0	cloudy	2024-09-04 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2450	22.5	96.0	4.0	cloudy	2024-09-04 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2451	27.6	79.0	7.3	rainy	2024-09-04 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2452	24.0	92.0	3.6	rainy	2024-09-04 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2453	22.0	98.0	3.2	cloudy	2024-09-05 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2454	22.0	96.0	1.8	cloudy	2024-09-05 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2455	27.7	78.0	8.9	rainy	2024-09-05 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2456	23.2	95.0	2.5	rainy	2024-09-05 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.40	1
2457	21.8	97.0	3.7	cloudy	2024-09-06 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2458	21.0	97.0	3.0	clear	2024-09-06 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2459	29.0	67.0	7.7	cloudy	2024-09-06 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2460	25.0	92.0	3.4	rainy	2024-09-06 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2461	23.8	93.0	0.8	cloudy	2024-09-07 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2462	23.0	87.0	2.5	cloudy	2024-09-07 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2463	30.2	68.0	7.0	rainy	2024-09-07 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2464	26.5	81.0	6.0	cloudy	2024-09-07 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2465	23.6	89.0	1.9	cloudy	2024-09-08 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2466	22.5	94.0	2.1	cloudy	2024-09-08 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2467	29.8	66.0	2.0	cloudy	2024-09-08 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2468	24.8	91.0	2.0	rainy	2024-09-08 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.40	1
2469	23.0	97.0	3.4	rainy	2024-09-09 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2470	22.1	100.0	4.8	cloudy	2024-09-09 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2471	27.5	83.0	9.6	rainy	2024-09-09 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2472	22.8	97.0	0.0	cloudy	2024-09-09 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2473	22.3	97.0	0.8	rainy	2024-09-10 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2474	21.5	100.0	3.1	cloudy	2024-09-10 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2475	27.6	76.0	5.8	rainy	2024-09-10 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2476	23.4	95.0	3.1	rainy	2024-09-10 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.40	1
2477	22.5	97.0	2.3	rainy	2024-09-11 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2478	22.0	99.0	3.9	rainy	2024-09-11 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2479	27.2	76.0	8.9	rainy	2024-09-11 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.00	1
2480	23.4	97.0	1.9	rainy	2024-09-11 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2481	22.6	98.0	3.4	rainy	2024-09-12 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.60	1
2482	22.0	98.0	6.8	rainy	2024-09-12 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.70	1
2483	25.2	86.0	8.2	rainy	2024-09-12 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.30	1
2484	23.0	96.0	6.9	rainy	2024-09-12 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.20	1
2485	21.8	98.0	8.1	rainy	2024-09-13 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2486	21.5	100.0	9.5	rainy	2024-09-13 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2487	25.7	86.0	15.2	rainy	2024-09-13 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2488	22.9	96.0	9.8	rainy	2024-09-13 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2489	21.8	98.0	10.0	rainy	2024-09-14 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2490	21.4	100.0	9.4	rainy	2024-09-14 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.70	1
2491	25.5	83.0	22.1	cloudy	2024-09-14 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2492	24.4	83.0	11.8	cloudy	2024-09-14 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2493	21.6	96.0	7.7	cloudy	2024-09-15 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2494	21.1	99.0	7.4	cloudy	2024-09-15 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2495	25.2	90.0	18.9	rainy	2024-09-15 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2496	23.0	90.0	4.7	rainy	2024-09-15 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	4.10	1
2497	21.5	98.0	3.1	rainy	2024-09-16 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2498	21.5	99.0	7.4	rainy	2024-09-16 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2499	25.6	90.0	15.4	rainy	2024-09-16 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.50	1
2500	23.5	93.0	6.8	rainy	2024-09-16 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.80	1
2501	22.0	96.0	3.8	cloudy	2024-09-17 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2502	21.6	100.0	6.0	rainy	2024-09-17 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2503	25.9	82.0	16.8	rainy	2024-09-17 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2504	24.5	87.0	6.0	rainy	2024-09-17 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2505	21.6	98.0	1.3	cloudy	2024-09-18 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2506	21.5	97.0	5.6	cloudy	2024-09-18 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2507	27.8	72.0	16.3	rainy	2024-09-18 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2508	25.0	85.0	3.3	rainy	2024-09-18 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2509	23.2	93.0	1.8	cloudy	2024-09-19 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2510	22.0	91.0	3.1	cloudy	2024-09-19 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2511	27.5	77.0	8.6	cloudy	2024-09-19 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2512	24.9	84.0	1.4	rainy	2024-09-19 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2513	22.5	92.0	3.0	rainy	2024-09-20 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2514	22.6	94.0	1.3	cloudy	2024-09-20 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2515	27.5	75.0	4.5	cloudy	2024-09-20 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2516	24.4	90.0	2.9	rainy	2024-09-20 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2517	24.9	77.0	1.5	cloudy	2024-09-21 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2518	22.6	89.0	2.3	cloudy	2024-09-21 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2519	29.5	65.0	3.5	cloudy	2024-09-21 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2520	24.5	92.0	1.8	rainy	2024-09-21 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2521	22.8	96.0	3.6	cloudy	2024-09-22 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2522	22.0	92.0	2.2	cloudy	2024-09-22 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2523	28.9	74.0	4.2	rainy	2024-09-22 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2524	24.2	92.0	3.5	cloudy	2024-09-22 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2525	22.5	93.0	3.7	cloudy	2024-09-23 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2526	21.4	92.0	3.3	cloudy	2024-09-23 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2527	27.8	69.0	6.5	cloudy	2024-09-23 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2528	24.5	87.0	1.8	rainy	2024-09-23 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	2.00	1
2529	23.9	96.0	2.6	cloudy	2024-09-24 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2530	22.5	92.0	2.1	rainy	2024-09-24 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2531	28.6	77.0	1.8	rainy	2024-09-24 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	1.10	1
2532	24.0	89.0	0.0	rainy	2024-09-24 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.30	1
2533	22.9	96.0	2.2	cloudy	2024-09-25 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2534	22.4	96.0	4.5	cloudy	2024-09-25 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2535	28.5	71.0	5.1	cloudy	2024-09-25 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2536	24.7	91.0	3.4	rainy	2024-09-25 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2537	22.4	96.0	2.1	rainy	2024-09-26 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2538	21.3	99.0	1.5	cloudy	2024-09-26 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2539	28.6	74.0	7.5	cloudy	2024-09-26 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2540	23.9	94.0	3.7	cloudy	2024-09-26 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2541	22.8	96.0	1.9	cloudy	2024-09-27 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2542	21.6	92.0	1.7	clear	2024-09-27 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2543	29.1	72.0	5.6	clear	2024-09-27 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2544	24.1	93.0	4.7	rainy	2024-09-27 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.10	1
2545	22.0	98.0	3.3	clear	2024-09-28 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2546	21.5	92.0	1.1	cloudy	2024-09-28 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2547	28.7	73.0	8.7	cloudy	2024-09-28 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2548	24.5	89.0	3.3	rainy	2024-09-28 18:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.20	1
2549	23.0	98.0	1.7	cloudy	2024-09-29 00:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2550	23.0	92.0	2.4	cloudy	2024-09-29 06:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2551	29.0	71.0	11.3	cloudy	2024-09-29 12:00:00	2026-02-12 08:44:35	2026-02-12 08:44:35	0.00	1
2552	25.4	90.0	3.7	cloudy	2024-09-29 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2553	23.6	94.0	1.8	cloudy	2024-09-30 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2554	22.0	95.0	2.4	cloudy	2024-09-30 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2555	28.5	69.0	6.7	rainy	2024-09-30 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2556	23.4	94.0	1.8	rainy	2024-09-30 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2557	22.5	94.0	3.4	cloudy	2024-10-01 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2558	22.4	89.0	2.8	cloudy	2024-10-01 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2559	29.1	71.0	9.8	rainy	2024-10-01 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2560	24.0	90.0	3.7	rainy	2024-10-01 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2561	22.3	95.0	4.2	cloudy	2024-10-02 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2562	22.1	89.0	2.7	cloudy	2024-10-02 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2563	30.5	59.0	7.6	cloudy	2024-10-02 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2564	27.2	75.0	3.6	cloudy	2024-10-02 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2565	22.2	98.0	2.7	rainy	2024-10-03 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2566	22.5	93.0	2.1	cloudy	2024-10-03 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2567	27.6	74.0	3.0	cloudy	2024-10-03 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2568	24.5	92.0	3.1	rainy	2024-10-03 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2569	23.1	95.0	2.3	rainy	2024-10-04 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	2.00	1
2570	22.3	96.0	1.7	cloudy	2024-10-04 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2571	28.5	72.0	10.1	clear	2024-10-04 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2572	25.2	86.0	2.6	rainy	2024-10-04 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2573	22.7	95.0	1.8	cloudy	2024-10-05 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2574	22.1	91.0	0.3	cloudy	2024-10-05 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2575	27.7	77.0	10.0	rainy	2024-10-05 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2576	25.3	85.0	1.5	rainy	2024-10-05 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2577	22.4	94.0	3.6	cloudy	2024-10-06 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2578	22.0	94.0	1.5	cloudy	2024-10-06 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2579	27.5	79.0	7.3	rainy	2024-10-06 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2580	24.2	88.0	2.2	rainy	2024-10-06 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.60	1
2581	22.4	94.0	2.3	cloudy	2024-10-07 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2582	22.2	91.0	1.9	cloudy	2024-10-07 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2583	28.8	71.0	9.0	cloudy	2024-10-07 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2584	26.0	84.0	3.9	rainy	2024-10-07 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2585	23.2	93.0	2.0	clear	2024-10-08 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2586	22.9	91.0	2.0	cloudy	2024-10-08 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2587	29.1	70.0	7.6	cloudy	2024-10-08 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2588	24.2	92.0	4.0	rainy	2024-10-08 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.60	1
2589	23.1	96.0	1.6	cloudy	2024-10-09 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2590	22.3	95.0	2.0	cloudy	2024-10-09 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2591	29.3	70.0	3.3	cloudy	2024-10-09 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2592	24.5	93.0	4.4	cloudy	2024-10-09 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2593	22.8	93.0	2.5	cloudy	2024-10-10 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2594	21.8	89.0	3.1	clear	2024-10-10 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2595	30.0	66.0	1.8	clear	2024-10-10 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2596	24.0	93.0	4.1	cloudy	2024-10-10 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2597	24.0	87.0	2.7	cloudy	2024-10-11 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2598	23.0	88.0	1.3	clear	2024-10-11 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2599	29.6	69.0	2.2	clear	2024-10-11 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2600	23.6	91.0	6.5	rainy	2024-10-11 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	5.70	1
2601	22.4	97.0	4.0	cloudy	2024-10-12 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2602	22.0	94.0	1.1	cloudy	2024-10-12 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2603	27.9	73.0	4.9	rainy	2024-10-12 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2604	23.9	91.0	1.5	rainy	2024-10-12 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.60	1
2605	22.5	96.0	4.3	cloudy	2024-10-13 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2606	22.3	92.0	2.0	cloudy	2024-10-13 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2607	29.4	67.0	1.3	cloudy	2024-10-13 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2608	23.5	94.0	2.8	cloudy	2024-10-13 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2609	23.2	94.0	4.0	cloudy	2024-10-14 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2610	22.9	90.0	2.3	cloudy	2024-10-14 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2611	29.0	72.0	4.0	cloudy	2024-10-14 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2612	24.1	91.0	2.9	rainy	2024-10-14 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2613	22.5	98.0	0.5	rainy	2024-10-15 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2614	21.9	96.0	3.1	cloudy	2024-10-15 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2615	28.5	74.0	4.2	cloudy	2024-10-15 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2616	22.6	94.0	3.6	rainy	2024-10-15 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2617	22.5	94.0	2.4	rainy	2024-10-16 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.80	1
2618	21.8	90.0	2.2	clear	2024-10-16 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2619	28.9	69.0	8.6	rainy	2024-10-16 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2620	23.9	94.0	3.1	cloudy	2024-10-16 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2621	22.7	97.0	2.4	cloudy	2024-10-17 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2622	22.0	92.0	3.5	cloudy	2024-10-17 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2623	28.5	71.0	4.5	clear	2024-10-17 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2624	24.1	89.0	5.9	rainy	2024-10-17 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2625	23.1	96.0	3.3	cloudy	2024-10-18 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2626	22.8	94.0	3.3	cloudy	2024-10-18 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2627	29.4	65.0	1.9	cloudy	2024-10-18 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2628	24.5	89.0	4.2	rainy	2024-10-18 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2629	22.1	98.0	3.1	cloudy	2024-10-19 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2630	22.4	93.0	2.0	cloudy	2024-10-19 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2631	27.9	77.0	7.8	cloudy	2024-10-19 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2632	23.3	93.0	2.0	rainy	2024-10-19 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2633	22.1	96.0	1.2	cloudy	2024-10-20 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2634	21.9	98.0	1.9	cloudy	2024-10-20 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2635	26.1	81.0	10.3	rainy	2024-10-20 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	4.10	1
2636	23.5	96.0	6.1	rainy	2024-10-20 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2637	22.6	97.0	3.5	rainy	2024-10-21 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2638	22.1	99.0	5.5	rainy	2024-10-21 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2639	25.5	85.0	10.6	rainy	2024-10-21 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2640	23.1	95.0	5.8	rainy	2024-10-21 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	1.90	1
2641	22.1	99.0	8.4	rainy	2024-10-22 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2642	21.8	99.0	11.7	rainy	2024-10-22 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2643	25.1	88.0	21.2	rainy	2024-10-22 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2644	23.6	90.0	13.3	cloudy	2024-10-22 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2645	21.5	97.0	7.6	cloudy	2024-10-23 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2646	20.9	99.0	13.8	rainy	2024-10-23 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2647	26.3	82.0	29.7	rainy	2024-10-23 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.40	1
2648	23.1	93.0	10.3	cloudy	2024-10-23 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2649	21.7	97.0	4.4	cloudy	2024-10-24 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2650	21.5	98.0	7.4	cloudy	2024-10-24 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2651	27.1	78.0	23.0	rainy	2024-10-24 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2652	24.3	88.0	8.3	cloudy	2024-10-24 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2653	21.8	99.0	1.5	cloudy	2024-10-25 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2654	21.8	99.0	3.3	cloudy	2024-10-25 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2655	27.5	77.0	18.0	cloudy	2024-10-25 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2656	24.0	90.0	3.8	rainy	2024-10-25 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2657	21.4	99.0	3.0	rainy	2024-10-26 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2658	21.0	98.0	4.0	cloudy	2024-10-26 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2659	24.2	88.0	3.7	cloudy	2024-10-26 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2660	23.1	95.0	3.3	rainy	2024-10-26 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2661	22.0	93.0	1.8	rainy	2024-10-27 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2662	21.9	88.0	0.8	rainy	2024-10-27 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2663	24.5	89.0	10.7	rainy	2024-10-27 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2664	23.2	97.0	1.7	rainy	2024-10-27 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2665	21.7	96.0	2.8	cloudy	2024-10-28 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2666	21.5	98.0	4.9	cloudy	2024-10-28 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2667	26.4	84.0	5.6	rainy	2024-10-28 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.60	1
2668	23.6	95.0	2.9	rainy	2024-10-28 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2669	22.9	95.0	1.6	rainy	2024-10-29 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2670	22.2	98.0	3.5	rainy	2024-10-29 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2671	25.9	86.0	10.5	rainy	2024-10-29 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2672	23.6	94.0	2.7	cloudy	2024-10-29 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2673	21.9	94.0	2.4	cloudy	2024-10-30 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2674	21.6	96.0	1.0	cloudy	2024-10-30 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2675	27.5	78.0	8.8	rainy	2024-10-30 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2676	23.0	96.0	3.7	cloudy	2024-10-30 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2677	22.2	93.0	2.6	cloudy	2024-10-31 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2678	22.0	85.0	1.5	cloudy	2024-10-31 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2679	29.6	65.0	7.5	cloudy	2024-10-31 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2680	23.5	94.0	3.4	cloudy	2024-10-31 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2681	22.1	93.0	2.3	clear	2024-11-01 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2682	20.6	90.0	3.8	cloudy	2024-11-01 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2683	29.9	62.0	5.0	cloudy	2024-11-01 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2684	24.0	83.0	0.4	rainy	2024-11-01 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2685	22.0	93.0	2.9	cloudy	2024-11-02 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2686	21.2	89.0	4.0	cloudy	2024-11-02 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2687	29.0	74.0	7.0	rainy	2024-11-02 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2688	25.3	84.0	0.5	cloudy	2024-11-02 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2689	22.3	95.0	3.2	cloudy	2024-11-03 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2690	21.2	92.0	2.3	cloudy	2024-11-03 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2691	29.1	71.0	6.7	cloudy	2024-11-03 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2692	24.6	89.0	4.2	rainy	2024-11-03 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2693	22.2	98.0	3.1	rainy	2024-11-04 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2694	22.0	93.0	1.8	cloudy	2024-11-04 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2695	27.5	78.0	7.2	cloudy	2024-11-04 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2696	23.3	94.0	2.1	rainy	2024-11-04 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2697	21.2	98.0	2.4	cloudy	2024-11-05 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2698	21.4	96.0	1.4	cloudy	2024-11-05 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2699	26.1	81.0	9.6	rainy	2024-11-05 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2700	23.2	93.0	2.1	rainy	2024-11-05 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2701	22.2	99.0	2.2	rainy	2024-11-06 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2702	22.0	95.0	1.1	cloudy	2024-11-06 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2703	28.9	72.0	2.5	cloudy	2024-11-06 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2704	23.2	95.0	2.7	rainy	2024-11-06 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2705	22.7	94.0	2.6	cloudy	2024-11-07 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2706	21.7	92.0	2.9	clear	2024-11-07 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2707	29.2	67.0	1.6	rainy	2024-11-07 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2708	24.0	91.0	3.8	rainy	2024-11-07 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2709	22.9	92.0	4.3	cloudy	2024-11-08 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2710	21.8	92.0	2.5	cloudy	2024-11-08 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2711	29.5	64.0	2.6	clear	2024-11-08 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2712	26.0	82.0	5.3	cloudy	2024-11-08 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2713	22.5	94.0	1.3	cloudy	2024-11-09 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2714	21.9	89.0	4.2	cloudy	2024-11-09 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2715	28.7	74.0	5.1	rainy	2024-11-09 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2716	23.9	95.0	2.8	cloudy	2024-11-09 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2717	22.5	94.0	2.1	rainy	2024-11-10 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2718	21.7	93.0	2.4	cloudy	2024-11-10 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2719	29.5	73.0	5.4	cloudy	2024-11-10 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2720	23.9	92.0	2.7	rainy	2024-11-10 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.80	1
2721	24.1	90.0	1.2	cloudy	2024-11-11 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2722	22.2	91.0	1.5	clear	2024-11-11 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2723	29.0	71.0	5.6	rainy	2024-11-11 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2724	22.5	92.0	7.4	rainy	2024-11-11 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	8.30	1
2725	22.8	93.0	2.4	cloudy	2024-11-12 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2726	21.5	95.0	0.2	clear	2024-11-12 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2727	29.5	64.0	5.8	cloudy	2024-11-12 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2728	23.3	91.0	11.3	rainy	2024-11-12 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	5.50	1
2729	21.9	97.0	2.7	cloudy	2024-11-13 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2730	20.9	93.0	2.7	clear	2024-11-13 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2731	30.0	61.0	3.6	cloudy	2024-11-13 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2732	24.2	90.0	6.4	rainy	2024-11-13 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2733	22.8	93.0	2.8	cloudy	2024-11-14 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2734	21.5	93.0	3.4	cloudy	2024-11-14 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2735	30.7	56.0	7.1	cloudy	2024-11-14 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2736	27.1	75.0	3.1	cloudy	2024-11-14 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2737	22.8	94.0	1.8	cloudy	2024-11-15 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2738	21.2	94.0	4.4	cloudy	2024-11-15 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2739	30.3	60.0	2.1	cloudy	2024-11-15 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2740	24.0	95.0	2.2	cloudy	2024-11-15 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2741	22.0	98.0	0.4	cloudy	2024-11-16 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2742	21.4	98.0	1.9	cloudy	2024-11-16 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2743	28.9	69.0	4.0	cloudy	2024-11-16 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2744	23.0	99.0	3.1	rainy	2024-11-16 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.60	1
2745	22.5	97.0	2.1	cloudy	2024-11-17 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2746	22.2	92.0	2.9	clear	2024-11-17 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2747	30.1	62.0	3.6	clear	2024-11-17 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2748	23.6	96.0	2.4	rainy	2024-11-17 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2749	22.4	95.0	2.2	cloudy	2024-11-18 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2750	21.5	93.0	2.4	cloudy	2024-11-18 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2751	27.0	80.0	13.5	rainy	2024-11-18 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	3.00	1
2752	23.4	96.0	0.9	rainy	2024-11-18 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2753	22.2	94.0	1.4	cloudy	2024-11-19 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2754	22.6	92.0	0.6	rainy	2024-11-19 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2755	27.9	71.0	11.3	cloudy	2024-11-19 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2756	24.1	92.0	0.8	rainy	2024-11-19 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2757	22.6	92.0	1.5	cloudy	2024-11-20 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2758	22.9	88.0	1.0	cloudy	2024-11-20 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2759	30.3	54.0	11.7	cloudy	2024-11-20 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2760	24.7	77.0	5.6	clear	2024-11-20 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2761	21.9	88.0	3.1	cloudy	2024-11-21 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2762	20.8	88.0	3.8	cloudy	2024-11-21 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2763	30.5	52.0	13.4	cloudy	2024-11-21 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2764	25.5	76.0	5.4	clear	2024-11-21 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2765	22.2	86.0	2.3	cloudy	2024-11-22 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2766	22.6	91.0	1.2	cloudy	2024-11-22 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2767	28.4	75.0	10.1	rainy	2024-11-22 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2768	23.6	96.0	1.0	rainy	2024-11-22 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	2.80	1
2769	22.6	98.0	4.5	rainy	2024-11-23 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	3.40	1
2770	22.5	95.0	1.2	rainy	2024-11-23 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2771	28.1	72.0	9.6	cloudy	2024-11-23 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2772	24.3	91.0	0.6	rainy	2024-11-23 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2773	23.0	93.0	0.5	cloudy	2024-11-24 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2774	22.3	89.0	2.0	cloudy	2024-11-24 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2775	28.8	67.0	14.9	rainy	2024-11-24 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2776	24.0	95.0	0.8	rainy	2024-11-24 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2777	22.9	98.0	3.3	rainy	2024-11-25 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.80	1
2778	22.4	95.0	1.0	cloudy	2024-11-25 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2779	27.5	76.0	12.0	rainy	2024-11-25 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2780	24.8	84.0	1.4	cloudy	2024-11-25 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2781	23.0	90.0	1.0	cloudy	2024-11-26 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2782	21.7	88.0	0.6	clear	2024-11-26 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2783	29.5	60.0	13.5	rainy	2024-11-26 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2784	25.1	80.0	4.3	clear	2024-11-26 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2785	23.0	93.0	2.8	cloudy	2024-11-27 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2786	22.8	89.0	1.5	cloudy	2024-11-27 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2787	28.5	71.0	13.6	rainy	2024-11-27 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2788	24.2	92.0	2.4	rainy	2024-11-27 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2789	23.2	95.0	1.0	cloudy	2024-11-28 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2790	22.2	94.0	2.2	cloudy	2024-11-28 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2791	29.0	65.0	12.1	cloudy	2024-11-28 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2792	24.3	98.0	2.2	rainy	2024-11-28 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	1.70	1
2793	23.9	89.0	1.1	cloudy	2024-11-29 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2794	22.5	90.0	2.5	cloudy	2024-11-29 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2795	26.5	84.0	2.0	rainy	2024-11-29 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2796	24.1	95.0	0.7	rainy	2024-11-29 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2797	23.0	98.0	2.6	rainy	2024-11-30 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2798	21.2	97.0	3.8	cloudy	2024-11-30 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2799	29.8	64.0	6.7	cloudy	2024-11-30 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2800	23.1	98.0	1.5	rainy	2024-11-30 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2801	22.3	99.0	1.5	rainy	2024-12-01 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.40	1
2802	21.9	99.0	3.2	cloudy	2024-12-01 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2803	27.4	79.0	4.7	rainy	2024-12-01 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2804	23.6	98.0	0.5	rainy	2024-12-01 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2805	22.6	99.0	2.9	cloudy	2024-12-02 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2806	21.6	95.0	3.6	cloudy	2024-12-02 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2807	30.0	62.0	7.4	rainy	2024-12-02 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2808	23.7	97.0	4.1	rainy	2024-12-02 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2809	23.0	90.0	1.8	cloudy	2024-12-03 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2810	21.9	90.0	2.3	cloudy	2024-12-03 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2811	29.9	67.0	7.8	rainy	2024-12-03 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2812	25.7	81.0	4.7	clear	2024-12-03 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2813	21.7	96.0	3.6	clear	2024-12-04 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2814	20.5	90.0	3.6	cloudy	2024-12-04 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2815	30.8	54.0	9.6	cloudy	2024-12-04 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2816	25.3	75.0	6.5	cloudy	2024-12-04 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2817	22.2	90.0	2.9	clear	2024-12-05 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2818	20.5	94.0	3.0	cloudy	2024-12-05 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2819	30.5	55.0	7.6	cloudy	2024-12-05 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2820	26.0	79.0	3.2	cloudy	2024-12-05 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2821	23.0	94.0	2.0	cloudy	2024-12-06 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2822	21.0	93.0	1.3	cloudy	2024-12-06 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2823	30.0	59.0	7.2	cloudy	2024-12-06 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2824	26.0	83.0	1.1	cloudy	2024-12-06 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2825	22.7	94.0	1.9	cloudy	2024-12-07 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2826	21.2	90.0	2.7	cloudy	2024-12-07 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2827	28.6	67.0	8.0	rainy	2024-12-07 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2828	24.5	98.0	1.5	cloudy	2024-12-07 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2829	23.7	95.0	0.7	rainy	2024-12-08 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2830	22.9	95.0	1.3	cloudy	2024-12-08 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2831	25.4	88.0	1.5	rainy	2024-12-08 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2832	23.8	97.0	1.3	rainy	2024-12-08 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2833	23.5	96.0	0.2	rainy	2024-12-09 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2834	23.0	93.0	1.8	rainy	2024-12-09 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2835	29.6	64.0	10.4	cloudy	2024-12-09 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2836	24.6	94.0	0.9	cloudy	2024-12-09 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2837	23.7	92.0	0.7	cloudy	2024-12-10 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2838	22.2	93.0	3.3	clear	2024-12-10 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2839	27.5	78.0	5.4	rainy	2024-12-10 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2840	24.5	94.0	0.4	rainy	2024-12-10 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2841	23.0	98.0	0.4	rainy	2024-12-11 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2842	23.0	92.0	0.6	rainy	2024-12-11 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2843	29.8	64.0	4.3	rainy	2024-12-11 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2844	24.1	96.0	2.3	rainy	2024-12-11 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2845	23.6	96.0	1.4	cloudy	2024-12-12 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2846	22.4	96.0	1.9	cloudy	2024-12-12 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2847	27.1	73.0	12.2	cloudy	2024-12-12 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2848	24.6	89.0	0.3	cloudy	2024-12-12 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2849	22.8	92.0	2.5	cloudy	2024-12-13 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2850	21.3	89.0	1.8	cloudy	2024-12-13 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2851	28.3	69.0	12.1	rainy	2024-12-13 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2852	24.5	83.0	2.8	cloudy	2024-12-13 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2853	20.0	86.0	3.1	cloudy	2024-12-14 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2854	20.4	82.0	3.5	cloudy	2024-12-14 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2855	30.0	56.0	11.9	cloudy	2024-12-14 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2856	24.9	77.0	5.9	cloudy	2024-12-14 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2857	20.2	89.0	4.1	cloudy	2024-12-15 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2858	19.1	78.0	6.0	cloudy	2024-12-15 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2859	27.5	63.0	13.9	cloudy	2024-12-15 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2860	24.5	85.0	1.3	cloudy	2024-12-15 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2861	23.0	93.0	0.6	cloudy	2024-12-16 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2862	21.4	92.0	2.5	cloudy	2024-12-16 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2863	25.9	85.0	3.2	rainy	2024-12-16 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.20	1
2864	23.7	95.0	3.1	rainy	2024-12-16 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	1.40	1
2865	22.8	98.0	4.0	rainy	2024-12-17 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	3.50	1
2866	21.5	96.0	2.4	cloudy	2024-12-17 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2867	25.5	81.0	3.2	rainy	2024-12-17 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.90	1
2868	24.0	94.0	0.8	rainy	2024-12-17 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2869	22.8	95.0	1.9	rainy	2024-12-18 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2870	21.1	97.0	3.8	cloudy	2024-12-18 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2871	28.0	72.0	2.9	rainy	2024-12-18 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2872	23.4	99.0	4.0	rainy	2024-12-18 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	3.20	1
2873	23.1	96.0	0.6	rainy	2024-12-19 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	3.50	1
2874	21.5	95.0	1.5	cloudy	2024-12-19 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2875	27.9	70.0	2.2	cloudy	2024-12-19 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2876	23.4	98.0	1.5	rainy	2024-12-19 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	1.80	1
2877	22.8	98.0	2.7	rainy	2024-12-20 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	10.20	1
2878	22.7	94.0	0.8	rainy	2024-12-20 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.30	1
2879	29.2	68.0	6.3	cloudy	2024-12-20 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2880	23.5	96.0	1.3	rainy	2024-12-20 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.70	1
2881	23.5	93.0	0.6	cloudy	2024-12-21 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2882	23.0	92.0	1.8	cloudy	2024-12-21 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2883	28.4	70.0	9.2	rainy	2024-12-21 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.40	1
2884	24.0	93.0	1.9	cloudy	2024-12-21 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2885	23.5	95.0	3.1	cloudy	2024-12-22 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2886	22.4	96.0	3.2	cloudy	2024-12-22 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2887	29.7	67.0	3.2	rainy	2024-12-22 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2888	24.1	95.0	0.5	rainy	2024-12-22 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2889	22.8	94.0	0.8	cloudy	2024-12-23 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2890	20.9	96.0	2.4	cloudy	2024-12-23 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2891	29.6	66.0	2.5	cloudy	2024-12-23 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2892	23.6	99.0	3.4	rainy	2024-12-23 18:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.50	1
2893	23.5	97.0	3.3	rainy	2024-12-24 00:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.10	1
2894	22.3	93.0	3.3	cloudy	2024-12-24 06:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2895	28.5	69.0	2.7	cloudy	2024-12-24 12:00:00	2026-02-12 08:44:36	2026-02-12 08:44:36	0.00	1
2896	24.4	96.0	1.1	cloudy	2024-12-24 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2897	22.8	96.0	2.7	cloudy	2024-12-25 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2898	22.1	92.0	2.4	cloudy	2024-12-25 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2899	27.0	77.0	8.4	rainy	2024-12-25 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2900	23.7	95.0	2.4	rainy	2024-12-25 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.90	1
2901	22.7	97.0	1.1	rainy	2024-12-26 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.40	1
2902	20.7	98.0	4.5	cloudy	2024-12-26 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2903	26.6	75.0	8.5	rainy	2024-12-26 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2904	23.6	98.0	1.4	rainy	2024-12-26 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.50	1
2905	22.6	96.0	2.4	rainy	2024-12-27 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.70	1
2906	22.3	95.0	0.4	rainy	2024-12-27 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.20	1
2907	25.2	87.0	3.5	rainy	2024-12-27 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
2908	23.6	94.0	1.8	rainy	2024-12-27 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2909	23.0	95.0	1.8	rainy	2024-12-28 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2910	21.2	95.0	2.6	cloudy	2024-12-28 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2911	28.3	71.0	3.3	cloudy	2024-12-28 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2912	23.4	97.0	1.7	rainy	2024-12-28 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2913	22.6	92.0	1.3	cloudy	2024-12-29 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2914	20.9	97.0	2.3	clear	2024-12-29 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2915	29.7	62.0	4.3	clear	2024-12-29 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2916	23.5	98.0	1.6	rainy	2024-12-29 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.70	1
2917	23.4	96.0	0.6	cloudy	2024-12-30 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2918	22.1	97.0	3.8	clear	2024-12-30 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2919	29.3	70.0	5.7	cloudy	2024-12-30 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2920	24.2	96.0	2.2	cloudy	2024-12-30 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2921	23.0	92.0	1.1	cloudy	2024-12-31 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2922	21.3	94.0	2.7	cloudy	2024-12-31 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2923	26.9	76.0	0.9	rainy	2024-12-31 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
2924	23.8	98.0	2.9	rainy	2024-12-31 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.00	1
2925	22.8	91.0	0.8	cloudy	2025-01-01 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2926	21.1	95.0	2.0	cloudy	2025-01-01 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2927	26.0	77.0	2.6	cloudy	2025-01-01 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2928	23.5	95.0	2.3	cloudy	2025-01-01 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2929	22.8	98.0	1.7	rainy	2025-01-02 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2930	21.5	96.0	2.2	cloudy	2025-01-02 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2931	29.3	66.0	8.0	rainy	2025-01-02 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2932	23.8	94.0	1.3	rainy	2025-01-02 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2933	22.3	94.0	1.5	cloudy	2025-01-03 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2934	21.2	97.0	1.1	cloudy	2025-01-03 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2935	28.8	71.0	5.7	cloudy	2025-01-03 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2936	23.5	95.0	4.6	rainy	2025-01-03 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.90	1
2937	21.9	99.0	3.1	rainy	2025-01-04 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2938	20.6	96.0	2.5	clear	2025-01-04 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2939	29.6	62.0	9.0	clear	2025-01-04 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2940	23.0	97.0	3.9	rainy	2025-01-04 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.40	1
2941	22.5	95.0	2.1	rainy	2025-01-05 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2942	21.4	94.0	2.7	cloudy	2025-01-05 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2943	29.4	59.0	10.7	cloudy	2025-01-05 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2944	22.9	97.0	4.6	rainy	2025-01-05 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
2945	22.5	97.0	0.7	cloudy	2025-01-06 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2946	21.0	99.0	2.4	cloudy	2025-01-06 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2947	27.6	72.0	3.1	rainy	2025-01-06 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2948	23.8	93.0	0.4	rainy	2025-01-06 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2949	22.8	94.0	1.1	cloudy	2025-01-07 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2950	20.9	95.0	3.4	cloudy	2025-01-07 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2951	29.4	64.0	4.9	rainy	2025-01-07 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2952	23.2	97.0	2.4	rainy	2025-01-07 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
2953	22.5	95.0	1.8	rainy	2025-01-08 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2954	21.5	95.0	1.9	cloudy	2025-01-08 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2955	28.8	71.0	1.8	rainy	2025-01-08 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2956	23.8	94.0	0.4	cloudy	2025-01-08 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2957	22.9	96.0	3.0	cloudy	2025-01-09 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2958	21.5	96.0	2.2	rainy	2025-01-09 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2959	26.1	82.0	10.8	rainy	2025-01-09 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.70	1
2960	24.1	94.0	2.3	cloudy	2025-01-09 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2961	21.6	97.0	3.1	cloudy	2025-01-10 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2962	20.7	95.0	2.9	cloudy	2025-01-10 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2963	28.7	66.0	9.0	cloudy	2025-01-10 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2964	23.3	98.0	2.8	rainy	2025-01-10 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
2965	21.9	96.0	2.2	cloudy	2025-01-11 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2966	21.2	89.0	1.0	cloudy	2025-01-11 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2967	28.0	68.0	12.4	rainy	2025-01-11 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2968	24.6	81.0	0.4	cloudy	2025-01-11 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2969	22.6	89.0	2.0	cloudy	2025-01-12 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2970	21.2	88.0	2.2	cloudy	2025-01-12 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2971	26.5	75.0	4.0	cloudy	2025-01-12 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2972	23.5	97.0	2.1	rainy	2025-01-12 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
2973	22.5	93.0	0.6	cloudy	2025-01-13 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2974	21.5	94.0	0.5	cloudy	2025-01-13 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2975	28.4	65.0	14.5	rainy	2025-01-13 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2976	24.3	85.0	4.3	cloudy	2025-01-13 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2977	22.6	98.0	3.8	rainy	2025-01-14 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2978	21.2	95.0	2.4	clear	2025-01-14 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2979	29.5	56.0	17.2	cloudy	2025-01-14 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2980	24.7	82.0	4.6	cloudy	2025-01-14 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2981	22.1	94.0	0.5	cloudy	2025-01-15 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2982	22.2	94.0	0.7	rainy	2025-01-15 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2983	26.4	74.0	12.0	rainy	2025-01-15 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
2984	24.0	86.0	1.0	cloudy	2025-01-15 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2985	22.6	96.0	1.0	rainy	2025-01-16 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.80	1
2986	21.8	91.0	2.0	cloudy	2025-01-16 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2987	28.5	65.0	13.8	rainy	2025-01-16 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
2988	24.8	83.0	1.6	cloudy	2025-01-16 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2989	21.5	92.0	2.4	clear	2025-01-17 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2990	20.8	88.0	3.0	clear	2025-01-17 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2991	29.9	55.0	14.3	cloudy	2025-01-17 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2992	24.9	78.0	12.0	cloudy	2025-01-17 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2993	22.9	88.0	2.0	cloudy	2025-01-18 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2994	20.0	86.0	2.2	cloudy	2025-01-18 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2995	29.4	53.0	12.4	cloudy	2025-01-18 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2996	25.0	70.0	9.6	cloudy	2025-01-18 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2997	20.4	91.0	5.1	cloudy	2025-01-19 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2998	20.5	78.0	2.3	cloudy	2025-01-19 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
2999	27.3	71.0	6.4	rainy	2025-01-19 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
3000	24.8	84.0	2.5	cloudy	2025-01-19 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3001	23.1	95.0	0.8	cloudy	2025-01-20 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3002	22.1	94.0	2.4	cloudy	2025-01-20 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3003	28.5	72.0	6.2	rainy	2025-01-20 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3004	24.2	94.0	2.5	cloudy	2025-01-20 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3005	22.5	97.0	3.6	rainy	2025-01-21 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3006	21.6	95.0	2.2	cloudy	2025-01-21 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3007	28.9	69.0	8.5	rainy	2025-01-21 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3008	24.8	85.0	2.9	cloudy	2025-01-21 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3009	22.5	93.0	2.7	cloudy	2025-01-22 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3010	23.2	85.0	0.7	cloudy	2025-01-22 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3011	28.1	71.0	10.7	rainy	2025-01-22 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3012	25.1	83.0	0.3	cloudy	2025-01-22 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3013	22.0	89.0	3.1	cloudy	2025-01-23 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3014	20.8	85.0	1.5	cloudy	2025-01-23 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3015	29.7	56.0	7.3	cloudy	2025-01-23 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3016	23.9	92.0	0.4	rainy	2025-01-23 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3017	22.3	96.0	2.6	cloudy	2025-01-24 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3018	21.1	89.0	2.0	cloudy	2025-01-24 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3019	29.2	61.0	7.6	rainy	2025-01-24 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3020	24.6	88.0	0.4	cloudy	2025-01-24 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3021	22.4	92.0	2.5	cloudy	2025-01-25 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3022	21.0	92.0	3.0	cloudy	2025-01-25 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3023	28.2	68.0	13.5	rainy	2025-01-25 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3024	23.8	98.0	2.0	cloudy	2025-01-25 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3025	22.1	96.0	3.1	cloudy	2025-01-26 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3026	20.6	97.0	2.9	cloudy	2025-01-26 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3027	27.3	78.0	12.7	rainy	2025-01-26 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	3.50	1
3028	24.4	94.0	2.4	rainy	2025-01-26 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3029	22.2	93.0	3.9	cloudy	2025-01-27 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3030	21.1	91.0	4.0	cloudy	2025-01-27 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3031	28.5	65.0	11.1	rainy	2025-01-27 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3032	23.9	93.0	0.4	rainy	2025-01-27 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.80	1
3033	22.5	96.0	2.4	cloudy	2025-01-28 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3034	20.9	93.0	1.5	cloudy	2025-01-28 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3035	29.5	56.0	14.9	cloudy	2025-01-28 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3036	25.1	75.0	7.8	cloudy	2025-01-28 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3037	20.9	89.0	3.5	cloudy	2025-01-29 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3038	20.8	82.0	3.8	cloudy	2025-01-29 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3039	24.7	87.0	1.2	rainy	2025-01-29 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.20	1
3040	23.1	96.0	2.7	rainy	2025-01-29 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3041	22.7	89.0	1.0	cloudy	2025-01-30 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3042	21.0	95.0	1.7	cloudy	2025-01-30 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3043	27.4	74.0	11.9	rainy	2025-01-30 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3044	24.5	82.0	4.9	cloudy	2025-01-30 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3045	22.4	88.0	0.4	cloudy	2025-01-31 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3046	21.5	87.0	1.5	cloudy	2025-01-31 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3047	29.2	58.0	13.9	clear	2025-01-31 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3048	25.3	73.0	9.4	cloudy	2025-01-31 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3049	21.2	88.0	3.1	cloudy	2025-02-01 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3050	19.6	88.0	3.7	cloudy	2025-02-01 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3051	27.0	76.0	10.0	rainy	2025-02-01 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.30	1
3052	24.7	88.0	1.3	cloudy	2025-02-01 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3053	22.5	91.0	1.3	cloudy	2025-02-02 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3054	22.0	94.0	2.6	cloudy	2025-02-02 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3055	28.4	68.0	7.5	rainy	2025-02-02 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3056	24.1	87.0	0.7	cloudy	2025-02-02 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3057	21.9	96.0	0.4	cloudy	2025-02-03 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3058	20.4	96.0	1.8	cloudy	2025-02-03 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3059	29.6	54.0	8.7	cloudy	2025-02-03 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3060	25.1	76.0	9.4	cloudy	2025-02-03 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3061	21.9	91.0	4.3	cloudy	2025-02-04 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3062	20.5	91.0	2.7	cloudy	2025-02-04 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3063	28.9	59.0	11.1	cloudy	2025-02-04 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3064	23.7	97.0	1.9	cloudy	2025-02-04 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3065	22.7	94.0	0.8	cloudy	2025-02-05 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3066	21.0	94.0	2.6	cloudy	2025-02-05 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3067	24.1	94.0	3.6	rainy	2025-02-05 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.80	1
3068	23.5	94.0	1.5	rainy	2025-02-05 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
3069	22.8	93.0	1.0	rainy	2025-02-06 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3070	20.7	97.0	5.1	cloudy	2025-02-06 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3071	23.5	96.0	1.8	rainy	2025-02-06 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.10	1
3072	23.7	91.0	0.8	cloudy	2025-02-06 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3073	21.7	97.0	3.6	cloudy	2025-02-07 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3074	20.9	95.0	1.3	cloudy	2025-02-07 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3075	27.9	71.0	6.5	rainy	2025-02-07 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3076	23.4	94.0	2.5	rainy	2025-02-07 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.20	1
3077	22.4	96.0	3.2	cloudy	2025-02-08 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3078	22.4	90.0	0.4	rainy	2025-02-08 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3079	29.0	69.0	9.9	rainy	2025-02-08 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3080	24.1	95.0	3.3	cloudy	2025-02-08 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3081	21.5	96.0	4.6	cloudy	2025-02-09 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3082	20.2	93.0	4.2	cloudy	2025-02-09 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3083	29.5	64.0	4.7	cloudy	2025-02-09 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3084	24.3	94.0	0.3	rainy	2025-02-09 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3085	22.4	94.0	4.0	cloudy	2025-02-10 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3086	22.2	89.0	0.4	cloudy	2025-02-10 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3087	26.7	75.0	12.1	cloudy	2025-02-10 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3088	23.9	91.0	0.6	rainy	2025-02-10 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3089	22.8	97.0	2.8	cloudy	2025-02-11 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3090	21.2	91.0	2.5	cloudy	2025-02-11 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3091	28.7	60.0	14.2	cloudy	2025-02-11 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3092	25.1	73.0	8.4	cloudy	2025-02-11 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3093	21.5	82.0	4.2	cloudy	2025-02-12 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3094	21.2	92.0	2.2	cloudy	2025-02-12 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3095	24.4	87.0	3.3	rainy	2025-02-12 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.60	1
3096	23.8	95.0	0.6	rainy	2025-02-12 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.50	1
3097	22.1	93.0	2.1	rainy	2025-02-13 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.00	1
3098	21.4	95.0	1.8	rainy	2025-02-13 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.90	1
3099	26.7	74.0	1.6	cloudy	2025-02-13 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3100	25.3	85.0	1.2	rainy	2025-02-13 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3101	21.7	97.0	3.1	cloudy	2025-02-14 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3102	20.4	93.0	3.3	cloudy	2025-02-14 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3103	28.9	61.0	9.4	cloudy	2025-02-14 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3104	24.5	87.0	2.5	cloudy	2025-02-14 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3105	23.1	96.0	0.8	rainy	2025-02-15 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.00	1
3106	22.1	92.0	1.0	cloudy	2025-02-15 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3107	29.0	66.0	10.1	cloudy	2025-02-15 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3108	24.9	88.0	1.2	cloudy	2025-02-15 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3109	21.6	95.0	3.1	clear	2025-02-16 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3110	19.9	91.0	4.1	cloudy	2025-02-16 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3111	29.0	58.0	8.6	cloudy	2025-02-16 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3112	25.3	78.0	4.8	cloudy	2025-02-16 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3113	22.2	92.0	2.2	cloudy	2025-02-17 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3114	20.2	89.0	2.5	cloudy	2025-02-17 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3115	30.0	61.0	8.8	cloudy	2025-02-17 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3116	23.6	97.0	0.9	rainy	2025-02-17 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3117	22.0	100.0	0.9	rainy	2025-02-18 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.60	1
3118	20.3	95.0	2.0	cloudy	2025-02-18 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3119	30.2	50.0	9.3	cloudy	2025-02-18 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3120	24.1	84.0	4.0	cloudy	2025-02-18 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3121	21.6	93.0	2.1	cloudy	2025-02-19 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3122	20.5	90.0	2.4	cloudy	2025-02-19 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3123	28.6	66.0	13.0	rainy	2025-02-19 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3124	23.8	93.0	1.7	rainy	2025-02-19 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3125	22.9	95.0	0.6	rainy	2025-02-20 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3126	21.7	95.0	1.9	cloudy	2025-02-20 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3127	28.7	64.0	13.4	rainy	2025-02-20 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3128	23.1	94.0	2.8	rainy	2025-02-20 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.70	1
3129	21.5	97.0	4.2	rainy	2025-02-21 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.70	1
3130	21.5	96.0	1.4	cloudy	2025-02-21 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3131	24.8	87.0	1.5	rainy	2025-02-21 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.40	1
3132	23.3	94.0	0.5	rainy	2025-02-21 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3133	22.6	93.0	1.0	cloudy	2025-02-22 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3134	21.9	96.0	1.9	cloudy	2025-02-22 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3135	26.5	77.0	15.7	rainy	2025-02-22 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3136	23.8	82.0	4.1	cloudy	2025-02-22 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3137	21.9	82.0	2.0	cloudy	2025-02-23 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3138	19.1	92.0	5.2	cloudy	2025-02-23 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3139	28.6	56.0	11.4	cloudy	2025-02-23 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3140	25.2	70.0	9.7	cloudy	2025-02-23 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3141	20.8	88.0	4.4	clear	2025-02-24 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3142	18.8	78.0	4.5	cloudy	2025-02-24 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3143	28.4	65.0	17.5	rainy	2025-02-24 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3144	23.6	88.0	0.2	rainy	2025-02-24 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.80	1
3145	22.4	100.0	1.8	rainy	2025-02-25 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3146	22.0	96.0	0.8	rainy	2025-02-25 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3147	27.6	60.0	11.8	cloudy	2025-02-25 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3148	23.8	86.0	4.0	rainy	2025-02-25 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3149	22.4	97.0	1.5	rainy	2025-02-26 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3150	21.8	95.0	0.7	cloudy	2025-02-26 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3151	26.2	75.0	9.2	rainy	2025-02-26 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3152	24.2	83.0	4.3	cloudy	2025-02-26 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3153	22.6	92.0	0.4	cloudy	2025-02-27 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3154	21.5	94.0	2.6	cloudy	2025-02-27 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3155	27.6	64.0	15.2	cloudy	2025-02-27 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3156	24.0	84.0	5.8	cloudy	2025-02-27 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3157	22.0	94.0	0.7	cloudy	2025-02-28 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3158	21.9	89.0	1.6	cloudy	2025-02-28 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3159	25.4	84.0	11.4	rainy	2025-02-28 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.40	1
3160	23.9	88.0	3.4	cloudy	2025-02-28 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3161	22.4	97.0	1.2	cloudy	2025-03-01 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3162	20.8	91.0	1.6	clear	2025-03-01 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3163	29.5	60.0	13.2	cloudy	2025-03-01 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3164	24.5	87.0	3.6	rainy	2025-03-01 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3165	23.0	92.0	1.1	cloudy	2025-03-02 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3166	21.6	89.0	2.0	cloudy	2025-03-02 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3167	30.4	52.0	14.9	clear	2025-03-02 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3168	25.2	76.0	6.6	cloudy	2025-03-02 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3169	22.5	94.0	0.2	cloudy	2025-03-03 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3170	22.6	94.0	0.5	rainy	2025-03-03 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3171	28.8	68.0	6.5	cloudy	2025-03-03 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3172	24.5	93.0	0.2	cloudy	2025-03-03 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3173	22.9	95.0	4.6	rainy	2025-03-04 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.80	1
3174	22.5	96.0	3.1	cloudy	2025-03-04 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3175	27.0	82.0	10.3	rainy	2025-03-04 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	5.00	1
3176	23.9	97.0	2.7	rainy	2025-03-04 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	1.40	1
3177	23.3	95.0	0.8	cloudy	2025-03-05 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3178	22.1	94.0	3.1	cloudy	2025-03-05 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3179	29.1	68.0	11.3	cloudy	2025-03-05 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3180	24.1	97.0	1.4	rainy	2025-03-05 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	2.50	1
3181	22.9	96.0	2.0	cloudy	2025-03-06 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3182	21.0	96.0	5.1	cloudy	2025-03-06 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3183	29.1	65.0	6.0	rainy	2025-03-06 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3184	24.0	98.0	1.0	rainy	2025-03-06 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.30	1
3185	22.6	97.0	2.8	cloudy	2025-03-07 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3186	21.0	92.0	2.6	cloudy	2025-03-07 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3187	29.2	62.0	17.0	rainy	2025-03-07 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3188	25.1	80.0	3.8	cloudy	2025-03-07 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3189	22.7	93.0	1.0	rainy	2025-03-08 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3190	22.1	90.0	1.1	clear	2025-03-08 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3191	28.9	60.0	11.0	cloudy	2025-03-08 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3192	25.2	80.0	4.5	cloudy	2025-03-08 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3193	21.4	93.0	2.4	cloudy	2025-03-09 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3194	20.5	83.0	2.7	cloudy	2025-03-09 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3195	27.6	70.0	10.9	rainy	2025-03-09 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3196	24.9	77.0	5.8	cloudy	2025-03-09 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3197	22.0	87.0	3.4	cloudy	2025-03-10 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3198	22.1	83.0	1.4	cloudy	2025-03-10 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3199	26.5	73.0	10.7	rainy	2025-03-10 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.10	1
3200	24.4	85.0	3.4	cloudy	2025-03-10 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3201	22.5	91.0	0.6	cloudy	2025-03-11 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3202	20.6	90.0	2.5	clear	2025-03-11 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3203	30.4	50.0	14.6	clear	2025-03-11 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3204	25.7	69.0	9.8	clear	2025-03-11 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3205	21.2	86.0	1.9	clear	2025-03-12 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3206	20.0	85.0	2.8	cloudy	2025-03-12 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3207	30.5	52.0	14.1	cloudy	2025-03-12 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3208	25.8	79.0	5.1	cloudy	2025-03-12 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3209	22.6	90.0	0.6	cloudy	2025-03-13 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3210	20.2	87.0	2.8	cloudy	2025-03-13 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3211	30.5	48.0	14.9	cloudy	2025-03-13 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3212	25.9	67.0	7.9	clear	2025-03-13 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3213	21.3	83.0	3.0	clear	2025-03-14 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3214	21.2	81.0	2.0	cloudy	2025-03-14 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3215	30.4	54.0	14.2	cloudy	2025-03-14 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3216	25.5	77.0	7.0	cloudy	2025-03-14 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3217	21.7	92.0	4.2	cloudy	2025-03-15 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3218	21.1	81.0	4.5	cloudy	2025-03-15 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3219	31.1	55.0	12.5	cloudy	2025-03-15 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3220	25.3	85.0	1.5	cloudy	2025-03-15 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3221	23.2	89.0	1.5	cloudy	2025-03-16 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3222	22.0	93.0	2.3	cloudy	2025-03-16 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3223	30.0	65.0	14.4	cloudy	2025-03-16 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3224	24.5	95.0	0.6	rainy	2025-03-16 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.50	1
3225	22.5	95.0	1.6	cloudy	2025-03-17 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3226	21.1	93.0	4.3	cloudy	2025-03-17 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3227	27.2	71.0	13.9	rainy	2025-03-17 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.90	1
3228	24.4	90.0	2.0	rainy	2025-03-17 18:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.50	1
3229	23.0	96.0	0.4	cloudy	2025-03-18 00:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3230	21.4	94.0	2.4	cloudy	2025-03-18 06:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.00	1
3231	30.3	59.0	13.2	rainy	2025-03-18 12:00:00	2026-02-12 08:44:37	2026-02-12 08:44:37	0.20	1
3232	25.5	80.0	4.6	cloudy	2025-03-18 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3233	23.1	96.0	2.0	cloudy	2025-03-19 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3234	21.6	92.0	2.0	cloudy	2025-03-19 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3235	29.9	59.0	12.8	rainy	2025-03-19 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3236	24.5	95.0	0.3	rainy	2025-03-19 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3237	23.5	95.0	1.9	cloudy	2025-03-20 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3238	21.9	94.0	3.5	clear	2025-03-20 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3239	31.0	51.0	11.9	cloudy	2025-03-20 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3240	25.6	79.0	3.1	cloudy	2025-03-20 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3241	22.8	98.0	3.1	cloudy	2025-03-21 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3242	21.1	91.0	2.3	cloudy	2025-03-21 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3243	29.5	62.0	10.9	cloudy	2025-03-21 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3244	24.6	88.0	2.1	cloudy	2025-03-21 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3245	23.3	92.0	2.3	cloudy	2025-03-22 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3246	21.8	95.0	2.0	cloudy	2025-03-22 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3247	30.5	55.0	14.4	rainy	2025-03-22 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3248	26.1	72.0	10.4	cloudy	2025-03-22 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3249	23.0	88.0	4.0	cloudy	2025-03-23 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3250	22.5	97.0	1.1	rainy	2025-03-23 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.40	1
3251	28.6	64.0	8.1	cloudy	2025-03-23 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3252	25.2	82.0	0.5	cloudy	2025-03-23 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3253	22.0	91.0	5.0	cloudy	2025-03-24 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3254	20.9	88.0	2.5	cloudy	2025-03-24 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3255	30.7	55.0	9.6	cloudy	2025-03-24 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3256	23.5	96.0	4.1	cloudy	2025-03-24 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3257	22.4	97.0	2.8	cloudy	2025-03-25 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3258	19.3	96.0	2.5	cloudy	2025-03-25 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3259	30.2	55.0	4.7	cloudy	2025-03-25 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3260	25.3	80.0	6.6	cloudy	2025-03-25 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3261	23.2	94.0	0.7	cloudy	2025-03-26 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3262	21.4	96.0	2.7	cloudy	2025-03-26 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3263	30.7	60.0	7.0	cloudy	2025-03-26 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3264	23.6	97.0	2.1	rainy	2025-03-26 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3265	22.4	99.0	3.2	cloudy	2025-03-27 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3266	22.0	95.0	2.0	cloudy	2025-03-27 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3267	30.2	63.0	11.4	cloudy	2025-03-27 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3268	24.4	95.0	1.7	rainy	2025-03-27 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3269	22.9	96.0	2.4	cloudy	2025-03-28 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3270	22.3	95.0	2.4	cloudy	2025-03-28 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3271	30.1	63.0	6.5	cloudy	2025-03-28 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3272	23.6	96.0	1.9	rainy	2025-03-28 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3273	22.5	97.0	1.9	cloudy	2025-03-29 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3274	22.0	94.0	3.0	cloudy	2025-03-29 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3275	30.4	63.0	3.1	cloudy	2025-03-29 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3276	24.2	94.0	1.3	rainy	2025-03-29 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3277	23.2	94.0	2.2	cloudy	2025-03-30 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3278	23.3	89.0	1.1	cloudy	2025-03-30 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3279	28.4	68.0	9.5	rainy	2025-03-30 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3280	23.6	94.0	2.9	rainy	2025-03-30 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3281	22.6	98.0	1.1	rainy	2025-03-31 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3282	21.9	98.0	2.5	rainy	2025-03-31 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3283	30.1	55.0	13.5	rainy	2025-03-31 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3284	25.5	81.0	3.4	clear	2025-03-31 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3285	21.1	94.0	4.5	cloudy	2025-04-01 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3286	19.5	89.0	4.0	cloudy	2025-04-01 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3287	31.2	49.0	8.8	cloudy	2025-04-01 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3288	26.4	72.0	7.6	cloudy	2025-04-01 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3289	22.9	90.0	1.9	cloudy	2025-04-02 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3290	21.7	87.0	6.7	cloudy	2025-04-02 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3291	30.6	54.0	7.0	cloudy	2025-04-02 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3292	26.5	68.0	7.2	cloudy	2025-04-02 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3293	21.5	91.0	3.2	clear	2025-04-03 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3294	19.7	89.0	5.4	cloudy	2025-04-03 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3295	31.4	49.0	7.7	cloudy	2025-04-03 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3296	25.5	81.0	4.4	cloudy	2025-04-03 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3297	23.0	91.0	1.7	cloudy	2025-04-04 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3298	21.9	87.0	2.8	cloudy	2025-04-04 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3299	29.4	57.0	10.8	cloudy	2025-04-04 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3300	26.1	73.0	8.1	cloudy	2025-04-04 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3301	22.0	91.0	3.9	cloudy	2025-04-05 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3302	20.3	85.0	3.6	clear	2025-04-05 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3303	29.6	55.0	8.6	rainy	2025-04-05 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3304	25.2	80.0	3.7	cloudy	2025-04-05 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3305	23.1	93.0	1.5	rainy	2025-04-06 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3306	22.8	91.0	1.1	cloudy	2025-04-06 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3307	30.4	60.0	13.0	cloudy	2025-04-06 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3308	24.8	93.0	0.6	cloudy	2025-04-06 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3309	22.4	99.0	1.6	rainy	2025-04-07 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3310	22.0	95.0	2.2	cloudy	2025-04-07 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3311	27.5	73.0	4.0	rainy	2025-04-07 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3312	25.0	88.0	0.9	cloudy	2025-04-07 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3313	23.4	92.0	0.7	cloudy	2025-04-08 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3314	21.0	96.0	3.3	cloudy	2025-04-08 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3315	31.5	56.0	12.1	cloudy	2025-04-08 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3316	24.6	92.0	2.1	rainy	2025-04-08 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3317	22.1	98.0	0.6	cloudy	2025-04-09 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3318	22.1	88.0	2.3	cloudy	2025-04-09 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3319	31.4	51.0	9.5	cloudy	2025-04-09 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3320	26.5	66.0	9.0	clear	2025-04-09 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3321	21.8	89.0	3.7	clear	2025-04-10 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3322	21.1	90.0	5.6	cloudy	2025-04-10 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3323	31.2	54.0	6.4	clear	2025-04-10 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3324	25.0	91.0	0.7	rainy	2025-04-10 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3325	23.1	96.0	0.3	cloudy	2025-04-11 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3326	21.5	95.0	3.2	cloudy	2025-04-11 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3327	29.5	65.0	13.6	cloudy	2025-04-11 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3328	25.3	85.0	1.4	cloudy	2025-04-11 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3329	23.5	98.0	1.5	cloudy	2025-04-12 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3330	22.2	94.0	4.9	cloudy	2025-04-12 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3331	29.2	65.0	7.8	cloudy	2025-04-12 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3332	24.5	94.0	1.8	rainy	2025-04-12 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3333	23.3	98.0	1.4	cloudy	2025-04-13 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3334	22.1	92.0	2.2	cloudy	2025-04-13 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3335	30.6	61.0	14.3	cloudy	2025-04-13 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3336	25.1	84.0	3.6	cloudy	2025-04-13 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3337	23.3	98.0	0.4	cloudy	2025-04-14 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3338	23.1	93.0	0.6	cloudy	2025-04-14 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3339	31.0	60.0	12.6	cloudy	2025-04-14 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3340	24.8	91.0	1.6	rainy	2025-04-14 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3341	23.5	95.0	0.7	clear	2025-04-15 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3342	21.2	96.0	3.5	cloudy	2025-04-15 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3343	29.3	65.0	15.5	rainy	2025-04-15 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3344	25.5	83.0	0.7	cloudy	2025-04-15 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3345	23.2	93.0	2.2	rainy	2025-04-16 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3346	23.0	92.0	0.4	cloudy	2025-04-16 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3347	30.6	51.0	13.2	cloudy	2025-04-16 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3348	26.5	70.0	8.3	cloudy	2025-04-16 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3349	20.5	95.0	6.7	cloudy	2025-04-17 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3350	20.3	78.0	4.0	cloudy	2025-04-17 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3351	31.9	46.0	9.9	cloudy	2025-04-17 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3352	24.5	92.0	2.1	cloudy	2025-04-17 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3353	23.0	97.0	2.3	cloudy	2025-04-18 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3354	21.5	94.0	4.7	clear	2025-04-18 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3355	31.8	42.0	8.5	cloudy	2025-04-18 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3356	26.6	72.0	6.3	cloudy	2025-04-18 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3357	22.0	89.0	2.4	cloudy	2025-04-19 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3358	21.9	81.0	2.4	clear	2025-04-19 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3359	31.0	54.0	12.3	cloudy	2025-04-19 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3360	25.9	83.0	0.4	rainy	2025-04-19 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3361	22.5	91.0	1.8	cloudy	2025-04-20 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3362	22.2	85.0	1.5	cloudy	2025-04-20 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3363	32.0	44.0	9.6	cloudy	2025-04-20 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3364	25.9	76.0	5.8	cloudy	2025-04-20 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3365	23.4	89.0	2.0	cloudy	2025-04-21 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3366	22.8	83.0	2.2	cloudy	2025-04-21 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3367	32.2	45.0	11.2	cloudy	2025-04-21 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3368	27.0	66.0	3.6	cloudy	2025-04-21 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3369	23.5	80.0	3.4	cloudy	2025-04-22 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3370	22.1	84.0	4.9	cloudy	2025-04-22 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3371	32.5	43.0	12.4	cloudy	2025-04-22 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3372	27.6	65.0	8.5	cloudy	2025-04-22 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3373	23.9	92.0	2.3	rainy	2025-04-23 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3374	21.8	92.0	3.4	cloudy	2025-04-23 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3375	33.5	37.0	12.2	cloudy	2025-04-23 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3376	27.8	63.0	12.3	cloudy	2025-04-23 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3377	23.1	88.0	3.1	cloudy	2025-04-24 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3378	20.8	89.0	4.3	cloudy	2025-04-24 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3379	33.1	41.0	11.8	clear	2025-04-24 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3380	27.8	66.0	11.1	clear	2025-04-24 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3381	23.9	85.0	2.2	cloudy	2025-04-25 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3382	22.3	89.0	3.2	cloudy	2025-04-25 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3383	33.2	42.0	15.3	clear	2025-04-25 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3384	23.7	94.0	5.6	rainy	2025-04-25 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.50	1
3385	22.5	91.0	5.2	cloudy	2025-04-26 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3386	21.8	91.0	3.3	cloudy	2025-04-26 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3387	27.0	74.0	5.3	cloudy	2025-04-26 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3388	24.9	88.0	1.8	rainy	2025-04-26 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3389	23.1	93.0	3.1	rainy	2025-04-27 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3390	22.1	89.0	4.1	cloudy	2025-04-27 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3391	29.9	62.0	12.4	cloudy	2025-04-27 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3392	24.6	91.0	0.4	rainy	2025-04-27 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3393	23.0	93.0	1.7	clear	2025-04-28 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3394	22.1	87.0	0.6	clear	2025-04-28 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3395	31.0	51.0	6.3	rainy	2025-04-28 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3396	23.7	89.0	2.2	rainy	2025-04-28 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.80	1
3397	22.7	96.0	1.7	cloudy	2025-04-29 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3398	22.8	93.0	1.8	cloudy	2025-04-29 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3399	30.2	59.0	12.4	cloudy	2025-04-29 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3400	24.2	97.0	1.7	rainy	2025-04-29 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3401	22.8	98.0	2.1	cloudy	2025-04-30 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3402	23.0	90.0	2.2	cloudy	2025-04-30 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3403	30.5	61.0	13.4	cloudy	2025-04-30 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3404	24.4	91.0	2.0	cloudy	2025-04-30 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3405	22.8	96.0	2.0	cloudy	2025-05-01 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3406	22.2	89.0	3.1	clear	2025-05-01 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3407	32.2	49.0	9.7	cloudy	2025-05-01 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3408	24.9	90.0	5.0	cloudy	2025-05-01 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3409	23.3	98.0	2.0	cloudy	2025-05-02 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3410	22.0	94.0	1.2	cloudy	2025-05-02 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3411	29.6	60.0	5.9	cloudy	2025-05-02 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3412	22.7	98.0	2.3	rainy	2025-05-02 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.80	1
3413	22.3	100.0	1.3	rainy	2025-05-03 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.50	1
3414	22.0	99.0	2.2	cloudy	2025-05-03 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3415	28.5	69.0	8.1	cloudy	2025-05-03 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3416	23.0	98.0	2.0	rainy	2025-05-03 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3417	22.3	98.0	0.9	cloudy	2025-05-04 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3418	21.7	99.0	4.0	cloudy	2025-05-04 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3419	30.1	58.0	8.3	rainy	2025-05-04 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3420	24.9	87.0	2.2	cloudy	2025-05-04 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3421	22.5	100.0	2.7	cloudy	2025-05-05 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3422	22.2	95.0	3.1	cloudy	2025-05-05 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3423	30.1	58.0	7.7	cloudy	2025-05-05 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3424	24.4	94.0	1.7	rainy	2025-05-05 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3425	22.6	98.0	1.6	rainy	2025-05-06 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.90	1
3426	22.1	98.0	1.3	rainy	2025-05-06 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3427	25.9	80.0	7.8	rainy	2025-05-06 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3428	23.5	99.0	2.1	rainy	2025-05-06 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3429	22.6	97.0	0.4	rainy	2025-05-07 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3430	21.2	96.0	3.5	cloudy	2025-05-07 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3431	29.6	67.0	6.2	rainy	2025-05-07 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3432	23.5	95.0	1.7	cloudy	2025-05-07 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3433	22.8	97.0	2.3	cloudy	2025-05-08 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3434	22.0	95.0	4.1	cloudy	2025-05-08 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3435	30.4	62.0	7.0	cloudy	2025-05-08 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3436	24.3	90.0	0.7	cloudy	2025-05-08 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3437	22.8	96.0	2.8	rainy	2025-05-09 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3438	22.4	93.0	4.1	clear	2025-05-09 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3439	30.5	62.0	10.7	cloudy	2025-05-09 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3440	25.9	82.0	1.1	cloudy	2025-05-09 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3441	23.2	95.0	2.8	rainy	2025-05-10 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3442	22.2	95.0	4.0	clear	2025-05-10 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3443	29.5	64.0	11.4	rainy	2025-05-10 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3444	25.1	89.0	1.4	rainy	2025-05-10 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3445	23.0	96.0	1.6	cloudy	2025-05-11 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3446	21.8	99.0	2.2	cloudy	2025-05-11 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3447	31.0	51.0	6.8	cloudy	2025-05-11 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3448	23.5	96.0	1.5	cloudy	2025-05-11 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3449	22.8	92.0	2.9	cloudy	2025-05-12 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3450	22.0	88.0	4.7	cloudy	2025-05-12 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3451	31.1	53.0	8.3	rainy	2025-05-12 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3452	25.6	89.0	0.7	rainy	2025-05-12 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3453	23.6	92.0	1.3	rainy	2025-05-13 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3454	22.3	92.0	3.1	cloudy	2025-05-13 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3455	31.6	52.0	8.1	cloudy	2025-05-13 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3456	24.9	88.0	1.2	cloudy	2025-05-13 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3457	23.3	91.0	3.8	rainy	2025-05-14 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.50	1
3458	22.6	92.0	5.6	cloudy	2025-05-14 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3459	28.3	69.0	14.9	rainy	2025-05-14 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3460	24.7	94.0	1.8	rainy	2025-05-14 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3461	23.4	98.0	0.4	rainy	2025-05-15 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3462	22.6	92.0	2.3	cloudy	2025-05-15 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3463	28.1	72.0	13.1	rainy	2025-05-15 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3464	24.8	93.0	6.6	rainy	2025-05-15 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.60	1
3465	23.1	97.0	1.1	cloudy	2025-05-16 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3466	22.4	92.0	2.1	cloudy	2025-05-16 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3467	29.5	66.0	16.0	rainy	2025-05-16 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3468	25.2	90.0	1.7	cloudy	2025-05-16 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3469	22.8	96.0	2.8	clear	2025-05-17 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3470	22.6	87.0	3.0	cloudy	2025-05-17 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3471	28.2	73.0	7.1	rainy	2025-05-17 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3472	24.5	95.0	0.9	rainy	2025-05-17 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.60	1
3473	23.0	98.0	3.1	rainy	2025-05-18 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.10	1
3474	22.7	97.0	2.8	rainy	2025-05-18 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.00	1
3475	26.2	83.0	2.1	rainy	2025-05-18 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3476	24.1	96.0	3.0	rainy	2025-05-18 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.70	1
3477	23.2	93.0	1.7	cloudy	2025-05-19 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3478	22.5	94.0	2.0	cloudy	2025-05-19 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3479	31.1	58.0	11.0	cloudy	2025-05-19 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3480	24.3	96.0	2.3	rainy	2025-05-19 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.00	1
3481	23.5	96.0	0.2	cloudy	2025-05-20 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3482	22.0	95.0	4.9	cloudy	2025-05-20 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3483	25.4	90.0	8.9	rainy	2025-05-20 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	10.10	1
3484	24.5	95.0	0.6	rainy	2025-05-20 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3485	22.6	98.0	1.0	cloudy	2025-05-21 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3486	22.6	92.0	3.3	cloudy	2025-05-21 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3487	29.7	65.0	10.5	cloudy	2025-05-21 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3488	24.1	98.0	2.1	rainy	2025-05-21 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3489	22.8	96.0	1.1	rainy	2025-05-22 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3490	23.0	92.0	1.6	cloudy	2025-05-22 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3491	28.0	75.0	8.5	rainy	2025-05-22 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3492	24.4	92.0	0.6	rainy	2025-05-22 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.50	1
3493	22.5	96.0	0.5	cloudy	2025-05-23 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3494	22.9	84.0	2.5	cloudy	2025-05-23 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3495	26.1	84.0	7.7	rainy	2025-05-23 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.00	1
3496	23.5	96.0	2.6	rainy	2025-05-23 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	6.60	1
3497	22.9	98.0	2.7	cloudy	2025-05-24 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3498	22.2	96.0	4.1	cloudy	2025-05-24 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3499	29.5	66.0	8.0	cloudy	2025-05-24 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3500	23.4	94.0	1.5	rainy	2025-05-24 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.90	1
3501	22.8	92.0	1.2	cloudy	2025-05-25 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3502	22.7	87.0	1.8	cloudy	2025-05-25 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3503	29.1	66.0	5.8	cloudy	2025-05-25 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3504	24.2	95.0	0.4	rainy	2025-05-25 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3505	23.8	96.0	1.5	rainy	2025-05-26 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.60	1
3506	22.0	97.0	4.1	cloudy	2025-05-26 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3507	30.3	60.0	5.2	clear	2025-05-26 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3508	25.1	91.0	1.6	rainy	2025-05-26 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.60	1
3509	23.3	97.0	2.0	cloudy	2025-05-27 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3510	22.0	97.0	3.8	cloudy	2025-05-27 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3511	30.5	67.0	8.7	rainy	2025-05-27 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3512	25.0	92.0	2.0	cloudy	2025-05-27 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3513	23.0	97.0	2.7	rainy	2025-05-28 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.20	1
3514	22.8	96.0	2.7	cloudy	2025-05-28 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3515	28.8	70.0	1.0	cloudy	2025-05-28 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3516	24.0	96.0	0.5	rainy	2025-05-28 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3517	23.0	98.0	1.5	cloudy	2025-05-29 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3518	22.0	97.0	0.5	rainy	2025-05-29 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.70	1
3519	29.5	64.0	4.0	cloudy	2025-05-29 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3520	24.0	96.0	0.2	rainy	2025-05-29 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3521	22.9	96.0	1.6	cloudy	2025-05-30 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3522	22.0	95.0	2.4	cloudy	2025-05-30 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3523	30.7	61.0	3.5	cloudy	2025-05-30 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3524	24.9	92.0	1.1	cloudy	2025-05-30 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3525	22.5	87.0	4.4	cloudy	2025-05-31 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3526	22.0	89.0	2.0	cloudy	2025-05-31 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3527	30.6	64.0	4.9	cloudy	2025-05-31 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3528	23.6	94.0	2.3	cloudy	2025-05-31 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3529	22.9	93.0	2.0	cloudy	2025-06-01 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3530	22.0	95.0	1.3	cloudy	2025-06-01 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3531	29.0	71.0	4.0	rainy	2025-06-01 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3532	23.8	98.0	1.5	cloudy	2025-06-01 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3533	23.1	95.0	0.8	rainy	2025-06-02 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.50	1
3534	22.1	97.0	3.4	cloudy	2025-06-02 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3535	29.8	68.0	4.1	rainy	2025-06-02 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3536	23.5	96.0	1.3	rainy	2025-06-02 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3537	22.0	99.0	3.8	cloudy	2025-06-03 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3538	21.4	99.0	3.3	cloudy	2025-06-03 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3539	28.9	70.0	5.9	cloudy	2025-06-03 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3540	23.2	98.0	3.4	rainy	2025-06-03 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3541	22.5	98.0	0.9	cloudy	2025-06-04 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3542	22.0	100.0	2.4	cloudy	2025-06-04 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3543	28.7	70.0	7.6	rainy	2025-06-04 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3544	23.8	98.0	2.8	rainy	2025-06-04 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3545	22.2	98.0	0.9	cloudy	2025-06-05 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3546	21.5	98.0	3.1	cloudy	2025-06-05 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3547	28.1	71.0	4.2	rainy	2025-06-05 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3548	23.0	98.0	3.4	rainy	2025-06-05 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3549	22.4	98.0	2.7	cloudy	2025-06-06 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3550	21.8	99.0	3.1	cloudy	2025-06-06 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3551	25.6	86.0	8.8	rainy	2025-06-06 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.30	1
3552	23.0	100.0	3.8	rainy	2025-06-06 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	1.60	1
3553	22.3	100.0	4.7	rainy	2025-06-07 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.60	1
3554	21.8	99.0	3.4	rainy	2025-06-07 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3555	26.0	86.0	3.6	rainy	2025-06-07 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3556	22.9	97.0	1.8	rainy	2025-06-07 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3557	22.1	99.0	4.1	rainy	2025-06-08 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.90	1
3558	21.2	100.0	5.3	rainy	2025-06-08 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3559	25.0	90.0	3.7	rainy	2025-06-08 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	2.30	1
3560	23.1	98.0	0.7	rainy	2025-06-08 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.40	1
3561	21.9	99.0	1.5	rainy	2025-06-09 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3562	21.3	100.0	1.7	rainy	2025-06-09 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.10	1
3563	26.5	83.0	7.4	rainy	2025-06-09 12:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.20	1
3564	23.2	98.0	1.3	rainy	2025-06-09 18:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.30	1
3565	22.4	93.0	0.8	cloudy	2025-06-10 00:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3566	21.3	98.0	4.4	cloudy	2025-06-10 06:00:00	2026-02-12 08:44:38	2026-02-12 08:44:38	0.00	1
3567	26.0	85.0	4.7	rainy	2025-06-10 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.60	1
3568	23.6	97.0	0.7	cloudy	2025-06-10 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3569	23.0	92.0	0.7	rainy	2025-06-11 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3570	21.7	96.0	4.9	cloudy	2025-06-11 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3571	26.8	74.0	6.3	cloudy	2025-06-11 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3572	24.0	98.0	1.4	rainy	2025-06-11 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3573	22.1	97.0	1.4	rainy	2025-06-12 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3574	22.0	95.0	3.2	cloudy	2025-06-12 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3575	28.9	72.0	5.6	cloudy	2025-06-12 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3576	24.1	94.0	2.1	cloudy	2025-06-12 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3577	21.8	91.0	4.9	cloudy	2025-06-13 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3578	22.0	89.0	3.1	cloudy	2025-06-13 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3579	30.7	56.0	13.4	cloudy	2025-06-13 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3580	24.4	96.0	0.7	rainy	2025-06-13 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3581	22.2	92.0	1.8	cloudy	2025-06-14 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3582	22.0	91.0	2.6	cloudy	2025-06-14 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3583	29.4	63.0	15.8	cloudy	2025-06-14 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3584	24.8	90.0	2.7	cloudy	2025-06-14 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3585	22.5	94.0	2.0	cloudy	2025-06-15 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3586	22.5	92.0	1.4	cloudy	2025-06-15 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3587	27.4	73.0	6.6	cloudy	2025-06-15 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3588	23.0	98.0	0.6	rainy	2025-06-15 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3589	22.1	99.0	1.1	cloudy	2025-06-16 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3590	21.2	100.0	2.2	cloudy	2025-06-16 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3591	26.8	76.0	8.2	rainy	2025-06-16 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3592	25.3	85.0	4.0	cloudy	2025-06-16 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3593	23.1	92.0	2.7	cloudy	2025-06-17 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3594	22.5	92.0	2.5	clear	2025-06-17 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3595	29.7	63.0	10.4	cloudy	2025-06-17 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3596	24.0	96.0	5.2	cloudy	2025-06-17 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3597	22.2	100.0	2.2	rainy	2025-06-18 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3598	21.0	98.0	5.4	cloudy	2025-06-18 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3599	28.8	69.0	2.2	rainy	2025-06-18 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3600	25.1	88.0	0.2	cloudy	2025-06-18 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3601	22.8	91.0	1.3	cloudy	2025-06-19 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3602	23.0	86.0	1.6	cloudy	2025-06-19 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3603	27.1	76.0	15.1	rainy	2025-06-19 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.00	1
3604	23.9	95.0	1.9	cloudy	2025-06-19 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3605	22.5	86.0	1.5	cloudy	2025-06-20 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3606	22.4	85.0	1.8	cloudy	2025-06-20 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3607	27.6	68.0	6.0	rainy	2025-06-20 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3608	23.9	95.0	1.5	rainy	2025-06-20 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3609	22.6	96.0	1.6	rainy	2025-06-21 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3610	21.5	94.0	2.5	cloudy	2025-06-21 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3611	26.3	78.0	7.9	rainy	2025-06-21 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.90	1
3612	22.1	98.0	5.7	rainy	2025-06-21 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.30	1
3613	21.4	100.0	1.5	cloudy	2025-06-22 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3614	20.7	99.0	1.2	cloudy	2025-06-22 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3615	28.0	73.0	7.5	cloudy	2025-06-22 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3616	22.6	99.0	3.2	rainy	2025-06-22 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.80	1
3617	21.7	99.0	2.0	rainy	2025-06-23 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3618	21.0	99.0	4.2	cloudy	2025-06-23 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3619	25.5	84.0	4.9	rainy	2025-06-23 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3620	23.1	100.0	3.7	rainy	2025-06-23 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.30	1
3621	22.0	99.0	0.5	cloudy	2025-06-24 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3622	21.0	99.0	1.5	cloudy	2025-06-24 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3623	28.5	69.0	4.9	cloudy	2025-06-24 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3624	23.5	94.0	0.3	rainy	2025-06-24 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.90	1
3625	22.0	100.0	1.3	rainy	2025-06-25 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3626	21.3	99.0	2.4	cloudy	2025-06-25 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3627	28.1	68.0	7.8	cloudy	2025-06-25 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3628	22.5	98.0	2.2	rainy	2025-06-25 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.40	1
3629	22.9	95.0	1.2	rainy	2025-06-26 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3630	21.9	100.0	1.8	cloudy	2025-06-26 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3631	26.0	80.0	7.7	rainy	2025-06-26 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.70	1
3632	23.0	97.0	1.6	rainy	2025-06-26 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	2.70	1
3633	22.5	99.0	2.9	rainy	2025-06-27 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3634	21.5	97.0	2.1	rainy	2025-06-27 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3635	27.4	80.0	5.9	rainy	2025-06-27 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3636	23.0	99.0	3.1	rainy	2025-06-27 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3637	22.0	93.0	0.8	cloudy	2025-06-28 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3638	20.6	96.0	1.9	cloudy	2025-06-28 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3639	28.5	73.0	6.0	cloudy	2025-06-28 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3640	23.1	98.0	2.3	rainy	2025-06-28 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3641	22.1	100.0	5.2	rainy	2025-06-29 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3642	21.5	100.0	3.7	rainy	2025-06-29 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3643	26.5	82.0	6.5	rainy	2025-06-29 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3644	22.0	100.0	4.7	rainy	2025-06-29 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	2.70	1
3645	21.4	99.0	3.5	rainy	2025-06-30 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3646	21.5	99.0	4.0	rainy	2025-06-30 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3647	26.0	85.0	4.5	rainy	2025-06-30 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3648	22.4	99.0	3.6	rainy	2025-06-30 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.90	1
3649	21.8	99.0	0.4	rainy	2025-07-01 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3650	21.4	99.0	4.1	rainy	2025-07-01 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3651	26.2	82.0	7.8	rainy	2025-07-01 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.70	1
3652	23.5	97.0	0.8	rainy	2025-07-01 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3653	22.9	89.0	1.0	cloudy	2025-07-02 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3654	22.2	91.0	2.9	cloudy	2025-07-02 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3655	28.6	67.0	5.9	cloudy	2025-07-02 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3656	24.2	94.0	2.3	cloudy	2025-07-02 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3657	22.8	90.0	0.7	cloudy	2025-07-03 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3658	21.9	91.0	0.5	cloudy	2025-07-03 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3659	28.0	75.0	9.4	rainy	2025-07-03 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3660	24.3	95.0	1.8	cloudy	2025-07-03 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3661	21.2	93.0	5.1	cloudy	2025-07-04 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3662	21.0	90.0	0.5	cloudy	2025-07-04 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3663	27.9	76.0	5.4	rainy	2025-07-04 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3664	23.9	96.0	0.4	rainy	2025-07-04 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3665	23.0	92.0	1.1	cloudy	2025-07-05 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3666	22.4	89.0	1.1	cloudy	2025-07-05 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3667	28.6	72.0	8.5	clear	2025-07-05 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3668	23.5	97.0	4.6	rainy	2025-07-05 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	5.00	1
3669	22.3	96.0	2.5	rainy	2025-07-06 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	2.00	1
3670	21.2	99.0	3.2	cloudy	2025-07-06 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3671	24.8	88.0	6.2	rainy	2025-07-06 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3672	24.5	88.0	4.5	cloudy	2025-07-06 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3673	22.2	95.0	1.5	cloudy	2025-07-07 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3674	21.0	93.0	0.9	cloudy	2025-07-07 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3675	29.3	67.0	5.5	cloudy	2025-07-07 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3676	22.5	96.0	5.8	rainy	2025-07-07 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	6.60	1
3677	21.4	93.0	1.7	cloudy	2025-07-08 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3678	21.4	92.0	3.3	cloudy	2025-07-08 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3679	27.3	78.0	7.4	rainy	2025-07-08 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3680	23.0	97.0	3.3	rainy	2025-07-08 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3681	21.5	99.0	4.2	rainy	2025-07-09 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3682	21.3	99.0	4.9	cloudy	2025-07-09 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3683	26.1	78.0	9.2	rainy	2025-07-09 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	3.10	1
3684	23.0	99.0	3.4	cloudy	2025-07-09 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3685	22.5	98.0	2.8	rainy	2025-07-10 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3686	21.9	100.0	3.8	rainy	2025-07-10 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3687	26.2	84.0	8.4	rainy	2025-07-10 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3688	22.9	97.0	6.4	rainy	2025-07-10 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.10	1
3689	21.8	99.0	3.1	rainy	2025-07-11 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3690	21.4	100.0	3.8	rainy	2025-07-11 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3691	25.5	82.0	6.1	rainy	2025-07-11 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3692	22.6	97.0	2.7	rainy	2025-07-11 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3693	21.7	99.0	1.5	cloudy	2025-07-12 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3694	21.2	99.0	2.5	cloudy	2025-07-12 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3695	26.5	82.0	5.4	rainy	2025-07-12 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3696	22.2	98.0	3.2	rainy	2025-07-12 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	5.30	1
3697	22.0	99.0	3.1	rainy	2025-07-13 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3698	21.6	98.0	1.4	cloudy	2025-07-13 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3699	27.7	78.0	7.2	rainy	2025-07-13 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3700	23.4	98.0	3.8	rainy	2025-07-13 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.40	1
3701	22.2	98.0	2.4	cloudy	2025-07-14 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3702	21.5	97.0	0.9	cloudy	2025-07-14 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3703	26.3	82.0	7.5	rainy	2025-07-14 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3704	22.9	98.0	2.1	rainy	2025-07-14 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	5.40	1
3705	22.1	100.0	2.8	rainy	2025-07-15 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3706	21.4	100.0	3.1	rainy	2025-07-15 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3707	25.9	83.0	6.4	rainy	2025-07-15 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3708	23.4	98.0	2.4	rainy	2025-07-15 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3709	22.1	99.0	5.4	rainy	2025-07-16 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.60	1
3710	21.4	99.0	5.9	rainy	2025-07-16 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3711	24.6	90.0	3.9	rainy	2025-07-16 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3712	22.8	97.0	5.2	rainy	2025-07-16 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	2.70	1
3713	21.9	99.0	4.7	rainy	2025-07-17 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.60	1
3714	21.4	99.0	8.9	rainy	2025-07-17 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.80	1
3715	24.8	84.0	6.9	rainy	2025-07-17 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.90	1
3716	22.4	98.0	8.1	rainy	2025-07-17 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.00	1
3717	21.5	100.0	6.4	rainy	2025-07-18 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3718	21.2	100.0	7.2	cloudy	2025-07-18 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3719	25.0	89.0	12.9	rainy	2025-07-18 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3720	22.6	96.0	9.8	rainy	2025-07-18 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3721	21.1	99.0	7.4	rainy	2025-07-19 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3722	21.0	100.0	9.7	rainy	2025-07-19 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3723	24.4	87.0	13.9	rainy	2025-07-19 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3724	23.0	96.0	2.7	cloudy	2025-07-19 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3725	21.4	97.0	3.1	cloudy	2025-07-20 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3726	21.0	100.0	3.1	cloudy	2025-07-20 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3727	26.3	81.0	6.2	rainy	2025-07-20 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3728	23.5	97.0	1.4	rainy	2025-07-20 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3729	22.5	95.0	2.0	cloudy	2025-07-21 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3730	21.9	97.0	2.3	cloudy	2025-07-21 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3731	27.6	77.0	6.9	rainy	2025-07-21 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3732	23.3	98.0	2.8	cloudy	2025-07-21 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3733	21.8	99.0	3.1	rainy	2025-07-22 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3734	21.4	97.0	0.8	rainy	2025-07-22 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3735	25.4	87.0	6.9	rainy	2025-07-22 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.60	1
3736	23.5	98.0	2.7	rainy	2025-07-22 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.80	1
3737	21.2	95.0	2.7	cloudy	2025-07-23 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3738	20.5	98.0	5.3	cloudy	2025-07-23 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3739	25.6	80.0	10.3	rainy	2025-07-23 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3740	24.5	88.0	3.5	cloudy	2025-07-23 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3741	22.8	88.0	2.7	cloudy	2025-07-24 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3742	21.9	93.0	2.8	cloudy	2025-07-24 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3743	27.6	73.0	13.8	rainy	2025-07-24 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3744	25.5	86.0	5.0	rainy	2025-07-24 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3745	23.6	84.0	0.6	cloudy	2025-07-25 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3746	22.2	87.0	2.0	cloudy	2025-07-25 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3747	29.0	65.0	17.2	clear	2025-07-25 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3748	26.0	82.0	3.8	cloudy	2025-07-25 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3749	23.0	87.0	2.1	cloudy	2025-07-26 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3750	21.0	91.0	3.1	cloudy	2025-07-26 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3751	29.1	66.0	15.3	cloudy	2025-07-26 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3752	26.0	85.0	2.9	cloudy	2025-07-26 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3753	22.7	90.0	2.5	cloudy	2025-07-27 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3754	22.0	91.0	2.3	clear	2025-07-27 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3755	28.4	71.0	11.5	cloudy	2025-07-27 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3756	24.1	95.0	8.8	rainy	2025-07-27 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3757	22.3	92.0	2.2	cloudy	2025-07-28 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3758	21.2	95.0	1.3	cloudy	2025-07-28 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3759	27.5	77.0	11.6	rainy	2025-07-28 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3760	25.3	87.0	2.7	cloudy	2025-07-28 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3761	22.9	86.0	2.4	cloudy	2025-07-29 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3762	21.4	93.0	3.3	cloudy	2025-07-29 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3763	28.9	66.0	14.9	cloudy	2025-07-29 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3764	26.1	86.0	2.7	clear	2025-07-29 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3765	22.6	91.0	1.8	cloudy	2025-07-30 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3766	21.4	92.0	2.5	cloudy	2025-07-30 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3767	29.0	66.0	9.5	cloudy	2025-07-30 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3768	26.3	85.0	1.5	cloudy	2025-07-30 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3769	23.2	91.0	2.9	cloudy	2025-07-31 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3770	21.9	94.0	0.7	cloudy	2025-07-31 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3771	29.1	68.0	7.5	cloudy	2025-07-31 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3772	26.0	89.0	2.6	cloudy	2025-07-31 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3773	23.8	92.0	1.6	cloudy	2025-08-01 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3774	22.6	88.0	0.7	cloudy	2025-08-01 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3775	29.6	66.0	6.1	cloudy	2025-08-01 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3776	23.4	96.0	8.7	rainy	2025-08-01 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3777	22.5	96.0	4.7	rainy	2025-08-02 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.60	1
3778	21.7	93.0	2.7	cloudy	2025-08-02 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3779	30.9	59.0	2.1	cloudy	2025-08-02 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3780	25.2	82.0	10.2	rainy	2025-08-02 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3781	23.6	91.0	2.1	cloudy	2025-08-03 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3782	21.5	93.0	3.4	cloudy	2025-08-03 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3783	30.9	60.0	4.0	cloudy	2025-08-03 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3784	24.0	96.0	2.5	rainy	2025-08-03 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3785	22.2	97.0	1.7	cloudy	2025-08-04 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3786	20.4	98.0	4.0	cloudy	2025-08-04 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3787	30.5	58.0	5.6	cloudy	2025-08-04 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3788	26.7	85.0	2.2	rainy	2025-08-04 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.70	1
3789	22.9	88.0	1.8	cloudy	2025-08-05 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3790	21.6	95.0	3.3	cloudy	2025-08-05 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3791	29.2	67.0	6.8	cloudy	2025-08-05 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3792	23.3	96.0	5.5	rainy	2025-08-05 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3793	22.0	99.0	1.3	cloudy	2025-08-06 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3794	20.5	100.0	7.1	cloudy	2025-08-06 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3795	27.8	73.0	8.2	rainy	2025-08-06 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3796	22.0	99.0	4.0	rainy	2025-08-06 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	7.10	1
3797	21.6	99.0	3.5	cloudy	2025-08-07 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3798	21.2	99.0	4.7	rainy	2025-08-07 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3799	27.5	77.0	9.4	rainy	2025-08-07 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3800	22.2	98.0	1.1	rainy	2025-08-07 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.30	1
3801	22.2	99.0	1.5	rainy	2025-08-08 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.40	1
3802	21.5	98.0	0.4	cloudy	2025-08-08 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3803	26.5	75.0	8.8	rainy	2025-08-08 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3804	23.9	93.0	1.1	cloudy	2025-08-08 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3805	22.8	95.0	1.7	cloudy	2025-08-09 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3806	20.9	98.0	4.1	cloudy	2025-08-09 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3807	30.0	61.0	3.8	clear	2025-08-09 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3808	24.0	94.0	0.3	rainy	2025-08-09 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3809	22.6	94.0	0.3	cloudy	2025-08-10 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3810	21.7	95.0	2.3	cloudy	2025-08-10 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3811	30.2	61.0	4.6	cloudy	2025-08-10 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3812	23.6	95.0	2.6	rainy	2025-08-10 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3813	21.6	100.0	3.2	cloudy	2025-08-11 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3814	20.2	95.0	2.7	cloudy	2025-08-11 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3815	29.2	69.0	7.4	rainy	2025-08-11 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3816	23.0	97.0	1.4	rainy	2025-08-11 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3817	21.5	100.0	0.4	cloudy	2025-08-12 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3818	20.9	100.0	2.1	cloudy	2025-08-12 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3819	27.7	67.0	3.8	cloudy	2025-08-12 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3820	22.9	92.0	2.5	rainy	2025-08-12 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.30	1
3821	21.9	93.0	0.2	cloudy	2025-08-13 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3822	21.2	94.0	1.7	cloudy	2025-08-13 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3823	27.6	71.0	7.3	cloudy	2025-08-13 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3824	22.1	98.0	5.8	rainy	2025-08-13 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	2.70	1
3825	22.2	99.0	2.7	rainy	2025-08-14 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	14.60	1
3826	21.5	99.0	1.1	rainy	2025-08-14 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3827	25.3	84.0	8.6	rainy	2025-08-14 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3828	22.0	99.0	1.5	rainy	2025-08-14 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.00	1
3829	21.7	95.0	1.9	rainy	2025-08-15 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.70	1
3830	21.0	98.0	2.0	rainy	2025-08-15 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.20	1
3831	27.5	74.0	7.3	cloudy	2025-08-15 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3832	22.6	98.0	0.9	rainy	2025-08-15 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.40	1
3833	21.4	95.0	1.1	cloudy	2025-08-16 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3834	20.5	93.0	2.1	clear	2025-08-16 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3835	29.3	62.0	1.7	clear	2025-08-16 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3836	22.6	98.0	2.5	rainy	2025-08-16 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.50	1
3837	21.7	94.0	3.2	cloudy	2025-08-17 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3838	20.9	92.0	3.0	cloudy	2025-08-17 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3839	29.4	66.0	6.9	cloudy	2025-08-17 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3840	23.1	94.0	10.5	rainy	2025-08-17 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	1.20	1
3841	22.6	92.0	2.3	rainy	2025-08-18 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.10	1
3842	20.5	97.0	2.8	cloudy	2025-08-18 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3843	29.9	62.0	10.7	cloudy	2025-08-18 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3844	25.0	89.0	0.6	cloudy	2025-08-18 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3845	22.4	91.0	3.1	cloudy	2025-08-19 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3846	22.0	90.0	1.8	cloudy	2025-08-19 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3847	24.4	90.0	8.3	rainy	2025-08-19 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	8.70	1
3848	23.1	97.0	3.2	rainy	2025-08-19 18:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.70	1
3849	22.5	90.0	0.8	cloudy	2025-08-20 00:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3850	21.2	93.0	2.9	cloudy	2025-08-20 06:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3851	28.6	66.0	3.2	cloudy	2025-08-20 12:00:00	2026-02-12 08:44:39	2026-02-12 08:44:39	0.00	1
3852	23.1	96.0	6.5	rainy	2025-08-20 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
3853	21.6	99.0	3.1	cloudy	2025-08-21 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3854	21.1	97.0	0.8	cloudy	2025-08-21 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3855	28.0	70.0	8.6	cloudy	2025-08-21 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3856	22.2	98.0	2.7	rainy	2025-08-21 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3857	21.3	99.0	3.3	cloudy	2025-08-22 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3858	20.6	99.0	2.2	cloudy	2025-08-22 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3859	27.0	75.0	9.5	rainy	2025-08-22 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3860	21.8	99.0	7.5	rainy	2025-08-22 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.40	1
3861	21.8	98.0	1.8	rainy	2025-08-23 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3862	20.9	100.0	2.3	cloudy	2025-08-23 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3863	25.4	86.0	5.4	cloudy	2025-08-23 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3864	22.6	98.0	2.2	rainy	2025-08-23 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3865	21.6	98.0	2.1	cloudy	2025-08-24 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3866	20.5	99.0	2.5	cloudy	2025-08-24 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3867	27.1	73.0	6.5	rainy	2025-08-24 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3868	22.6	96.0	2.6	rainy	2025-08-24 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3869	21.8	99.0	2.6	cloudy	2025-08-25 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3870	21.3	100.0	1.8	rainy	2025-08-25 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3871	24.2	88.0	8.4	rainy	2025-08-25 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.60	1
3872	21.9	99.0	3.9	rainy	2025-08-25 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
3873	21.3	99.0	5.0	rainy	2025-08-26 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3874	20.5	99.0	4.8	rainy	2025-08-26 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
3875	25.7	80.0	7.9	rainy	2025-08-26 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3876	22.2	97.0	4.6	rainy	2025-08-26 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	5.00	1
3877	21.6	99.0	4.0	rainy	2025-08-27 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3878	21.0	99.0	5.8	cloudy	2025-08-27 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3879	24.8	85.0	8.4	rainy	2025-08-27 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.90	1
3880	21.6	99.0	2.3	rainy	2025-08-27 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.00	1
3881	21.2	99.0	2.9	rainy	2025-08-28 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3882	20.8	99.0	5.1	rainy	2025-08-28 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3883	24.9	88.0	7.5	rainy	2025-08-28 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3884	23.5	95.0	0.5	rainy	2025-08-28 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3885	21.9	94.0	1.9	cloudy	2025-08-29 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3886	21.1	95.0	0.8	cloudy	2025-08-29 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3887	27.0	74.0	5.7	cloudy	2025-08-29 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3888	22.8	98.0	2.6	rainy	2025-08-29 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3889	22.0	99.0	2.3	rainy	2025-08-30 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3890	21.1	98.0	3.0	cloudy	2025-08-30 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3891	22.9	97.0	6.7	rainy	2025-08-30 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3892	22.2	99.0	5.3	rainy	2025-08-30 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3893	21.5	99.0	5.1	rainy	2025-08-31 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.30	1
3894	21.0	99.0	4.1	rainy	2025-08-31 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.30	1
3895	23.0	96.0	7.3	rainy	2025-08-31 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3896	22.0	99.0	2.4	rainy	2025-08-31 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3897	21.9	99.0	2.5	rainy	2025-09-01 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3898	20.9	100.0	2.7	rainy	2025-09-01 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.30	1
3899	25.5	82.0	9.1	rainy	2025-09-01 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.90	1
3900	22.8	96.0	5.8	rainy	2025-09-01 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.90	1
3901	21.9	94.0	1.8	cloudy	2025-09-02 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3902	21.1	98.0	1.3	cloudy	2025-09-02 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3903	26.9	78.0	9.4	rainy	2025-09-02 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3904	23.1	97.0	2.8	rainy	2025-09-02 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3905	22.5	94.0	1.0	rainy	2025-09-03 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
3906	21.7	93.0	1.2	cloudy	2025-09-03 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3907	27.4	71.0	7.0	cloudy	2025-09-03 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3908	24.5	90.0	2.3	rainy	2025-09-03 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3909	22.2	91.0	0.8	cloudy	2025-09-04 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3910	21.8	92.0	1.4	cloudy	2025-09-04 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3911	29.7	64.0	8.3	cloudy	2025-09-04 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3912	23.4	96.0	1.7	rainy	2025-09-04 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
3913	22.3	92.0	1.0	cloudy	2025-09-05 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3914	21.2	93.0	2.0	cloudy	2025-09-05 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3915	29.0	63.0	2.1	rainy	2025-09-05 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3916	23.1	97.0	5.2	rainy	2025-09-05 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.60	1
3917	23.0	92.0	1.4	rainy	2025-09-06 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3918	21.5	92.0	3.7	cloudy	2025-09-06 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3919	29.9	66.0	2.2	cloudy	2025-09-06 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3920	23.6	96.0	5.1	rainy	2025-09-06 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
3921	22.9	94.0	1.7	cloudy	2025-09-07 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3922	21.2	93.0	2.9	cloudy	2025-09-07 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3923	28.0	70.0	10.9	cloudy	2025-09-07 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3924	23.7	96.0	1.9	cloudy	2025-09-07 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3925	22.4	94.0	3.0	rainy	2025-09-08 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3926	21.7	91.0	0.6	cloudy	2025-09-08 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3927	28.1	72.0	7.1	rainy	2025-09-08 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
3928	23.2	97.0	3.1	rainy	2025-09-08 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3929	21.9	95.0	2.0	cloudy	2025-09-09 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3930	20.9	95.0	3.1	cloudy	2025-09-09 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3931	29.9	62.0	3.6	clear	2025-09-09 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3932	24.1	97.0	3.1	cloudy	2025-09-09 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3933	21.9	99.0	2.6	cloudy	2025-09-10 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3934	21.0	95.0	2.3	clear	2025-09-10 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3935	29.2	67.0	5.5	clear	2025-09-10 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3936	23.9	93.0	1.3	rainy	2025-09-10 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3937	22.2	100.0	1.4	cloudy	2025-09-11 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3938	21.6	98.0	1.9	cloudy	2025-09-11 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3939	29.8	63.0	4.3	cloudy	2025-09-11 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3940	22.7	97.0	3.0	rainy	2025-09-11 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
3941	21.7	99.0	2.4	rainy	2025-09-12 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3942	21.3	97.0	2.8	cloudy	2025-09-12 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3943	28.9	65.0	3.1	cloudy	2025-09-12 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3944	23.8	94.0	3.7	rainy	2025-09-12 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
3945	22.6	95.0	0.7	rainy	2025-09-13 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3946	21.8	93.0	1.0	rainy	2025-09-13 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3947	29.0	68.0	6.2	cloudy	2025-09-13 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3948	23.5	96.0	0.8	rainy	2025-09-13 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3949	22.5	98.0	0.6	cloudy	2025-09-14 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3950	21.5	99.0	1.6	cloudy	2025-09-14 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3951	28.5	73.0	6.9	cloudy	2025-09-14 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3952	22.8	98.0	5.9	rainy	2025-09-14 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.00	1
3953	21.8	98.0	1.3	rainy	2025-09-15 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.70	1
3954	21.4	99.0	1.5	cloudy	2025-09-15 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3955	27.6	74.0	8.5	cloudy	2025-09-15 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3956	22.2	98.0	3.6	rainy	2025-09-15 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
3957	22.3	99.0	2.0	cloudy	2025-09-16 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3958	21.6	99.0	2.2	cloudy	2025-09-16 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3959	25.4	84.0	9.2	rainy	2025-09-16 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
3960	23.5	94.0	0.4	rainy	2025-09-16 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3961	22.6	96.0	1.1	cloudy	2025-09-17 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3962	21.8	97.0	1.6	cloudy	2025-09-17 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3963	29.0	66.0	7.1	cloudy	2025-09-17 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3964	22.5	98.0	1.1	rainy	2025-09-17 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.20	1
3965	21.8	99.0	2.9	rainy	2025-09-18 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3966	21.0	97.0	0.6	cloudy	2025-09-18 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3967	29.0	66.0	5.9	cloudy	2025-09-18 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3968	23.6	94.0	1.2	cloudy	2025-09-18 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3969	21.1	96.0	0.6	cloudy	2025-09-19 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3970	21.4	93.0	0.3	cloudy	2025-09-19 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3971	28.2	69.0	4.3	cloudy	2025-09-19 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3972	23.5	97.0	3.8	rainy	2025-09-19 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3973	21.5	99.0	1.3	cloudy	2025-09-20 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3974	21.4	99.0	1.8	cloudy	2025-09-20 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3975	26.5	79.0	9.7	cloudy	2025-09-20 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3976	23.5	96.0	3.9	cloudy	2025-09-20 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3977	22.4	92.0	1.8	cloudy	2025-09-21 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3978	22.1	93.0	2.3	rainy	2025-09-21 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3979	26.8	84.0	13.4	rainy	2025-09-21 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3980	23.3	96.0	1.3	rainy	2025-09-21 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
3981	22.1	99.0	4.4	rainy	2025-09-22 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3982	21.5	99.0	3.6	cloudy	2025-09-22 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3983	27.6	77.0	8.0	rainy	2025-09-22 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.30	1
3984	23.5	88.0	7.9	rainy	2025-09-22 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3985	22.9	84.0	2.3	cloudy	2025-09-23 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3986	21.5	95.0	3.1	cloudy	2025-09-23 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3987	26.0	75.0	7.4	cloudy	2025-09-23 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3988	22.0	98.0	1.7	rainy	2025-09-23 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.80	1
3989	21.8	97.0	0.7	cloudy	2025-09-24 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3990	21.2	95.0	1.5	cloudy	2025-09-24 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3991	27.2	65.0	8.3	cloudy	2025-09-24 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3992	24.3	92.0	0.6	cloudy	2025-09-24 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3993	22.8	87.0	1.5	cloudy	2025-09-25 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3994	21.9	95.0	0.9	cloudy	2025-09-25 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
3995	24.0	86.0	5.5	rainy	2025-09-25 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3996	22.1	97.0	2.4	rainy	2025-09-25 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.50	1
3997	21.4	100.0	5.6	rainy	2025-09-26 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
3998	20.9	100.0	7.4	rainy	2025-09-26 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
3999	25.6	78.0	9.9	rainy	2025-09-26 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4000	23.1	93.0	5.2	cloudy	2025-09-26 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4001	20.5	93.0	2.2	cloudy	2025-09-27 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4002	19.9	88.0	2.8	cloudy	2025-09-27 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4003	31.1	53.0	3.7	cloudy	2025-09-27 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4004	24.0	89.0	2.9	cloudy	2025-09-27 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4005	21.1	97.0	3.5	cloudy	2025-09-28 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4006	20.9	95.0	4.3	cloudy	2025-09-28 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4007	29.6	64.0	6.7	cloudy	2025-09-28 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4008	23.2	98.0	2.2	rainy	2025-09-28 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.90	1
4009	22.5	92.0	1.5	cloudy	2025-09-29 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4010	21.3	94.0	3.5	cloudy	2025-09-29 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4011	29.6	66.0	7.2	clear	2025-09-29 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4012	22.0	99.0	4.0	rainy	2025-09-29 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.80	1
4013	22.5	93.0	2.4	cloudy	2025-09-30 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4014	21.2	95.0	2.9	cloudy	2025-09-30 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4015	29.0	67.0	5.3	cloudy	2025-09-30 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4016	23.5	95.0	1.6	rainy	2025-09-30 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4017	21.6	97.0	2.4	cloudy	2025-10-01 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4018	21.1	93.0	2.8	cloudy	2025-10-01 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4019	29.4	60.0	5.1	cloudy	2025-10-01 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4020	22.8	97.0	3.8	rainy	2025-10-01 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.70	1
4021	21.6	92.0	2.7	cloudy	2025-10-02 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4022	21.2	97.0	2.0	cloudy	2025-10-02 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4023	29.2	63.0	8.9	cloudy	2025-10-02 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4024	22.7	96.0	2.8	rainy	2025-10-02 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.00	1
4025	21.5	94.0	1.7	cloudy	2025-10-03 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4026	20.8	94.0	5.1	cloudy	2025-10-03 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4027	29.4	63.0	3.8	cloudy	2025-10-03 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4028	22.9	96.0	1.0	cloudy	2025-10-03 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4029	21.8	93.0	0.8	cloudy	2025-10-04 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4030	20.2	95.0	3.1	cloudy	2025-10-04 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4031	29.5	59.0	4.4	cloudy	2025-10-04 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4032	24.8	85.0	2.5	cloudy	2025-10-04 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4033	22.0	94.0	2.4	cloudy	2025-10-05 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4034	21.2	95.0	4.6	cloudy	2025-10-05 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4035	30.1	61.0	3.2	rainy	2025-10-05 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4036	24.1	94.0	3.9	cloudy	2025-10-05 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4037	22.2	98.0	2.6	cloudy	2025-10-06 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4038	21.4	96.0	0.2	cloudy	2025-10-06 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4039	30.2	62.0	5.4	cloudy	2025-10-06 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4040	23.5	96.0	0.4	cloudy	2025-10-06 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4041	21.6	98.0	2.2	cloudy	2025-10-07 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4042	21.2	98.0	3.8	cloudy	2025-10-07 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4043	27.8	70.0	6.0	cloudy	2025-10-07 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4044	22.4	99.0	2.9	rainy	2025-10-07 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4045	22.0	99.0	0.2	cloudy	2025-10-08 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4046	21.1	99.0	3.0	rainy	2025-10-08 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4047	26.1	82.0	9.1	rainy	2025-10-08 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4048	22.2	98.0	3.7	rainy	2025-10-08 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.50	1
4049	21.5	99.0	6.0	rainy	2025-10-09 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4050	21.4	99.0	4.5	rainy	2025-10-09 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
4051	25.9	78.0	10.1	rainy	2025-10-09 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4052	22.5	97.0	2.0	rainy	2025-10-09 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4053	21.6	98.0	1.5	rainy	2025-10-10 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4054	21.4	98.0	1.9	rainy	2025-10-10 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4055	24.6	83.0	6.4	rainy	2025-10-10 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4056	22.0	100.0	3.4	rainy	2025-10-10 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.10	1
4057	21.4	98.0	1.0	rainy	2025-10-11 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4058	21.4	97.0	2.0	rainy	2025-10-11 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4059	26.5	75.0	5.7	rainy	2025-10-11 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4060	23.0	96.0	1.2	rainy	2025-10-11 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4061	21.4	95.0	3.8	cloudy	2025-10-12 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4062	20.4	94.0	4.9	cloudy	2025-10-12 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4063	29.8	63.0	3.8	cloudy	2025-10-12 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4064	24.8	91.0	1.7	cloudy	2025-10-12 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4065	22.0	94.0	4.1	cloudy	2025-10-13 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4066	22.0	92.0	1.8	cloudy	2025-10-13 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4067	27.2	76.0	8.9	rainy	2025-10-13 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4068	25.0	86.0	1.5	cloudy	2025-10-13 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4069	21.1	95.0	3.8	cloudy	2025-10-14 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4070	21.5	89.0	3.1	clear	2025-10-14 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4071	29.9	61.0	3.4	clear	2025-10-14 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4072	23.2	95.0	2.0	rainy	2025-10-14 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.00	1
4073	22.1	99.0	2.5	cloudy	2025-10-15 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4074	21.6	97.0	0.9	cloudy	2025-10-15 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4075	30.0	65.0	3.4	clear	2025-10-15 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4076	23.4	96.0	1.2	cloudy	2025-10-15 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4077	22.1	97.0	3.8	cloudy	2025-10-16 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4078	21.1	95.0	3.5	cloudy	2025-10-16 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4079	30.7	59.0	6.3	cloudy	2025-10-16 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4080	25.6	84.0	0.9	cloudy	2025-10-16 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4081	23.1	92.0	0.9	cloudy	2025-10-17 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4082	22.5	94.0	2.2	cloudy	2025-10-17 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4083	28.8	74.0	5.6	rainy	2025-10-17 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4084	23.5	96.0	0.4	rainy	2025-10-17 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4085	22.4	99.0	2.3	cloudy	2025-10-18 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4086	21.8	99.0	3.7	cloudy	2025-10-18 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4087	27.5	74.0	13.8	rainy	2025-10-18 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4088	23.6	97.0	0.6	cloudy	2025-10-18 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4089	22.2	96.0	1.3	cloudy	2025-10-19 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4090	21.2	98.0	4.8	cloudy	2025-10-19 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4091	29.6	58.0	3.1	clear	2025-10-19 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4092	24.7	82.0	6.1	cloudy	2025-10-19 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4093	22.6	88.0	3.3	clear	2025-10-20 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4094	21.9	89.0	3.8	cloudy	2025-10-20 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4095	31.4	55.0	7.2	cloudy	2025-10-20 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4096	25.3	94.0	2.2	rainy	2025-10-20 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.30	1
4097	23.0	96.0	3.5	rainy	2025-10-21 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4098	22.5	93.0	1.1	cloudy	2025-10-21 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4099	29.7	68.0	1.1	cloudy	2025-10-21 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4100	23.5	98.0	1.5	cloudy	2025-10-21 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4101	22.4	96.0	1.1	cloudy	2025-10-22 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4102	21.4	99.0	3.8	rainy	2025-10-22 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.70	1
4103	29.5	69.0	3.3	rainy	2025-10-22 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4104	23.6	95.0	0.5	rainy	2025-10-22 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4105	22.2	93.0	0.6	cloudy	2025-10-23 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4106	22.4	95.0	1.9	cloudy	2025-10-23 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4107	29.4	67.0	4.6	rainy	2025-10-23 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4108	23.5	95.0	0.7	cloudy	2025-10-23 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4109	23.0	93.0	2.8	cloudy	2025-10-24 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4110	22.6	90.0	0.6	cloudy	2025-10-24 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4111	29.1	68.0	5.1	cloudy	2025-10-24 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4112	22.7	98.0	3.6	rainy	2025-10-24 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.40	1
4113	22.1	99.0	1.4	cloudy	2025-10-25 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4114	21.0	96.0	1.9	cloudy	2025-10-25 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4115	29.2	74.0	3.0	rainy	2025-10-25 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.70	1
4116	23.7	97.0	3.7	rainy	2025-10-25 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
4117	22.9	96.0	1.0	cloudy	2025-10-26 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4118	22.4	97.0	1.6	rainy	2025-10-26 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.40	1
4119	24.5	91.0	4.7	rainy	2025-10-26 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	7.10	1
4120	22.9	95.0	3.4	rainy	2025-10-26 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.10	1
4121	22.5	99.0	0.6	cloudy	2025-10-27 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4122	21.1	98.0	5.0	cloudy	2025-10-27 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4123	29.3	68.0	2.4	rainy	2025-10-27 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4124	25.1	86.0	2.7	cloudy	2025-10-27 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4125	22.5	96.0	1.4	cloudy	2025-10-28 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4126	21.0	91.0	5.5	clear	2025-10-28 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4127	29.0	62.0	4.0	cloudy	2025-10-28 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4128	24.8	91.0	3.3	rainy	2025-10-28 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4129	23.0	94.0	1.1	rainy	2025-10-29 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4130	22.3	97.0	0.8	rainy	2025-10-29 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4131	28.2	71.0	3.4	cloudy	2025-10-29 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4132	22.9	98.0	1.5	rainy	2025-10-29 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4133	22.4	98.0	1.0	rainy	2025-10-30 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4134	22.1	99.0	0.6	cloudy	2025-10-30 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4135	26.7	78.0	7.4	rainy	2025-10-30 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4136	23.0	97.0	1.0	rainy	2025-10-30 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4137	22.4	98.0	2.2	cloudy	2025-10-31 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4138	22.0	97.0	1.9	cloudy	2025-10-31 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4139	28.5	70.0	6.7	cloudy	2025-10-31 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4140	23.6	94.0	1.3	cloudy	2025-10-31 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4141	22.0	96.0	1.1	cloudy	2025-11-01 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4142	22.0	95.0	2.0	cloudy	2025-11-01 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4143	26.6	80.0	2.6	rainy	2025-11-01 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4144	23.0	96.0	1.1	rainy	2025-11-01 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4145	20.9	98.0	2.5	cloudy	2025-11-02 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4146	20.5	95.0	2.2	cloudy	2025-11-02 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4147	29.8	65.0	5.2	clear	2025-11-02 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4148	23.6	95.0	1.7	rainy	2025-11-02 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.30	1
4149	21.3	96.0	1.3	cloudy	2025-11-03 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4150	21.1	98.0	4.0	cloudy	2025-11-03 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4151	25.3	83.0	5.2	rainy	2025-11-03 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.70	1
4152	22.3	99.0	6.3	rainy	2025-11-03 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	2.30	1
4153	21.9	98.0	8.2	rainy	2025-11-04 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	1.70	1
4154	21.7	99.0	10.0	rainy	2025-11-04 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4155	24.9	87.0	19.2	rainy	2025-11-04 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.70	1
4156	22.4	99.0	5.6	rainy	2025-11-04 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.40	1
4157	22.2	98.0	6.2	cloudy	2025-11-05 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4158	21.0	99.0	3.8	cloudy	2025-11-05 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4159	28.5	70.0	10.8	cloudy	2025-11-05 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4160	24.8	88.0	4.8	cloudy	2025-11-05 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4161	22.8	89.0	2.8	cloudy	2025-11-06 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4162	22.4	85.0	3.4	cloudy	2025-11-06 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4163	28.6	71.0	7.4	cloudy	2025-11-06 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4164	24.3	91.0	0.4	cloudy	2025-11-06 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4165	22.1	94.0	4.2	cloudy	2025-11-07 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4166	21.8	88.0	1.5	cloudy	2025-11-07 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4167	30.8	55.0	8.0	cloudy	2025-11-07 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4168	25.0	83.0	1.0	cloudy	2025-11-07 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4169	23.0	92.0	2.3	cloudy	2025-11-08 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4170	21.9	98.0	4.1	cloudy	2025-11-08 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4171	28.5	67.0	5.8	cloudy	2025-11-08 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4172	23.5	94.0	3.2	cloudy	2025-11-08 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4173	22.7	99.0	6.9	rainy	2025-11-09 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.10	1
4174	22.0	100.0	12.2	rainy	2025-11-09 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
4175	25.2	87.0	22.5	rainy	2025-11-09 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.60	1
4176	23.5	95.0	10.2	cloudy	2025-11-09 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4177	22.8	94.0	5.9	cloudy	2025-11-10 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4178	21.6	97.0	4.5	cloudy	2025-11-10 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4179	27.8	75.0	10.4	rainy	2025-11-10 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.20	1
4180	23.2	96.0	2.4	cloudy	2025-11-10 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4181	22.4	98.0	3.7	cloudy	2025-11-11 00:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4182	21.8	97.0	1.3	cloudy	2025-11-11 06:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4183	29.4	64.0	5.0	cloudy	2025-11-11 12:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4184	23.4	96.0	1.5	cloudy	2025-11-11 18:00:00	2026-02-12 08:44:40	2026-02-12 08:44:40	0.00	1
4185	21.6	95.0	3.4	cloudy	2025-11-12 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4186	20.9	94.0	3.4	cloudy	2025-11-12 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4187	29.7	64.0	2.2	cloudy	2025-11-12 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4188	23.8	94.0	0.2	cloudy	2025-11-12 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4189	22.1	93.0	2.2	cloudy	2025-11-13 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4190	22.0	93.0	2.6	cloudy	2025-11-13 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4191	28.4	73.0	1.8	cloudy	2025-11-13 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4192	23.5	94.0	0.4	rainy	2025-11-13 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4193	22.5	97.0	0.8	rainy	2025-11-14 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.70	1
4194	22.5	92.0	0.5	rainy	2025-11-14 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.40	1
4195	24.5	91.0	3.1	rainy	2025-11-14 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4196	23.6	96.0	2.1	rainy	2025-11-14 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.40	1
4197	22.7	95.0	2.3	rainy	2025-11-15 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4198	22.1	94.0	3.2	rainy	2025-11-15 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4199	27.9	71.0	9.9	rainy	2025-11-15 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4200	23.9	94.0	2.3	rainy	2025-11-15 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	2.20	1
4201	22.5	98.0	3.7	cloudy	2025-11-16 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4202	22.2	92.0	2.4	cloudy	2025-11-16 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4203	28.0	71.0	12.7	rainy	2025-11-16 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4204	24.3	95.0	0.5	cloudy	2025-11-16 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4205	22.2	91.0	2.8	cloudy	2025-11-17 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4206	21.7	88.0	3.1	cloudy	2025-11-17 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4207	29.5	64.0	10.5	cloudy	2025-11-17 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4208	23.9	93.0	0.9	rainy	2025-11-17 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.40	1
4209	22.2	97.0	0.6	rainy	2025-11-18 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.40	1
4210	21.2	96.0	3.1	cloudy	2025-11-18 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4211	29.1	66.0	11.3	cloudy	2025-11-18 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4212	23.7	94.0	1.7	cloudy	2025-11-18 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4213	22.1	95.0	2.2	cloudy	2025-11-19 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4214	22.4	90.0	2.1	cloudy	2025-11-19 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4215	26.4	82.0	5.3	rainy	2025-11-19 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4216	23.4	96.0	1.0	cloudy	2025-11-19 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4217	22.1	93.0	3.0	cloudy	2025-11-20 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4218	21.2	88.0	1.9	cloudy	2025-11-20 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4219	27.6	73.0	9.7	rainy	2025-11-20 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.10	1
4220	24.9	81.0	1.6	cloudy	2025-11-20 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4221	21.6	86.0	3.1	cloudy	2025-11-21 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4222	21.4	86.0	4.1	cloudy	2025-11-21 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4223	29.6	58.0	12.1	cloudy	2025-11-21 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4224	24.6	79.0	3.2	cloudy	2025-11-21 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4225	21.4	88.0	4.6	cloudy	2025-11-22 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4226	20.2	89.0	3.8	cloudy	2025-11-22 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4227	30.5	56.0	12.3	cloudy	2025-11-22 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4228	26.0	71.0	10.5	cloudy	2025-11-22 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4229	22.9	88.0	2.3	cloudy	2025-11-23 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4230	21.9	95.0	1.9	cloudy	2025-11-23 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4231	30.2	64.0	7.0	rainy	2025-11-23 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4232	24.0	97.0	2.2	cloudy	2025-11-23 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4233	22.2	96.0	2.2	cloudy	2025-11-24 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4234	22.5	94.0	0.4	rainy	2025-11-24 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.60	1
4235	23.6	94.0	6.7	rainy	2025-11-24 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.10	1
4236	22.4	100.0	4.0	rainy	2025-11-24 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.80	1
4237	22.0	100.0	5.5	rainy	2025-11-25 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4238	21.9	98.0	5.2	cloudy	2025-11-25 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4239	26.4	78.0	14.1	rainy	2025-11-25 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4240	23.6	93.0	1.0	cloudy	2025-11-25 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4241	22.0	100.0	4.0	cloudy	2025-11-26 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4242	21.5	95.0	3.1	cloudy	2025-11-26 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4243	29.5	63.0	5.2	cloudy	2025-11-26 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4244	26.0	81.0	2.0	cloudy	2025-11-26 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4245	23.4	97.0	2.4	cloudy	2025-11-27 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4246	22.2	97.0	4.0	clear	2025-11-27 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4247	29.9	66.0	4.1	clear	2025-11-27 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4248	25.2	85.0	0.7	cloudy	2025-11-27 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4249	23.4	87.0	3.4	rainy	2025-11-28 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4250	22.2	93.0	2.7	cloudy	2025-11-28 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4251	30.1	65.0	2.7	rainy	2025-11-28 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4252	23.9	96.0	3.1	cloudy	2025-11-28 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4253	22.7	95.0	0.6	cloudy	2025-11-29 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4254	21.1	97.0	2.2	cloudy	2025-11-29 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4255	30.1	66.0	4.2	rainy	2025-11-29 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4256	24.0	95.0	1.7	cloudy	2025-11-29 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4257	22.3	96.0	1.8	cloudy	2025-11-30 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4258	21.0	96.0	2.9	cloudy	2025-11-30 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4259	31.2	57.0	4.0	cloudy	2025-11-30 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4260	25.0	94.0	2.7	cloudy	2025-11-30 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4261	22.0	96.0	5.8	rainy	2025-12-01 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4262	22.1	96.0	4.6	rainy	2025-12-01 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.50	1
4263	24.5	94.0	1.3	rainy	2025-12-01 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	2.00	1
4264	24.0	96.0	1.9	rainy	2025-12-01 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4265	20.9	98.0	3.8	cloudy	2025-12-02 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4266	20.0	98.0	3.8	cloudy	2025-12-02 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4267	29.6	60.0	2.9	cloudy	2025-12-02 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4268	24.4	94.0	2.6	rainy	2025-12-02 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4269	21.2	96.0	4.2	cloudy	2025-12-03 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4270	19.6	97.0	4.3	cloudy	2025-12-03 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4271	30.2	58.0	4.7	rainy	2025-12-03 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4272	25.2	81.0	4.1	cloudy	2025-12-03 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4273	21.5	89.0	4.5	cloudy	2025-12-04 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4274	20.2	91.0	2.0	clear	2025-12-04 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4275	29.6	61.0	6.7	cloudy	2025-12-04 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4276	24.5	82.0	7.8	cloudy	2025-12-04 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4277	23.4	92.0	0.4	cloudy	2025-12-05 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4278	21.5	97.0	1.5	cloudy	2025-12-05 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4279	29.2	65.0	11.0	rainy	2025-12-05 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4280	23.0	98.0	2.0	rainy	2025-12-05 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.90	1
4281	22.0	97.0	2.2	cloudy	2025-12-06 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4282	21.5	92.0	1.5	cloudy	2025-12-06 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4283	29.0	70.0	5.1	rainy	2025-12-06 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4284	23.1	99.0	3.3	rainy	2025-12-06 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4285	21.9	99.0	1.8	cloudy	2025-12-07 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4286	21.6	96.0	4.2	cloudy	2025-12-07 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4287	29.0	69.0	3.3	cloudy	2025-12-07 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4288	23.7	97.0	3.4	rainy	2025-12-07 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.90	1
4289	22.1	95.0	1.8	clear	2025-12-08 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4290	21.5	94.0	2.6	cloudy	2025-12-08 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4291	30.2	64.0	10.9	cloudy	2025-12-08 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4292	25.0	90.0	0.2	cloudy	2025-12-08 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4293	22.7	90.0	2.6	cloudy	2025-12-09 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4294	21.5	89.0	4.6	cloudy	2025-12-09 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4295	30.2	55.0	8.0	cloudy	2025-12-09 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4296	24.8	79.0	4.3	cloudy	2025-12-09 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4297	21.4	89.0	2.9	cloudy	2025-12-10 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4298	18.9	90.0	3.3	cloudy	2025-12-10 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4299	30.8	54.0	12.5	cloudy	2025-12-10 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4300	25.3	79.0	4.8	cloudy	2025-12-10 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4301	22.2	91.0	1.6	cloudy	2025-12-11 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4302	21.5	88.0	2.9	cloudy	2025-12-11 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4303	29.8	62.0	11.5	rainy	2025-12-11 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4304	25.5	77.0	6.7	cloudy	2025-12-11 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4305	21.9	90.0	2.1	cloudy	2025-12-12 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4306	21.0	86.0	2.7	cloudy	2025-12-12 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4307	30.6	55.0	14.8	cloudy	2025-12-12 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4308	25.2	78.0	4.5	cloudy	2025-12-12 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4309	19.8	92.0	3.6	cloudy	2025-12-13 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4310	20.3	78.0	3.1	cloudy	2025-12-13 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4311	30.4	50.0	15.2	cloudy	2025-12-13 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4312	25.1	73.0	6.4	cloudy	2025-12-13 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4313	21.0	90.0	3.8	cloudy	2025-12-14 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4314	19.7	88.0	3.5	cloudy	2025-12-14 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4315	29.4	57.0	10.0	cloudy	2025-12-14 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4316	24.7	82.0	2.9	cloudy	2025-12-14 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4317	22.3	90.0	2.4	rainy	2025-12-15 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4318	21.0	88.0	1.6	clear	2025-12-15 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4319	28.1	71.0	8.8	rainy	2025-12-15 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4320	23.4	92.0	0.7	rainy	2025-12-15 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.70	1
4321	22.1	95.0	1.5	cloudy	2025-12-16 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4322	22.0	91.0	1.5	rainy	2025-12-16 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4323	29.5	59.0	11.2	cloudy	2025-12-16 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4324	25.0	78.0	4.3	cloudy	2025-12-16 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4325	21.4	87.0	3.1	cloudy	2025-12-17 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4326	21.8	77.0	2.4	rainy	2025-12-17 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4327	28.0	63.0	9.2	cloudy	2025-12-17 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4328	24.0	96.0	0.3	rainy	2025-12-17 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.50	1
4329	22.6	88.0	1.1	cloudy	2025-12-18 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4330	22.3	88.0	0.4	cloudy	2025-12-18 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4331	26.9	72.0	9.9	rainy	2025-12-18 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4332	23.9	92.0	1.0	rainy	2025-12-18 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4333	20.9	97.0	2.4	cloudy	2025-12-19 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4334	20.6	94.0	3.5	cloudy	2025-12-19 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4335	25.6	83.0	5.2	rainy	2025-12-19 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.70	1
4336	23.3	91.0	2.1	cloudy	2025-12-19 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4337	21.7	88.0	2.6	cloudy	2025-12-20 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4338	21.0	91.0	2.5	cloudy	2025-12-20 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4339	29.5	64.0	7.2	cloudy	2025-12-20 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4340	22.6	98.0	3.7	rainy	2025-12-20 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.40	1
4341	23.0	90.0	1.4	cloudy	2025-12-21 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4342	21.7	96.0	2.6	cloudy	2025-12-21 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4343	28.8	63.0	10.3	cloudy	2025-12-21 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4344	23.6	97.0	4.7	rainy	2025-12-21 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4345	22.2	95.0	2.5	cloudy	2025-12-22 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4346	21.0	95.0	2.5	cloudy	2025-12-22 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4347	28.9	64.0	9.0	rainy	2025-12-22 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4348	24.6	86.0	5.2	rainy	2025-12-22 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4349	22.1	97.0	2.6	rainy	2025-12-23 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	2.00	1
4350	22.0	93.0	1.9	cloudy	2025-12-23 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4351	26.0	82.0	7.7	rainy	2025-12-23 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	1.50	1
4352	24.9	88.0	4.3	rainy	2025-12-23 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4353	22.3	96.0	3.2	cloudy	2025-12-24 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4354	21.4	93.0	4.0	cloudy	2025-12-24 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4355	29.0	67.0	9.7	rainy	2025-12-24 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4356	24.2	92.0	0.7	rainy	2025-12-24 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	3.10	1
4357	23.3	89.0	1.3	cloudy	2025-12-25 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4358	21.4	95.0	3.4	cloudy	2025-12-25 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4359	29.4	68.0	5.5	rainy	2025-12-25 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4360	22.5	99.0	2.7	rainy	2025-12-25 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4361	22.0	95.0	1.4	cloudy	2025-12-26 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4362	20.5	98.0	4.4	cloudy	2025-12-26 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4363	30.1	52.0	9.0	cloudy	2025-12-26 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4364	25.1	79.0	4.9	cloudy	2025-12-26 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4365	21.5	91.0	4.0	cloudy	2025-12-27 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4366	20.9	87.0	2.9	cloudy	2025-12-27 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4367	30.2	61.0	8.7	cloudy	2025-12-27 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4368	24.1	95.0	1.8	cloudy	2025-12-27 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4369	22.9	89.0	1.5	cloudy	2025-12-28 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4370	20.9	95.0	1.3	cloudy	2025-12-28 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4371	27.6	73.0	4.1	cloudy	2025-12-28 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4372	23.4	98.0	5.6	rainy	2025-12-28 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	3.60	1
4373	23.0	96.0	1.0	cloudy	2025-12-29 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4374	21.4	96.0	2.4	cloudy	2025-12-29 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4375	29.1	62.0	4.9	cloudy	2025-12-29 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4376	24.4	91.0	2.7	cloudy	2025-12-29 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4377	22.7	92.0	1.8	cloudy	2025-12-30 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4378	21.8	94.0	2.9	cloudy	2025-12-30 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4379	29.5	63.0	5.8	rainy	2025-12-30 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4380	23.4	96.0	0.9	rainy	2025-12-30 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4381	22.3	98.0	2.2	cloudy	2025-12-31 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4382	21.3	95.0	2.9	cloudy	2025-12-31 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4383	29.4	61.0	4.4	rainy	2025-12-31 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4384	23.5	96.0	2.1	rainy	2025-12-31 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	3.00	1
4385	22.2	97.0	2.5	cloudy	2026-01-01 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4386	21.6	93.0	3.8	cloudy	2026-01-01 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4387	29.4	66.0	6.0	cloudy	2026-01-01 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4388	24.5	94.0	0.6	cloudy	2026-01-01 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4389	23.0	97.0	1.7	rainy	2026-01-02 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4390	21.9	99.0	1.7	cloudy	2026-01-02 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4391	28.8	67.0	4.2	cloudy	2026-01-02 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4392	22.7	97.0	1.8	rainy	2026-01-02 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4393	22.5	97.0	0.5	rainy	2026-01-03 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4394	20.5	97.0	5.4	cloudy	2026-01-03 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4395	25.5	92.0	4.5	rainy	2026-01-03 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	12.80	1
4396	23.8	92.0	1.7	rainy	2026-01-03 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4397	22.1	97.0	3.4	rainy	2026-01-04 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4398	21.2	98.0	3.8	cloudy	2026-01-04 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4399	27.9	74.0	6.1	rainy	2026-01-04 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.40	1
4400	22.5	98.0	3.1	cloudy	2026-01-04 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4401	22.1	97.0	1.3	cloudy	2026-01-05 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4402	20.1	97.0	2.5	cloudy	2026-01-05 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4403	29.4	56.0	11.0	cloudy	2026-01-05 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4404	25.0	80.0	2.9	cloudy	2026-01-05 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4405	23.4	87.0	0.4	cloudy	2026-01-06 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4406	21.5	96.0	0.9	cloudy	2026-01-06 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4407	29.2	68.0	6.2	cloudy	2026-01-06 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4408	25.1	83.0	2.2	cloudy	2026-01-06 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4409	21.7	99.0	1.4	cloudy	2026-01-07 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4410	21.0	97.0	1.0	cloudy	2026-01-07 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4411	30.0	61.0	5.9	clear	2026-01-07 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4412	25.1	88.0	2.2	rainy	2026-01-07 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4413	22.8	97.0	1.9	cloudy	2026-01-08 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4414	21.1	98.0	4.7	cloudy	2026-01-08 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4415	30.5	55.0	9.4	cloudy	2026-01-08 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4416	26.1	74.0	7.0	cloudy	2026-01-08 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4417	21.5	93.0	2.7	cloudy	2026-01-09 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4418	20.8	88.0	2.0	cloudy	2026-01-09 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4419	29.5	61.0	4.0	rainy	2026-01-09 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4420	25.4	81.0	4.9	cloudy	2026-01-09 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4421	21.8	90.0	2.1	cloudy	2026-01-10 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4422	21.1	88.0	2.5	cloudy	2026-01-10 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4423	29.2	64.0	7.0	cloudy	2026-01-10 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4424	24.2	89.0	1.4	cloudy	2026-01-10 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4425	22.1	95.0	2.7	rainy	2026-01-11 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4426	21.4	88.0	2.5	cloudy	2026-01-11 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4427	28.6	62.0	15.6	rainy	2026-01-11 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4428	24.8	84.0	1.0	cloudy	2026-01-11 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4429	21.7	91.0	3.1	cloudy	2026-01-12 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4430	20.4	91.0	2.2	cloudy	2026-01-12 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4431	30.1	52.0	8.5	cloudy	2026-01-12 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4432	25.5	71.0	7.2	cloudy	2026-01-12 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4433	21.5	90.0	3.3	cloudy	2026-01-13 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4434	19.0	91.0	4.3	cloudy	2026-01-13 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4435	28.5	59.0	3.3	cloudy	2026-01-13 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4436	25.0	79.0	1.6	cloudy	2026-01-13 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4437	22.6	97.0	2.1	rainy	2026-01-14 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4438	21.4	92.0	2.4	cloudy	2026-01-14 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4439	28.2	65.0	1.6	cloudy	2026-01-14 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4440	25.1	72.0	8.7	cloudy	2026-01-14 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4441	22.4	83.0	1.5	cloudy	2026-01-15 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4442	22.3	85.0	3.1	cloudy	2026-01-15 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4443	26.8	64.0	13.5	cloudy	2026-01-15 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4444	25.1	73.0	5.1	cloudy	2026-01-15 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4445	23.7	84.0	0.7	cloudy	2026-01-16 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4446	21.8	98.0	2.6	rainy	2026-01-16 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4447	27.8	63.0	8.4	cloudy	2026-01-16 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4448	23.8	96.0	2.3	rainy	2026-01-16 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4449	22.1	100.0	3.0	rainy	2026-01-17 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4450	21.1	98.0	1.1	rainy	2026-01-17 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.40	1
4451	27.5	68.0	9.4	cloudy	2026-01-17 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4452	24.6	92.0	1.7	rainy	2026-01-17 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4453	20.5	93.0	3.4	clear	2026-01-18 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4454	19.4	90.0	1.8	cloudy	2026-01-18 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4455	29.6	56.0	4.9	clear	2026-01-18 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4456	25.4	66.0	7.7	cloudy	2026-01-18 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4457	22.7	76.0	4.5	cloudy	2026-01-19 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4458	20.6	77.0	3.5	cloudy	2026-01-19 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4459	29.7	58.0	0.7	clear	2026-01-19 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4460	23.9	95.0	1.7	rainy	2026-01-19 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4461	20.8	80.0	5.5	cloudy	2026-01-20 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4462	20.2	76.0	3.8	cloudy	2026-01-20 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4463	27.6	64.0	1.7	cloudy	2026-01-20 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4464	24.6	72.0	6.0	cloudy	2026-01-20 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4465	20.1	75.0	4.2	cloudy	2026-01-21 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4466	18.4	85.0	4.5	cloudy	2026-01-21 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4467	29.9	50.0	13.4	clear	2026-01-21 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4468	24.8	70.0	11.5	cloudy	2026-01-21 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4469	20.0	88.0	6.9	clear	2026-01-22 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4470	19.5	89.0	6.4	clear	2026-01-22 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4471	29.6	50.0	11.6	rainy	2026-01-22 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4472	24.6	72.0	8.4	clear	2026-01-22 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4473	20.8	86.0	5.9	clear	2026-01-23 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4474	19.1	87.0	5.5	cloudy	2026-01-23 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4475	30.2	46.0	9.2	cloudy	2026-01-23 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4476	24.5	73.0	5.2	cloudy	2026-01-23 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4477	20.4	86.0	5.2	cloudy	2026-01-24 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4478	19.2	84.0	5.8	cloudy	2026-01-24 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4479	30.5	46.0	3.4	cloudy	2026-01-24 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4480	25.0	76.0	5.8	cloudy	2026-01-24 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4481	22.9	82.0	2.4	cloudy	2026-01-25 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4482	21.6	84.0	3.2	rainy	2026-01-25 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4483	28.2	62.0	4.1	rainy	2026-01-25 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4484	25.2	71.0	8.1	cloudy	2026-01-25 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4485	23.0	76.0	6.3	cloudy	2026-01-26 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4486	21.7	85.0	0.9	cloudy	2026-01-26 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4487	29.1	58.0	4.0	cloudy	2026-01-26 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4488	23.3	98.0	1.7	rainy	2026-01-26 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4489	22.2	97.0	4.0	cloudy	2026-01-27 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4490	21.0	94.0	3.4	cloudy	2026-01-27 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4491	29.7	57.0	1.9	cloudy	2026-01-27 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4492	25.4	85.0	3.7	cloudy	2026-01-27 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4493	23.0	90.0	4.8	cloudy	2026-01-28 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4494	21.0	94.0	5.0	cloudy	2026-01-28 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4495	29.0	61.0	14.9	rainy	2026-01-28 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4496	23.9	81.0	3.7	rainy	2026-01-28 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4497	21.5	94.0	3.6	cloudy	2026-01-29 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4498	19.4	95.0	3.3	clear	2026-01-29 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4499	30.0	48.0	14.1	cloudy	2026-01-29 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4500	24.7	74.0	7.4	cloudy	2026-01-29 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4501	20.6	91.0	4.0	cloudy	2026-01-30 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4502	19.4	91.0	4.3	cloudy	2026-01-30 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4503	30.4	48.0	7.8	cloudy	2026-01-30 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4504	24.7	71.0	7.7	cloudy	2026-01-30 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4505	21.0	82.0	4.2	cloudy	2026-01-31 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4506	18.4	79.0	3.1	cloudy	2026-01-31 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4507	30.4	52.0	3.5	cloudy	2026-01-31 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4508	25.3	77.0	6.2	cloudy	2026-01-31 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4509	22.0	94.0	5.6	rainy	2026-02-01 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.20	1
4510	20.5	95.0	2.8	cloudy	2026-02-01 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4511	30.0	55.0	11.8	cloudy	2026-02-01 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4512	26.5	68.0	9.2	cloudy	2026-02-01 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4513	20.5	91.0	4.7	cloudy	2026-02-02 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4514	19.1	88.0	4.2	cloudy	2026-02-02 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4515	26.6	69.0	5.5	rainy	2026-02-02 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.10	1
4516	25.4	78.0	5.1	cloudy	2026-02-02 18:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4517	21.5	93.0	2.6	clear	2026-02-03 00:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4518	21.3	91.0	1.7	rainy	2026-02-03 06:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.30	1
4519	28.2	67.0	12.1	cloudy	2026-02-03 12:00:00	2026-02-12 08:44:41	2026-02-12 08:44:41	0.00	1
4520	23.0	97.0	1.0	rainy	2026-02-03 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.10	1
4521	21.0	98.0	3.1	cloudy	2026-02-04 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4522	19.0	97.0	5.2	cloudy	2026-02-04 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4523	29.7	53.0	11.6	cloudy	2026-02-04 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4524	24.9	76.0	5.5	cloudy	2026-02-04 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4525	22.4	82.0	4.7	cloudy	2026-02-05 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4526	21.2	87.0	3.2	cloudy	2026-02-05 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4527	22.2	98.0	2.6	rainy	2026-02-05 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	11.90	1
4528	21.4	98.0	4.5	rainy	2026-02-05 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	1.70	1
4529	21.8	99.0	5.2	rainy	2026-02-06 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	1.70	1
4530	21.9	100.0	3.6	rainy	2026-02-06 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.30	1
4531	26.0	81.0	11.4	rainy	2026-02-06 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.10	1
4532	23.6	93.0	1.2	rainy	2026-02-06 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.10	1
4533	22.6	92.0	0.4	cloudy	2026-02-07 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4534	21.4	98.0	1.5	cloudy	2026-02-07 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4535	28.8	64.0	10.6	cloudy	2026-02-07 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4536	25.5	80.0	3.1	cloudy	2026-02-07 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4537	22.8	92.0	0.9	cloudy	2026-02-08 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4538	21.9	96.0	3.2	cloudy	2026-02-08 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4539	26.8	64.0	4.5	cloudy	2026-02-08 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4540	24.0	87.0	2.3	cloudy	2026-02-08 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4541	23.0	87.0	2.7	cloudy	2026-02-09 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4542	21.3	92.0	2.4	cloudy	2026-02-09 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4543	30.1	56.0	5.6	cloudy	2026-02-09 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4544	24.8	88.0	1.2	cloudy	2026-02-09 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4545	22.5	91.0	2.2	cloudy	2026-02-10 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4546	20.8	92.0	4.4	cloudy	2026-02-10 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4547	30.6	58.0	5.8	cloudy	2026-02-10 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4548	24.1	88.0	3.8	cloudy	2026-02-10 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4549	22.1	95.0	2.0	cloudy	2026-02-11 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4550	21.0	95.0	3.2	cloudy	2026-02-11 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4551	29.6	61.0	11.0	rainy	2026-02-11 12:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.20	1
4552	24.5	88.0	2.8	rainy	2026-02-11 18:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.30	1
4553	22.5	95.0	2.5	cloudy	2026-02-12 00:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4554	21.5	93.0	3.1	cloudy	2026-02-12 06:00:00	2026-02-12 08:44:42	2026-02-12 08:44:42	0.00	1
4555	24.4	82.0	8.0	cloudy	2026-02-13 02:30:00	2026-02-12 18:34:14	2026-02-12 18:34:14	0.00	1
4556	24.9	79.0	8.7	cloudy	2026-02-13 20:45:00	2026-02-13 12:45:02	2026-02-13 12:45:02	0.00	1
\.


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 220
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 4, true);


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 222
-- Name: automated_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.automated_tasks_id_seq', 1, false);


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 224
-- Name: buyers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.buyers_id_seq', 1, true);


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 228
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 12, true);


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 230
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 232
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.expenses_id_seq', 9, true);


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 234
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 236
-- Name: farms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.farms_id_seq', 1, true);


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 238
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.favorites_id_seq', 1, false);


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 240
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fields_id_seq', 3, true);


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 242
-- Name: group_laborer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.group_laborer_id_seq', 1, false);


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 244
-- Name: harvests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.harvests_id_seq', 5, true);


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 246
-- Name: inventory_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_alerts_id_seq', 1, false);


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 248
-- Name: inventory_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_categories_id_seq', 1, false);


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 250
-- Name: inventory_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_items_id_seq', 6, true);


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 252
-- Name: inventory_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_transactions_id_seq', 9, true);


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 255
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 257
-- Name: labor_wages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.labor_wages_id_seq', 6, true);


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 259
-- Name: laborer_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.laborer_groups_id_seq', 1, false);


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 261
-- Name: laborers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.laborers_id_seq', 2, true);


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 263
-- Name: marketplace_listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.marketplace_listings_id_seq', 1, false);


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 265
-- Name: marketplace_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.marketplace_orders_id_seq', 1, false);


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 267
-- Name: marketplace_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.marketplace_reviews_id_seq', 1, false);


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 269
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 105, true);


--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 271
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 28, true);


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 273
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 275
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 277
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 9, true);


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 279
-- Name: pest_analytics_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pest_analytics_rules_id_seq', 13, true);


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 281
-- Name: pest_incidents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pest_incidents_id_seq', 4, true);


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 283
-- Name: pest_libraries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pest_libraries_id_seq', 6, true);


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 285
-- Name: planting_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.planting_stages_id_seq', 25, true);


--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 287
-- Name: plantings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plantings_id_seq', 5, true);


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 289
-- Name: price_negotiations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.price_negotiations_id_seq', 6, true);


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 291
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 1, false);


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 293
-- Name: rice_growth_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rice_growth_stages_id_seq', 5, true);


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 295
-- Name: rice_order_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rice_order_messages_id_seq', 1, false);


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 297
-- Name: rice_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rice_orders_id_seq', 11, true);


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 299
-- Name: rice_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rice_products_id_seq', 3, true);


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 301
-- Name: rice_varieties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rice_varieties_id_seq', 13, true);


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 303
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sales_id_seq', 3, true);


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 305
-- Name: scheduled_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.scheduled_reports_id_seq', 1, false);


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 307
-- Name: seed_plantings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seed_plantings_id_seq', 1, true);


--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 309
-- Name: task_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.task_templates_id_seq', 1, false);


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 311
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tasks_id_seq', 6, true);


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 313
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 315
-- Name: weather_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.weather_alerts_id_seq', 1, false);


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 317
-- Name: weather_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.weather_logs_id_seq', 4556, true);


--
-- TOC entry 3699 (class 2606 OID 351479)
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3702 (class 2606 OID 351481)
-- Name: automated_tasks automated_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 3704 (class 2606 OID 351483)
-- Name: buyers buyers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (id);


--
-- TOC entry 3708 (class 2606 OID 351485)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 3706 (class 2606 OID 351487)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 3710 (class 2606 OID 351489)
-- Name: cart_items cart_items_buyer_id_rice_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_buyer_id_rice_product_id_unique UNIQUE (buyer_id, rice_product_id);


--
-- TOC entry 3712 (class 2606 OID 351491)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3714 (class 2606 OID 351493)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3716 (class 2606 OID 351495)
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- TOC entry 3718 (class 2606 OID 351497)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3720 (class 2606 OID 351499)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3722 (class 2606 OID 351501)
-- Name: farms farms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_pkey PRIMARY KEY (id);


--
-- TOC entry 3724 (class 2606 OID 351503)
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 351505)
-- Name: favorites favorites_user_id_rice_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_rice_product_id_unique UNIQUE (user_id, rice_product_id);


--
-- TOC entry 3728 (class 2606 OID 351507)
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- TOC entry 3730 (class 2606 OID 351509)
-- Name: group_laborer group_laborer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_pkey PRIMARY KEY (id);


--
-- TOC entry 3732 (class 2606 OID 351511)
-- Name: harvests harvests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_pkey PRIMARY KEY (id);


--
-- TOC entry 3734 (class 2606 OID 351513)
-- Name: inventory_alerts inventory_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts
    ADD CONSTRAINT inventory_alerts_pkey PRIMARY KEY (id);


--
-- TOC entry 3736 (class 2606 OID 351515)
-- Name: inventory_categories inventory_categories_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories
    ADD CONSTRAINT inventory_categories_code_unique UNIQUE (code);


--
-- TOC entry 3738 (class 2606 OID 351517)
-- Name: inventory_categories inventory_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories
    ADD CONSTRAINT inventory_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3740 (class 2606 OID 351519)
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3742 (class 2606 OID 351521)
-- Name: inventory_transactions inventory_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 351523)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 3747 (class 2606 OID 351525)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 351527)
-- Name: labor_wages labor_wages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_pkey PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 351529)
-- Name: laborer_groups laborer_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups
    ADD CONSTRAINT laborer_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 351531)
-- Name: laborers laborers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers
    ADD CONSTRAINT laborers_pkey PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 351533)
-- Name: marketplace_listings marketplace_listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_pkey PRIMARY KEY (id);


--
-- TOC entry 3758 (class 2606 OID 351535)
-- Name: marketplace_orders marketplace_orders_order_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_order_number_unique UNIQUE (order_number);


--
-- TOC entry 3760 (class 2606 OID 351537)
-- Name: marketplace_orders marketplace_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3762 (class 2606 OID 351539)
-- Name: marketplace_reviews marketplace_reviews_order_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_order_id_unique UNIQUE (order_id);


--
-- TOC entry 3764 (class 2606 OID 351541)
-- Name: marketplace_reviews marketplace_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 3766 (class 2606 OID 351543)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3768 (class 2606 OID 351545)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 3771 (class 2606 OID 351547)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3773 (class 2606 OID 351549)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3776 (class 2606 OID 351551)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3778 (class 2606 OID 351553)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3781 (class 2606 OID 351555)
-- Name: pest_analytics_rules pest_analytics_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules
    ADD CONSTRAINT pest_analytics_rules_pkey PRIMARY KEY (id);


--
-- TOC entry 3783 (class 2606 OID 351557)
-- Name: pest_incidents pest_incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_pkey PRIMARY KEY (id);


--
-- TOC entry 3787 (class 2606 OID 351559)
-- Name: pest_libraries pest_libraries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries
    ADD CONSTRAINT pest_libraries_pkey PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 351561)
-- Name: pest_libraries pest_libraries_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries
    ADD CONSTRAINT pest_libraries_slug_unique UNIQUE (slug);


--
-- TOC entry 3791 (class 2606 OID 351563)
-- Name: planting_stages planting_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_pkey PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 351565)
-- Name: planting_stages planting_stages_planting_id_rice_growth_stage_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_planting_id_rice_growth_stage_id_unique UNIQUE (planting_id, rice_growth_stage_id);


--
-- TOC entry 3795 (class 2606 OID 351567)
-- Name: plantings plantings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_pkey PRIMARY KEY (id);


--
-- TOC entry 3797 (class 2606 OID 351569)
-- Name: price_negotiations price_negotiations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_pkey PRIMARY KEY (id);


--
-- TOC entry 3802 (class 2606 OID 351571)
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 351573)
-- Name: rice_growth_stages rice_growth_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages
    ADD CONSTRAINT rice_growth_stages_pkey PRIMARY KEY (id);


--
-- TOC entry 3807 (class 2606 OID 351575)
-- Name: rice_growth_stages rice_growth_stages_stage_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages
    ADD CONSTRAINT rice_growth_stages_stage_code_unique UNIQUE (stage_code);


--
-- TOC entry 3809 (class 2606 OID 351577)
-- Name: rice_order_messages rice_order_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3814 (class 2606 OID 351579)
-- Name: rice_orders rice_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 351581)
-- Name: rice_products rice_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_pkey PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 351583)
-- Name: rice_varieties rice_varieties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties
    ADD CONSTRAINT rice_varieties_pkey PRIMARY KEY (id);


--
-- TOC entry 3821 (class 2606 OID 351585)
-- Name: rice_varieties rice_varieties_variety_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties
    ADD CONSTRAINT rice_varieties_variety_code_unique UNIQUE (variety_code);


--
-- TOC entry 3823 (class 2606 OID 351587)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 3825 (class 2606 OID 351589)
-- Name: scheduled_reports scheduled_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 351591)
-- Name: seed_plantings seed_plantings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_pkey PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 351593)
-- Name: task_templates task_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_pkey PRIMARY KEY (id);


--
-- TOC entry 3831 (class 2606 OID 351595)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 351597)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3835 (class 2606 OID 351599)
-- Name: users users_phone_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_unique UNIQUE (phone);


--
-- TOC entry 3837 (class 2606 OID 351601)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 351603)
-- Name: weather_alerts weather_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_pkey PRIMARY KEY (id);


--
-- TOC entry 3842 (class 2606 OID 351605)
-- Name: weather_logs weather_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs
    ADD CONSTRAINT weather_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3696 (class 1259 OID 351606)
-- Name: activity_logs_action_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_action_index ON public.activity_logs USING btree (action);


--
-- TOC entry 3697 (class 1259 OID 351607)
-- Name: activity_logs_model_type_model_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_model_type_model_id_index ON public.activity_logs USING btree (model_type, model_id);


--
-- TOC entry 3700 (class 1259 OID 351608)
-- Name: activity_logs_user_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_user_id_created_at_index ON public.activity_logs USING btree (user_id, created_at);


--
-- TOC entry 3743 (class 1259 OID 351609)
-- Name: inventory_transactions_reference_type_reference_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_transactions_reference_type_reference_id_index ON public.inventory_transactions USING btree (reference_type, reference_id);


--
-- TOC entry 3748 (class 1259 OID 351610)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 3769 (class 1259 OID 351611)
-- Name: notifications_user_id_read_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_user_id_read_at_index ON public.notifications USING btree (user_id, read_at);


--
-- TOC entry 3774 (class 1259 OID 351612)
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- TOC entry 3779 (class 1259 OID 351613)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 3784 (class 1259 OID 351614)
-- Name: pest_incidents_planting_id_detected_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pest_incidents_planting_id_detected_date_index ON public.pest_incidents USING btree (planting_id, detected_date);


--
-- TOC entry 3785 (class 1259 OID 351615)
-- Name: pest_incidents_user_id_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pest_incidents_user_id_status_index ON public.pest_incidents USING btree (user_id, status);


--
-- TOC entry 3798 (class 1259 OID 351616)
-- Name: price_negotiations_rice_order_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_negotiations_rice_order_id_created_at_index ON public.price_negotiations USING btree (rice_order_id, created_at);


--
-- TOC entry 3799 (class 1259 OID 351617)
-- Name: price_negotiations_rice_order_id_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_negotiations_rice_order_id_status_index ON public.price_negotiations USING btree (rice_order_id, status);


--
-- TOC entry 3800 (class 1259 OID 351618)
-- Name: product_reviews_buyer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_reviews_buyer_id_index ON public.product_reviews USING btree (buyer_id);


--
-- TOC entry 3803 (class 1259 OID 351619)
-- Name: product_reviews_rice_product_id_is_approved_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_reviews_rice_product_id_is_approved_index ON public.product_reviews USING btree (rice_product_id, is_approved);


--
-- TOC entry 3810 (class 1259 OID 351620)
-- Name: rice_order_messages_rice_order_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_order_messages_rice_order_id_created_at_index ON public.rice_order_messages USING btree (rice_order_id, created_at);


--
-- TOC entry 3811 (class 1259 OID 351621)
-- Name: rice_orders_checkout_group_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_checkout_group_id_index ON public.rice_orders USING btree (checkout_group_id);


--
-- TOC entry 3812 (class 1259 OID 351622)
-- Name: rice_orders_order_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_order_date_index ON public.rice_orders USING btree (order_date);


--
-- TOC entry 3815 (class 1259 OID 351623)
-- Name: rice_orders_status_payment_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_status_payment_status_index ON public.rice_orders USING btree (status, payment_status);


--
-- TOC entry 3840 (class 1259 OID 351624)
-- Name: weather_logs_farm_id_recorded_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX weather_logs_farm_id_recorded_at_index ON public.weather_logs USING btree (farm_id, recorded_at);


--
-- TOC entry 3843 (class 2606 OID 351625)
-- Name: activity_logs activity_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 3844 (class 2606 OID 351630)
-- Name: automated_tasks automated_tasks_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3845 (class 2606 OID 351635)
-- Name: automated_tasks automated_tasks_planting_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_planting_stage_id_foreign FOREIGN KEY (planting_stage_id) REFERENCES public.planting_stages(id) ON DELETE CASCADE;


--
-- TOC entry 3846 (class 2606 OID 351640)
-- Name: automated_tasks automated_tasks_task_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_task_id_foreign FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE SET NULL;


--
-- TOC entry 3847 (class 2606 OID 351645)
-- Name: automated_tasks automated_tasks_task_template_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_task_template_id_foreign FOREIGN KEY (task_template_id) REFERENCES public.task_templates(id) ON DELETE CASCADE;


--
-- TOC entry 3848 (class 2606 OID 351650)
-- Name: buyers buyers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3849 (class 2606 OID 351655)
-- Name: cart_items cart_items_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3850 (class 2606 OID 351660)
-- Name: cart_items cart_items_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- TOC entry 3851 (class 2606 OID 351665)
-- Name: expenses expenses_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3852 (class 2606 OID 351670)
-- Name: expenses expenses_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3853 (class 2606 OID 351675)
-- Name: farms farms_primary_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_primary_rice_variety_id_foreign FOREIGN KEY (primary_rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE SET NULL;


--
-- TOC entry 3854 (class 2606 OID 351680)
-- Name: farms farms_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3855 (class 2606 OID 351685)
-- Name: favorites favorites_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- TOC entry 3856 (class 2606 OID 351690)
-- Name: favorites favorites_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3857 (class 2606 OID 351695)
-- Name: fields fields_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


--
-- TOC entry 3858 (class 2606 OID 351700)
-- Name: fields fields_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3859 (class 2606 OID 351705)
-- Name: group_laborer group_laborer_laborer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_laborer_group_id_foreign FOREIGN KEY (laborer_group_id) REFERENCES public.laborer_groups(id) ON DELETE CASCADE;


--
-- TOC entry 3860 (class 2606 OID 351710)
-- Name: group_laborer group_laborer_laborer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_laborer_id_foreign FOREIGN KEY (laborer_id) REFERENCES public.laborers(id) ON DELETE CASCADE;


--
-- TOC entry 3861 (class 2606 OID 351715)
-- Name: harvests harvests_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3862 (class 2606 OID 351720)
-- Name: inventory_alerts inventory_alerts_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts
    ADD CONSTRAINT inventory_alerts_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- TOC entry 3863 (class 2606 OID 351725)
-- Name: inventory_items inventory_items_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.inventory_categories(id) ON DELETE SET NULL;


--
-- TOC entry 3864 (class 2606 OID 351730)
-- Name: inventory_items inventory_items_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3865 (class 2606 OID 351735)
-- Name: inventory_transactions inventory_transactions_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- TOC entry 3866 (class 2606 OID 351740)
-- Name: inventory_transactions inventory_transactions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3867 (class 2606 OID 351745)
-- Name: labor_wages labor_wages_laborer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_laborer_id_foreign FOREIGN KEY (laborer_id) REFERENCES public.laborers(id) ON DELETE CASCADE;


--
-- TOC entry 3868 (class 2606 OID 351750)
-- Name: labor_wages labor_wages_task_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_task_id_foreign FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- TOC entry 3869 (class 2606 OID 351755)
-- Name: laborer_groups laborer_groups_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups
    ADD CONSTRAINT laborer_groups_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3870 (class 2606 OID 351760)
-- Name: laborers laborers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers
    ADD CONSTRAINT laborers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3871 (class 2606 OID 351765)
-- Name: marketplace_listings marketplace_listings_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3872 (class 2606 OID 351770)
-- Name: marketplace_listings marketplace_listings_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE SET NULL;


--
-- TOC entry 3873 (class 2606 OID 351775)
-- Name: marketplace_listings marketplace_listings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- TOC entry 3874 (class 2606 OID 351780)
-- Name: marketplace_orders marketplace_orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3875 (class 2606 OID 351785)
-- Name: marketplace_orders marketplace_orders_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3876 (class 2606 OID 351790)
-- Name: marketplace_orders marketplace_orders_listing_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_listing_id_foreign FOREIGN KEY (listing_id) REFERENCES public.marketplace_listings(id) ON DELETE CASCADE;


--
-- TOC entry 3877 (class 2606 OID 351795)
-- Name: marketplace_reviews marketplace_reviews_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3878 (class 2606 OID 351800)
-- Name: marketplace_reviews marketplace_reviews_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3879 (class 2606 OID 351805)
-- Name: marketplace_reviews marketplace_reviews_listing_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_listing_id_foreign FOREIGN KEY (listing_id) REFERENCES public.marketplace_listings(id) ON DELETE CASCADE;


--
-- TOC entry 3880 (class 2606 OID 351810)
-- Name: marketplace_reviews marketplace_reviews_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.marketplace_orders(id) ON DELETE CASCADE;


--
-- TOC entry 3881 (class 2606 OID 351815)
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3882 (class 2606 OID 351820)
-- Name: order_items order_items_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- TOC entry 3883 (class 2606 OID 351825)
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 3884 (class 2606 OID 351830)
-- Name: orders orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3885 (class 2606 OID 351835)
-- Name: pest_analytics_rules pest_analytics_rules_pest_library_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules
    ADD CONSTRAINT pest_analytics_rules_pest_library_id_foreign FOREIGN KEY (pest_library_id) REFERENCES public.pest_libraries(id) ON DELETE CASCADE;


--
-- TOC entry 3886 (class 2606 OID 351840)
-- Name: pest_incidents pest_incidents_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3887 (class 2606 OID 351845)
-- Name: pest_incidents pest_incidents_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3888 (class 2606 OID 351850)
-- Name: planting_stages planting_stages_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3889 (class 2606 OID 351855)
-- Name: planting_stages planting_stages_rice_growth_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_rice_growth_stage_id_foreign FOREIGN KEY (rice_growth_stage_id) REFERENCES public.rice_growth_stages(id) ON DELETE CASCADE;


--
-- TOC entry 3890 (class 2606 OID 351860)
-- Name: plantings plantings_field_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_field_id_foreign FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- TOC entry 3891 (class 2606 OID 351865)
-- Name: plantings plantings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- TOC entry 3892 (class 2606 OID 351870)
-- Name: plantings plantings_seed_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_seed_planting_id_foreign FOREIGN KEY (seed_planting_id) REFERENCES public.seed_plantings(id) ON DELETE SET NULL;


--
-- TOC entry 3893 (class 2606 OID 351875)
-- Name: price_negotiations price_negotiations_proposer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_proposer_id_foreign FOREIGN KEY (proposer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3894 (class 2606 OID 351880)
-- Name: price_negotiations price_negotiations_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE CASCADE;


--
-- TOC entry 3895 (class 2606 OID 351885)
-- Name: product_reviews product_reviews_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3896 (class 2606 OID 351890)
-- Name: product_reviews product_reviews_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE SET NULL;


--
-- TOC entry 3897 (class 2606 OID 351895)
-- Name: product_reviews product_reviews_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- TOC entry 3898 (class 2606 OID 351900)
-- Name: rice_order_messages rice_order_messages_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE CASCADE;


--
-- TOC entry 3899 (class 2606 OID 351905)
-- Name: rice_order_messages rice_order_messages_sender_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_sender_id_foreign FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3900 (class 2606 OID 351910)
-- Name: rice_orders rice_orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3901 (class 2606 OID 351915)
-- Name: rice_orders rice_orders_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- TOC entry 3902 (class 2606 OID 351920)
-- Name: rice_products rice_products_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3903 (class 2606 OID 351925)
-- Name: rice_products rice_products_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE SET NULL;


--
-- TOC entry 3904 (class 2606 OID 351930)
-- Name: rice_products rice_products_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE SET NULL;


--
-- TOC entry 3905 (class 2606 OID 351935)
-- Name: rice_products rice_products_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- TOC entry 3906 (class 2606 OID 351940)
-- Name: sales sales_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.buyers(id) ON DELETE CASCADE;


--
-- TOC entry 3907 (class 2606 OID 351945)
-- Name: sales sales_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE CASCADE;


--
-- TOC entry 3908 (class 2606 OID 351950)
-- Name: sales sales_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE SET NULL;


--
-- TOC entry 3909 (class 2606 OID 351955)
-- Name: sales sales_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3910 (class 2606 OID 351960)
-- Name: scheduled_reports scheduled_reports_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


--
-- TOC entry 3911 (class 2606 OID 351965)
-- Name: scheduled_reports scheduled_reports_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3912 (class 2606 OID 351970)
-- Name: seed_plantings seed_plantings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id);


--
-- TOC entry 3913 (class 2606 OID 351975)
-- Name: seed_plantings seed_plantings_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3914 (class 2606 OID 351980)
-- Name: task_templates task_templates_rice_growth_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_rice_growth_stage_id_foreign FOREIGN KEY (rice_growth_stage_id) REFERENCES public.rice_growth_stages(id) ON DELETE CASCADE;


--
-- TOC entry 3915 (class 2606 OID 351985)
-- Name: tasks tasks_assigned_to_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_foreign FOREIGN KEY (assigned_to) REFERENCES public.laborers(id) ON DELETE SET NULL;


--
-- TOC entry 3916 (class 2606 OID 351990)
-- Name: tasks tasks_laborer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_laborer_group_id_foreign FOREIGN KEY (laborer_group_id) REFERENCES public.laborer_groups(id) ON DELETE SET NULL;


--
-- TOC entry 3917 (class 2606 OID 351995)
-- Name: tasks tasks_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3918 (class 2606 OID 352000)
-- Name: weather_alerts weather_alerts_field_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_field_id_foreign FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- TOC entry 3919 (class 2606 OID 352005)
-- Name: weather_alerts weather_alerts_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- TOC entry 3920 (class 2606 OID 352010)
-- Name: weather_logs weather_logs_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs
    ADD CONSTRAINT weather_logs_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


-- Completed on 2026-02-13 23:41:24 PST

--
-- PostgreSQL database dump complete
--

\unrestrict FyBl1i8MB4Uo2PxqdmqqmGpiNNUG5X08iH0Si1md15XpQ5RpXd0lQRG6TG9ZTcp

