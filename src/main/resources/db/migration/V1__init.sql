create table users
(
    id       serial primary key,
    login    varchar(30) not null unique,
    password varchar(40) not null,
    company varchar(40) not null
);

create table permissions
(
    id         serial primary key,
    permission varchar(30) not null unique
);

create table user_to_permissions (
    user_id int not null,
    permission_id int not null,
    constraint fk_user_to_permission_user foreign key (user_id) references users(id),
    constraint fk_user_to_permission_permission foreign key (permission_id) references permissions(id)
);

insert into users (login, password, company) values
    ('admin', 'password', 'admin-company'),
    ('catalog', 'password', 'catalog-company'),
    ('user', 'password', 'user-company');

insert into permissions (permission) values
    ('VIEW_ADMIN'),
    ('VIEW_CATALOG');

insert into user_to_permissions (user_id, permission_id) values
    ((select id from users where login = 'admin'), (select id from permissions where permission = 'VIEW_ADMIN')),
    ((select id from users where login = 'admin'), (select id from permissions where permission = 'VIEW_CATALOG')),

    ((select id from users where login = 'catalog'), (select id from permissions where permission = 'VIEW_CATALOG'));