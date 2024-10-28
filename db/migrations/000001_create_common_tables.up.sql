create table users (
    id uuid primary key,
    username varchar(64) not null,
    password_hash varchar(128) not null,
    created_at timestamp default now(),
    updated_at timestamp default now()
);

create unique index idx_unique_username on users(username);

create table accounts (
    id uuid primary key,
    user_id uuid not null,
    name varchar(255) not null,
    is_archived bool default false,
    is_in_balance bool default true,
    currency_code varchar(3) not null,
    account_type varchar(64) not null,
    bank_name varchar(255),
    country_code varchar(2),
    region_name varchar(128),
    created_at timestamp default now(),
    updated_at timestamp default now(),
    constraint fk_accounts_users foreign key(user_id) references users(id)
);

create unique index idx_unique_account_name on accounts(user_id, name);

create table projects (
    id uuid primary key,
    user_id uuid not null,
    name varchar(128) not null,
    constraint fk_project_users foreign key(user_id) references users(id)
);

create unique index idx_unique_project_name on projects(user_id, name);

create table fx_rates (
    fx_date date not null,
    currency_code_from varchar(3),
    currency_code_to varchar(3),
    rate numeric(38, 10)
);

create unique index idx_unique_fx_rates on fx_rates(fx_date, currency_code_from, currency_code_to);

create table categories (
    id uuid primary key,
    user_id uuid not null,
    name varchar(128)
);

create unique index idx_unique_categories on categories(user_id, name);

create table operations (
    id uuid primary key,
    user_id uuid not null,
    account_id uuid not null,
    project_id uuid not null,
    category_id uuid not null,
    chain_id uuid not null,
    operation_date date not null,
    amount numeric(38,10) not null,
    currency_code varchar(3) not null,
    operation_type varchar(16) not null,
    created_at timestamp default now(),
    updated_at timestamp default now(),
    constraint fk_operations_users foreign key(user_id) references users(id),
    constraint fk_operations_accounts foreign key(account_id) references accounts(id),
    constraint fk_operations_projects foreign key(project_id) references projects(id),
    constraint fk_operations_categories foreign key(category_id) references categories(id)
);
