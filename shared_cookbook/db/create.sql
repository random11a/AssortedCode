drop table if exists recipes; 
drop table if exists categories;
drop table if exists users;
create table categories ( 
    id                     int            not null auto_increment, 
    name                   varchar(100)   not null default '', 
    primary key(id) 
) engine=InnoDB; 
create table users (
    id                     int            not null auto_increment, 
    name                   varchar(100)   not null default '', 
    primary key(id) 
) engine=InnoDB;
create table recipes ( 
    id                     int            not null auto_increment, 
    category_id            int            not null, 
    user_id                int            not null, 
    title                  varchar(100)   not null default '', 
    description            varchar(255)   null, 
    date                   date           null, 
    instructions           text           null, 
    constraint fk_recipes_categories foreign key (category_id) references categories(id), 
    constraint fk_recipes_users foreign key (user_id) references users(id),
    primary key(id) 
) engine=InnoDB;
