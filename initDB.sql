CREATE SCHEMA IF NOT EXISTS company CHARACTER SET utf8;

DROP TABLES IF EXISTS company.userskills, company.teamusers, company.projectteams, company.customerprojects; 
DROP TABLES IF EXISTS company.users, company.skills, company.teams, company.projects, company.customers; 
COMMIT;

CREATE TABLE company.users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

	CREATE TABLE company.skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    skill VARCHAR(30) NOT NULL
);

CREATE TABLE company.teams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(30) NOT NULL
);

CREATE TABLE company.projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(30) NOT NULL
);

CREATE TABLE company.customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE company.customerprojects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customerid INT,
	projectid INT,
    customer_budget INT,
   FOREIGN KEY (customerid)
        REFERENCES company.customers (id)
        ON DELETE CASCADE,
    FOREIGN KEY (projectid)
        REFERENCES company.projects (id)
        ON DELETE CASCADE,
    UNIQUE KEY unique_projects_per_customer (customerid, projectid)    
);


CREATE TABLE company.projectteams (
    id INT PRIMARY KEY AUTO_INCREMENT,
	projectid INT,
    teamid INT,
    FOREIGN KEY (projectid)
        REFERENCES company.projects (id)
        ON DELETE CASCADE,
    FOREIGN KEY (teamid)
        REFERENCES company.teams (id)
        ON DELETE CASCADE,
    UNIQUE KEY unique_teams_per_project (projectid, teamid)    
);

CREATE TABLE company.teamusers (
    id INT PRIMARY KEY AUTO_INCREMENT,
	teamid INT,
    userid INT,
    FOREIGN KEY (teamid)
        REFERENCES company.teams (id)
        ON DELETE CASCADE,
    FOREIGN KEY (userid)
        REFERENCES company.users (id)
        ON DELETE CASCADE,
    UNIQUE KEY unique_users_per_team (teamid, userid)    
);

CREATE TABLE company.userskills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    skillid INT,
    FOREIGN KEY (userid)
        REFERENCES company.users (id)
        ON DELETE CASCADE,
    FOREIGN KEY (skillid)
        REFERENCES company.skills (id)
        ON DELETE RESTRICT,
    UNIQUE KEY unique_skills_per_user (userid, skillid)    
);


COMMIT;