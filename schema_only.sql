--
-- PostgreSQL database dump
--

\restrict bHIoW3u5AG5vVNmsgWhbYWGxyewEgrkmborNI1I5N2R4we8HZal8Ov6fuvpBDEQ

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
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
-- Name: automated_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.automated_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: automated_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.automated_tasks_id_seq OWNED BY public.automated_tasks.id;


--
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
-- Name: buyers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buyers_id_seq OWNED BY public.buyers.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
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
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
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
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
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
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
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
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
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
-- Name: farms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.farms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: farms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.farms_id_seq OWNED BY public.farms.id;


--
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
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
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
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fields_id_seq OWNED BY public.fields.id;


--
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
-- Name: group_laborer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_laborer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_laborer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_laborer_id_seq OWNED BY public.group_laborer.id;


--
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
-- Name: harvests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.harvests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: harvests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.harvests_id_seq OWNED BY public.harvests.id;


--
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
-- Name: inventory_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_alerts_id_seq OWNED BY public.inventory_alerts.id;


--
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
-- Name: inventory_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_categories_id_seq OWNED BY public.inventory_categories.id;


--
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
-- Name: inventory_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_items_id_seq OWNED BY public.inventory_items.id;


--
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
-- Name: inventory_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_transactions_id_seq OWNED BY public.inventory_transactions.id;


--
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
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
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
-- Name: labor_wages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.labor_wages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labor_wages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.labor_wages_id_seq OWNED BY public.labor_wages.id;


--
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
-- Name: laborer_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.laborer_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: laborer_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.laborer_groups_id_seq OWNED BY public.laborer_groups.id;


--
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
-- Name: laborers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.laborers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: laborers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.laborers_id_seq OWNED BY public.laborers.id;


--
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
-- Name: marketplace_listings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketplace_listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_listings_id_seq OWNED BY public.marketplace_listings.id;


--
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
-- Name: marketplace_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketplace_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_orders_id_seq OWNED BY public.marketplace_orders.id;


--
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
-- Name: marketplace_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.marketplace_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketplace_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.marketplace_reviews_id_seq OWNED BY public.marketplace_reviews.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
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
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
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
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
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
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
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
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
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
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
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
-- Name: pest_analytics_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_analytics_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pest_analytics_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_analytics_rules_id_seq OWNED BY public.pest_analytics_rules.id;


--
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
-- Name: pest_incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pest_incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_incidents_id_seq OWNED BY public.pest_incidents.id;


--
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
-- Name: pest_libraries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pest_libraries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pest_libraries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pest_libraries_id_seq OWNED BY public.pest_libraries.id;


--
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
-- Name: planting_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.planting_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: planting_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.planting_stages_id_seq OWNED BY public.planting_stages.id;


--
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
-- Name: plantings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plantings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plantings_id_seq OWNED BY public.plantings.id;


--
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
-- Name: price_negotiations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_negotiations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: price_negotiations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_negotiations_id_seq OWNED BY public.price_negotiations.id;


--
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
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
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
-- Name: rice_growth_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_growth_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rice_growth_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_growth_stages_id_seq OWNED BY public.rice_growth_stages.id;


--
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
-- Name: rice_order_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_order_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rice_order_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_order_messages_id_seq OWNED BY public.rice_order_messages.id;


--
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
-- Name: rice_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rice_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_orders_id_seq OWNED BY public.rice_orders.id;


--
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
-- Name: rice_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rice_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_products_id_seq OWNED BY public.rice_products.id;


--
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
-- Name: rice_varieties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rice_varieties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rice_varieties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rice_varieties_id_seq OWNED BY public.rice_varieties.id;


--
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
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
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
-- Name: scheduled_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scheduled_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scheduled_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scheduled_reports_id_seq OWNED BY public.scheduled_reports.id;


--
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
-- Name: seed_plantings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seed_plantings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seed_plantings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seed_plantings_id_seq OWNED BY public.seed_plantings.id;


--
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
-- Name: task_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_templates_id_seq OWNED BY public.task_templates.id;


--
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
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
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
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
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
-- Name: weather_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.weather_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weather_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.weather_alerts_id_seq OWNED BY public.weather_alerts.id;


--
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
-- Name: weather_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.weather_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weather_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.weather_logs_id_seq OWNED BY public.weather_logs.id;


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: automated_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks ALTER COLUMN id SET DEFAULT nextval('public.automated_tasks_id_seq'::regclass);


--
-- Name: buyers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers ALTER COLUMN id SET DEFAULT nextval('public.buyers_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: farms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms ALTER COLUMN id SET DEFAULT nextval('public.farms_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);


--
-- Name: group_laborer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer ALTER COLUMN id SET DEFAULT nextval('public.group_laborer_id_seq'::regclass);


--
-- Name: harvests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests ALTER COLUMN id SET DEFAULT nextval('public.harvests_id_seq'::regclass);


--
-- Name: inventory_alerts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts ALTER COLUMN id SET DEFAULT nextval('public.inventory_alerts_id_seq'::regclass);


--
-- Name: inventory_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories ALTER COLUMN id SET DEFAULT nextval('public.inventory_categories_id_seq'::regclass);


--
-- Name: inventory_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items ALTER COLUMN id SET DEFAULT nextval('public.inventory_items_id_seq'::regclass);


--
-- Name: inventory_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions ALTER COLUMN id SET DEFAULT nextval('public.inventory_transactions_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: labor_wages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages ALTER COLUMN id SET DEFAULT nextval('public.labor_wages_id_seq'::regclass);


--
-- Name: laborer_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups ALTER COLUMN id SET DEFAULT nextval('public.laborer_groups_id_seq'::regclass);


--
-- Name: laborers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers ALTER COLUMN id SET DEFAULT nextval('public.laborers_id_seq'::regclass);


--
-- Name: marketplace_listings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings ALTER COLUMN id SET DEFAULT nextval('public.marketplace_listings_id_seq'::regclass);


--
-- Name: marketplace_orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders ALTER COLUMN id SET DEFAULT nextval('public.marketplace_orders_id_seq'::regclass);


--
-- Name: marketplace_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews ALTER COLUMN id SET DEFAULT nextval('public.marketplace_reviews_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: pest_analytics_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules ALTER COLUMN id SET DEFAULT nextval('public.pest_analytics_rules_id_seq'::regclass);


--
-- Name: pest_incidents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents ALTER COLUMN id SET DEFAULT nextval('public.pest_incidents_id_seq'::regclass);


--
-- Name: pest_libraries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries ALTER COLUMN id SET DEFAULT nextval('public.pest_libraries_id_seq'::regclass);


--
-- Name: planting_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages ALTER COLUMN id SET DEFAULT nextval('public.planting_stages_id_seq'::regclass);


--
-- Name: plantings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings ALTER COLUMN id SET DEFAULT nextval('public.plantings_id_seq'::regclass);


--
-- Name: price_negotiations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations ALTER COLUMN id SET DEFAULT nextval('public.price_negotiations_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: rice_growth_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages ALTER COLUMN id SET DEFAULT nextval('public.rice_growth_stages_id_seq'::regclass);


--
-- Name: rice_order_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages ALTER COLUMN id SET DEFAULT nextval('public.rice_order_messages_id_seq'::regclass);


--
-- Name: rice_orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders ALTER COLUMN id SET DEFAULT nextval('public.rice_orders_id_seq'::regclass);


--
-- Name: rice_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products ALTER COLUMN id SET DEFAULT nextval('public.rice_products_id_seq'::regclass);


--
-- Name: rice_varieties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties ALTER COLUMN id SET DEFAULT nextval('public.rice_varieties_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- Name: scheduled_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports ALTER COLUMN id SET DEFAULT nextval('public.scheduled_reports_id_seq'::regclass);


--
-- Name: seed_plantings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings ALTER COLUMN id SET DEFAULT nextval('public.seed_plantings_id_seq'::regclass);


--
-- Name: task_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates ALTER COLUMN id SET DEFAULT nextval('public.task_templates_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: weather_alerts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts ALTER COLUMN id SET DEFAULT nextval('public.weather_alerts_id_seq'::regclass);


--
-- Name: weather_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs ALTER COLUMN id SET DEFAULT nextval('public.weather_logs_id_seq'::regclass);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: automated_tasks automated_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_pkey PRIMARY KEY (id);


--
-- Name: buyers buyers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_buyer_id_rice_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_buyer_id_rice_product_id_unique UNIQUE (buyer_id, rice_product_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: farms farms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_user_id_rice_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_rice_product_id_unique UNIQUE (user_id, rice_product_id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: group_laborer group_laborer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_pkey PRIMARY KEY (id);


--
-- Name: harvests harvests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_pkey PRIMARY KEY (id);


--
-- Name: inventory_alerts inventory_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts
    ADD CONSTRAINT inventory_alerts_pkey PRIMARY KEY (id);


--
-- Name: inventory_categories inventory_categories_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories
    ADD CONSTRAINT inventory_categories_code_unique UNIQUE (code);


--
-- Name: inventory_categories inventory_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_categories
    ADD CONSTRAINT inventory_categories_pkey PRIMARY KEY (id);


--
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (id);


--
-- Name: inventory_transactions inventory_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: labor_wages labor_wages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_pkey PRIMARY KEY (id);


--
-- Name: laborer_groups laborer_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups
    ADD CONSTRAINT laborer_groups_pkey PRIMARY KEY (id);


--
-- Name: laborers laborers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers
    ADD CONSTRAINT laborers_pkey PRIMARY KEY (id);


--
-- Name: marketplace_listings marketplace_listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_pkey PRIMARY KEY (id);


--
-- Name: marketplace_orders marketplace_orders_order_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_order_number_unique UNIQUE (order_number);


--
-- Name: marketplace_orders marketplace_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_pkey PRIMARY KEY (id);


--
-- Name: marketplace_reviews marketplace_reviews_order_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_order_id_unique UNIQUE (order_id);


--
-- Name: marketplace_reviews marketplace_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: pest_analytics_rules pest_analytics_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules
    ADD CONSTRAINT pest_analytics_rules_pkey PRIMARY KEY (id);


--
-- Name: pest_incidents pest_incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_pkey PRIMARY KEY (id);


--
-- Name: pest_libraries pest_libraries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries
    ADD CONSTRAINT pest_libraries_pkey PRIMARY KEY (id);


--
-- Name: pest_libraries pest_libraries_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_libraries
    ADD CONSTRAINT pest_libraries_slug_unique UNIQUE (slug);


--
-- Name: planting_stages planting_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_pkey PRIMARY KEY (id);


--
-- Name: planting_stages planting_stages_planting_id_rice_growth_stage_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_planting_id_rice_growth_stage_id_unique UNIQUE (planting_id, rice_growth_stage_id);


--
-- Name: plantings plantings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_pkey PRIMARY KEY (id);


--
-- Name: price_negotiations price_negotiations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: rice_growth_stages rice_growth_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages
    ADD CONSTRAINT rice_growth_stages_pkey PRIMARY KEY (id);


--
-- Name: rice_growth_stages rice_growth_stages_stage_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_growth_stages
    ADD CONSTRAINT rice_growth_stages_stage_code_unique UNIQUE (stage_code);


--
-- Name: rice_order_messages rice_order_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_pkey PRIMARY KEY (id);


--
-- Name: rice_orders rice_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_pkey PRIMARY KEY (id);


--
-- Name: rice_products rice_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_pkey PRIMARY KEY (id);


--
-- Name: rice_varieties rice_varieties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties
    ADD CONSTRAINT rice_varieties_pkey PRIMARY KEY (id);


--
-- Name: rice_varieties rice_varieties_variety_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_varieties
    ADD CONSTRAINT rice_varieties_variety_code_unique UNIQUE (variety_code);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: scheduled_reports scheduled_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_pkey PRIMARY KEY (id);


--
-- Name: seed_plantings seed_plantings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_pkey PRIMARY KEY (id);


--
-- Name: task_templates task_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_phone_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_unique UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weather_alerts weather_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_pkey PRIMARY KEY (id);


--
-- Name: weather_logs weather_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs
    ADD CONSTRAINT weather_logs_pkey PRIMARY KEY (id);


--
-- Name: activity_logs_action_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_action_index ON public.activity_logs USING btree (action);


--
-- Name: activity_logs_model_type_model_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_model_type_model_id_index ON public.activity_logs USING btree (model_type, model_id);


--
-- Name: activity_logs_user_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_logs_user_id_created_at_index ON public.activity_logs USING btree (user_id, created_at);


--
-- Name: inventory_transactions_reference_type_reference_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_transactions_reference_type_reference_id_index ON public.inventory_transactions USING btree (reference_type, reference_id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: notifications_user_id_read_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notifications_user_id_read_at_index ON public.notifications USING btree (user_id, read_at);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: pest_incidents_planting_id_detected_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pest_incidents_planting_id_detected_date_index ON public.pest_incidents USING btree (planting_id, detected_date);


--
-- Name: pest_incidents_user_id_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pest_incidents_user_id_status_index ON public.pest_incidents USING btree (user_id, status);


--
-- Name: price_negotiations_rice_order_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_negotiations_rice_order_id_created_at_index ON public.price_negotiations USING btree (rice_order_id, created_at);


--
-- Name: price_negotiations_rice_order_id_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_negotiations_rice_order_id_status_index ON public.price_negotiations USING btree (rice_order_id, status);


--
-- Name: product_reviews_buyer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_reviews_buyer_id_index ON public.product_reviews USING btree (buyer_id);


--
-- Name: product_reviews_rice_product_id_is_approved_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_reviews_rice_product_id_is_approved_index ON public.product_reviews USING btree (rice_product_id, is_approved);


--
-- Name: rice_order_messages_rice_order_id_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_order_messages_rice_order_id_created_at_index ON public.rice_order_messages USING btree (rice_order_id, created_at);


--
-- Name: rice_orders_checkout_group_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_checkout_group_id_index ON public.rice_orders USING btree (checkout_group_id);


--
-- Name: rice_orders_order_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_order_date_index ON public.rice_orders USING btree (order_date);


--
-- Name: rice_orders_status_payment_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rice_orders_status_payment_status_index ON public.rice_orders USING btree (status, payment_status);


--
-- Name: weather_logs_farm_id_recorded_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX weather_logs_farm_id_recorded_at_index ON public.weather_logs USING btree (farm_id, recorded_at);


--
-- Name: activity_logs activity_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: automated_tasks automated_tasks_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: automated_tasks automated_tasks_planting_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_planting_stage_id_foreign FOREIGN KEY (planting_stage_id) REFERENCES public.planting_stages(id) ON DELETE CASCADE;


--
-- Name: automated_tasks automated_tasks_task_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_task_id_foreign FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE SET NULL;


--
-- Name: automated_tasks automated_tasks_task_template_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automated_tasks
    ADD CONSTRAINT automated_tasks_task_template_id_foreign FOREIGN KEY (task_template_id) REFERENCES public.task_templates(id) ON DELETE CASCADE;


--
-- Name: buyers buyers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- Name: expenses expenses_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: expenses expenses_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: farms farms_primary_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_primary_rice_variety_id_foreign FOREIGN KEY (primary_rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE SET NULL;


--
-- Name: farms farms_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.farms
    ADD CONSTRAINT farms_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fields fields_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


--
-- Name: fields fields_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: group_laborer group_laborer_laborer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_laborer_group_id_foreign FOREIGN KEY (laborer_group_id) REFERENCES public.laborer_groups(id) ON DELETE CASCADE;


--
-- Name: group_laborer group_laborer_laborer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_laborer
    ADD CONSTRAINT group_laborer_laborer_id_foreign FOREIGN KEY (laborer_id) REFERENCES public.laborers(id) ON DELETE CASCADE;


--
-- Name: harvests harvests_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvests
    ADD CONSTRAINT harvests_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: inventory_alerts inventory_alerts_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_alerts
    ADD CONSTRAINT inventory_alerts_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- Name: inventory_items inventory_items_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.inventory_categories(id) ON DELETE SET NULL;


--
-- Name: inventory_items inventory_items_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: inventory_transactions inventory_transactions_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- Name: inventory_transactions inventory_transactions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: labor_wages labor_wages_laborer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_laborer_id_foreign FOREIGN KEY (laborer_id) REFERENCES public.laborers(id) ON DELETE CASCADE;


--
-- Name: labor_wages labor_wages_task_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor_wages
    ADD CONSTRAINT labor_wages_task_id_foreign FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: laborer_groups laborer_groups_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborer_groups
    ADD CONSTRAINT laborer_groups_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: laborers laborers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.laborers
    ADD CONSTRAINT laborers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_listings marketplace_listings_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_listings marketplace_listings_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE SET NULL;


--
-- Name: marketplace_listings marketplace_listings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_listings
    ADD CONSTRAINT marketplace_listings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- Name: marketplace_orders marketplace_orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_orders marketplace_orders_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_orders marketplace_orders_listing_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_orders
    ADD CONSTRAINT marketplace_orders_listing_id_foreign FOREIGN KEY (listing_id) REFERENCES public.marketplace_listings(id) ON DELETE CASCADE;


--
-- Name: marketplace_reviews marketplace_reviews_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_reviews marketplace_reviews_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: marketplace_reviews marketplace_reviews_listing_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_listing_id_foreign FOREIGN KEY (listing_id) REFERENCES public.marketplace_listings(id) ON DELETE CASCADE;


--
-- Name: marketplace_reviews marketplace_reviews_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_reviews
    ADD CONSTRAINT marketplace_reviews_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.marketplace_orders(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: pest_analytics_rules pest_analytics_rules_pest_library_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_analytics_rules
    ADD CONSTRAINT pest_analytics_rules_pest_library_id_foreign FOREIGN KEY (pest_library_id) REFERENCES public.pest_libraries(id) ON DELETE CASCADE;


--
-- Name: pest_incidents pest_incidents_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: pest_incidents pest_incidents_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pest_incidents
    ADD CONSTRAINT pest_incidents_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: planting_stages planting_stages_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: planting_stages planting_stages_rice_growth_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planting_stages
    ADD CONSTRAINT planting_stages_rice_growth_stage_id_foreign FOREIGN KEY (rice_growth_stage_id) REFERENCES public.rice_growth_stages(id) ON DELETE CASCADE;


--
-- Name: plantings plantings_field_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_field_id_foreign FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: plantings plantings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- Name: plantings plantings_seed_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plantings
    ADD CONSTRAINT plantings_seed_planting_id_foreign FOREIGN KEY (seed_planting_id) REFERENCES public.seed_plantings(id) ON DELETE SET NULL;


--
-- Name: price_negotiations price_negotiations_proposer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_proposer_id_foreign FOREIGN KEY (proposer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: price_negotiations price_negotiations_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_negotiations
    ADD CONSTRAINT price_negotiations_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE CASCADE;


--
-- Name: product_reviews product_reviews_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: product_reviews product_reviews_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE SET NULL;


--
-- Name: product_reviews product_reviews_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- Name: rice_order_messages rice_order_messages_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE CASCADE;


--
-- Name: rice_order_messages rice_order_messages_sender_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_order_messages
    ADD CONSTRAINT rice_order_messages_sender_id_foreign FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rice_orders rice_orders_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rice_orders rice_orders_rice_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_orders
    ADD CONSTRAINT rice_orders_rice_product_id_foreign FOREIGN KEY (rice_product_id) REFERENCES public.rice_products(id) ON DELETE CASCADE;


--
-- Name: rice_products rice_products_farmer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_farmer_id_foreign FOREIGN KEY (farmer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rice_products rice_products_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE SET NULL;


--
-- Name: rice_products rice_products_inventory_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_inventory_item_id_foreign FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_items(id) ON DELETE SET NULL;


--
-- Name: rice_products rice_products_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rice_products
    ADD CONSTRAINT rice_products_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id) ON DELETE CASCADE;


--
-- Name: sales sales_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES public.buyers(id) ON DELETE CASCADE;


--
-- Name: sales sales_harvest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_harvest_id_foreign FOREIGN KEY (harvest_id) REFERENCES public.harvests(id) ON DELETE CASCADE;


--
-- Name: sales sales_rice_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_rice_order_id_foreign FOREIGN KEY (rice_order_id) REFERENCES public.rice_orders(id) ON DELETE SET NULL;


--
-- Name: sales sales_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: scheduled_reports scheduled_reports_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


--
-- Name: scheduled_reports scheduled_reports_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reports
    ADD CONSTRAINT scheduled_reports_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: seed_plantings seed_plantings_rice_variety_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_rice_variety_id_foreign FOREIGN KEY (rice_variety_id) REFERENCES public.rice_varieties(id);


--
-- Name: seed_plantings seed_plantings_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seed_plantings
    ADD CONSTRAINT seed_plantings_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: task_templates task_templates_rice_growth_stage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_rice_growth_stage_id_foreign FOREIGN KEY (rice_growth_stage_id) REFERENCES public.rice_growth_stages(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_assigned_to_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_foreign FOREIGN KEY (assigned_to) REFERENCES public.laborers(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_laborer_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_laborer_group_id_foreign FOREIGN KEY (laborer_group_id) REFERENCES public.laborer_groups(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: weather_alerts weather_alerts_field_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_field_id_foreign FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: weather_alerts weather_alerts_planting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_alerts
    ADD CONSTRAINT weather_alerts_planting_id_foreign FOREIGN KEY (planting_id) REFERENCES public.plantings(id) ON DELETE CASCADE;


--
-- Name: weather_logs weather_logs_farm_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weather_logs
    ADD CONSTRAINT weather_logs_farm_id_foreign FOREIGN KEY (farm_id) REFERENCES public.farms(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict bHIoW3u5AG5vVNmsgWhbYWGxyewEgrkmborNI1I5N2R4we8HZal8Ov6fuvpBDEQ

