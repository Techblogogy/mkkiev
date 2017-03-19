--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articles_article; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_article (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    activity boolean NOT NULL,
    content text NOT NULL,
    caption character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    video character varying(255) NOT NULL,
    slug_date date NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    write_date timestamp with time zone,
    create_date timestamp with time zone NOT NULL,
    edit_date timestamp with time zone NOT NULL,
    free boolean NOT NULL,
    show boolean NOT NULL,
    headline boolean NOT NULL,
    aside boolean NOT NULL,
    version integer NOT NULL,
    pageviews integer NOT NULL,
    ordering integer,
    author_id integer,
    category_id integer NOT NULL,
    creator_id integer NOT NULL,
    editor_id integer,
    publisher_id integer,
    CONSTRAINT articles_article_ordering_check CHECK ((ordering >= 0)),
    CONSTRAINT articles_article_version_check CHECK ((version >= 0))
);


ALTER TABLE public.articles_article OWNER TO mkkiev;

--
-- Name: articles_article_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_article_id_seq OWNER TO mkkiev;

--
-- Name: articles_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_article_id_seq OWNED BY articles_article.id;


--
-- Name: articles_article_related; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_article_related (
    id integer NOT NULL,
    from_article_id integer NOT NULL,
    to_article_id integer NOT NULL
);


ALTER TABLE public.articles_article_related OWNER TO mkkiev;

--
-- Name: articles_article_related_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_article_related_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_article_related_id_seq OWNER TO mkkiev;

--
-- Name: articles_article_related_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_article_related_id_seq OWNED BY articles_article_related.id;


--
-- Name: articles_article_tags; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_article_tags (
    id integer NOT NULL,
    article_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.articles_article_tags OWNER TO mkkiev;

--
-- Name: articles_article_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_article_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_article_tags_id_seq OWNER TO mkkiev;

--
-- Name: articles_article_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_article_tags_id_seq OWNED BY articles_article_tags.id;


--
-- Name: articles_category; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_category (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    ordering integer NOT NULL,
    activity boolean NOT NULL,
    main_category boolean NOT NULL,
    CONSTRAINT articles_category_ordering_check CHECK ((ordering >= 0))
);


ALTER TABLE public.articles_category OWNER TO mkkiev;

--
-- Name: articles_category_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_category_id_seq OWNER TO mkkiev;

--
-- Name: articles_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_category_id_seq OWNED BY articles_category.id;


--
-- Name: articles_image; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_image (
    id integer NOT NULL,
    image character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    activity boolean NOT NULL,
    article_id integer NOT NULL
);


ALTER TABLE public.articles_image OWNER TO mkkiev;

--
-- Name: articles_image_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_image_id_seq OWNER TO mkkiev;

--
-- Name: articles_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_image_id_seq OWNED BY articles_image.id;


--
-- Name: articles_tag; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE articles_tag (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    ordering integer NOT NULL,
    activity boolean NOT NULL,
    CONSTRAINT articles_tag_ordering_check CHECK ((ordering >= 0))
);


ALTER TABLE public.articles_tag OWNER TO mkkiev;

--
-- Name: articles_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE articles_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_tag_id_seq OWNER TO mkkiev;

--
-- Name: articles_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE articles_tag_id_seq OWNED BY articles_tag.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO mkkiev;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO mkkiev;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO mkkiev;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO mkkiev;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO mkkiev;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO mkkiev;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    location character varying(200) NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE public.auth_user OWNER TO mkkiev;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO mkkiev;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO mkkiev;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO mkkiev;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO mkkiev;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO mkkiev;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: banners_banner; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE banners_banner (
    id integer NOT NULL,
    url character varying(200) NOT NULL,
    create_date timestamp with time zone NOT NULL,
    ordering integer,
    activity boolean NOT NULL,
    is_shown boolean NOT NULL,
    show_count integer NOT NULL,
    max_show_count integer,
    clicks integer NOT NULL,
    file character varying(100) NOT NULL,
    width integer,
    height integer,
    code text NOT NULL,
    category_id integer,
    client_id integer NOT NULL,
    CONSTRAINT banners_banner_clicks_check CHECK ((clicks >= 0)),
    CONSTRAINT banners_banner_height_check CHECK ((height >= 0)),
    CONSTRAINT banners_banner_max_show_count_check CHECK ((max_show_count >= 0)),
    CONSTRAINT banners_banner_ordering_check CHECK ((ordering >= 0)),
    CONSTRAINT banners_banner_show_count_check CHECK ((show_count >= 0)),
    CONSTRAINT banners_banner_width_check CHECK ((width >= 0))
);


ALTER TABLE public.banners_banner OWNER TO mkkiev;

--
-- Name: banners_banner_categories; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE banners_banner_categories (
    id integer NOT NULL,
    banner_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.banners_banner_categories OWNER TO mkkiev;

--
-- Name: banners_banner_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE banners_banner_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_banner_categories_id_seq OWNER TO mkkiev;

--
-- Name: banners_banner_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE banners_banner_categories_id_seq OWNED BY banners_banner_categories.id;


--
-- Name: banners_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE banners_banner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_banner_id_seq OWNER TO mkkiev;

--
-- Name: banners_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE banners_banner_id_seq OWNED BY banners_banner.id;


--
-- Name: banners_category; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE banners_category (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    width integer,
    height integer,
    main boolean NOT NULL,
    ordering integer NOT NULL,
    activity boolean NOT NULL,
    CONSTRAINT banners_category_height_check CHECK ((height >= 0)),
    CONSTRAINT banners_category_ordering_check CHECK ((ordering >= 0)),
    CONSTRAINT banners_category_width_check CHECK ((width >= 0))
);


ALTER TABLE public.banners_category OWNER TO mkkiev;

--
-- Name: banners_category_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE banners_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_category_id_seq OWNER TO mkkiev;

--
-- Name: banners_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE banners_category_id_seq OWNED BY banners_category.id;


--
-- Name: banners_client; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE banners_client (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    url character varying(200) NOT NULL,
    email character varying(254) NOT NULL,
    ordering integer NOT NULL,
    activity boolean NOT NULL,
    CONSTRAINT banners_client_ordering_check CHECK ((ordering >= 0))
);


ALTER TABLE public.banners_client OWNER TO mkkiev;

--
-- Name: banners_client_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE banners_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banners_client_id_seq OWNER TO mkkiev;

--
-- Name: banners_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE banners_client_id_seq OWNED BY banners_client.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO mkkiev;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO mkkiev;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO mkkiev;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO mkkiev;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO mkkiev;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO mkkiev;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO mkkiev;

--
-- Name: pages_page; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE pages_page (
    id integer NOT NULL,
    url character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    keywords character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    content text NOT NULL,
    enable_comments boolean NOT NULL,
    template_name character varying(70) NOT NULL,
    registration_required boolean NOT NULL
);


ALTER TABLE public.pages_page OWNER TO mkkiev;

--
-- Name: pages_page_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE pages_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_page_id_seq OWNER TO mkkiev;

--
-- Name: pages_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE pages_page_id_seq OWNED BY pages_page.id;


--
-- Name: polls_choice; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE polls_choice (
    id integer NOT NULL,
    choice_text character varying(200) NOT NULL,
    votes integer NOT NULL,
    poll_id integer NOT NULL
);


ALTER TABLE public.polls_choice OWNER TO mkkiev;

--
-- Name: polls_choice_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE polls_choice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_choice_id_seq OWNER TO mkkiev;

--
-- Name: polls_choice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE polls_choice_id_seq OWNED BY polls_choice.id;


--
-- Name: polls_poll; Type: TABLE; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE TABLE polls_poll (
    id integer NOT NULL,
    question_text character varying(200) NOT NULL,
    pub_date timestamp with time zone NOT NULL
);


ALTER TABLE public.polls_poll OWNER TO mkkiev;

--
-- Name: polls_poll_id_seq; Type: SEQUENCE; Schema: public; Owner: mkkiev
--

CREATE SEQUENCE polls_poll_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_poll_id_seq OWNER TO mkkiev;

--
-- Name: polls_poll_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkkiev
--

ALTER SEQUENCE polls_poll_id_seq OWNED BY polls_poll.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article ALTER COLUMN id SET DEFAULT nextval('articles_article_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_related ALTER COLUMN id SET DEFAULT nextval('articles_article_related_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_tags ALTER COLUMN id SET DEFAULT nextval('articles_article_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_category ALTER COLUMN id SET DEFAULT nextval('articles_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_image ALTER COLUMN id SET DEFAULT nextval('articles_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_tag ALTER COLUMN id SET DEFAULT nextval('articles_tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner ALTER COLUMN id SET DEFAULT nextval('banners_banner_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner_categories ALTER COLUMN id SET DEFAULT nextval('banners_banner_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_category ALTER COLUMN id SET DEFAULT nextval('banners_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_client ALTER COLUMN id SET DEFAULT nextval('banners_client_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY pages_page ALTER COLUMN id SET DEFAULT nextval('pages_page_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY polls_choice ALTER COLUMN id SET DEFAULT nextval('polls_choice_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY polls_poll ALTER COLUMN id SET DEFAULT nextval('polls_poll_id_seq'::regclass);


--
-- Data for Name: articles_article; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_article (id, title, slug, activity, content, caption, image, video, slug_date, pub_date, write_date, create_date, edit_date, free, show, headline, aside, version, pageviews, ordering, author_id, category_id, creator_id, editor_id, publisher_id) FROM stdin;
9	ПОВЫШЕНИЕ "МИНИМАЛКИ" — ЭКСПЕРИМЕНТ НА ЛЮДЯХ	povyshenie-minimalki-eksperiment-na-lyudyah	t	<p>Бюджетным организациям не хватает финансирования на зарплаты и коммуналку, поэтому они отправляют сотрудников в бесплатный отпуск и даже вынуждены идти на их сокращение. По мнению экспертов, это произошло потому, что предварительные расчеты по повышению минимальной зарплаты не проводились, поэтому нельзя прогнозировать, сколько еще организаций окажутся под угрозой закрытия. Об этом пишут "Вести". </p>\r\n\r\n<p>Отдельно стоит вопрос о начислении зарплат, который добавился в январе. "Уже должны начисляться стипендии и зарплаты, а их еще даже не посчитали — неизвестно, сколько останется на выплаты после погашения "коммуналки" и начисления "минималки", — комментируют положение дел в Харьковском университете им. Каразина. </p>\r\n\r\n<p>Не получив директив от Кабмина, директора пытаются решить проблемы на ходу. "По максимуму людей отправили в отпуска и пытаются "утрамбовать" новую минимальную зарплату в старый бюджет, ведь после решения о ее повышении бюджеты никто не пересматривал, — прояснил ситуацию экс-министр ЖКХ Алексей Кучеренко. — Потом будут сокращать штаты, переводить сотрудников на половину и четверть ставки". </p>\r\n\r\n<p>Процесс уже начался. "Фонд зарплаты и так был неполным, а после решения Кабмина оказался полупустым, — констатирует глава профсоюза работников НАН Анатолий Широков. — Мы наблюдаем массовые сокращения, отпуска за свой счет, переводы на неполную занятость. Люди работают по три дня в неделю и получают зарплату, которая не выше той, что была". По его словам, по итогам прошлого года только из структуры Академии наук сократили 5 тысяч сотрудников, а это 17% от общего числа работников. </p>\r\n\r\n<p>"Выплывут не все, — убежден и Алексей Кучеренко. — Чтобы не было массовых увольнений, местным бюджетам увеличили отчисления от налогов. Но все съест "коммуналка". Это показывает, что каких-либо расчетов не проводили. Идет эксперимент на людях, и чем это закончится — непонятно".</p>	Мария СОКОЛОВСКАЯ.	images/glavnoe-za-nedelyu/2.jpg		2017-02-02	2017-02-02 06:49:15-05	\N	2017-02-02 06:49:15.24422-05	2017-02-03 07:35:38.336702-05	t	f	f	t	4	0	\N	\N	37	2	2	2
7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	den-pamyati-zhertv-holokosta-tragediya-ne-dolzhna-povtoritsya	t	<p>Вместе со всем миром его отметила 27 января и наша страна. А утвержден он резолюцией 60/7 Генеральной Ассамблеи ООН 1 ноября 2005 года. "Холокост, который привел к уничтожению одной трети евреев и несчитанного количества жертв из числа представителей других меньшинств, будет всегда служить всем народам предупреждением об опасностях, которые таят в себе ненависть, фанатизм, расизм и предубежденность", — говорится в тексте резолюции. </p>\r\n\r\n<p>Дата 27 января была выбрана не случайно: именно в этот день в 1945 году Советская Армия освободила узников крупнейшего нацистского лагеря смерти Аушвиц-Биркенау в Освенциме. За время существования этого концлагеря в нем погибли, по разным оценкам, от 1,5 до 2,2 миллиона человек. А всего жертвами беспощадной фашистской машины смерти стали более 6 миллионов евреев. </p>\r\n\r\n<p>В Украине впервые на государственном уровне отметили эту дату в 2012 году в соответствии с постановлением Верховной Рады от 5 июля 2011 года "О 70-летии трагедии Бабьего Яра". Слово "холокост" — греческого происхождения. В буквальном переводе — "всесожжение". Изначально термин возник в связи с геноцидом армян в начале XX века, позже стал обозначать уничтожение евреев в период нацистской Германии. В этом году тема Международного дня памяти — "Образование во имя лучшего будущего: роль исторических мест и музеев в просвещении по вопросам Холокоста". Так как памятные места сочетают в себе функции просветительских, культурных и научно-исследовательских центров, а также музеев. </p>\r\n\r\n<p>Первый в нашей стране Музей Холокоста — Мемориальный комплекс "Дробицкий Яр" был открыт в Харькове на пожертвования самих горожан 20 лет назад. А в этом году новая его экспозиция посвящена истории музея. Об этом корреспонденту Укринформа рассказала его основатель и руководитель, заслуженный работник культуры Украины Лариса Воловик. По ее словам, новая экспозиция была открыта при участии специально прибывших на юбилей музея представителей дипломатических служб, включая Посольство Государства Израиль в Украине, и приурочена она ко Дню памяти жертв Холокоста. </p>\r\n\r\n<p>"Новая экспозиция рассказывает о друзьях музея, членах областного комитета "Дробицкий Яр", тех, кто ведет поисковую работу, воссоздавая картину массового геноцида евреев в годы фашистской оккупации Харькова, кто пополняет общую экспозицию документальными свидетельствами прошлого, в том числе из семейных архивов. Есть здесь и материалы, рассказывающие о харьковской областной организации Праведников мира — земляках, спасавших евреев в годы фашистской оккупации", — отметила Лариса Фалеевна. По её словам, основная часть экспозиции — а это более 5 тысяч экспонатов — рассказывает о зиме 1941–1942 гг., когда в Дробицком Яру, на окраине Харькова, фашисты расстреляли более 16 тысяч харьковчан — в основном евреев. "Сейчас, когда в стране военный конфликт, особенно важна деятельность учреждений культуры, сохраняющих историческую память и культурное наследие. Музей продолжает работу, на наши конференции, выставки, встречи будет и впредь приходить молодежь. Трагедия Холокоста не должна повториться", — убеждена создатель музея. </p>\r\n\r\n<p>Мемориальный музейный центр евреев Буковины появится и в Черновцах. Центр, посвященный теме Холокоста, расположится в историческом здании "Бейт-Кадишин" (Дом прощания) на черновицком еврейском кладбище. Об этом говорится на официальном сайте Ассоциации еврейских организаций и общин Украины. "Проект пока в разработке. Для концептуального решения экспозиции будущего музея приглашаются различные специалисты — дизайнеры, музейщики, историки, архивисты. Поскольку здание "Бейт-Кадишин" долгое время использовалось не по назначению, сейчас оно находится в полуразрушенном состоянии. На его восстановление активно собираются средства", — сообщается на сайте.</p>	Мария СОКОЛОВСКАЯ.	images/politics/glavnaya.jpg		2017-02-02	2017-02-02 06:25:54-05	\N	2017-02-02 06:25:54.519148-05	2017-02-03 07:36:03.547764-05	t	f	f	t	6	0	\N	\N	48	2	2	2
16	КАКИЕ ИЗМЕНЕНИЯ НАС ЖДУТ В 2017 ГОДУ?	kakie-izmeneniya-nas-zhdut-v-2017-godu	t	<p><strong>Будет проще вернуть свои деньги из банка при наличии депозита</strong></p>\r\n\r\n<p>Верховный суд признал законными действия ипотечных заемщиков, закрывавших свои кредиты депозитами. Об этом идет речь в постановлении по делу №3-773гс16. Теперь официально разрешено проводить взаиморасчет с вкладчиками — менять кредит в проблемном банке на депозит. Единственное условие — все это нужно успеть до введения временной администрации. Иначе проблемой для вкладчиков может стать то, что с началом работы временной администрации в банке вводится мораторий на выполнение требований кредиторов. При этом кредиторами считаются и вкладчики, которые держат в банке свои депозиты. Таким образом, пока в банке работает временная администрация (а вводится она, как правило, на 6 месяцев), вкладчики не смогут получить свои деньги.</p>\r\n\r\n<p>"ВСУ и в предыдущих своих постановлениях давал разрешения на взаимозачет однородных требований — позволял обмен кредитных долгов перед банком на задолженность самого банка перед вкладчиком. Но данный случай интересен тем, что речь идет об ипотеке. За такие займы представители Фонда гарантирования вкладов физлиц (ФГВФЛ) активно спорят в судах. Теперь же им это будет делать намного сложнее. Ведь Верховный суд открыто встал на сторону клиентов банка. Заемщик сможет спокойно договориться с вкладчиком и каждый получит свою выгоду: вкладчик сможет снять со счета проблемного банка более 200 тыс. грн, предлагаемых ФГВФЛ, а заемщик — погасить кредит на более выгодных для себя условиях и сроках (поскольку включится механизм дисконта)", — разъясняет старший партнер адвокатской компании "Кравец и партнеры" Ростислав Кравец.</p>\r\n\r\n<p><strong>Верховная Рада продлила мораторий на продажу сельскохозяйственных земель до 1 января 2018 года</strong></p>\r\n\r\n<p>Законом №1669-VIII продлевается срок действия моратория на продажу или иной способ отчуждения земель сельскохозяйственного назначения.</p>\r\n\r\n<p><strong>У аграриев заберут соцльготы на НДС, но увеличат дотации</strong></p>\r\n\r\n<p>Дотации на сельское хозяйство в 2017 году увеличатся вдвое и составят 5,5 млрд грн. В 5 раз вырастет бюджет Министерства аграрной политики — до 7,4 млрд грн.</p>\r\n\r\n<p>Предусмотрены такие бюджетные программы:</p>\r\n\r\n<ul>\r\n<li><p>«Финансовая поддержка мероприятий в агропромышленном комплексе через удешевление кредитов»;</p></li>\r\n<li><p>«Государственная поддержка развития хмелеводства, закладки молодых садов, виноградников и ягодников и надзор за ними»;</p></li>\r\n<li><p>«Государственная поддержка отрасли животноводства»;</p></li>\r\n<li><p>«Финансовая поддержка сельхозтоваропроизводителей»;</p></li>\r\n<li><p>«Финансовая поддержка мероприятий в агропромышленном комплексе».</p></li>\r\n</ul>\r\n\r\n<p><strong>Изменения в налогообложении</strong></p>\r\n\r\n<p>С принятием изменений в налоговое законодательство и изменением так называемой "минимальной зарплаты", изменятся и условия работы субъектов предпринимательства, зарегистрированных как "единоналожники".</p>\r\n\r\n<p>Главное изменение, внесенное в Налоговый кодекс Украины — ставка единого налога для первой группы остается на уровне 10%, и расчеты привязываются к прожиточному минимуму, а не к минимальной заработной плате, как раньше. Исходя из прожиточного минимума 2017 года — 1600 грн, предпринимателям нужно будет платить за месяц до 160 грн. Для второй группы остаются фиксированные ставки в процентах от размера минимальной заработной платы, но вырастет сама сумма — 640 грн (20% от 3200 грн).</p>\r\n\r\n<p>По третьей группе методология тоже не поменялась — процентные ставки зависят от доходов. У плательщиков НДС остается 3%, у неплательщиков — 5%.</p>\r\n\r\n<p>Нельзя обойти стороной тот факт, что норма, согласно которой физические лица – плательщики единого налога, которые являются пенсионерами по возрасту, освобождаются от уплаты этого налога и в 2017 году.</p>\r\n\r\n<p><strong>Кто будет получать стипендию?</strong></p>\r\n\r\n<p>Это, пожалуй, самая обсуждаемая тема и самая спорная. Напомним, что Кабмин принял Постановление «О внесении изменений в стипендиальное обеспечение», которое предусматривает сокращение количества стипендиатов почти наполовину. Как и раньше, стипендиальный фонд Украины предусматривает два вида стипендий — социальные (для социально незащищенных граждан, льготников) и академические (за достижения в учебе). В рамках студенческой (стипендиальной) реформы социальную стипендию будут получать порядка 7% нынешних студентов, а именно:</p>\r\n\r\n<ul>\r\n<li><p>лица, пострадавшие вследствие Чернобыльской катастрофы;</p></li>\r\n<li><p>признанные участниками боевых действий и их дети;</p></li>\r\n<li><p>зарегистрированные как внутренне перемещенные лица;</p></li>\r\n<li><p>дети, один из родителей которых погиб во время массовых акций гражданского протеста;</p></li>\r\n<li><p>дети, один из родителей которых погиб (пропал без вести) в районе проведения АТО, боевых действий или вооруженных конфликтов;</p></li>\r\n<li><p>дети шахтеров, чьи родители имеют необходимый стаж работы или погибли в результате несчастного случая на производстве, или стали инвалидами I или II группы.</p></li>\r\n</ul>\r\n\r\n<p>Каждый вуз самостоятельно разработает свои критерии для составления рейтинга успеваемости. Примерно на 90% место студента в рейтинге будет зависеть от учебной успеваемости и на 10% — от установленных критериев учебного заведения (например, научная, спортивная или общественная деятельность). Обычная стипендия в высших учебных заведениях I-II уровней аккредитации составит 830 грн, повышенная — 1207 грн (например, в 2016 году повышенная стипендия в таких заведениях была 692 грн).</p>\r\n\r\n<p>В вузах III-IV уровней аккредитации обычную стипендию повысили по сравнению с прошлым годом на 33%, и она равна 1100 грн, повышенная — 1600 грн (увеличена на 73% по сравнению с 2016 годом).</p>\r\n\r\n<p>Стипендии для студентов отдельных специальностей, которые являются остродефицитными, на факультетах природных, инженерных, будут еще выше: обычная составит 1400 грн, повышенная — 2037 грн. Кроме того, Минфин настаивает, чтобы к 2019 году постепенно уменьшить количество стипендиатов до 15%.</p>\r\n\r\n<p><strong>Вырастут зарплаты бюджетников</strong></p>\r\n\r\n<p>По решению Кабинета министров Украины с января 2017 года должностные оклады учителей повысятся на два тарифных разряда — то есть на 50%. Таким образом, зарплата учителя высшей категории, которого отнесут не к 12-му, а к 14-му разряду, с 1 января составит от 5266 грн до 6841 грн. Учителя без категории будут получать от 3960 грн до 4853 грн.</p>\r\n\r\n<p>Также вырастет на 30% зарплата врачей и остальных бюджетников.</p>\r\n\r\n<p><strong>Новая старая пенсионная система</strong></p>\r\n\r\n<p>Согласно Закону “Об общеобязательном государственном пенсионном страховании”, с января изменится система начисления пенсий.</p>\r\n\r\n<p>При этом отчисления предприятий будут осуществляться и по старой пенсионной системе. Таким образом, пенсионных сборов в течение ближайших лет придется платить от 22% + 2% до 22% + 7%. В среднем пенсионные выплаты увеличатся на 11% — с 1 мая, а потом – с 1 декабря. С января 2017 года запускается накопительная система выплаты пенсий: каждый украинец до 35 лет начнет отчислять часть своей зарплаты на индивидуальный счет. Для этого будет создан целевой внебюджетный фонд, куда будут поступать взносы застрахованных украинцев, однако воспользоваться ими можно будет только после выхода на пенсию. На протяжении пяти лет (с 2017-го по 2022 год) процент отчислений постепенно вырастет с 2% до 7%. <em>Напомним, что сегодня порядка 80% пенсионеров получают минимальную пенсию. Но лишь 38,5% работоспособных граждан платят взносы в Пенсионный фонд</em>. </p>\r\n\r\n<p><strong>Платные телеканалы</strong></p>\r\n\r\n<p>Вступает в силу Закон "О внесении изменений в Закон Украины "О телевидении и радиовещании" (об уточнении условий распространения программ телерадиоорганизаций в составе универсальной программной услуги)".</p>\r\n\r\n<p>Благодаря этому медиагруппы теперь смогут требовать с операторов платного телевидения плату за вещание каналов в их сетях (до этого кабельщики были обязаны в соответствии с УПУ транслировать их бесплатно). С февраля за пакет программ придется дополнительно платить от 12 до 18 гривен ежемесячно. При этом эти суммы лишь на 1% покрывают убытки телеканалов.</p>\r\n\r\n<p><strong>Реформирование медицинской отрасли на протяжении 2016−2017 гг.</strong></p>\r\n\r\n<ul>\r\n<li><p>внедрение механизма оплаты медицинских услуг по принципу “деньги идут за пациентом”. По рекомендациям зарубежных экспертов государство изменяет подходы к финансированию здравоохранения, ориентируясь не на оплату стен медучреждений и коммунальных услуг, а на оказание медицинских услуг, в которых непосредственно нуждаются пациенты. Врачи будут выписывать необходимые пациентам препараты в соответствии с изменениями в национальном перечне. Лекарства будут доступны по ценам, так как их цены будут референтированы с пятью странами — членами Евросоюза (Польшей, Латвией, Словакией, Венгрией, Чехией).</p></li>\r\n<li><p>внедрение системы реимбурсации лекарств (полное или частичное возмещение пациентам стоимости лекарств) и установление предельно допустимых оптово-отпускных цен. По проекту постановления Кабмина, компенсировать стоимость медпрепаратов будут украинцам с сердечно-сосудистыми заболеваниями, сахарным диабетом и астмой. Для таких пациентов планируют сделать бесплатными 93 препарата. Выдавать лекарства будут аптеки и только по рецепту врача на специальном бланке. </p></li>\r\n</ul>	Виктория БУРКОВСКАЯ.	images/russia/nv_36_pyshniy_pyshnyi_01_0.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-06 06:56:17.320637-05	2017-02-06 06:57:43.720149-05	t	f	f	t	3	0	\N	\N	48	2	2	2
10	ЭТО ИНДИЯ, ДЕТКА!	eto-indiya-detka	t	<p><strong>«Земля грёз и романтики, неслыханного богатства и небывалой нищеты, роскоши и бедности, дворцов и лачуг, духов и исполинов, ламп Аладдина, тигров, слонов, кобр и джунглей; страна сотен народов и языков, тысячи религий и двух миллионов богов... Единственная страна под солнцем, которая бесконечно интересна... образованному и неграмотному, мудрому и глупому, богатому и бедному, пред которой меркнут все другие прелести мира». Так описал Индию чуть больше века назад, в 1897 году, Марк Твен.</strong> </p>\r\n\r\n<p><strong>Сегодняшние путешественники могут, без сомнения, повторить эти слова.</strong></p>\r\n\r\n<p><strong>От Маугли до Камасутры</strong></p>\r\n\r\n<p>Об Индии с ее миллиардным населением мы знаем немало. В детстве зачитывались приключениями Маугли, которого знаменитый англичанин Редьярд Киплинг поселил в штате Мадхья-Прадеш, самом большом в Индии. Заслушивались арией Индийского гостя из оперы «Садко», уверявшего, что «не счесть алмазов в каменных пещерах», со стыдливым любопытством заглядывали в «энциклопедию любви» - Камасутру. И все повально увлекались йогой… И все-таки об Индии мы не знаем почти ничего. Потому что дух Индии, ее атмосферу, где мистика и быт сплелись в прочный клубок, разобрать на отдельные нити не дано никому.</p>\r\n\r\n<p><strong>Сначала были запахи…</strong></p>\r\n\r\n<p>Мы прилетели из заснеженного, ветрено-промозглого Борисполя в аэропорт Дели в половине пятого утра. И прямо с трапа как будто попали в круглосуточную баню. Сезон дождей еще не начался, но влажность воздуха была такая, что в принципе стало понятно, почему индусам можно не мыться каждый день. И вообще, как выяснилось в процессе путешествия, представления о гигиене у местных жителей весьма и весьма специфические. Это страна немытых рук, открытых туалетов и полного игнорирования санитарных норм. Как при этом весь этот миллиард с лишним до сих пор жив, здоров и успешно размножается - для меня большая загадка. Очевидно, потому что у индусов очень острая пища – огненные специи убивают бактерии. И продлевают жизнь продуктам. Слегка подпорченное мясо хранят в острых соусах и обильно сдабривают экзотическими приправами. В итоге крайне сложно понять, что именно вам подают. Выбор места, где поесть - та еще забава. Подавляющее число уличных «кафе» - откровенная попытка самоубийства. Продукты могут лежать на полу, мясо рубиться топором прямо на асфальте, облезлая собака отдыхать на овощах. Да и моют эти овощи если не в ближайшей грязной речке, то в общей бадье с горой грязной посуды. Поэтому мы питались исключительно со «шведского стола» в отеле. Первый же обед в самолете на местных линиях, который мы попытались очень осторожно попробовать, начисто отбил желание экспериментировать с индийской кулинарией.</p>\r\n\r\n<p>Запах Индии - это смесь нечистот и ароматических палочек, которые жгут повсеместно и круглосуточно. Подозреваю, что не только в религиозных целях, но и чтобы перебить «аромат природы». Невероятно, но именно запах этих ароматических веществ и вызывает потом острую ностальгию, до сердечного замирания...</p>\r\n\r\n<p><strong>«Гибельный восторг» Старого Дели</strong></p>\r\n\r\n<p>Поскольку основная часть нашего путешествия была запланирована по самому южному штату Керала, расположенному на Аравийском побережье страны, в Дели мы задержались ненадолго. Но все равно впечатлений хватило с головой. Особенно потрясла старая часть, где, в отличие от относительно спокойного и цивилизованного Нью-Дели, царит настоящий бедлам. Лично у меня сложилось впечатление, что я попала в город сразу после массированной бомбардировки – настолько упаднически выглядят здешние строения. Возведенные еще во времена английской колонизации, которая закончилась в 50-х годах ХХ века, они с тех пор только методично ветшают и рушатся. Ни местные власти, ни местные жители, похоже, не заморачиваются поддержанием хотя бы минимального порядка. Если его вообще мыслимо навести в этом невероятном скопище людей и транспорта…</p>\r\n\r\n<p><strong>Стопроцентная экзотика</strong></p>\r\n\r\n<p>Индийские дороги и движение по ним - это отдельная песня. Представьте себе две полосы в каждую сторону, разделенные чем-то вроде газона, на котором безмятежно пасутся осел или баран. Каждый мало-мальски обозначенный населенный пункт вываливает практически на проезжую часть содержимое своих бесконечных базаров: овощи, фрукты, одежду, бытовую химию. Это оттого, что никаких правил дорожного движения никто в Индии соблюдать и не собирается. Ударить соседа бампером считается правилом хорошего тона, а выехать на встречную полосу и увильнуть за секунду до лобового столкновения с тяжелым грузовиком – обычное дело. На крышах автобусов теснятся люди с детьми и котомками. Водители заявляют о присутствии на дороге беспрерывным гудением. В итоге все эти разнообразные музыкальные гудки складываются в такую чудовищную какофонию, что двухчасовой переезд в аэропорт внутренних авиалиний грозил нам временной потерей слуха и реальным нервным срывом.</p>\r\n\r\n<p>Зато стопроцентная экзотика поджидает здесь на каждом шагу. Вот на дереве у отеля сидит дикий павлин, оглашая окрестности своими мяукающими воплями. Вместо воробьев порхают зеленые попугаи. Вот посреди узенькой улицы разлеглась корова и меланхолично зевает, явно устроилась надолго, перекрыв собой всякую возможность передвижения. Вообще коровы - это настоящие санитары города. Они съедают абсолютно все органические отходы, которые бросают на землю люди, взамен, правда, выдают лепешки. Но кого такая мелочь может, собственно, волновать?</p>\r\n\r\n<p><strong>В ожидании лучшей жизни</strong></p>\r\n\r\n<p>Как украинские водители маршруток любят украшать салон своего транспортного средства православными иконками, так и их индийские коллеги обклеивают все внутри яркими изображениями Вишну, Кришны, Шивы, Дурги и прочих богов, густо занавешивая все это сверху гирляндами из шафрана. При этом индуизм - такая интересная и демократичная религия, в которой каждый может найти себе соответствующего бога по вкусу и потребностям. Сами индусы шутят, что пантеон их богов по численности догоняет население.</p>\r\n\r\n<p>Как древние индусы умудрились построить такое количество великолепных дворцов, резных и воздушных храмовых комплексов, поражающих воображение громадных фортов – уму непостижимо. И как при этом умудряются жить в развалинах без окон, дверей, туалетов и часто электричества в нынешнее время - понять нереально.</p>\r\n\r\n<p>Ты можешь, открыв рот от восхищения, наслаждаться видом прекрасного средневекового сооружения, а через 10 метров споткнуться о спящего прямо на земле человека. И никого такое соседство не смущает. Индусов вообще трудно смутить. Дети благосклонных природных условий и своеобразной религии, они могут всю жизнь просидеть на тротуаре, жуя бетель и ожидая лучшей доли в следующем воплощении. Не требуя никаких богатств, индус уже не будет чувствовать себя нищим, если у него найдется что постелить под себя на землю, и будет безмерно благодарен доброй торговке за лепешку. В Индии стоит оказаться хотя бы для того, чтобы поучиться такому философскому отношению к жизни.</p>\r\n\r\n<p><strong>Город с непроизносимым названием</strong></p>\r\n\r\n<p>Перевести дух после экстремальных переездов на допотопном бусике, включая двухчасовой перелет местным самолетом, мы смогли лишь прибыв в отель неподалеку от города с практически непроизносимым названием - Тируванантапурам, хотя столицу южного индийского штата Керала гораздо чаще именуют упрощённо - Тривандрам. И это была настоящая награда за все наши моральные и физические испытания! Отель - современный, чистый, уютный - настоящий оазис среди изматывающей до предела экзотики.</p>\r\n\r\n<p>Необходимо сказать, что штат Керала отличается от остальной Индии. Здесь существенно чище, хотя все равно грязи хватает. Во главе штата стоит коммунистическое правительство, везде красные флаги с серпом и молотом, всюду политические плакаты с изображениями Маркса, Энгельса, Ленина, Сталина, Фиделя Кастро и Че Гевары. Зато грамотность в Штате почти стопроцентная, практически все могут объясняться на английском. Так как грамотность здесь высокая, многие ездят на заработки в арабские страны и Европу. На земле местные не работают, приезжают люди из других штатов, где средний уровень жизни значительно ниже. Кстати, средний заработок керальцев составляет около 300 долларов, тогда как в соседних штатах – $100–150. </p>\r\n\r\n<p>На следующее утро, отдохнувшие и подкрепившиеся вполне европейским завтраком (отведать местные кулинарные изыски так и не решились), мы отправились на экскурсию в Тривандрам. Богатая и необычная история города отражается в контрасте современных кварталов и хранящего колорит индийской культуры старого города. Символ столицы штата – Храм Шри Падманабхасвами, возведенный в середине ХVI века. Его стены выложены изображающими мистические сюжеты фресками, а внутри хранится покрытая драгоценными камнями и золотом пятиметровая статуя Маха Вишну, доступ к которой позволен только индусам. Вечером нас ждал незабываемый шопинг в центре, откуда мы вернулись с нитками нешлифованного жемчуга, красивыми статуэтками Шивы, вырезанными вручную из красного дерева, и местными барабанами, про которые говорят: если вернешься из Индии без барабана, поездка считается недействительной…</p>\r\n\r\n<p><strong>Дальше - только Антарктида</strong></p>\r\n\r\n<p>Конечный пункт нашей поездки – Каньякумари. Город вечной невесты Шивы, так и не ставшей женой. Это - край земли, самая южная точка Индии, Индостана, и Евразийского континента. Место слияния Индийского океана, Бенгальского залива и Аравийского моря. Только здесь, не вставая с камня на берегу океана, можно одновременно встретить рассвет и проводить закат. </p>\r\n\r\n<p>На расстоянии 500 метров от берега расположено два острова, на которых высятся монументы. Один открыт в честь индийского мыслителя Свами Вивекананды и там же находится храм принцессы Каньякумари, а на другом - в честь древнего поэта Тируваллувара - статуя высотой 30 метров. В Каньякумари возведен монумент и в честь Махатмы Ганди, написавшего о здешних местах: «Что может быть прекрасней, чем созерцать восходы и закаты там, где Дева ждала Бога». </p>	Виктория ЯСНОПОЛЬСКАЯ.	images/politics/indianka-lakshmi.jpg		2017-02-02	2017-02-02 08:50:53-05	\N	2017-02-02 08:50:53.797306-05	2017-02-14 02:35:22.01471-05	f	f	f	t	4	0	\N	\N	42	2	2	2
17	КАК ПРАВИЛЬНО ЛЕЧИТЬ АНГИНУ?	kak-pravilno-lechit-anginu	t	<p><strong>В холодное время года ангина – одно из самых распространённых заболеваний. Болезнь эта довольно неприятная, так как сопровождается не только болезненными ощущениями в горле, усиливающимися при глотании, но и высокой температурой.</strong></p>\r\n\r\n<p>Чаще всего ангину вызывают стрептококки, и источником заболевания бывает другой человек. Заражение может произойти воздушно-капельным путем или через одну посуду. Ангина может протекать в разных формах.</p>\r\n\r\n<p><strong><em>Катаральная</em></strong></p>\r\n\r\n<p>Это самая легкая форма ангины, и начинается она, как правило, с сухости и жжения в горле. Миндалины увеличены, температура может быть небольшой – от 37,2 до 38˚. При правильном лечении неприятные симптомы исчезают через 1–2 дня, но если катаральную ангину не лечить, она перейдет в более серьезные формы.</p>\r\n\r\n<p><strong><em>Фолликулярная</em></strong></p>\r\n\r\n<p>При этой форме ангины миндалины бывают сильно увеличены, на них хорошо видны гнойные образования (фолликулы), напоминающие булавочную головку. Через несколько дней они вскрываются, тогда на миндалинах появляется белый налет. Болезнь сопровождается ознобом и лихорадкой, головной болью и слабостью. Температура может подниматься до 39 градусов. При правильном лечении фолликулярная ангина проходит через 5–7 дней.</p>\r\n\r\n<p><strong><em>Лакунарная</em></strong></p>\r\n\r\n<p>По симптоматике эта форма ангины сходна с фолликулярной, но протекает тяжелее. При лакунарной ангине не только миндалины увеличены, но и лакуны заполнены гнойным содержимым и расширены. На их поверхности можно наблюдать мелкие образования или налет. При правильно подобранном лечении проходит за неделю.</p>\r\n\r\n<p>Следующие три формы ангины встречаются крайне редко.</p>\r\n\r\n<p><strong><em>Герпетическая</em></strong></p>\r\n\r\n<p>Ее вызывает специфический вирус – Коксаки. Протекает крайне тяжело и сопровождается не только болью при глотании, но и сильной головной болью, а также болью в мышцах. Нередко проявляются симптомы расстройства пищеварения. На нёбе, миндалинах и задней стенке горла появляются красноватые пузырьки, которые бесследно проходят через 3–4 дня. Температура может подняться до 40 градусов.</p>\r\n\r\n<p><strong><em>Некротическая</em></strong></p>\r\n\r\n<p>При этой форме ангины на одной из гланд образуется язва, из-за чего возникают следующие симптомы: повышенное слюноотделение, ощущение инородного тела при глотании, гнилостный запах изо рта. Эта тяжелая форма заболевания характеризуется очень высокой температурой, рвотой, сильной слабостью и спутанностью сознания. На миндалине образовывается серовато-зеленый налет, ее поверхность становится неровной. Длительность лечения может составлять от пары недель до нескольких месяцев.</p>\r\n\r\n<p><strong><em>Флегмонозная</em></strong></p>\r\n\r\n<p>Самая редкая форма ангины. Ее развитие связано с гнойным расплавлением части миндалины (чаще всего одной). При этом пораженная миндалина сильно увеличивается, как и близлежащие лимфоузлы. Температура повышается до 40 градусов, появляются сильная головная боль и озноб.</p>\r\n\r\n<p>Так как ангину чаще всего вызывают стрептококки, ее лечение невозможно без антибиотиков. Если попытаться просто убрать симптомы ангины, то стрептококки все равно останутся в организме и через несколько лет проявятся ревматизмом или воспалением почек. Конкретный антибиотик должен быть назначен врачом после осмотра больного.</p>\r\n\r\n<p>Большое внимание стоит уделить тому, чтобы удалить гной с миндалин, а для этого необходимы полоскания. Подойдут солевой или содовый растворы, фурацилин, отвары трав (ромашка, шалфей, кора дуба и т.д.).</p>\r\n\r\n<p>Кроме того, необходимы антимикробные средства для горла – спреи и таблетки для рассасывания. Нередко они оказывают еще и анестезирующее действие, что даст возможность избавиться от боли достаточно быстро.</p>\r\n\r\n<p>При повышенной температуре (больше 38,5 градусов у взрослых и 38˚ – у детей) следует принять жаропонижающее.</p>\r\n\r\n<p>При контакте с человеком, больным ангиной, используйте медицинские маски. Обязательно отделите его посуду от общей. Старайтесь как можно чаще мыть руки и протирать дезинфицирующими средствами предметы общего пользования (трубку телефона, пульт от телевизора и т.д.). Лучше, если заболевший будет находиться большую часть времени в отдельном помещении.</p>	Инна НОВИКОВА.	images/medicina/angina-e1469807672818.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-06 07:03:53.327881-05	2017-02-07 06:18:31.828558-05	f	f	f	t	4	0	\N	\N	55	2	2	2
11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	avstraliya-perepisala-istoriyu-tennisa	t	<h1>Выдающийся рекорд Роджера Федерера и историческая победа украинки Марты Костюк на Зелёном континенте</h1>\r\n\r\n<p><strong>В минувшее воскресенье в Мельбурне завершился Australian Open. Первого соревнования из серии «Большого шлема» всегда ждут особенно, так как именно с него фактически и начинается теннисный сезон. В сравнении с другими главными турнирами — Ролан Гарросом, Уимблдоном и US Open – у Открытого чемпионата Австралии есть своя особенность и изюминка. Если Уимблдон считается самым дождливым «Шлемом», то Australian Open - самым жарким. Словом, выносливость спортсменов проверяется не только пятисетовыми матчами у мужчин, но и жарой под 40 градусов.</strong></p>\r\n\r\n<p>Впрочем, организаторы турнира делают все, чтобы облегчить жизнь теннисистам – несколько лет назад три главных корта «Мельбурн Парка» были оборудованы раздвижной крышей, что позволяет проводить матчи как во время самого сильного зноя, так и во время дождя. В отличие от тех же Роллан Гарроса или Уимблдона, где поединки из-за непогоды то и дело переносятся, в Австралии уже привыкли, что расписание выполняется безукоризненно, и для поклонников со всего мира, которые платят бешеные деньги, чтобы приехать на Зелёный континент и понаблюдать за матчами вживую, риск опоздать на самолет сведен к минимуму. </p>\r\n\r\n<p>Благодаря этим факторам растет и посещаемость турнира. Всего за две недели соревнование посетили почти 700 тысяч любителей тенниса, и это при том, что стоимость билетов на самые статусные поединки – к примеру, полуфиналы и финал в мужском разряде – достигает 1500 долларов! Те, кто не в состоянии выложить круглую сумму, за матчами наблюдают на огромных экранах, расположенных на территории теннисного парка. В ходу и разнообразные сувениры. Одним из самых продаваемых товаров на Australian Open является фирменное полотенце, которое стоит около 50 американских долларов.</p>\r\n\r\n<p>Такая популярность, а следовательно и прибыль позволяют организаторам ежегодно увеличивать призовой фонд: в течение последних лет он постоянно растет. Если в 2012 году организаторы гордились суммой в 26 миллионов долларов, то на турнире 2017 года призовой фонд для участников составил ровно 50 миллионов, и это – абсолютный рекорд за всю историю теннисных соревнований!</p>\r\n\r\n<p><strong>Невероятное достижение 14-летней киевлянки</strong></p>\r\n\r\n<p>Даже пройти один-два раунда на таком турнире – серьезное достижение для любого теннисиста, а тем более для неизбалованных славой украинских спортсменов. В этом смысле выход в третий круг во взрослом одиночном разряде нашей Элины Свитолиной можно считать неплохим результатом. </p>\r\n\r\n<p>Но самую большую радость украинским болельщикам принесла невероятная победа 14-летней киевлянки Марты Костюк, которой удалось практически невозможное – выиграть титул в юниорском разряде, при том, что большинство ее оппоненток были на 3–4 года старше украинки. </p>\r\n\r\n<p>Марта была «посеяна» на соревнованиях под 11-м номером, и для нее этот турнир «Большого шлема» был вообще дебютным в карьере. Но на пути к титулу она обыграла шестерых соперниц - Махак Джаин из Индии, японку Нахо Сато, Джоди Баррейдж из Великобритании, Лян Эньшуо (Тайвань), Елену Рыбакину из России и, наконец, в финале – 17-летнюю Ребеку Масарову (Швейцария) – первую ракетку мира среди юниорок! </p>\r\n\r\n<p>Борьба в решающем поединке была невероятно упорной: 14-летняя украинка сумела удивить соперницу в первой партии, выиграв 7:5. Швейцарка сумела исправиться во втором сете, доведя его до победы 6:1. Казалось, что исход третьей, решающей партии предрешен, однако Марта неожиданно для всех переломила ход встречи, продолжила разводить швейцарку по углам и взяла решающий сет – 6:4. Победив, Марта упала на корт и несколько секунд рыдала от счастья!.. А на церемонии награждения завернулась в украинский флаг.</p>\r\n\r\n<p>Марта Костюк стала всего лишь четвертой представительницей нашей страны, которой удалось завоевать трофей на турнирах «Большого шлема». В далеком 1991 году юниорский Ролан Гаррос выиграл нынешний главный тренер сборной Украины Андрей Медведев. В 2004-м Катерине Бондаренко покорился юниорский Уимблдон и, наконец, в 2010-м Элина Свитолина праздновала победу на Ролан Гарросе – тоже юниорском.</p>\r\n\r\n<p>Более того, украинка стала самой молодой победительницей юниорского «Большого шлема» за последние 9 лет. Есть все основания надеяться на то, что ее ждет блестящее спортивное будущее!.. </p>\r\n\r\n<p><strong>Федерер – Надаль: назад в будущее</strong></p>\r\n\r\n<p>Турнир стал историческим для Украины, но в еще большей степени – эпохальным для всего мира и знаковым в разрезе истории вида спорта. Взять хотя бы состав финальных пар в мужском и женском разрядах. Впервые в истории все четыре финалиста турнира «Большого шлема» оказались старше 30 лет, причем троим из них - 35 и больше. </p>\r\n\r\n<p>Самым молодым участником решающего матча оказался Рафаэль Надаль, родившийся в 1986 году. Противостояние испанца с 35-летним Роджером Федерером было главным в мужском теннисе примерно с 2005-го по 2010 годы. Затем основным соперником Надаля стал Новак Джокович. На протяжении последних двух-трех сезонов ушли в тень оба – и Федерер, и Надаль: их замучили травмы. </p>\r\n\r\n<p>Но теперь мужской теннис вернулся к истокам. Болельщики словно переместились на машине времени лет на 10–12 назад, когда швейцарец и испанец разыгрывали между собой самые зрелищные и драматичные матчи, ставшие классикой этого вида спорта. Многие окрестили финал-2017 «финалом мечты»… </p>\r\n\r\n<p>Для того чтобы он состоялся, должно было совпасть много факторов, и они совпали: Федерер сумел неожиданно быстро набрать форму после полугодичного перерыва, когда он вообще не проводил официальные матчи. А Надаль, до этого два с половиной года не выходивший на «Шлемах» дальше четвертьфинала, еще больше разнообразил свой тактический арсенал. Его крученые удары стали закручиваться еще интенсивнее, траекторию полета мяча после ударов ракетки испанца предугадать было практически невозможно. О неудобности Надаля для швейцарца красноречиво говорит тот факт, что из предыдущих восьми финалов на «Больших шлемах» Федереру удалось выиграть только в двух… </p>\r\n\r\n<p>Однако перед самим матчем вся статистика ушла на задний план: два больших чемпиона снова встретились, намереваясь подарить зрителям незабываемое зрелище.</p>\r\n\r\n<p><strong>Великие чемпионы</strong></p>\r\n\r\n<p>Соперники долго втягивались в игру – сказался и возраст, и колоссальная физическая нагрузка на протяжении всего турнира: в полуфиналах и Роджер, и Рафа прошли тяжелейшие испытания пятисетовыми матчами. В первых четырех партиях их очной дуэли инициатива попеременно переходила то к одному, то к другому, и накануне решающего сета наметился классический баланс – 2:2. Оказалось, что самое интересное друзья-соперники приберегли на концовку. Два гейма подряд прошли в очень упорной борьбе с обилием красивых длинных розыгрышей. Оба много бегали по задней линии и приводили публику в экстаз своими действиями. Федерер вначале потерял свою подачу, но когда Надаль уже «почувствовал кровь», швейцарец на невероятных волевых усилиях заставил оппонента тоже ошибиться. Тут же у Роджера наладилась подача. Эйсы в этом финале он выдавал пачками, и два из них в 7-м гейме были очень кстати. </p>\r\n\r\n<p>Вновь почувствовав уверенность, Федерер сделал брейк в решающем 8-м гейме. Оставалось лишь подать «на матч». Подача швейцарца вновь выручила - три эйса! На первом матч-пойнте Федерер ошибся по длине, но на втором швейцарец точно пробил справа кроссом в угол. Надаль взял повтор, но, как показала система Hawk-Eye, мяч на считанные миллиметры зацепил боковую линию. Именно это крошечное расстояние стало решающим: гейм, сет и матч в пользу Федерера - 6:4, 3:6, 6:1, 3:6, 6:3! </p>\r\n\r\n<p>Швейцарец завоевал исторический 18-й «Большой шлем» и первый для себя начиная с Уимблдона-2012. Роджер радовался как ребенок. При этом все знают, что они с Надалем в чудесных дружеских отношениях. На церемонии награждения победитель признался: «Ни я, ни Рафа не верили, что снова сыграем в финале такого турнира. Было бы здорово, если бы мы могли разделить эту победу. Мы оба очень много работали над своей игрой».</p>\r\n\r\n<p>…На кону в этот день и правда стояло очень многое. В более позднем возрасте, чем Федерер, «Шлем» выигрывал только Кен Розуолл - в 37 лет он победил на Australian Open-1972. По общему числу титулов Роджер еще больше укрепил свой рекорд в Открытой эре – 18 титулов! Больше нет ни у кого, если не исключать женские соревнования. </p>\r\n\r\n<p>Там, кстати, обновилось достижение американки Серены Уильямс, завоевавшей также исторический 23-й «Шлем» в карьере. В финале спортсменка обыграла свою старшую сестру Венеру, для которой участие в решающем поединке стало своего рода спортивным подвигом. По числу титулов на «мэйджорах» Серена побила рекорд немки Штеффи Граф…</p>\r\n\r\n<p>Что ж, две недели теннисных баталий дали болельщикам немало пищи для обсуждений. А это ведь только начало сезона! Год обещает быть жарким… </p>	Юрий ВИНОГРАДОВ.	images/sport/1.jpg		2017-02-01	2017-01-31 17:00:00-05	\N	2017-02-03 05:23:33.081752-05	2017-02-03 05:48:53.16235-05	t	f	f	t	5	0	\N	\N	43	2	2	2
12	ЕВРОПА ЗА ТО, ЧТОБЫ УКРАИНА ПОКУПАЛА ГАЗ У РОССИИ	evropa-za-chtoby-ukraina-pokupala-gaz-u-rossii	t	<p><strong>И Украина готова его покупать - для этого у страны есть необходимые деньги, а юридические аспекты поставок обсуждаются. Об этом в четверг, 19 января, заявил вице-президент Еврокомиссии по энергосоюзу Марош Шефчович.</strong></p>\r\n\r\n<p>«Мы находимся в частном и хорошем контакте с обеими - российской и украинской - сторонами… При необходимости Россия готова поставлять газ. Положительная вещь в том, что Украина готова покупать и имеет адекватные финансовые средства для этого", – отметил европейский чиновник.</p>\r\n\r\n<p>После многочисленных заявлений об энергетической независимости и о том, что мы больше не покупаем российский газ, которые мы слышали в течение целого года, слова Шефчовича прозвучали несколько неожиданно. Если информация соответствует действительности, то это означает, что победил здравый смысл, который состоит в том, что покупать лучше все-таки тот газ, который дешевле. В социально-экономической ситуации, сложившейся в Украине после энергетической реформы, каждый сэкономленный доллар не будет лишним.</p>\r\n\r\n<p><strong>Платёжная лихорадка</strong></p>\r\n\r\n<p>А какая ситуация сложилась после "энергетической реформы", сегодня уже не нужно объяснять никому. Она отражается в декабрьских платежках украинцев за отопление: больше 1 тысячи гривен - за 2-комнатную квартиру, около 2-х тысяч - за «трёшку». И это средние киевские цифры, а максимум и в столице, и в регионах, как оказалось, не имеет границ.</p>\r\n\r\n<p>Ну а 7900 и 9600 гривен за отопление отнюдь не огромных квартир – это, конечно, нонсенс. Правда, и "стандартные" 2–3 тысячи, которые приходят людям в платежках, потянуть сегодня могут далеко не все. Даже с субсидиями, которые начисляются не на всю площадь квартиры, а только на "социальные" метры. Поэтому люди вынуждены откладывать платежи, еще надеясь, что в следующем месяце что-то изменится в лучшему. Если, к примеру, в ноябре за отопление заплатило чуть более половины украинцев, то в зимние месяцы этот процент падает. А впереди платежи за январь, который выдался на редкость холодным…</p>\r\n\r\n<p><strong>Бери и не плати</strong></p>\r\n\r\n<p>Мы подробно писали о том, что в декабре 2016-го в Брюсселе проходили переговоры между Москвой и Киевом по поводу поставок газа. Стороны тогда разошлись в оценках итогов встречи. Министр энергетики РФ Александр Новак сообщил, что переговоры прошли конструктивно. А глава «Нафтогаза Украины» Андрей Коболев, в свою очередь, заявил, что договоренности достичь не удалось, и указал на необходимость подписания дополнительного соглашения.</p>\r\n\r\n<p>Украина перестала закупать газ в России с конца ноября 2015 года и начала приобретать его в Европе, объясняя это более низкой ценой. Правда, в июле прошлого года Андрей Коболев отметил, что «Газпром» предложил Киеву топливо по более привлекательной цене, нежели европейские поставщики. Но он посчитал, что рынок волатилен и тенденции к снижению цены есть и в Европе.</p>\r\n\r\n<p>Позже руководитель "Нафтогаза" также признал, что Украина с трудом сможет сохранить транзит российского голубого топлива через свою территорию. Об этом он заявил в эфире одного из украинских телеканалов: "По моему глубокому убеждению, без привлечения европейской компании в украинский транзит сохранить его по территории Украины будет очень тяжело, поскольку, с другой стороны, есть очень мощный оппонент, который фактически делает европейцам очень интересное предложение, говоря: давайте мы за свои деньги построим вам еще одну трубу".</p>\r\n\r\n<p>Топ-менеджер обратил внимание, что если Россия реализует "Турецкий поток" и "Северный поток-2", то от транзита газа через нашу территорию можно будет отказаться. Коболев считает, что из-за этого европейцам придется больше платить за российский природный газ. "Этот газ (поставляемый в обход Украины) из дешевого превратится в дорогой. За все надо когда-то платить, но не все это понимают, к сожалению", - добавил он.</p>\r\n\r\n<p>И вот 19 января Еврокомиссия вдруг заявляет о готовности Украины покупать российский газ. Марош Шефчович напомнил, что в ходе переговоров в Брюсселе по вопросу поставок газа в конце прошлого года РФ и Украине не удалось прийти к соглашению, но, по его мнению, стороны были близки к этому. По его словам, у Киева есть необходимые для закупки средства, а юридические аспекты поставок в настоящее время обсуждаются. «Есть один вопрос, который мы обсуждаем. Это юридический вопрос. Он по-прежнему на столе. Я так понимаю, что этот вопрос очень чувствительный для обеих сторон ввиду приближения Стокгольмского арбитража», - подчеркнул Шефчович. </p>\r\n\r\n<p>Напомним, что с июня 2014 года «Газпром» и «Нафтогаз» судятся друг с другом из-за неоплаченного Украиной газа. </p>\r\n\r\n<p>ПАО "Газпром" направил в НАК "Нафтогаз Украины" счет на 5,3 млрд долларов за невыбранный газ. Об этом сообщает "Интерфакс" со ссылкой на пресс-службу компании. В "Газпроме" объяснили, что действуют в соответствии с контрактом, где прописано правило "бери или плати". Контракт предусматривает, что украинская компания должна оплачивать "Газпрому" ежегодно минимальное годовое количество газа, вне зависимости от того, принимала она его или нет.</p>\r\n\r\n<p>Если счет не будет оплачен в течение 10 дней, эта сумма может быть приобщена к иску "Газпрома", направленному в Стокгольмский арбитраж. В этом случае сумма требований по иску к украинской компании вырастет до $37 млрд. Однако в "Нафтогазе" не планируют оплачивать этот счет до принятия решения арбитражным трибуналом по вопросу, должно ли применяться положение контракта "бери или плати" в рамках существующего арбитражного спора. </p>\r\n\r\n<p>Тем не менее вице-президент Европейской комиссии по энергосоюзу Марош Шефчович утверждает, что у Киева есть деньги на закупку российского газа, и в ближайшее время он урегулирует с Москвой все спорные моменты. В частности, по его словам, Россия готова поставлять в Украину голубое топливо, а та готова его приобретать за адекватные деньги. Продолжатся ли газовые поставки, прерванные в 2015 году, «МК» решил выяснить у экспертов.</p>\r\n\r\n<p><strong>Владимир ЖАРИХИН, заместитель директора Института стран СНГ:</strong> <br>\r\n- Киеву нужно заполнять свои газовые хранилища, чтобы поддерживать давление, необходимое для транспортировки голубого топлива. Но здесь настораживает то, что о готовности Украины закупать российский газ заявил не украинский, а европейский чиновник от энергетики. Понятно, почему Евросоюз насторожен: если Киев продолжит отказываться от закупок в России, он все больше будет расходовать тот газ, который предназначен для транзита. Но что значит фраза о приемлемой цене? Если нам опять предлагают торг, который длился до этого десятилетиями, то ничего хорошего в этом нет.</p>\r\n\r\n<p><strong>Александр ГУСЕВ, руководитель Центра стратегического развития стран СНГ:</strong> <br>\r\n- Россия должна помочь Украине, так как там без нашего газа будут страдать люди. Но цена, которую хотят получить украинцы за 1 тысячу кубометров, в два раза ниже того, что мы предлагаем, например, Белоруссии, которая получает газ по 138 долларов. Белорусы тоже настаивают на уменьшении цены в связи с увеличением объемов потребления топлива из-за холодов, и Киев хочет таких же поблажек. Конечно, это невозможно, но идет определенный торг. Запасов в украинских хранилищах практически не осталось, так как перед началом зимы в 13 хранилищах было около 14 млрд кубометров газа, что примерно в 2 раза меньше необходимого объема. Поэтому теперь они вынуждены закупать его во Франции, Норвегии, Польше, Словакии и т.д. Но их цена не низкая. Тем не менее Киев продолжает стоять на своем и даже увеличил стоимость транзита на 100 долларов. Мы понимаем, что люди мучаются, но нам тоже надо бюджет наполнять. Мне кажется, что украинские власти все же будут вынуждены пойти на попятную, так как Запад увеличил объемы потребления газа. Европу накрывает снегопад. В связи с этим европейские чиновники настаивают на увеличении объемов транзита, но чтобы добиться этого, им придется убедить Киев начать вести себя с Россией не как продавец, а как покупатель. </p>\r\n\r\n<p><strong>Александр ОХРИМЕНКО, глава Украинского аналитического центра:</strong> <br>\r\n- К сожалению, и в экономике, и в газовой сфере у нас сейчас очень много политики. Потому периодически мы и слышим заявления всевозможных министров и газовых чиновников о том, что вот уже скоро - примерно к 2024 году - Украина полностью откажется от закупок российского газа и т.д. и т.п. Все эти заявления просто расходятся со здравым смыслом и логикой. На них лучше вообще не обращать внимания. Теоретически нечто подобное возможно, теоретически Украина может обходиться даже только своим газом, но для этого полностью надо остановить промышленность. На это указывают хотя бы данные энергобаланса, опубликованные на сайте Госстата.</p>\r\n\r\n<p>С заявлением Мароша Шефчовича, что у Украины имеются «адекватные финансовые ресурсы» для закупки российского газа, эксперт согласен. «Потребление газа в стране уменьшилось. На сегодня закупка газа в России требует около 0,5 миллиарда долларов. Чистыми золотовалютными резервами Украина сейчас имеет 4,2 миллиарда долларов. Из четырех миллиардов выделить полмиллиарда не так уж и сложно. Другое дело, что у нас все решают сиюминутно. Сейчас есть проблема - ее надо решать. О том же, что будет завтра или послезавтра, думать слишком сложно», - поясняет экономист.</p>\r\n\r\n<p>Вопросом остается лишь то, почему вдруг Еврокомиссия решила принять такое деятельное участие в газовых переговорах между Киевом и Москвой. Казалось бы, когда Украина по политическим соображениям отказывалась покупать российский газ, это играло на руку прежде всего Евросоюзу. В конце концов, следуя принципу «не покупать ничего у «Газпрома», Украина была вынуждена перекупать тот же российский газ у европейцев, да ещё и с наценкой. При этом различные отечественные политики называли это абсурдное решение победой.</p>\r\n\r\n<p>«Скорее всего, ответ достаточно простой. У Евросоюза сейчас попросту не осталось излишков российского газа, чтобы перепродавать их в Украину», - резюмирует Александр Охрименко.</p>	Артур АВАКОВ, Дарья САНИНА.	images/politics/3_5years-eas-sefcovic-gros-plan5.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-03 05:43:03.451275-05	2017-02-03 05:49:46.152048-05	f	f	f	t	2	0	\N	\N	36	2	2	2
8	ЮЛИЯ ДЖИМА — ЧЕМПИОНКА ЕВРОПЫ-2017!	yuliya-dzhima-chempionka-evropy-2017	t	<p>В польском городе Душники-Здруй состоялся чемпионат Европы по биатлону, ставший весьма успешным для членов украинской сборной. </p>\r\n\r\n<p>На высшую ступень пьедестала почета сумела подняться лидер нашей женской команды Юлия Джима. Спортсменка из Сум выиграла состязание в спринте на 7,5 км, сразу на 27 секунд опередив ближайшую конкурентку. На следующий день Юлия завоевала "серебро" в гонке преследования. Еще одна медаль на счету молодой тернопольчанки Анастасии Меркушиной, финишировавшей третьей в индивидуальной гонке. Интересно, что во всех случаях оставшиеся места на подиуме заняли россиянки. </p>\r\n\r\n<p>В последний день чемпионата успех пришел к украинским спортсменкам и в командной гонке. Наша четверка в составе Анастасии Меркушиной, Юлии Джимы, Александра Жирного и Руслана Ткаленко завоевала бронзовую награду в смешанной эстафете. </p>\r\n\r\n<p>Таким образом, на счету украинцев одна золотая, одна серебряная и две бронзовые медали чемпионата Европы. Поздравляем!</p>	Мария СОКОЛОВСКАЯ.	images/glavnoe-za-nedelyu/492761.jpg		2017-02-02	2017-02-02 06:39:25-05	\N	2017-02-02 06:39:25.373445-05	2017-02-02 10:10:23.43415-05	t	f	f	t	3	0	\N	\N	43	2	2	2
1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	kak-ubivayut-kievskuyu-rus	t	<p><strong>Время беспощадно… Год за годом оно уносит остатки того, что сохранилось от прошлого. От великих и героических эпох, когда наши предки воевали и строили, любили и ненавидели… Создавали государство, любовь к которому начинается с ощущения величия его истории.</strong></p>\r\n\r\n<p>С этим ведь, правда, не поспоришь? Историю, конечно, можно изучать по книгам, видеть на экранах то, что когда-то удалось запечатлеть на старых пленках. Но гораздо лучше – соприкоснуться со всем этим «вживую» — потрогать, примерить, утонуть босыми ногами в пахучих опилках строящейся деревянной усадьбы, ощутить ладонью тяжесть боевого меча или кузнечного молота. Ведь правда?</p>\r\n\r\n<p><strong>И это уже есть сейчас…</strong></p>\r\n\r\n<p>Парк «Киевская Русь» — научно безупречная копия части «града Киева» эпохи князя Владимира Крестителя. Там возведены деревянные городские ворота и два огромных прясла (отрезка) оборонительных стен – и это самая большая реконструкция средневекового деревянного строения в Европе.</p>\r\n\r\n<p>Парк превратился в самое крупное европейское фестивальное поле, где регулярно, к огромному удовольствию зрителей, сражаются реконструкторы – и пешие, и конные. Там работает несколько музеев, где копии древних вещей можно подержать в руках – почувствовать в ладони ту самую «тяжесть боевого меча».</p>\r\n\r\n<p>Проект Парка уже получил восторженную оценку в Европе, вплоть до Парламентской Ассамблеи ее Совета – в формировании феномена Киевской Руси участвовали греки и болгары, армяне и грузины, французы и британцы, евреи и скандинавы (при подготовке проекта насчитали 26 государств и народов). Парк уже посетили десятки тысяч людей, и практически все в восторге: это не какой-то сухой академический музей, это живой город – с харчевнями, торговыми рядами, конюшнями и даже стойбищем кочевников.</p>\r\n\r\n<p>При активном участии Парка «Киевская Русь» создана Всеукраинская федерация средневекового боя, а автор проекта Владимир Янченко (он же – «князь Владимир» во всех сценариях исторических реконструкций) стал президентом этой федерации. А «средневековый бой» недавно официально стал самостоятельным видом спорта. Пусть пока не олимпийским, но ведь это только «пока». Правда же?</p>\r\n\r\n<p><strong>Но всё это может исчезнуть…</strong></p>\r\n\r\n<p>Потому что хрупкий «образ истории» может не выдержать столкновения с грубой реальностью, которая категорически не терпит возражений, даже если виновата сама. Дело в том, что более двух лет назад управляющая компания Парка «Киевская Русь» и ПАО «Киевоблэнерго» (председатель правления Иван Поливянный) заключили договор: облэнерго поставляет, а Парк потребляет электричество. Ежемесячно инспектор облэнерго снимает показания счетчика и выставляет счет к оплате. Парк платит. Проще простого…</p>\r\n\r\n<p>Но в декабре прошлого года все поломалось, когда в последнем счете совершенно неожиданно возник «долг парка» — 523 000 гривен. Как было сообщено потребителю, два года назад в расчетах энергетики допустили ошибку, которую они и сейчас не отрицают, в результате которой и возникла недоплата. Повторяю, недоплата возникла по вине энергетиков, потому что именно они все это время рассчитывали и выставляли счета. К тому же существует «буква закона», которая гласит: <strong>«Потребитель не несет ответственности за имущественный ущерб, причиненный поставщику электрической энергии, который вызван… неквалифицированными действиями персонала электропередающей организации, поставщика электрической энергии или субпотребителя».</strong></p>\r\n\r\n<p>Парк «Киевская Русь» в этой истории – потребитель. Почему он должен платить за неквалифицированные действия поставщиков из облэнерго? И ставить под угрозу само существование Парка? Потому что полмиллиона гривен – эта та сумма, которая сегодня может зачеркнуть весь проект.</p>\r\n\r\n<p>Ведь витязи, кони, девушки в славянских «рубахах до пят» — это очень красиво и зрелищно, но совсем недешево. А есть еще и эксплуатационные расходы (аренда земли, вода, транспорт). Парк не берет ни копейки из бюджета. Помощь от спонсоров и доход от продажи входных билетов – единственный источник его существования, очень небольшой по сравнению с расходами – вот и всё. </p>\r\n\r\n<p>Если удовлетворить претензии энергетиков, придется отказаться от развития и воплощения многих интересных идей. А может, и вообще отправить в забытье весь проект. Только потому, что «монополистам от энергии» захотелось (ненавижу этот сленг, но сейчас он вполне уместен) «срубить деньжат по-лёгкому». Уже сейчас в Парке беда, потому что облэнерго отключил электричество, и там не смогли провести празднование Крещения. Ветераны АТО и их дети, которых бесплатно пригласили на праздник, просто мерзли на морозе: ни перекусить, ни в туалет сходить. Потому что кухня, водопровод и отопление без электричества не работают. Ведь правда?</p>\r\n\r\n<p><strong>Рэкет: с рубильником вместо оружия</strong></p>\r\n\r\n<p>В классическом определении это вымогательство с применением угроз, насилия или взятия заложников. Может, это слишком эмоционально, но все происходящее напоминает «энергетический рэкет» со стороны монополистов-энергетиков: сначала угроза, потом насилие (несогласованное отключение энергопитания). Ну а в заложники взят сам проект, который вообще-то не «гасить» надо, а развивать дальше как национальное достояние страны. Облэнерго, очевидно, всякие разговоры считает неуместными. Это неимоверно (хотя что сейчас может быть неимоверным?), но даже «Акт о нарушении» они не посчитали нужным составить, чего уж говорить о надменном игнорировании всех обращений Парка.</p>\r\n\r\n<p>«Признавайте долг, а потом начнем переговоры по его реструктуризации», — заявляет руководство облэнерго. Оно прекрасно понимает, что, признав долг, Парк отрежет для себя возможность обращения в суд. А беспристрастный суд энергетики проиграют. Парк это тоже понимает.</p>\r\n\r\n<p>Но суд – это долго, а Парк должен работать сейчас: сегодня, завтра, послезавтра. Тем более что в ближайших планах — конференция и отборочные соревнования по средневековому бою. И если они сорвутся, можно попрощаться с репутацией — соревнования-то международные. И тогда это уже не рэкет, а убийство. Убийство чудесного и бесконечно престижного для Украины проекта. Ведь правда?</p>\r\n\r\n<p><strong>Между депрессией и азартом</strong></p>\r\n\r\n<p>В Парке это понимают и настроение там соответствующее. Замдиректора Людмила Новицкая с тоской в голосе спрашивает: «Так что теперь — лошадей продавать?». А лошади в Парке чудесные: фризы, першероны, арабы… Потому что без лошадей в Киевской Руси было ну никак.</p>\r\n\r\n<p>А вот «князь» Владимир Янченко настроен на борьбу: «Конечно, будем судиться и отстаивать наши права всем миром и всеми законными способами!». А ведь «князь» может и дружину вывести. Вот как выйдут на эту улицу Стеценко, 1А (адрес Киевоблэнерго) и пешие, и конные. И будут стоять, пока к ним не прислушаются…</p>\r\n\r\n<p>И, уверен, придут – у Парка много друзей. Но хотелось бы попросить и всех, всех, всех, кому небезразлична сложившаяся ситуация – помогайте. Держите кулак на удачу, скажите слово поддержки, сделайте так, чтобы о покушении на Парк узнало как можно больше людей. </p>\r\n\r\n<p>Я уж точно приду. Потому что наблюдаю за проектом уже много лет, убежден в его необходимости и уверен, что нельзя убивать историю. Пусть даже если это только её образ. Ведь правда?</p>	Андрей ГАНЖА.	images/politics/10471.jpg		2017-02-02	2017-02-02 04:13:53-05	\N	2017-02-02 04:13:53.331775-05	2017-02-03 07:36:25.472384-05	t	f	f	t	7	0	\N	\N	48	2	2	2
6	ГЛАВНОЕ ОРУЖИЕ ПОЛИТИКОВ	glavnoe-oruzhie-politikov	t	<p>Вопрос о языке — один из немногих, гарантированно грозящий обернуться скандалом и усилением раскола в обществе, снова на слуху. Украине предстоит языковая битва не на жизнь, а на смерть, в ходе которой и будет поставлена точка в истории "имперского рабства". </p>\r\n\r\n<p>Так во всяком случае считает журнал "Український тиждень", выступивший в поддержку зарегистрированного в ВР законопроекта о тотальной украинизации. Его основная идея — сделать обязательным использование украинского языка во всех сферах государственной и общественной жизни. </p>\r\n\r\n<p>Следить за соблюдением закона будет специально созданный институт Уполномоченного по защите госязыка. За нарушение закона предусмотрены штрафы для граждан — от 3,4 тыс. до 6,8 тыс. гривен. Если речь идёт о прессе, то штраф увеличивается до 6,8–8,5 тыс. гривен. А за попытки "внедрения в Украине официального многоязычия" предлагается ввести уголовную ответственность, приравняв их к посягательству на государственный строй Украины. </p>\r\n\r\n<p>Соцсети отреагировали мгновенно. В том роде, что ни о чем другом в ВР так не заботятся как о языковом вопросе, которым "трясут каждый раз у народа перед носом, когда надо отвлечь от чего-то более важного". Эксперты и вовсе считают, что политики играют с огнем. "Языковой вопрос – это маркер. Если берутся за язык – то скоро возьмутся за людей. Именно языковой вопрос послужил детонатором крымских событий. И Украина в 2014 году уцелела именно благодаря лояльности русскоязычных украинцев, – уверен политолог Андрей Золотарев. – Вспомните, в 30-е годы Польша тоже была пестрой по своему этническому составу. В него входили литовские, украинские и западно-белорусские земли. Но там тоже стремились все унифицировать: один народ, один бог, один язык. И в итоге у них теперь нет ни восточных кресов, ни Литвы". </p>\r\n\r\n<p>Политолог Кость Бондаренко не противник того, чтобы Украина рано или поздно стала полностью украиноязычной. "Но это должно происходить постепенно, на уровне нескольких поколений, а подобного рода законопроекты только отдаляют эту перспективу, поскольку вызывают раздражение, сопротивление и внутреннее неприятие", — отметил он в комментарии "Апострофу".</p>\r\n\r\n<p>"Я представляю, как поведут себя русскоязычные граждане и на востоке, и на юге Украины, которые поддержали Майдан, поддержали эту власть, а она им сегодня собирается устанавливать правила и говорить, что язык, на котором они привыкли говорить, не подходит, и они должны от него отказываться", — предостерегает он. </p>\r\n\r\n<p>По мнению политолога, этот законопроект для его авторов является всего лишь фиговым листком, который прикрывает их полную бездеятельность как политиков. "Если не сделано ничего, можно браться за историю, религию и язык и спекулировать на этих темах", — заметил Кость Бондаренко.</p>\r\n\r\n<p>И как в воду глядел. В обществе еще не стихли баталии о тотальной украинизации, а власть уже собирается переписывать календарь. </p>\r\n\r\n<p>Директор Украинского института национальной памяти Владимир Вятрович сообщил, что подготовлен законопроект об отмене государственных праздников — 8 марта, 1 и 9 мая. Вместо них предлагается отмечать только переломные и чрезвычайно важные для страны события, такие как День независимости и День Конституции. Кстати, идея отмечать вместо 9-го мая – 8-е, в качестве Дня примирения, культивируется еще со времен Виктора Ющенко. Но особенно остро этот вопрос встал после 9 мая прошлого года, когда акция "Бессмертный полк" по своей массовости превысила все ожидания.</p>\r\n\r\n<p>Так что власти, после того, как она закончит с законом о тотальной украинизации, будет чем заняться. </p>	Мария СОКОЛОВСКАЯ.			2017-02-02	2017-02-02 06:14:43-05	\N	2017-02-02 06:14:43.157388-05	2017-02-02 10:11:17.300741-05	t	f	f	f	3	0	\N	\N	36	2	2	2
13	В ЗНАК ЕДИНЕНИЯ	v-znak-edineniya	t	<p>День соборности Украины официально выходным не считается, но в этом году совпал с воскресеньем. Официальный статус он получил в 1999 году после подписания соответствующего указа президентом страны Леонидом Кучмой. Тогда же в знак солидарности украинцы вышли на улицы своих городов и поселков, чтобы, взявшись за руки в знак единения страны, создать живую непрерывную цепь от Киева до Львова. </p>\r\n\r\n<p>С годами это стало традицией и главной особенностью Дня соборности Украины, когда люди берутся за руки, создавая непрерывные живые цепи, тем самым демонстрируя силу и нерушимость национального духа. </p>\r\n\r\n<p>В столице Украины сформировалась своя традиция празднования. На мосту Патона, соединяющем правый берег с левым, в этом году киевляне в 10-й раз организовали живую цепь соборности, развернув 30-метровый государственный флаг. Жители Запорожья также провели акцию "Единение на Днепре", объединив два берега главной реки страны живой цепью на плотине Днепрогэса. </p>\r\n\r\n<p>Праздник этот зародился в прошлом столетии, когда в январе 1918 года была создана Украинская Народная Республика, а на территориях, входивших в состав Австро-Венгерской империи, — Западно-Украинская Народная Республика. Предобъединительный договор лидеры двух государств подписали в декабре 1918 года в Фастове. А 22 января 1919-го это соглашение, вошедшее в историю как Акт злуки — акт объединения украинских земель, было обнародовано в Киеве на Софиевской площади. </p>\r\n\r\n<p>К сожалению, независимость страны тогда сохранить не удалось. Спустя всего несколько месяцев после провозглашения воссоединения большевики захватили Киев, поляки — Восточную Галичину, а чехи — Закарпатье. Но Акт злуки стал для украинцев воплощением мечты о суверенном государстве.</p>	Мария СОКОЛОВСКАЯ.	images/politics/glavnaya_KKHPLI4.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-03 06:01:58.925464-05	2017-02-03 06:38:26.896956-05	f	f	f	t	3	0	\N	\N	56	2	2	2
18	ИЗ РИМА В РИМИНИ	iz-rima-v-rimini	t	<h1>Очарование итальянской провинции</h1>\r\n\r\n<p><strong>Точно так же, как нельзя судить по Нью-Йорку обо всей Америке, так и Рим, о котором мы уже рассказывали, не является исключительным олицетворением удивительной и восхитительной Италии. Её провинциальная глубинка не менее колоритна и неподражаема.</strong></p>\r\n\r\n<p>Невозможно описать словами те непередаваемые впечатления и эмоции, которые мы перманентно испытывали во время путешествия из Рима в Римини, пересекая практически посередине знаменитый географический «сапожок». Даже вечный спутник туристов - хронический недосып - был не в состоянии побороть желание, не отрываясь, смотреть в окно, любуясь проплывающими пейзажами. Не иначе как вся эта красота выписана кистью Всевышнего! Несмотря на все интеграционные процессы, преобладание хай-тека, Италии удалось не поддаться архитектурному искушению и сохранить индивидуальность, присущую ей и только ей…</p>\r\n\r\n<p><strong>Выйти за рамки стандартного</strong></p>\r\n\r\n<p>Настоящим культурным шоком стало посещение небольшого городка Ассизи. Построенный из розового камня «туф» на высокой скале, он вырастает перед вами, как будто из облаков. А на мощенных булыжником узких улочках застыло настоящее средневековье. Входишь в эту красоту и словно растворяешься в ней, сам себе не веря, что это происходит действительно с тобой!</p>\r\n\r\n<p>В Ассизи с нами случилось забавное недоразумение. Туроператоры чего-то там напутали, и вместо русскоязычного гида нас встретила симпатичная англоговорящая экскурсовод. Так как времени на «разборки» не было, пришлось осматривать достопримечательности с комментариями на «примитивнейшем» английском, поскольку более продвинутым уровнем в нашей группе, увы, никто не владел. Но это не помешало в полной мере насладиться невероятной прогулкой по Ассизи. С его улочками, карабкающимися в гору, со старинными домиками, с чарующей нетронутой стариной. Как утверждают историки, городок сохранился практически в том же состоянии, как много веков назад. Не считая многотысячных толп туристов и паломников, разумеется. </p>\r\n\r\n<p>Главная достопримечательность Ассизи – величественная, украшенная красивейшими фресками и витражами церковь Сан-Франческо - главная святыня «ордена нищенствующих францисканцев». Храм был сооружен в честь Святого Франциска Ассизского, родившегося в этом городе. </p>\r\n\r\n<p>Нетленные мощи святого бережно сохраняются в нижнем ярусе церкви, куда мы спустились, без преувеличения, с каким-то мистическим трепетом. Именно святому Франциску удалось переосмыслить саму суть бедности. Следуя примеру и заветам Христа, он сумел из отрицательно воспринимаемого подавляющим большинством его соотечественников отречения от соблазнов мира создать положительный жизненный идеал. А вместе с этим ему удалось преобразить и само назначение монашества, поменяв существование монаха-отшельника на активную жизнь апостола-миссионера. Отрекаясь от суетности мира духовно, он остается в нем физически, чтобы, участвуя на равных в повседневной жизни людей, оказывать им помощь, призывать к смирению или покаянию, когда это необходимо для их же блага. </p>\r\n\r\n<p>Может, именно поэтому весьма живописно одетые монахи действующего местного монастыря францисканцев, которых мы встречали на улочках Ассизи, так приветливы и доброжелательны к туристам-чужакам, которые не в силах отказать себе в удовольствии сфотографироваться с колоритными обитателями древнего города. Подверженные инстинкту толпы, разумеется, не упустили такой возможности и мы. А еще - купили изысканные керамические сувениры с изображением классического Франциска Ассизского в коричневой монашеской рясе, подпоясанной веревкой с тремя узлами - символами данных им обетов: воздержания, целомудрия и послушания.</p>\r\n\r\n<p><strong>Глина – это гениально!</strong></p>\r\n\r\n<p>Следующей нашей остановкой был город, в котором, собственно, и были изготовлены эти прекрасные керамические изделия. Называется он Дерута. Тут уместно отметить, что практически все сувениры, а также обувь и одежда, продающиеся на территории Италии, изготовлены исключительно в Италии, а не в вездесущем Китае, как это принято в подавляющем большинстве развитых стран мира. Не знаю, как вас, а меня эта «патриотическая» подробность тронула до глубины души. Если керамика - одно из самых древнейших видов искусств, то Италия, без сомнения, является местом его рождения. И Дерута здесь выделяется особо. На протяжении веков тут были созданы тысячи произведений искусства, которые сегодня хранятся в музеях, личных коллекциях, антикварных галереях на всех пяти континентах. Толпы туристов специально приезжают в Деруту, чтобы посетить заводы, фабрики, музеи и старые мастерские, находящиеся у подножья старой деревни. Все это говорит о том, что, несмотря на время, городу удалось сохранить те характерные черты, которые сделали его самым известным в мире. </p>\r\n\r\n<p>Разумеется, и мы не остались в стороне, а отправились на одно из самых уникальных действующих предприятий, где с искренним удовольствием наблюдали, как из кусков темной глины в умелых человеческих руках на наших глазах рождаются настоящие шедевры. </p>\r\n\r\n<p><strong>Зри под землю и там увидишь…</strong></p>\r\n\r\n<p>Исторически так сложилось, что Дерута всегда была привязана к Перудже – столице провинции Умбрия, единственной области Апеннин, не имеющей выхода к морю. Однако вынужденная «обезвоженность» отнюдь не мешает десяткам тысяч путешественников ежегодно посещать этот старинный, дышащий средневековой атмосферой город. Особенно впечатлила подземная часть Перуджи, с чрезвычайно разветвленной и запутанной системой галерей и тоннелей, принадлежащих этрусской, римской и византийской эрам. Один из входов в это сказочное подземелье находится прямо в галерее обычного с виду административного здания, куда мы спустились на эскалаторе, и были потрясены увиденным. Внизу действительно находился целый город с улицами и переулками, уходившими в полумрак. Вместо неба - высокие каменные своды, под ногами – грубый каменный пол. Старинный город-фантом будоражил воображение, напоминая театральные декорации фантасмагорической пьесы, где можно переходить из одного дома в другой, от которых остались только задние стены. Кое-где сохранились боковые перегородки, а в одном месте мы увидели подобие очага. Пару раз попадались фрагменты старинных скульптур. </p>\r\n\r\n<p>Мы ходили по улицам с остовами трехэтажных домов и средневековыми арками, соединяющими их на противоположных сторонах узких улочек. Всю эту ирреальную картину скудно освещали редкие фонари. Иногда сверху пробивался тусклый свет из вырубленного в каменном потолке светового колодца. И вдруг после очередного поворота мы попадаем на свет Божий, щурясь от яркого полуденного солнца и еще долго приходя в себя после пережитого «культурного» потрясения… </p>\r\n\r\n<p>Что касается поверхности, то, с туристической точки зрения, наиболее интересное место в Перудже - ее исторический центр, представляющий собой хаотичный лабиринт узких улочек, заполненных церквями, музеями и уникальными археологическими памятниками. Мы направили свои стопы к зданию бывшего доминиканского монастыря, где расположен Национальный археологический музей Умбрии. Наш дружный интерес вызвали представленные здесь саркофаги, урны и надгробные камни, изображающие погребальную церемонию. Но как-то не печалилось. Наверное, потому, что многие из надгробных памятников были украшены фигурами радостных и улыбающихся людей. Ведь этруски верили: провожать в загробный мир нужно с музыкой и весельем. Эту историческую деталь мы почти хором прокомментировали словами знаменитой частушки о двух порванных баянах на похоронах тещи…</p>\r\n\r\n<p>Но настоящий восторг души - самый грандиозный в Европе и один из крупнейших в мире Фестиваль шоколада под названием «Eurochocolate». Каждый год в октябре в Перудже, ставшей своеобразной «сладкой столицей» мира, на несколько дней собираются истинные эксперты и простые любители этого ни с чем не сравнимого лакомства.</p>\r\n\r\n<p><strong>По следам Феллини - в Римини</strong></p>\r\n\r\n<p>И наконец, Римини – чрезвычайно шумный и многолюдный итальянский курорт на Адриатическом побережье, центр так называемой Романьской ривьеры. Римини неразрывно связан с именем великого итальянского режиссера Федерико Феллини: здесь он родился, вырос, не раз воссоздавал этот город в своих фильмах и здесь же нашел свой последний приют. </p>\r\n\r\n<p>Прогулка по местам Феллини начинается с городской набережной. Именно сюда приезжали «маменькины сынки», не зная чем заняться долгими зимними вечерами. Именно здесь один из героев фильма «Амаркорд» произносит знаменитую фразу: «Дед мой делал кирпичи, отец мой делал кирпичи и я делаю кирпичи, но где же мой собственный дом?» Как и в былые времена, в порту собираются мужчины, чтобы порыбачить и посудачить. Пройдя вдоль берега по набережной, можно выйти к парку имени великого Феллини, возле которого расположен один из символов Римини - легендарный Гранд Отель. Здесь даже в наше время сохраняется атмосфера начала ХХ века, когда юный Федерико прибегал к шикарному зданию отеля, чтобы пофантазировать о приезжих, которые в нем останавливались, полюбоваться роскошными нарядами женщин. </p>\r\n\r\n<p>Будучи уже всемирно известным, Федерико Феллини с женой Джульеттой Мазиной неизменно останавливались в одном и том же номере - 316. Здесь великий режиссер вспоминал свое детство и часами сидел в холле отеля, наблюдая за постояльцами и разгадывая их судьбы. В этом же отеле в августе 1993 года с Федерико случился инсульт, от которого он так и не смог оправиться…</p>\r\n\r\n<p>В память о великом земляке благодарные жители Римини каждые два года, во время праздника Festa de' Borg, создают на стенах своих домов памятные фрески - муралы - о жизни и фильмах этого гения ХХ века…</p>	Виктория ЯСНОПОЛЬСКАЯ.	images/tourism/img_41607-assisi.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-06 07:40:42.701848-05	2017-02-06 07:41:58.475544-05	t	f	f	t	3	0	\N	\N	42	2	2	2
14	ТРИ ПОЛЯКА, ГРУЗИН И СОБАКА	tri-polyaka-gruzin-i-sobaka	t	<h1>95 лет назад родился автор культового сериала о четырёх танкистах</h1>\r\n\r\n<p>*<em>В августе 1941-го, когда гитлеровцы рвались к Москве, в станице Кармалиновской, затерявшейся среди степей Ставрополья, появился юноша, почти мальчишка, говоривший по-русски с польским акцентом, он ни с кем особо не общался. Кроме, пожалуй, немощных деда и бабки, хозяев вросшей в землю хаты, в которую на постой определил его сотрудник местного НКВД. На расспросы любопытных станичников «Откуда ты?.. Что да как?» отвечал неохотно, предпочитая проводить время за рычагами старенького «фордзона». *</em></p>\r\n\r\n<p>*<em>Между тем почти все мужчины, способные носить оружие, ушли на фронт. В Кармалиновской остались одни бабы с голопузыми ребятишками на руках да старики. И тогда, от нечего делать, покряхтев и почесав затылок, председатель колхоза назначил «поляка», как называли здесь парня, на «ответственную» должность – учётчиком. А спустя год, когда немцы приблизились к предгорьям Кавказа, он исчез из станицы… И только десятки лет спустя станичники узнали, что неприметным хлопцем с грустью в глазах был Януш Пшимановский, автор полюбившегося миллионам зрителей сериала «Четыре танкиста и собака»… *</em></p>\r\n\r\n<p><strong>Судьба поляка в России</strong></p>\r\n\r\n<p>Янек появился на свет Божий у интеллигентной четы Пшимановских, проживавшей в Варшаве, 20 января 1922 года. Сызмальства его приучали к книжкам, а когда пришло время, отдали в весьма престижную гимназию, носившую имя польского классика Стефана Жеромского. После ее окончания Януш поступил на исторический факультет Варшавского университета. Впрочем, проучился недолго. Когда 1 сентября 1939 года Германия вероломно вторглась в пределы Речи Посполитой, студент Пшимановский, в силу патриотических чувств, культивируемых в семье, немедля отправился на призывной пункт. Воевал жолнеж-доброволец недолго. Спустя две недели после того, как Гитлер и Сталин «по-братски» поделили Польшу, Януш оказался в Бресте, где с омерзением и безысходной тоской в душе стал свидетелем совместного парада «победителей» - германских и советских частей. </p>\r\n\r\n<p>Януш тогда не знал, что ему несказанно повезло – мог запросто оказаться в Катыни…</p>\r\n\r\n<p>Вскоре Пшимановского отправили работать вглубь СССР, на базальтовые рудники. Потом перебросили на металлургический комбинат, затем – в ставропольский колхоз. И наконец, в Сибирь… </p>\r\n\r\n<p><strong>И снова в бой…</strong></p>\r\n\r\n<p>Пребывая «во глубине сибирских руд», Януш решает, опять-таки добровольно, пойти в армию. Из военкомата, тщательно изучив документы, молодого человека направляют в 62-ю бригаду морской пехоты. Его однополчанин Николай Ермолович рассказывал, что память Пшимановского «ярче всего сохранила из тех лет эпизод: приазовские плавни, где погиб его командир, боцман Степа Волков. Поднял взвод в атаку и упал, закрывая собой от пули очкарика-поляка из Варшавы». Тем времена, в 1943-м, польский генерал Зыгмунт Берлинг и писательница Ванда Василевская инициировали создание на территории Советского Союза Войска Польского. Идея Сталину понравилась. Тем более что ранее сформированная польская армия под руководством дивизионного генерала Владислава Андерса, отказалась «воевать под красным знаменем» и транзитом, через Ирак и Палестину, передислоцировалась в Италию, подчинившись польскому правительству в Лондоне. Януш Пшимановский стремился во что бы то ни стало, разбив ненавистных «бошей», вернуться в родную Польшу. Как говорится, хоть с чертом, хоть с дьяволом. Так доброволец и оказался в составе 1-й пехотной дивизии имени Тадеуша Костюшко, сформированной из вчерашних польских ссыльных в Селецких военных лагерях под Рязанью.</p>\r\n\r\n<p>Уже 12–13 октября дивизия приняла участие в битве под Могилевым. Это сражение было частью масштабной Оршанской наступательной операции, в которой погибло 510 польских офицеров и солдат. И потому в послевоенной Польше дата этого сражения стала Днем Народного Войска Польского.</p>\r\n\r\n<p>Из той мясорубки Янушу удалось выбраться, правда, ценой тяжелого ранения. Однако в дальнейшем «судьба его хранила»… </p>\r\n\r\n<p><strong>Вспомним всех поимённо…</strong></p>\r\n\r\n<p>Тогда же он подружился с Абдрахманом Деминовым, одним из основателей стекольной промышленности СССР. В 1942-м Абдрахман Султанович, на то время уже немолодой отец четверых детей-малолеток, ушел добровольцем на фронт. Офицер-танкист Деминов, отутюжив на своем Т-34 «пол-Европы, полземли», погиб незадолго до Победы неподалеку от польского городка Тухля.</p>\r\n\r\n<p>Фронтовая дружба сблизила будущего писателя и с Виктором Тюфяковым, командовавшим 1-й танковой ротой. 1 августа 1944 года 8-я гвардейская армия Чуйкова, в составе которой действовала и 1-я Польская танковая бригада имени Героев Вестерплятте, захватила плацдарм на западном берегу Вислы. Здесь у деревни Студзянки и разгорелся жестокий бой, «не ради славы, ради жизни на земле». Об одном из эпизодов Януш Пшимановский вспоминал: «Командир первой танковой роты капитан Виктор Тюфяков обнаружил расположение немецкого гренадерского полка. Полк прикрывали три «тигра», которые по одному время от времени выходили на просеку и вели огонь. Тюфяков поставил свой Т-34 в засаду и сжег два «тигра». Затем его рота вместе с автоматчиками атаковала вражеский штаб, разгромила его и захватила два знамени». </p>\r\n\r\n<p>Тут следует заметить, что после войны Тюфяков работал в Алтайской геофизической экспедиции. «Сначала мы были просто знакомы по работе, о героической биографии Виктора я ничего не знал, - вспоминал его начальник Николай Душин. - Виктор Тюфяков был оператором магнитной разведки и запомнился мне прежде всего своим прямолинейным, независимым характером. Терпеть не мог обмана, «резал правду-матку в глаза». Именно из-за скандального характера Виктора Васильевича «ушли» из армии, лишив воинского звания и всех наград. Тогда никто не знал, что именно Тюфяков являлся прообразом командира танка Т-34-76 Rudy с бортовым номером 102. В книге «Четыре танкиста и собака» - это советский офицер Василий Семен, а в одноименном фильме – поручик Ольгерд Ярош. </p>\r\n\r\n<p>Когда сериал, названный в народе «Три поляка, грузин и собака», вышел на экраны стран Варшавского блока и стало известно имя настоящего командира «Рыжего», Виктора Тюфякова в Польше встречали как национального героя. Естественно, его тут же восстановили в звании и вернули боевые ордена…</p>\r\n\r\n<p>Еще одним однополчанином Пшимановского, среди членов экипажа «Рыжего» - стрелка-радиста Яна Коса, наводчика Густава Еленя, механика-водителя грузина Григория Саакашвили (каково!) - был уроженец Виннитчины Владимир Тушевский, воевавший вместе с будущим автором бестселлера на «тридцатьчетвёрке» №110. Кстати, отвечая на вопрос родных: «А как насчет Шарика? Был ли такой пёс?», Владимир Иванович отвечал: «А холера его знает, куда он подевался! Не, ну собака, конечно, была, холера. Но в танке с собой собаку возить? Не-е-е, это позволить никто не мог! Да и кто будет в бою с собакой возиться!»</p>\r\n\r\n<p><strong>О друзьях-товарищах…</strong></p>\r\n\r\n<p>С «боями-пожарищами» Януш Пшимановский дошел до Варшавы. Вступив в Польскую объединенную рабочую партию, стал работать в газете Zwyciężymy - печатном органе Войска Польского. Сначала спецкором, затем - заместителем главного редактора.</p>\r\n\r\n<p>Через пять лет, когда «отгремели последние залпы», журналист выпустил книгу, рассказывающую о подвигах поляков в годы Второй мировой. А в 1960-м, совместно с советским писателем и бывшим военным разведчиком Овидием Горчаковым, издал повесть «Вызываем огонь на себя» - о подполье, действовавшем в оккупированном немцами поселке Сеща, под Смоленском. На этом стратегически важном немецком аэродроме против общего врага вместе боролись советские, польские, чешские и словацкие патриоты. В 1965-м документальное повествование было экранизировано. </p>\r\n\r\n<p>Режиссер 4-серийной картины Сергей Колосов вспоминал о Пшимановском: «Этот человек - мой ровесник, воевал в Красной армии и был тяжело ранен, а потом сражался в Первой армии Войска Польского, стал полковником и консультантом начальника Главного политического управления по вопросам литературы и публицистики… Он был депутатом Сейма и так далее, писал детские книжки, приключенческие...»</p>\r\n\r\n<p>В 1964-м Януш Пшимановский выпустил свой, не побоимся этого слова, бестселлер – повесть «Четыре танкиста и собака». А спустя пять лет режиссеры Анджей Чекалский и Конрад Налесский сняли боевик о приключениях танкистов, воевавших в одной из частей Войска Польского. Его премьера состоялась 9 мая 1966 года, а вскоре картину признали «лучшим телесериалом, когда-либо снятым в Польше». Спустя два года, 25 сентября 1968-го, «Танкистов…» показали по советскому ТВ, после этого они «триумфально» прошли по телеканалам всех стран «социалистического лагеря».</p>\r\n\r\n<p>В 2006-м властями Польши «Четыре танкиста и собака» были признаны «продуктом коммунистической пропаганды, однако через два года здравый смысл возобладал и сериал вернули на «голубой экран»…</p>\r\n\r\n<p>Главной же «книгой жизни» писатель считал мемориальный сборник «Память», в которой увековечил имена советских солдат и офицеров, павших при освобождении его родной Польши. В предисловии к изданному в 1987 году первому тому автор-составитель писал: «Пусть каждый экземпляр этой книги явится скромным, но дорогим сердцам сотен тысяч советских семей памятником. Открытая на нужной странице книга расскажет родным, потомкам героев о тех, кому мы обязаны жизнью… Как жаль, что нельзя именно им всем вместе и каждому в отдельности сказать, что мы не забыли, что мы помним. Могилы не слышат, не видят. Но живые должны понять и запомнить. Книга посвящена героическим советским партизанам и воинам, на крови которых бурно расцвела жизнь между Бугом, Одрой и Нысой». </p>\r\n\r\n<p>А вот дальше дело застопорилось. Полковник в отставке Михаил Захарчук писал в «Литературной газете», публично обращаясь к Пшимановскому: «Правда оказалась, увы, не менее горька, чем память. Она заключается в том, что понапрасну вы, Януш, заложили свой дом, спустили все свои многолетние сбережения на подготовку книги «Память». Лежит сейчас ваша рукопись на дискетках никем невостребованной. Я наводил справки: «Память» никто и не думает выпускать. Для этого потребовались бы астрономические суммы денег, которых нет…» </p>\r\n\r\n<p>Автор статьи «Зияющая высота памяти» описал и последний разговор с польским писателем-энтузиастом: «Януш позвонил мне и поблагодарил за статью: «Ну, теперь по крайней мере ваши чиновники должны зачесаться! Жди меня в гости. Скоро будем с тобой вкушать «Чисту водку выборову»!..</p>\r\n\r\n<p>Однако выступления в «Литературке» никто даже не заметил. А вскоре Пшимановского не стало. Как потом оказалось, перед смертью (4 июля 1998 года. – <strong>С.К.</strong>) Януш продал и свой маленький домик, что-то наподобие нашей дачи, чтобы на эти деньги приехать в Россию пробивать издание книги «Память»…»</p>\r\n\r\n<p>Что касается Польши, то своеобразным памятником Янушу Пшимановскому и его бессмертным героям стал Rudy, танк Т-34 с нанесённым на его борт номером 102, установленный на площадке возле заправки «Shell» на 171-м километре трассы №7 Варшава–Гданьск. Гордо подняв ствол башни, боевая машина ждёт не дождётся свой веселый экипаж и тоскует по заливчатому лаю овчарки Шарика…</p>	Сергей КУЛИДА.	images/kak-eto-bylo/2.jpeg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-03 06:45:42.253103-05	2017-02-03 06:46:59.391135-05	t	f	f	t	3	0	\N	\N	58	2	2	2
15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	knyaginya-ukrayinskoyi-pisni	t	<p><strong>Технічний геній наших днів відкрив магічну можливість. Створена система, здатна "списувати" уривки мелодій, які наспівували гончари, що сотні років тому виготовляли полумиски, макітри, глеки. З’ясувалося, що, обертаючись, гончарний круг з руками чи різцем майстра був по суті звукозаписувальним пристроєм. І обпалена в печі глина береже ту "звукову доріжку". Її можна відтворити й почути крізь товщу літ – чим наразі і займаються науковці. Та пісенне послання є далеко не в кожному виробі. Адже співають не всі. Це дар, про властивості якого все знає наша співбесідниця – співачка від Бога, народна артистка України Ніна МАТВІЄНКО.</strong></p>\r\n\r\n<blockquote>\r\n  <p><em>Скажи, мати, де є терен, піду наламаю. <br>\r\n  Скажи, мати, де є доля, піду нагукаю. <br>\r\n  Терен, доню, ще зелений, не треба ламати. <br>\r\n  Як є доля, сама прийде, не треба шукати. <br>\r\n  <strong>Народна пісня</strong></em></p>\r\n</blockquote>\r\n\r\n<p><strong>– Ніно Митрофанівно, чому люди співають?</strong></p>\r\n\r\n<p>– А чому вони саджають квіти? Бо не можуть інакше. Особисто я – то вже напевно. Бог дав мені одну долю – співати. Не уявляю для себе іншого життя. Без пісні я вже немов і не я. Місяць без виступів – і я власний голос не пізнаю. Поки співаю, доти й пульсує моя душа. Я б померла, коли б не співала, чи стала б безнадійно хворою. Мене, як квітку, треба підживлювати концертами. Та це, між іншим, невтямки нашим зверхникам. Згідно з їх приписами, пенсійна служба "ріже" мені пенсію, байдуже, що я з гонорарів ретельно сплачую всі податки. Втім, хіба лише я? У мене, однак, до можновладців одне прохання: не вкорочуйте мені віку, не вбивайте бажання співати. Я без пісні не живу.</p>\r\n\r\n<p><strong>– А вони вам ще не радять працювати безкоштовно?</strong></p>\r\n\r\n<p>– Подібне – образа й приниження Божого дару. Це я знаю твердо. Бо змолоду десятки років співала й співала, не думаючи, скільки мені за це заплатять. Кидала дітей і мчала на виступи – за "голу" зарплату. І мені якось сказали: "Ти не шануєш дар Отця, а це тяжкий гріх. Не дозволяй себе грабувати". А мене й справді дурили і обкрадали. І ось тепер до здирників долучилась держава.</p>\r\n\r\n<p><strong>– Чим викликана плутанина з вашим днем народження? Скрізь вказують на 10 жовтня, а ви називаєте 13-е.</strong></p>\r\n\r\n<p>– У той час породіллі видавали манку. Але тим, хто народжував після 10 числа, крупи вже не діставалося. Ось мама й "перенесла" мене на 10-е. Голодні роки…</p>\r\n\r\n<p><strong>– Нескладно здогадатися, що ви доньку назвали в честь мами – Антоніни Ільковни. Вони в чомусь схожі?</strong></p>\r\n\r\n<p>– Мама двічі виходила заміж, Тоня – так само. Мама була висока духом, і Антоніна є самостійною, незалежною в своїх засадах. Мама була сильною, вкрай непоступливою, але ж і Тоня мовчки, терпляче, але неодмінно досягає мети. Звісно, й різного в них удосталь.</p>\r\n\r\n<p>Антоніна Ільковна була берегинею нашого дому. Постійно його впорядковувала, та головне – була його душевним осердям. Мама чудово знала і чітко дотримувалась традицій і сімейних свят, до кулінарних звичаїв включно. На Хрещення по народженню дитини, коли приходять куми, обов’язково готувала визначені страви – так звану "потравку" і холодну юшку з грибами, й ніколи не нехтувала обрядовістю. Тому й не розуміла випадкових гостей, що не давали господині як слід підготуватися. Казала в цих випадках: "Який чорт в гості – така й закуска". Натомість, Тоня спонтанним гостям рада, й за п’ять хвилин в неї з нічого готове частування.</p>\r\n\r\n<p><strong>– У вашої мами було 11 дітей. І четверо з них перебували в школі-інтернаті. Як вам там жилося, відірваній від близьких?</strong></p>\r\n\r\n<p>– Навіть не уявляєте, як добре! Інтернат в селі Потіївка на Житомирщині був дуже гарний. І хочу зазначити, що мама віддала нас в інтернат не через нестачу прожитку в родині, а хотіла, щоб я найшвидше йшла далі, бо вона мене виокремлювала із всіх своїх дітей. А ми ж в селі були кріпаками, бо й паспортів не мали.</p>\r\n\r\n<p><strong>– Десь читав, що в тому ж таки інтернаті вам довелось відстоювати своє дитяче уявлення щодо себе…</strong></p>\r\n\r\n<p>– Там був чіткий розпорядок дня, дисципліна, що добре, але я, скажімо, звикла вдома спати в нічній сорочці, на якій, до слова, маминими руками було вишите ім’я "Ніна". В інтернаті ж дівчатка мали одягати на ніч трусики – це перевірялося, і для мене такий контроль був неприйнятним. А за порушення режиму карали часом аж надто. Вихователі і на коліна ставили, і туалет чистити відсилали. Так ось я ніколи на колінах не стояла і туалети не чистила – хай би мене вбили.</p>\r\n\r\n<p><strong>– Ви якось прохопилися, що вам ніяково їсти в присутності значної кількості людей. Звідки це? В селах все ж святкові столи довгі, та й інтернат не передбачає обособлення…</strong></p>\r\n\r\n<p>– Що ви – дітей з дорослими за спільний стіл не садовили! Ми б там просто не помістилися. Нас кормили окремо: велика тарілка ставилася на підлогу і кожен своєю ложкою вправлявся, як міг. Їли швидко, мені це здавалось негожим, я обідала статечно і завжди лишалася голодною. Мама це бачила і частенько, коли доїла корову, кликала мене з кухлем до себе, щоб напоїти парним молоком. Я ж, по щирості, ліктями працювати не навчилася й досі.</p>\r\n\r\n<p>З сімейних свят яскраво запам’ятався день народження братика, якого хрещені підкидали до стелі, щоб він ріс і літав усе життя, що дуже мені сподобалося.</p>\r\n\r\n<p><strong>– А Митрофан Устинович, ваш батько, який був чоловік?</strong></p>\r\n\r\n<p>– По натурі – напрочуд веселий. Коли випивав – з нього можна було вірьовки вити, чим ми, діти, охоче й користувалися. Вони з мамою дуже гарно співали. Та жилось йому тяжко –велика родина, і працював він як чорний віл, брався за все, до нічної охорони і копання могил включно. Як наслідок, його батьківської ніжності на дрібних діток ще вистачало, але ж нас було як гороху – Толя, Люся, Марія, Микола, Ніна, Василь, Валентин, Іван, Михайло, Поліна, Володя. Тож було всякого. Батько під час війни воював у партизанах, і цим все сказано. Він частіше таївся, ніж відкрито проявляв себе, і в цьому вони з мамою були єдині: їм для мовчазної оцінки недолугого голови чи корисливого бригадира було досить миттю перезирнутися. Однак, якщо Митрофан Устинович "виходив з берегів" – ховайся в жито! Мати ж невипадково співала про те, що і не раз й не два: "крізь віконечко утікала". Мама рятувалась від батька у вікна, як втікали від нього мої сестри й брати, коли він сваволив.</p>\r\n\r\n<p><strong>– Як думаєте, які риси характеру закарбувало вам дитинство, що не виглядало безхмарним?</strong></p>\r\n\r\n<p>– Головно – велике терпіння. Я вмію чекати. А ще я не схильна теревенити. Точніше, не була схильна, бо зараз вже не мовчу, виговоритись не можу. <em>(Сміється)</em>. Не всі знають, але КДБ роками забороняв мені на концертах говорити: пісні співай, а спілкуватися з залом не смій!</p>\r\n\r\n<p><strong>– Тепер вже знаємо, що в ті часи був "змитий" і фільм Юрія Барановича "Співає Ніна Матвієнко". Проте і тоді вам принаймні раз вдалося переграти "кураторів культури" – маю на увазі творчий вечір, де ви мали співати разом з матір’ю…</strong></p>\r\n\r\n<p>– Без мами в нашому селі нічого не співалося, не святилося й не хрестилося. Її голос зі дзвоником проймав всіх, а знамените мамине "ой" перейшло у спадок до мене. І я дуже хотіла заспівати з мамою в Києві. Вже й афіші з її ім’ям були готові, коли мене закликали у владний кабінет і сказали, що "сільська баба" не повинна виходити на столичну сцену. І це в "державі робітників і селян"! Я була вражена і вбита й не знала як, попри заборону, вивести маму на сцену. Та Господь все управив, як треба. Я співала одну з наших улюблених пісень і раптом змовкла: "Ой, мамо, я слова забула!" І тоді мама, що сиділа в першому ряду, підійшла до сцени й продовжила спів. Я підхопила, вивела маму на кін і вже разом ми доспівали до кінця. Зал вибухнув оплесками й вигуками захвату. Це був справжній фурор!</p>\r\n\r\n<p><strong>– Ви якось сказали, що діти і батька, і матір хочуть бачити сильними. Невже ваші діти і справді вимагають від вас крицевої волі й такої ж поведінки? Мама – це ж просто мама…</strong></p>\r\n\r\n<p>– Гадаю, вони вже змирилися з моєю наївністю і романтизмом. Хоч за інерцією ще питають, коли я подорослішаю. В моєму житті з раннього дитинства чомусь все відбувалося через біль і страшне безсоння. Часто підйом був о п’ятій ранку. Мама втішала: "Вставай, вставай, розходишся…" І я вставала – пальчики збиті, ніжки поколоті, але біжу босоніж, кульгаючи, до телят… Завжди недоспата… "На тому світі виспишся". Проте я не жаліюся ні на що, бо в цьому супротиву життя міцніла і лише дивуюся часом, що не озвіріла, а навпаки – лишилася довірливою і щедрою, можу з хати винести все, окрім щастя. А моє щастя, моє раювання – це голос через сльозу сердечну, обов’язок співати на висоті правди мого народу. Що ж до всього пережитого, то я маю щоденник, куди стягую свої записи-спогади, наче сирі дрова, просушені від сліз – можливо для донечки, яка їх потім буде читати і посміхатися, а може трохи й поплаче…</p>\r\n\r\n<p><strong>– Ми зростали в добу безбожжя, і лад дикунськи пильнував, аби дитя людське не увійшло під захист Отця небесного. Та вам, здається, це не завадило зростити в серці віру?</strong></p>\r\n\r\n<p>– До чого тут віра? Вона поневолює. А я вільна людина, що живе Богом. Сказати про особу "віруюча" – означає зробити пусту наліпку, не більше. В мене не віра – довіра до Бога. А це різні речі. Знання ж про Господа приходять до мене духовними шляхами: через віщі сни, видющих людей. Я, коли хочете, довгий час колядки, де є Христос, навіть не співала. Зате дуже любила веснянки, наші прапісні, що закликали прихід Весни. Прикро про це говорити, але дівочі весняночки навколо храмів Церква сама і знищила, вважаючи їх язичеством. А це була велика культура, красива і світла. Що ж до радянської влади, то її свавілля в духовній царині не знало меж, натомість ми навіть не здогадувались, хто ми є насправді – настільки все було перекручено й поховано. Знання здобували самотужки і значно пізніше. Тому мене змолоду так вабили щедрівки: в часи колгоспів в них возвеличувалися господар і господиня. Він був ясним місяцем, вона – зорею, а дітки – дрібними зірками. Господиня в свята ходила панною, а не була гуртовим нічим, як так звана "радянська трудівниця". Українці спрадавна вірно славили Отця. Поважали батька й матір, ревно шанували закони чистоти й незайманості, гідні стосунки між людьми, вільні від осуду, заздрості, зловтіхи. В нас повік не було розбрату, а суспільна етика грунтувалася на єдності й турботі про інших.</p>\r\n\r\n<p><strong>– Ви не в міфах живете?</strong></p>\r\n\r\n<p>– Жодним чином! В нашій родині ще лишались елементи давнього устрою громади. Тата і маму ми, діти, називали виключно на "ви". Інакше не мислимо. Мені дивно і дико чути від своїх доньки чи сина, що вони мені "тикають", правда, лише коли посваряться зі мною. Християнство князь Володимир запроваджував вимушено і робив це під тиском обставин, стосунків з Анатолією, чим невиправно збіднив наш народ. Адже постулати на кшталт "Всяка влада від Бога", чи проповідь покори, смирення й людської нікчемності перед особою Христа – "раб Божий", ввійшло в генетичне протиріччя із засадничими рисами українського національного характеру. Ми – чада Божі, а не раби. Християнство дійсно вчить любові до ближнього, але ця любов була прадавньою чеснотою українців. До того ж ім’ям Христа чинилися такі злочини проти людяності, про які моторошно й згадувати. А деякі біблійні тексти? Подиву гідна приміром, молитва "Отче наш", скажімо, її рядок: "Не введи нас у спокусу". Чи не безглуздя? Як Отець небесний може вводити людей у спокусу – це ж диявольська втіха?! І чому в цій молитві не знайшлося місця для Божої Матері – Оранти-заступниці, яку споконвіку славив наш народ?</p>\r\n\r\n<p><strong>– Звання Героя України ви удостоєні зі знаменним обгрунтуванням: "За вершинний пісенний талант, що пробуджує і возвеличує духовну силу українського народу".</strong></p>\r\n\r\n<p>– Я це вперше чую!</p>\r\n\r\n<p><strong>– Скажіть, як на духу, в Україні важко пробуджувати духовну спрагу співвітчизників?</strong></p>\r\n\r\n<p>– Народною чи талановитою сучасною піснею – зовсім ні. Адже вони вібрують в унісон з людською душею, найпотаємнішими й найчутливішими її струнами. Пісня діє на людину, оминаючи захист, яким ми "озброєні" в буденному житті для побутових воєн. Я знаходжуся в полоні духовної харизми народної пісні, а відтак вона чарує й слухачів.</p>\r\n\r\n<p>Ось часто кажуть про розрив сходу й заходу України. А ми в складі тріо "Золоті ключі" влітку 2007 року здійснили благодійний тур "Самотності – ні", під час якого співали в притулках для старих в тих регіонах країни, де українська пісня, згідно з хибними уявленнями, людям не люба. І що б ви думали? Глядачі після кожного концерту кидались до нас: "Чого ви так швидко закінчили?", хоч у нас була повна програма. Проблем з порозумінням там не було, а якщо щось і ятрило серце, то це питання: "Як можуть діти віддавати батьків в богодільні?" Цей крик душі супроводжував мене впродовж всього туру: "Де ви, діти? Що ви робите?". Тож коли співаю: <em>"Наступає чорна хмара, // А за нею синя. // Чи є в світі така друга, // Як я нещаслива?"</em>, то я це співаю і про них, і про себе…</p>\r\n\r\n<p><strong>– Ніно Митрофанівно, зізнаюсь вам, що цього літа, гостюючи в друзів, я не витримав іспит на знання "пісенного контенту". Мені поставили запис вашої пісні. "Хто співає?" – питають. "Не смішіть, – кажу, – звичайно ж, Ніна Матвієнко". "А ось і ні, – переможно заявили вони, – це дійсно Матвієнко, однак Антоніна". Я не йняв віри! Та звідси й питання. Голос, справді, не вибирають, але наскільки така подібність ваших з донькою голосів ускладнює прагнення Антоніни бути неповторною?</strong></p>\r\n\r\n<p>– Немає в неї такого прагнення, бо несхожість як мета є дурня, що й розмови не варта. Співай душею і своїм голосом, не переймайся лукавими розрахунками – і люди тебе слухатимуть. І тоді навіть буде зайвим музичний супровід. Якось в Німеччині дві години слухали мій акапельний спів, і величезний зал сприймав виступ як одна людина. Гарна пісня може все, а хитрощі маркетингу – для пустої попси. В цьому сенсі я за Тоню спокійна, душа болить за неї з інших причин, та вони не для преси.</p>\r\n\r\n<p><em>Я щаслива і вдячна Богові й людям за можливість переллятися у своє дитя, як молоко в горличко кухлика. Ота характерність, сльозинка кришталева, що чула я в маминому голосі, вживилася і в голос Тоні. Три покоління її переповнили і співає моя доня голосом Роду.</em></p>\r\n\r\n<p><strong>– Ваш чоловік Петро Гончар – всиновлений племінник Івана Гончара, знаного фольклориста-етнографа, збирача українських старожитностей, виробів народних промислів. Та колекціонери – зациклені на своїх зібраннях люди. В цьому зв’язку мені важко уявити, щоб Петро Іванович купив вам коштовність чи улюблені парфуми, а не придбав щось запропоноване йому для музею. Чи я помиляюся?</strong></p>\r\n\r\n<p>– Помиляєтесь. Були і духи "Ніна Річі", і сережки, і перстень, і ще одні сережки…</p>\r\n\r\n<p><strong>– Тоді даруйте. Однак ось ваше відверте зізнання: "У чоловіка на дачі, яку я будувала, тепер велика майстерня. В нього також – музей батька, кабінет в ньому, окрема спальна кімната, в доньки – квартира на Хрещатику, а в мене нічого подібного немає". Чому так?</strong></p>\r\n\r\n<p>– Бо не це головне. Головне – спокій, щастя сім’ї і дітей, внутрішня злагода, яку я відчуваю навіть в крихітній кімнаті.</p>\r\n\r\n<p><strong>– Ви в шлюбі з Петром Івановичем 45 років. І був час, казали ви, "коли я гризла себе питаннями: чому під час прогулянки по місту чоловік не бере мене за руку, як це роблять інші? Чому, коли я була вагітною, він соромився йти поряд зі мною, а інколи навіть переходив на інший бік вулиці?" Зараз ці подивування розвіяні чи лишаються?</strong></p>\r\n\r\n<p>– З минулим у мене рахунків немає – який в них сенс? Мені тільки гірко, що я в свої роки статків для дітей не зібрала. В українців заведено лишати їм основу благополуччя – кошти. А мені їм нічого передати. В моєї мами було те ж саме. Вона лише заздалегідь поклала за іконку гроші на свої похорони. Я про них забула і згадала тільки після поховання, коли ми їхали на поминки в село до сестри. Ті гроші тоді таки знадобилися.</p>\r\n\r\n<p><strong>– Коли людина співає в щасті, це зрозуміло. А чи може вона співати в горі?</strong></p>\r\n\r\n<p>– Ще більше! Коли я дівчиною дізналася, що мій хлопець одружився, то вбігла в гуртожитку в ванну, закрила двері, пустила воду литися і співала, хоч, скоріше, вила, виплакуючи своє горе.</p>\r\n\r\n<p><strong>– Людям властиво прагнути душевної злагоди. Однак як же важко утримувати гармонію в серці! Вражає, скажімо, випадок матері Терези, подвижниці милосердя й діяльної допомоги стражденним, блаженної, а тепер вже й святої, що на схилку життя гризотно волала до Спаса: "Де моя віра? Навіть глибоко всередині немає нічого, крім пустоти і темряви. Та якщо немає Бога, не може бути й душі. А коли немає душі, тоді, Ісус, ти теж неправда". Який відчай богополишеності! Ніно Митрофанівно, вам зрозуміло, що з нею відбувалося?</strong></p>\r\n\r\n<p>– Якось мені сказали: "Ніно, чим більше ти даєш старцям, тим більша черга стоїть до тебе". Тереза всю себе віддавала хворим і немічним, а горя лише збільшувалось, і біди було без дна. Ось вона і не могла збагнути, чому Господь це не припинить, і не могла з цим змиритися.</p>\r\n\r\n<p>А взагалі, ми з вами говоримо, і я розумію, що багато питань, яких ми торкаємося, насправді не мають відповідей. І може навіть мені не варто їх шукати, а треба жити й співати, наскільки стає сил і благословення.</p>\r\n\r\n<p><strong>– Ми всі пам’ятаємо, яким бездоганним був перший Майдан! На ньому перемагали не тільки єдністю духу, але й красою. Адже там навіть не пили. Це була естетична перемога, демонстративно красива навіть до протилежної сторони. Не випадково, Майдан в нашій поезії вже став українським архетипом, адже краса – суто народний пісенний чинник. Тому й не згасає надія на те, що мистецтво, пісня ошляхетнюють душу, а краса породжує етику терпимості до інших людей. Та існує й інше. Дехто дивиться виставу чи кінофільм, виходить з концерту прекрасних пісень і каже підручному: "Йди і вбий!". То що ж, на ваш погляд, до снаги пісні? Що вона, власне, може?</strong></p>\r\n\r\n<p>– Пісня може бути незрадливим другом, духовним опертям. Переконана, що з мого концерту не виходять з наміром вбивства іншої людини. Леся Українка писала: "Слово, моя ти єдиная зброя!" В моєму розпорядженні є пісня, і це немало. В пісні я сповідаюся, пісня, окрім почуття, несе й сакральний зміст. Втім, пояснити, що з нами робить пісня, не під силу нікому. Це незбагненно.</p>\r\n\r\n<p><strong>– Років двадцять тому на виставці живопису Катерини Білокур – до слова, жінки і митця суціль драматичної долі – мене приголомшив такий факт. На її довершених полотнах – тріумфуюче бароко матінки-природи, апогей родючості української землі. І ця всеплодючість рідного лану так естетично впорядкована, немов списана з Божих гобеленів. Краса невимовна! А під тими картинами – дати написання, що збігаються з найстрашнішими роками Голодомору. На якому ж доланні навколишнього й внутрішнього пекла вона малювала! І ось повірте: виходжу я з Лаври і перше, що зринає в моїй голові після всього побаченого, це фраза, яка може бути заголовком статті: "Ніна Матвієнко – Білокур української пісні". Як би ви поставилися до такої назви?</strong></p>\r\n\r\n<p>– Катерина Білокур близька мені саме цим видатним доланням обставин. Вона довела, що крім Бога, нікому й нічим не зобов’язана. І, скажімо, заміж задля годиться виходити не стала. Немає кохання – жінка народить сиріт. Вона це знала серцем і вікувала самотньо. Любов – найбільше багатство землі і людського життя. Це, власне, сама формула життя. Але для чесної дівчини потрібен той єдиний коханий, щоб потім ні про що не пожалкувати. Катерина Білокур такого хлопця не зустріла. І рятувалась живописом.</p>\r\n\r\n<p>Для мене щастя полягає в пісні. Через пісню я любила, формувала світогляд, страждала, зверталась до всього світу. Люди, мабуть, думали, що це пісні, та й годі. А це була моя доля. Я співала, приміром: <em>"Полюбила невірного, й навіки пропала"</em>. Співала про себе, бо що мене чекає, знала наперед. Змінити не могла, ось і співала.</p>\r\n\r\n<p>Втім, що б ми з вами тут не обговорювали, а в житті все йде своїм чином. Це як до мами підходить хлопчик і каже: "Мамусю, вгадай, що я з’їв на букву "ш"? Мама навздогад: "Шоколадку". – "Ні". "Шишечку?" – "Ні! Здаєшся? Тоді я тобі скажу – шерв’ячка". – "А де ж ти його взяв?" – "Шам пришкакав". От і ми будемо шукати щось таємниче на букву "ш", а виявиться, що це в підсумку банальний хробак.</p>\r\n\r\n<p><strong>– Декілька років тому вас запросили на ток-шоу Савіка Шустера. Була в його передачі "фішка": насамкінець шоу знаний виконавець співав щось ліричне, гамуючи пристрасті політичних сутичок. Але той вечір відзначився просто шаленим струмом ненависті і люті між учасниками телегризні. Лаялись всі з усіма, і за три години ефіру ніхто навіть не згадав про людей, так званих "маленьких українців". Впродовж шоу камера декілька разів зупинялась на вашому обличчі, і глядачі ціпеніли, дивлячись, якою все більш пригніченою ви ставали. І коли Савік, нарешті, оголосив ваш вихід, країна побачила Ніну Матвієнко в стані потрясіння. І та Ніна Матвієнко сказала людям лише одне: "Як страшно знати, що наші діти, внуки і правнуки приречені працювати на оцих і їм подібних господарів життя. Врятуй і збережи!" Ви поміняли пісню, яку хотіли виконати, і заспівали акапельно якусь тужливу народну про нашу долю – сумну й розпачливу без меж. Це було просто і велично: сухе людське страждання без сліз. Розумію, що питання не до вас, а до народу України, та все ж запитаю: як трапилося, що нація поділилася на два світи – надбагатих і бідних, які ледь не жебракують. І ці два світи несумісні.</strong></p>\r\n\r\n<p>– Я інколи думаю, що стосовно України здійснюється якийсь пекельний план задля її розкладу й поневолення. Ось тільки не певна, внутрішній цей намір чи сторонній. Інакше й пояснити не можна, чому ми всякчас втрачаємо свої шанси – один за іншим. І живемо все гірше.</p>\r\n\r\n<p>Нас впродовж віків нищили і вбивали. Мабуть, наш Чумацький шлях стоїть комусь на заваді. Та історія вчить тому, що й коту зрозуміло: миша все ж колись вилізе із нори. Мабуть, невипадково, готуючи до виконання нині широко відому пісню "Роде наш красний", що є весільною, я серцем відчула потребу надати їй більш точного і ємного змісту. До мене заклик "не цуратися й признаватися" виводили з того, що, мовляв, <em>"небагацько нас є"</em>. В цьому була скарга, звучав жаль – і на тому все. Я ж співаю: <em>"Бо багацько нас є"</em>. В такому засновку домінує гордість за рідну спільноту, пошанування її планетарної значущості й самобутності. Тим часом, на ображених воду возять.</p>\r\n\r\n<p><strong>– Ви якось сказали: "Головне, щоб було завтра". Яким вам сьогодні бачиться майбутнє нашої землі?</strong></p>\r\n\r\n<p>– Вийде ясне сонечко. Прийде світлий день. І народ український продовжить своє буття у Всесвіті. Адже, <em>"ми, русичі – з первородних Родів, що прийшли на цю землю, роджені у правді: анти, скіфи, орії. Це ми, нащадки із сузір’я "Матьковша", назвали нашу святу Землю – Макош – Мати, де я молюся серцем до Богині життя Живи, схлипуючи загубленим, знищеним минулим і заступаюся пісенно, живучи сьогоденням. Жайвір мого Полісся й досі мліє у моєму голосі, моїх дітях-піснях, у поклоні до Всевишнього Отця і духовного батька – архангела, Святого Гавриїла. "І справжнє лиш те, що встиг"</em>!</p>	Олександр САКВА.	images/rozhdyonnye-ukrainoj/dsc_9836-2.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-03 07:14:42.48701-05	2017-02-06 03:59:57.9299-05	f	f	f	t	11	0	\N	\N	39	2	2	2
19	БЫСТРЕЕ БЬОРНДАЛЕНА	bystree-borndalena	t	<h1>Украинец Сергей Семёнов завоевал бронзовую медаль в индивидуальной гонке на этапе Кубка мира</h1>\r\n\r\n<p><strong>Завершившийся в прошлое воскресенье шестой этап Кубка мира по биатлону проходил в итальянском местечке с двойным названием Антхольц-Антерсельва. Хотя в большей мере распространена немецкоязычная половинка этого названия – Антхольц. Все просто: область Южный Тироль, на территории которой расположен поселок, до начала прошлого века находилась под протекторатом Австрии, а сейчас имеет расширенную автономию и едва ли четвертая часть местных жителей общается по-итальянски.</strong></p>\r\n\r\n<p>За представителей Германии здесь болеют особенно сильно, и, возможно, во многом поэтому немецкие биатлонисты выступили в Антхольце лучше не придумаешь: в четырех гонках из шести они занимали первые места, в том числе триумфовали на обоих самых престижных стартах – мужской и женской эстафетах. В индивидуальной гонке у женщин также не было равных признанной королеве биатлона Лауре Дальмайер, а в масс-старте немецкую волну поддержала Надин Хорхлер. Счастливые минуты наконец-то пережили и украинские болельщики – благодаря первому в этом сезоне восхождению на пьедестал нашего Сергея Семенова, который в индивидуальном состязании уступил лишь признанным фаворитам – россиянину Антону Шипулину и французу Мартену Фуркаду. Украинец получил заслуженную «бронзу».</p>\r\n\r\n<p>Сергей до последнего претендовал на победу, но, промахнувшись в последнем выстреле, упустил шансы взять золотую награду. К сожалению, психологическая подготовка – это то, что часто отличает ведущих спортсменов от просто хороших… Хотя похвалить нашего соотечественника нужно обязательно! 28-летний биатлонист из Чернигова показал достаточно приличную скорость на дистанции, а при прохождении огневых рубежей сумел уменьшить пульс до нужной кондиции. Если бы не тот злосчастный единственный промах, мы поздравляли бы Сергея с первым местом. В итоге – чуть менее почетная «бронза». Впрочем, она тем более ценна, что всего на несколько секунд от украинца отстал самый культовый биатлонист Оле-Эйнар Бьорндален.</p>\r\n\r\n<p>«Я старался как мог. Бежалось тяжело, но результат неплохой. А так шел ровно, без особых срывов. На самом финише споткнулся - палки перед лыжами встали. Что касается промаха, то мне просто не хватило дыхания. Надо было, наверное, не торопиться с выстрелом», - подытожил свое выступление Семенов.</p>\r\n\r\n<p>Интересно, что 3-е место Сергея стало первым достижением украинских биатлонистов на Кубке мира в личных гонках не только в этом сезоне, но и вообще, начиная с февраля прошлого года. Также в активе у нас еще одна бронзовая медаль в женской эстафете, добытая в декабре в словенской Поклюке. </p>\r\n\r\n<p>В минувшие выходные многие украинские болельщики вновь прильнули к экранам телевизоров в надежде увидеть повторение подвига нашей сборной в эстафетных гонках. Однако в первый день мужчины, а во второй - женщины – интригу разжечь сумели, а вот результат оказался самый обидный – два 4-х места. Итог тем более неприятный, ведь в обоих случаях «сине-желтые» уступали своим соперникам буквально на последней стометровке, проигрывая борьбу один в один – корпус в корпус. </p>\r\n\r\n<p>Конечно, хотелось бы видеть более уверенный финиш в исполнении Дмитрия Пидручного и Анастасии Меркушиной, но реальные расклады пока таковы, что наши спортсмены на этом отрезке сезона находятся не в лучших своих кондициях. Пидручный только недавно оправился от болезни и не сумел набрать форму к данному этапу, а требовать высоких результатов от Меркушиной вообще пока рано – спортсменка проводит всего лишь первый сезон на таком уровне. Более опытная итальянка Доротея Вирер все же сумела улучить момент и оторвалась от украинки в решающий момент на финише. </p>\r\n\r\n<p>Еще один довлеющий над нами фактор – неоптимальные составы украинских четверок. Тренеры попросту не смогли задействовать всех сильнейших. Особенно это относится к женской дружине, где мы не досчитались Елены Пидгрушной и Ирины Варвинец. Обе спортсменки сейчас стремительно набирают кондиции в надежде выстрелить – в прямом и переносном смысле – на чемпионате мира, который 9 февраля начнется в австрийском Хохфильцене. Только-только начала входить в соревновательный ритм Валентина Семеренко, пропустившая много месяцев из-за травмы. В воскресенье Валя классно стреляла, а скорость, верим, будет постепенно к ней возвращаться. </p>\r\n\r\n<p>А вот кто действительно радует, так это одна из лидеров нашей сборной Юлия Джима. В воскресной эстафете она продемонстрировала нереальное выступление - на этот раз к отличной скорости Юли добавилась безукоризненная стрельба. Что касается мужской эстафеты, то нашим ребятам в этом сезоне каждый раз не хватает совсем чуть-чуть, чтобы взойти вместе на подиум. В нынешнем Кубке мира они - стабильно четвертые, но не будем забывать, какая острая конкуренция разгорается за первые позиции, при том, что топ-сборные мужского биатлона имеют значительно более мощные кадровые и технические ресурсы, чем наши. Да, на чемпионате мира хотелось бы «бронзы», но это станет возможным, если удачно совпадут сразу несколько факторов в нашу пользу: сохранит нынешнюю прекрасную форму Сергей Семенов, приблизится к оптимальным кондициям Дмитрий Пидручный, и, конечно, двое других участников - Артем Прима и Владимир Семаков - поддержат лидеров.</p>\r\n\r\n<p>Что ж, подводя итоги январских выступлений на Кубке мира и перебрасывая своеобразный мостик на самый важный старт зимы – чемпионат мира, – можем выдать нашим ребятам и девчатам сдержанные комплименты за проявленные характер и борьбу, а также пожелать выздоровления тем, кто еще не выходил на трассу в этом году. </p>\r\n\r\n<p>Несмотря на состояние общей апатии в отношении спорта со стороны государства наши атлеты и тренеры продолжают делать свое дело весьма качественно. Всем бы так!.. </p>	Юрий ВИНОГРАДОВ.	images/politics/631521.jpg		2017-01-25	2017-01-24 17:00:00-05	\N	2017-02-06 07:49:37.928611-05	2017-02-06 07:50:26.383513-05	t	f	f	t	3	0	\N	\N	43	2	2	2
\.


--
-- Name: articles_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_article_id_seq', 19, true);


--
-- Data for Name: articles_article_related; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_article_related (id, from_article_id, to_article_id) FROM stdin;
\.


--
-- Name: articles_article_related_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_article_related_id_seq', 1, false);


--
-- Data for Name: articles_article_tags; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_article_tags (id, article_id, tag_id) FROM stdin;
\.


--
-- Name: articles_article_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_article_tags_id_seq', 1, false);


--
-- Data for Name: articles_category; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_category (id, name, slug, ordering, activity, main_category) FROM stdin;
10	Анализ	analysis	1000	t	f
11	Интервью	interview	1100	t	f
13	Фотогалерея	photo-gallery	1300	t	f
14	Видеогалерея	video-gallery	1400	t	f
38	Евразия	eurasia	400	t	f
40	Образование и Наука	education	700	t	f
46	Комментарии	blog	1200	t	t
47	В мире	world	500	t	f
52	Популярное	populyarnoe	500	t	f
48	В Украине	russia	500	t	f
57	Главное за неделю	glavnoe-za-nedelyu	500	t	f
58	Как это было	kak-eto-bylo	500	t	f
59	Рождённые Украиной	rozhdyonnye-ukrainoj	500	t	f
36	Политика	politics	20	t	t
41	Общество	life	10	t	t
42	Туризм	tourism	80	t	t
39	Культура	culture	50	t	t
37	Экономика	economics	30	t	t
43	Спорт	sport	70	t	t
53	Безопасность	bezopasnost	120	t	f
2	Происшествия	incident	150	t	f
56	Социалка	socialka	500	t	f
54	Острая тема	ostraya-tema	500	t	f
55	Здоровье	medicina	60	t	t
49	В эпицентре внимания	daynews	40	t	t
\.


--
-- Name: articles_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_category_id_seq', 59, true);


--
-- Data for Name: articles_image; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_image (id, image, description, activity, article_id) FROM stdin;
\.


--
-- Name: articles_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_image_id_seq', 1, false);


--
-- Data for Name: articles_tag; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY articles_tag (id, name, slug, ordering, activity) FROM stdin;
\.


--
-- Name: articles_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('articles_tag_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add group	1	add_group
2	Can change group	1	change_group
3	Can delete group	1	delete_group
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add content type	3	add_contenttype
8	Can change content type	3	change_contenttype
9	Can delete content type	3	delete_contenttype
10	Can add Пользователь	4	add_user
11	Can change Пользователь	4	change_user
12	Can delete Пользователь	4	delete_user
13	Can add Категория	5	add_category
14	Can change Категория	5	change_category
15	Can delete Категория	5	delete_category
16	Can add Тег	6	add_tag
17	Can change Тег	6	change_tag
18	Can delete Тег	6	delete_tag
19	Can add Статья	7	add_article
20	Can change Статья	7	change_article
21	Can delete Статья	7	delete_article
22	Can add Категория	8	add_category
23	Can change Категория	8	change_category
24	Can delete Категория	8	delete_category
25	Can add Клиент	9	add_client
26	Can change Клиент	9	change_client
27	Can delete Клиент	9	delete_client
28	Can add Баннер	10	add_banner
29	Can change Баннер	10	change_banner
30	Can delete Баннер	10	delete_banner
31	Can add Подписка	11	add_subscribe
32	Can change Подписка	11	change_subscribe
33	Can delete Подписка	11	delete_subscribe
34	Can add page	12	add_page
35	Can change page	12	change_page
36	Can delete page	12	delete_page
37	Can view page	12	view_page
38	Can add session	13	add_session
39	Can change session	13	change_session
40	Can delete session	13	delete_session
41	Can add log entry	14	add_logentry
42	Can change log entry	14	change_logentry
43	Can delete log entry	14	delete_logentry
44	Can add Категория	5	add_newscategory
45	Can change Категория	5	change_newscategory
46	Can delete Категория	5	delete_newscategory
47	Can add Новость	7	add_news
48	Can change Новость	7	change_news
49	Can delete Новость	7	delete_news
50	Can add Маншет	7	add_headline
51	Can change Маншет	7	change_headline
52	Can delete Маншет	7	delete_headline
53	Can add Автор	4	add_author
54	Can change Автор	4	change_author
55	Can delete Автор	4	delete_author
56	Can add Блог	7	add_blog
57	Can change Блог	7	change_blog
58	Can delete Блог	7	delete_blog
59	Can add image	20	add_image
60	Can change image	20	change_image
61	Can delete image	20	delete_image
62	Can add Фотогалерея	7	add_photogallery
63	Can change Фотогалерея	7	change_photogallery
64	Can delete Фотогалерея	7	delete_photogallery
65	Can add Видео	7	add_videogallery
66	Can change Видео	7	change_videogallery
67	Can delete Видео	7	delete_videogallery
68	Can add Выбор	23	add_choice
69	Can change Выбор	23	change_choice
70	Can delete Выбор	23	delete_choice
71	Can add Опрос	24	add_poll
72	Can change Опрос	24	change_poll
73	Can delete Опрос	24	delete_poll
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_permission_id_seq', 73, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, location, image) FROM stdin;
1	pbkdf2_sha256$30000$u8WzrXTKQCGC$21090c3UiVLMPDNLgvYANMcvZxMuV5PQqWnFu+va8eo=	2017-01-30 04:22:43.768394-05	t	admin				t	t	2017-01-30 04:22:34.448982-05		
2	pbkdf2_sha256$30000$wDE0vZJuhKJq$QUfT2mlKVf5diY5r+ANH9Q5zsSuZkVUFltjYj9G7dZ0=	2017-03-18 15:58:42.365504-04	t	stas				t	t	2017-01-30 08:07:13.15087-05		
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: banners_banner; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY banners_banner (id, url, create_date, ordering, activity, is_shown, show_count, max_show_count, clicks, file, width, height, code, category_id, client_id) FROM stdin;
2		2017-03-14 14:37:23.860011-04	500	t	f	220	\N	0	banners/IMG_1815_JXQlODR.JPG	468	60	{{ width = 468px }}\r\n{{ height }} : 60px;	2	2
\.


--
-- Data for Name: banners_banner_categories; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY banners_banner_categories (id, banner_id, category_id) FROM stdin;
1	2	3
\.


--
-- Name: banners_banner_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('banners_banner_categories_id_seq', 1, true);


--
-- Name: banners_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('banners_banner_id_seq', 2, true);


--
-- Data for Name: banners_category; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY banners_category (id, name, slug, width, height, main, ordering, activity) FROM stdin;
1	клиент 2	klient-2	30	40	t	500	t
2	banner	banner	468	60	t	500	t
3	banner-2	banner-2	468	60	f	500	t
\.


--
-- Name: banners_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('banners_category_id_seq', 3, true);


--
-- Data for Name: banners_client; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY banners_client (id, name, slug, url, email, ordering, activity) FROM stdin;
1	клиент	klient	http://mk-turkey.ru/		500	t
2	client_test	client_test			500	t
\.


--
-- Name: banners_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('banners_client_id_seq', 2, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2017-02-02 04:13:53.35837-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	1	[{"added": {}}]	7	2
2	2017-02-02 04:18:22.950078-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["content"]}}]	7	2
3	2017-02-02 04:36:43.431962-05	2	йуцуцу	1	[{"added": {}}]	7	2
4	2017-02-02 04:37:50.135349-05	2	йуцуцу	3		7	2
5	2017-02-02 04:39:13.919758-05	54	Острая тема	1	[{"added": {}}]	5	2
6	2017-02-02 04:39:17.693595-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["content", "category"]}}]	7	2
7	2017-02-02 04:40:26.545058-05	54	Острая тема	2	[{"changed": {"fields": ["main_category"]}}]	16	2
8	2017-02-02 04:42:03.422057-05	55	Медицина	1	[{"added": {}}]	16	2
9	2017-02-02 04:42:29.36915-05	43	Спорт	2	[{"changed": {"fields": ["main_category"]}}]	16	2
10	2017-02-02 04:42:38.792121-05	56	Социалка	1	[{"added": {}}]	16	2
11	2017-02-02 04:42:47.746375-05	56	Социалка	2	[{"changed": {"fields": ["main_category"]}}]	16	2
12	2017-02-02 04:48:32.980966-05	48	В России	2	[{"changed": {"fields": ["activity"]}}]	16	2
13	2017-02-02 04:49:28.804722-05	48	В Украине	2	[{"changed": {"fields": ["name", "slug", "activity"]}}]	16	2
14	2017-02-02 04:51:45.605453-05	48	В России	2	[{"changed": {"fields": ["name", "slug"]}}]	16	2
15	2017-02-02 04:54:48.763362-05	48	В Украине	2	[{"changed": {"fields": ["name"]}}]	16	2
16	2017-02-02 05:02:21.156651-05	3	Скай	1	[{"added": {}}]	21	2
17	2017-02-02 05:03:48.139502-05	3	Скай	3		21	2
18	2017-02-02 05:31:12.491708-05	4	блог	1	[{"added": {}}]	18	2
19	2017-02-02 05:32:47.808282-05	5	блог1	1	[{"added": {}}]	18	2
20	2017-02-02 05:35:02.985827-05	5	блог1	2	[{"changed": {"fields": ["content"]}}]	18	2
21	2017-02-02 05:35:46.803933-05	5	блог1	3		18	2
22	2017-02-02 05:35:51.838661-05	4	блог	3		18	2
23	2017-02-02 05:53:05.171995-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["content"]}}]	7	2
24	2017-02-02 06:06:24.616439-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["content"]}}]	7	2
25	2017-02-02 06:14:43.167867-05	6	ГЛАВНОЕ ОРУЖИЕ ПОЛИТИКОВ	1	[{"added": {}}]	7	2
26	2017-02-02 06:23:19.264762-05	6	ГЛАВНОЕ ОРУЖИЕ ПОЛИТИКОВ	2	[{"changed": {"fields": ["activity", "aside"]}}]	7	2
27	2017-02-02 06:25:54.531961-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	1	[{"added": {}}]	7	2
28	2017-02-02 06:34:53.120105-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	2	[{"changed": {"fields": ["content"]}}]	7	2
29	2017-02-02 06:35:20.308343-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	2	[{"changed": {"fields": ["image"]}}]	7	2
30	2017-02-02 06:36:19.427929-05	57	Главное за неделю	1	[{"added": {}}]	5	2
31	2017-02-02 06:36:21.64652-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	2	[{"changed": {"fields": ["category"]}}]	7	2
32	2017-02-02 06:39:25.383656-05	8	ЮЛИЯ ДЖИМА — ЧЕМПИОНКА ЕВРОПЫ-2017!	1	[{"added": {}}]	7	2
33	2017-02-02 06:42:32.635843-05	8	ЮЛИЯ ДЖИМА — ЧЕМПИОНКА ЕВРОПЫ-2017!	2	[{"changed": {"fields": ["content", "image"]}}]	7	2
34	2017-02-02 06:49:15.254034-05	9	ПОВЫШЕНИЕ "МИНИМАЛКИ" — ЭКСПЕРИМЕНТ НА ЛЮДЯХ	1	[{"added": {}}]	7	2
35	2017-02-02 06:52:34.105145-05	9	ПОВЫШЕНИЕ "МИНИМАЛКИ" — ЭКСПЕРИМЕНТ НА ЛЮДЯХ	2	[{"changed": {"fields": ["content"]}}]	7	2
36	2017-02-02 08:50:53.816412-05	10	ЭТО ИНДИЯ, ДЕТКА!	1	[{"added": {}}]	7	2
37	2017-02-02 08:51:32.513441-05	10	ЭТО ИНДИЯ, ДЕТКА!	2	[{"changed": {"fields": ["content"]}}]	7	2
38	2017-02-02 08:51:46.098375-05	10	ЭТО ИНДИЯ, ДЕТКА!	2	[{"changed": {"fields": ["category"]}}]	7	2
39	2017-02-02 08:52:14.0219-05	10	ЭТО ИНДИЯ, ДЕТКА!	2	[{"changed": {"fields": ["content"]}}]	7	2
40	2017-02-02 10:09:59.194582-05	9	ПОВЫШЕНИЕ "МИНИМАЛКИ" — ЭКСПЕРИМЕНТ НА ЛЮДЯХ	2	[{"changed": {"fields": ["category"]}}]	7	2
41	2017-02-02 10:10:23.446435-05	8	ЮЛИЯ ДЖИМА — ЧЕМПИОНКА ЕВРОПЫ-2017!	2	[{"changed": {"fields": ["category"]}}]	7	2
42	2017-02-02 10:10:42.60879-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	2	[{"changed": {"fields": ["category"]}}]	7	2
43	2017-02-02 10:11:17.31374-05	6	ГЛАВНОЕ ОРУЖИЕ ПОЛИТИКОВ	2	[{"changed": {"fields": ["category"]}}]	7	2
44	2017-02-02 10:11:41.358364-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["content", "category"]}}]	7	2
45	2017-02-03 05:23:33.092058-05	11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	1	[{"added": {}}]	7	2
46	2017-02-03 05:24:03.491693-05	11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	2	[{"changed": {"fields": ["content"]}}]	7	2
47	2017-02-03 05:24:21.803009-05	11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	2	[]	7	2
48	2017-02-03 05:25:07.460103-05	11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	2	[{"changed": {"fields": ["content"]}}]	7	2
49	2017-02-03 05:43:03.462108-05	12	ЕВРОПА ЗА ТО, ЧТОБЫ УКРАИНА ПОКУПАЛА ГАЗ У РОССИИ	1	[{"added": {}}]	7	2
50	2017-02-03 05:46:40.071969-05	12	ЕВРОПА ЗА ТО, ЧТОБЫ УКРАИНА ПОКУПАЛА ГАЗ У РОССИИ	2	[{"changed": {"fields": ["content", "pub_date"]}}]	7	2
51	2017-02-03 05:48:53.176766-05	11	АВСТРАЛИЯ ПЕРЕПИСАЛА ИСТОРИЮ ТЕННИСА	2	[{"changed": {"fields": ["pub_date"]}}]	7	2
52	2017-02-03 06:01:58.938304-05	13	В ЗНАК ЕДИНЕНИЯ	1	[{"added": {}}]	7	2
53	2017-02-03 06:05:54.34759-05	13	В ЗНАК ЕДИНЕНИЯ	2	[{"changed": {"fields": ["content", "pub_date"]}}]	7	2
54	2017-02-03 06:06:24.771857-05	13	В ЗНАК ЕДИНЕНИЯ	2	[{"changed": {"fields": ["category"]}}]	7	2
55	2017-02-03 06:45:36.821717-05	58	Как это было	1	[{"added": {}}]	5	2
56	2017-02-03 06:45:42.265415-05	14	ТРИ ПОЛЯКА, ГРУЗИН И СОБАКА	1	[{"added": {}}]	7	2
57	2017-02-03 06:46:01.318246-05	14	ТРИ ПОЛЯКА, ГРУЗИН И СОБАКА	2	[{"changed": {"fields": ["content", "pub_date"]}}]	7	2
58	2017-02-03 06:46:59.406382-05	14	ТРИ ПОЛЯКА, ГРУЗИН И СОБАКА	2	[{"changed": {"fields": ["image"]}}]	7	2
59	2017-02-03 07:14:38.617333-05	59	Рождённые Украиной	1	[{"added": {}}]	5	2
60	2017-02-03 07:14:42.500211-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	1	[{"added": {}}]	7	2
61	2017-02-03 07:21:17.507688-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content", "pub_date"]}}]	7	2
62	2017-02-03 07:22:42.866092-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content", "image"]}}]	7	2
63	2017-02-03 07:23:48.061204-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
64	2017-02-03 07:24:59.950308-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
65	2017-02-03 07:26:29.707065-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
66	2017-02-03 07:29:01.961269-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
67	2017-02-03 07:30:28.817985-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
68	2017-02-03 07:31:08.719225-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	7	2
69	2017-02-03 07:35:38.350827-05	9	ПОВЫШЕНИЕ "МИНИМАЛКИ" — ЭКСПЕРИМЕНТ НА ЛЮДЯХ	2	[{"changed": {"fields": ["category"]}}]	15	2
70	2017-02-03 07:36:03.562831-05	7	ДЕНЬ ПАМЯТИ ЖЕРТВ ХОЛОКОСТА: ТРАГЕДИЯ НЕ ДОЛЖНА ПОВТОРИТЬСЯ	2	[{"changed": {"fields": ["category"]}}]	15	2
71	2017-02-03 07:36:25.487033-05	1	КАК УБИВАЮТ «КИЕВСКУЮ РУСЬ»	2	[{"changed": {"fields": ["category"]}}]	15	2
72	2017-02-03 07:36:58.566224-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["category"]}}]	15	2
73	2017-02-03 07:37:42.30589-05	15	КНЯГИНЯ УКРАЇНСЬКОЇ ПІСНІ	2	[{"changed": {"fields": ["content"]}}]	15	2
74	2017-02-06 06:56:17.333408-05	16	КАКИЕ ИЗМЕНЕНИЯ НАС ЖДУТ В 2017 ГОДУ?	1	[{"added": {}}]	15	2
75	2017-02-06 06:56:34.286643-05	16	КАКИЕ ИЗМЕНЕНИЯ НАС ЖДУТ В 2017 ГОДУ?	2	[{"changed": {"fields": ["content", "pub_date"]}}]	15	2
76	2017-02-06 06:57:43.73456-05	16	КАКИЕ ИЗМЕНЕНИЯ НАС ЖДУТ В 2017 ГОДУ?	2	[{"changed": {"fields": ["image"]}}]	15	2
77	2017-02-06 07:03:53.338046-05	17	КАК ПРАВИЛЬНО ЛЕЧИТЬ АНГИНУ?	1	[{"added": {}}]	15	2
78	2017-02-06 07:04:06.723046-05	17	КАК ПРАВИЛЬНО ЛЕЧИТЬ АНГИНУ?	2	[{"changed": {"fields": ["content", "pub_date"]}}]	15	2
79	2017-02-06 07:05:15.320634-05	17	КАК ПРАВИЛЬНО ЛЕЧИТЬ АНГИНУ?	2	[{"changed": {"fields": ["image"]}}]	15	2
80	2017-02-06 07:05:29.377968-05	17	КАК ПРАВИЛЬНО ЛЕЧИТЬ АНГИНУ?	2	[{"changed": {"fields": ["image"]}}]	15	2
81	2017-02-06 07:40:42.713875-05	18	ИЗ РИМА В РИМИНИ	1	[{"added": {}}]	15	2
82	2017-02-06 07:40:57.73526-05	18	ИЗ РИМА В РИМИНИ	2	[{"changed": {"fields": ["content", "pub_date"]}}]	15	2
83	2017-02-06 07:41:58.489226-05	18	ИЗ РИМА В РИМИНИ	2	[{"changed": {"fields": ["content"]}}]	15	2
84	2017-02-06 07:49:37.939633-05	19	БЫСТРЕЕ БЬОРНДАЛЕНА	1	[{"added": {}}]	15	2
85	2017-02-06 07:49:54.302901-05	19	БЫСТРЕЕ БЬОРНДАЛЕНА	2	[{"changed": {"fields": ["content", "pub_date"]}}]	15	2
86	2017-02-06 07:50:26.396669-05	19	БЫСТРЕЕ БЬОРНДАЛЕНА	2	[{"changed": {"fields": ["category"]}}]	15	2
87	2017-02-10 04:25:39.174218-05	1	да/нет	1	[{"added": {}}, {"added": {"object": "\\u0434\\u0430", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}, {"added": {"object": "\\u043d\\u0435\\u0442", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}, {"added": {"object": "\\u043d\\u0435 \\u0437\\u043d\\u0430\\u044e", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}]	24	2
88	2017-02-10 04:30:55.214864-05	1	да/нет	2	[]	24	2
89	2017-02-10 07:47:50.971742-05	36	Политика	2	[{"changed": {"fields": ["ordering"]}}]	16	2
90	2017-02-10 07:47:50.977584-05	41	Общество	2	[{"changed": {"fields": ["ordering"]}}]	16	2
91	2017-02-10 07:47:50.981962-05	42	Туризм	2	[{"changed": {"fields": ["ordering"]}}]	16	2
92	2017-02-10 07:47:50.986702-05	39	Культура	2	[{"changed": {"fields": ["ordering"]}}]	16	2
93	2017-02-10 07:47:50.992391-05	37	Экономика	2	[{"changed": {"fields": ["ordering"]}}]	16	2
94	2017-02-10 07:47:50.99877-05	55	Медицина	2	[{"changed": {"fields": ["ordering"]}}]	16	2
95	2017-02-10 07:47:51.004494-05	43	Спорт	2	[{"changed": {"fields": ["ordering"]}}]	16	2
96	2017-02-10 07:47:51.008663-05	49	Злоба дня	2	[{"changed": {"fields": ["ordering"]}}]	16	2
97	2017-02-10 07:48:40.405141-05	53	Безопасность	2	[{"changed": {"fields": ["main_category"]}}]	16	2
98	2017-02-10 07:48:40.411456-05	2	Происшествия	2	[{"changed": {"fields": ["main_category"]}}]	16	2
99	2017-02-10 07:48:40.416117-05	56	Социалка	2	[{"changed": {"fields": ["main_category"]}}]	16	2
100	2017-02-10 07:48:40.428259-05	54	Острая тема	2	[{"changed": {"fields": ["main_category"]}}]	16	2
101	2017-02-10 07:49:59.482498-05	55	Здоровье	2	[{"changed": {"fields": ["name"]}}]	16	2
102	2017-02-10 07:50:39.678729-05	49	Злоба дня	2	[{"changed": {"fields": ["main_category"]}}]	16	2
103	2017-02-14 06:12:33.991271-05	1	клиент	1	[{"added": {}}]	9	2
104	2017-02-14 06:13:00.957807-05	1	клиент 2	1	[{"added": {}}]	8	2
105	2017-02-14 06:16:17.261653-05	1	клиент	1	[{"added": {}}]	10	2
106	2017-02-14 06:17:03.614471-05	1	клиент	3		10	2
107	2017-02-14 06:20:53.942408-05	1	/about/ -- О нас	1	[{"added": {}}]	12	2
108	2017-02-14 06:21:12.380968-05	1	/about/ -- О нас	2	[]	12	2
109	2017-02-14 06:21:50.60548-05	2	что где?	1	[{"added": {}}, {"added": {"object": "1", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}, {"added": {"object": "2", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}, {"added": {"object": "3", "name": "\\u0412\\u044b\\u0431\\u043e\\u0440"}}]	24	2
110	2017-03-14 14:26:09.315462-04	49	В эпицентре внимания	2	[{"changed": {"fields": ["name"]}}]	16	2
111	2017-03-14 14:37:23.869446-04	2	клиент	1	[{"added": {}}]	10	2
112	2017-03-14 14:40:00.875312-04	2	banner	1	[{"added": {}}]	8	2
113	2017-03-14 14:41:57.823498-04	2	клиент	2	[{"changed": {"fields": ["category", "ordering", "file", "code"]}}]	10	2
114	2017-03-14 14:43:20.088579-04	2	client_test	1	[{"added": {}}]	9	2
115	2017-03-14 14:43:48.219198-04	3	banner-2	1	[{"added": {}}]	8	2
116	2017-03-14 14:44:04.820463-04	2	client_test	2	[{"changed": {"fields": ["client", "file"]}}]	10	2
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 116, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	group
2	auth	permission
3	contenttypes	contenttype
4	registration	user
5	articles	category
6	articles	tag
7	articles	article
8	banners	category
9	banners	client
10	banners	banner
11	subscribes	subscribe
12	pages	page
13	sessions	session
14	admin	logentry
15	news	news
16	news	newscategory
17	headlines	headline
18	blogs	blog
19	blogs	author
20	photogallery	image
21	photogallery	photogallery
22	videogallery	videogallery
23	polls	choice
24	polls	poll
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('django_content_type_id_seq', 24, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-01-30 03:59:45.17675-05
2	contenttypes	0002_remove_content_type_name	2017-01-30 04:03:19.737127-05
3	auth	0001_initial	2017-01-30 04:03:19.853565-05
4	auth	0002_alter_permission_name_max_length	2017-01-30 04:03:19.875253-05
5	auth	0003_alter_user_email_max_length	2017-01-30 04:03:19.892145-05
6	auth	0004_alter_user_username_opts	2017-01-30 04:03:19.917039-05
7	auth	0005_alter_user_last_login_null	2017-01-30 04:03:19.932416-05
8	auth	0006_require_contenttypes_0002	2017-01-30 04:03:19.935124-05
9	auth	0007_alter_validators_add_error_messages	2017-01-30 04:03:19.949286-05
10	auth	0008_alter_user_username_max_length	2017-01-30 04:03:19.963823-05
11	registration	0001_initial	2017-01-30 04:05:10.850369-05
12	admin	0001_initial	2017-01-30 04:05:10.891701-05
13	admin	0002_logentry_remove_auto_add	2017-01-30 04:05:10.914898-05
14	sessions	0001_initial	2017-01-30 04:05:10.931178-05
15	polls	0001_initial	2017-01-30 04:06:08.812608-05
16	articles	0001_initial	2017-01-30 04:09:40.981511-05
17	banners	0001_initial	2017-01-30 04:09:41.253033-05
18	blogs	0001_initial	2017-01-30 04:09:41.268524-05
19	headlines	0001_initial	2017-01-30 04:09:41.279632-05
20	news	0001_initial	2017-01-30 04:09:41.295325-05
21	photogallery	0001_initial	2017-01-30 04:09:41.369215-05
22	videogallery	0001_initial	2017-01-30 04:09:41.379509-05
23	pages	0001_initial	2017-01-30 04:26:28.879448-05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('django_migrations_id_seq', 23, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: pages_page; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY pages_page (id, url, title, keywords, description, content, enable_comments, template_name, registration_required) FROM stdin;
1	/about/	О нас				f		f
\.


--
-- Name: pages_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('pages_page_id_seq', 1, true);


--
-- Data for Name: polls_choice; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY polls_choice (id, choice_text, votes, poll_id) FROM stdin;
1	да	0	1
2	нет	0	1
3	не знаю	0	1
4	1	0	2
5	2	0	2
6	3	0	2
\.


--
-- Name: polls_choice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('polls_choice_id_seq', 6, true);


--
-- Data for Name: polls_poll; Type: TABLE DATA; Schema: public; Owner: mkkiev
--

COPY polls_poll (id, question_text, pub_date) FROM stdin;
1	да/нет	2017-02-10 04:25:39-05
2	что где?	2017-02-14 06:21:50.594983-05
\.


--
-- Name: polls_poll_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkkiev
--

SELECT pg_catalog.setval('polls_poll_id_seq', 2, true);


--
-- Name: articles_article_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_pkey PRIMARY KEY (id);


--
-- Name: articles_article_related_from_article_id_303464eb_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article_related
    ADD CONSTRAINT articles_article_related_from_article_id_303464eb_uniq UNIQUE (from_article_id, to_article_id);


--
-- Name: articles_article_related_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article_related
    ADD CONSTRAINT articles_article_related_pkey PRIMARY KEY (id);


--
-- Name: articles_article_slug_date_b3f3737e_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_slug_date_b3f3737e_uniq UNIQUE (slug_date, slug);


--
-- Name: articles_article_tags_article_id_1988a91e_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article_tags
    ADD CONSTRAINT articles_article_tags_article_id_1988a91e_uniq UNIQUE (article_id, tag_id);


--
-- Name: articles_article_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_article_tags
    ADD CONSTRAINT articles_article_tags_pkey PRIMARY KEY (id);


--
-- Name: articles_category_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_category
    ADD CONSTRAINT articles_category_pkey PRIMARY KEY (id);


--
-- Name: articles_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_category
    ADD CONSTRAINT articles_category_slug_key UNIQUE (slug);


--
-- Name: articles_image_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_image
    ADD CONSTRAINT articles_image_pkey PRIMARY KEY (id);


--
-- Name: articles_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_tag
    ADD CONSTRAINT articles_tag_pkey PRIMARY KEY (id);


--
-- Name: articles_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY articles_tag
    ADD CONSTRAINT articles_tag_slug_key UNIQUE (slug);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: banners_banner_categories_banner_id_6d75fb3e_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_banner_categories
    ADD CONSTRAINT banners_banner_categories_banner_id_6d75fb3e_uniq UNIQUE (banner_id, category_id);


--
-- Name: banners_banner_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_banner_categories
    ADD CONSTRAINT banners_banner_categories_pkey PRIMARY KEY (id);


--
-- Name: banners_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_banner
    ADD CONSTRAINT banners_banner_pkey PRIMARY KEY (id);


--
-- Name: banners_category_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_category
    ADD CONSTRAINT banners_category_pkey PRIMARY KEY (id);


--
-- Name: banners_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_category
    ADD CONSTRAINT banners_category_slug_key UNIQUE (slug);


--
-- Name: banners_client_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_client
    ADD CONSTRAINT banners_client_pkey PRIMARY KEY (id);


--
-- Name: banners_client_slug_key; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY banners_client
    ADD CONSTRAINT banners_client_slug_key UNIQUE (slug);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: pages_page_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY pages_page
    ADD CONSTRAINT pages_page_pkey PRIMARY KEY (id);


--
-- Name: polls_choice_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY polls_choice
    ADD CONSTRAINT polls_choice_pkey PRIMARY KEY (id);


--
-- Name: polls_poll_pkey; Type: CONSTRAINT; Schema: public; Owner: mkkiev; Tablespace: 
--

ALTER TABLE ONLY polls_poll
    ADD CONSTRAINT polls_poll_pkey PRIMARY KEY (id);


--
-- Name: articles_article_2604cbea; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_2604cbea ON articles_article USING btree (publisher_id);


--
-- Name: articles_article_2dbcba41; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_2dbcba41 ON articles_article USING btree (slug);


--
-- Name: articles_article_3700153c; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_3700153c ON articles_article USING btree (creator_id);


--
-- Name: articles_article_4f331e2f; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_4f331e2f ON articles_article USING btree (author_id);


--
-- Name: articles_article_b583a629; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_b583a629 ON articles_article USING btree (category_id);


--
-- Name: articles_article_eb93b3b0; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_eb93b3b0 ON articles_article USING btree (editor_id);


--
-- Name: articles_article_related_58b6ddc3; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_related_58b6ddc3 ON articles_article_related USING btree (to_article_id);


--
-- Name: articles_article_related_be73af96; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_related_be73af96 ON articles_article_related USING btree (from_article_id);


--
-- Name: articles_article_slug_cc61df93_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_slug_cc61df93_like ON articles_article USING btree (slug varchar_pattern_ops);


--
-- Name: articles_article_tags_76f094bc; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_tags_76f094bc ON articles_article_tags USING btree (tag_id);


--
-- Name: articles_article_tags_a00c1b00; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_article_tags_a00c1b00 ON articles_article_tags USING btree (article_id);


--
-- Name: articles_category_slug_f02e70e2_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_category_slug_f02e70e2_like ON articles_category USING btree (slug varchar_pattern_ops);


--
-- Name: articles_image_a00c1b00; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_image_a00c1b00 ON articles_image USING btree (article_id);


--
-- Name: articles_tag_slug_c4fc6368_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX articles_tag_slug_c4fc6368_like ON articles_tag USING btree (slug varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: banners_banner_2bfe9d72; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_banner_2bfe9d72 ON banners_banner USING btree (client_id);


--
-- Name: banners_banner_b583a629; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_banner_b583a629 ON banners_banner USING btree (category_id);


--
-- Name: banners_banner_categories_38947952; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_banner_categories_38947952 ON banners_banner_categories USING btree (banner_id);


--
-- Name: banners_banner_categories_b583a629; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_banner_categories_b583a629 ON banners_banner_categories USING btree (category_id);


--
-- Name: banners_category_slug_fcc59e9e_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_category_slug_fcc59e9e_like ON banners_category USING btree (slug varchar_pattern_ops);


--
-- Name: banners_client_slug_970c81de_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX banners_client_slug_970c81de_like ON banners_client USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: pages_page_572d4e42; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX pages_page_572d4e42 ON pages_page USING btree (url);


--
-- Name: pages_page_url_c10fea58_like; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX pages_page_url_c10fea58_like ON pages_page USING btree (url varchar_pattern_ops);


--
-- Name: polls_choice_582e9e5a; Type: INDEX; Schema: public; Owner: mkkiev; Tablespace: 
--

CREATE INDEX polls_choice_582e9e5a ON polls_choice USING btree (poll_id);


--
-- Name: articles_articl_from_article_id_0c7c6fd5_fk_articles_article_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_related
    ADD CONSTRAINT articles_articl_from_article_id_0c7c6fd5_fk_articles_article_id FOREIGN KEY (from_article_id) REFERENCES articles_article(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article__to_article_id_2656defe_fk_articles_article_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_related
    ADD CONSTRAINT articles_article__to_article_id_2656defe_fk_articles_article_id FOREIGN KEY (to_article_id) REFERENCES articles_article(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_author_id_059aea7d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_author_id_059aea7d_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_category_id_633dad2b_fk_articles_category_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_category_id_633dad2b_fk_articles_category_id FOREIGN KEY (category_id) REFERENCES articles_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_creator_id_55f71ecb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_creator_id_55f71ecb_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_editor_id_d1e5878c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_editor_id_d1e5878c_fk_auth_user_id FOREIGN KEY (editor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_publisher_id_95fc2d71_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article
    ADD CONSTRAINT articles_article_publisher_id_95fc2d71_fk_auth_user_id FOREIGN KEY (publisher_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_tag_article_id_524565b8_fk_articles_article_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_tags
    ADD CONSTRAINT articles_article_tag_article_id_524565b8_fk_articles_article_id FOREIGN KEY (article_id) REFERENCES articles_article(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_article_tags_tag_id_56ec02c6_fk_articles_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_article_tags
    ADD CONSTRAINT articles_article_tags_tag_id_56ec02c6_fk_articles_tag_id FOREIGN KEY (tag_id) REFERENCES articles_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: articles_image_article_id_5f6bf24f_fk_articles_article_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY articles_image
    ADD CONSTRAINT articles_image_article_id_5f6bf24f_fk_articles_article_id FOREIGN KEY (article_id) REFERENCES articles_article(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner_cate_category_id_a43e3ec8_fk_banners_category_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner_categories
    ADD CONSTRAINT banners_banner_cate_category_id_a43e3ec8_fk_banners_category_id FOREIGN KEY (category_id) REFERENCES banners_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner_categori_banner_id_6160b443_fk_banners_banner_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner_categories
    ADD CONSTRAINT banners_banner_categori_banner_id_6160b443_fk_banners_banner_id FOREIGN KEY (banner_id) REFERENCES banners_banner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner_category_id_3957ed0e_fk_banners_category_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner
    ADD CONSTRAINT banners_banner_category_id_3957ed0e_fk_banners_category_id FOREIGN KEY (category_id) REFERENCES banners_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: banners_banner_client_id_4d1e10aa_fk_banners_client_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY banners_banner
    ADD CONSTRAINT banners_banner_client_id_4d1e10aa_fk_banners_client_id FOREIGN KEY (client_id) REFERENCES banners_client(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: polls_choice_poll_id_3a553f1a_fk_polls_poll_id; Type: FK CONSTRAINT; Schema: public; Owner: mkkiev
--

ALTER TABLE ONLY polls_choice
    ADD CONSTRAINT polls_choice_poll_id_3a553f1a_fk_polls_poll_id FOREIGN KEY (poll_id) REFERENCES polls_poll(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

