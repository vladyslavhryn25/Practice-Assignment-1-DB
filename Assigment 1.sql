DROP TABLE IF EXISTS payments, projects, categories, freelancers, clients CASCADE;

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR(100),
    country VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE freelancers (
    freelancer_id SERIAL PRIMARY KEY,
    freelancer_name VARCHAR(100),
    email VARCHAR(100),
    hourly_rate NUMERIC(10, 2)
);


CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50)
);


CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    freelancer_id INT REFERENCES freelancers(freelancer_id),
    category_id INT REFERENCES categories(category_id),
    title VARCHAR(100),
    status VARCHAR(20),
    budget NUMERIC(10, 2),
    start_date DATE
);


CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(project_id),
    amount NUMERIC(10, 2),
    payment_date DATE
);


INSERT INTO clients (client_name, country, email) VALUES
    ('TechStart LLC', 'USA', 'contact@techstart.com'),
    ('GreenLeaf Inc', 'Canada', 'info@greenleaf.com'),
    ('Bright Studio', 'UK', 'hello@brightstudio.com'),
    ('Nova Group', 'Germany', 'nova@novagroup.com'),
    ('Pixel Agency', 'Poland', 'contact@pixelagency.com');
	
	
INSERT INTO freelancers (freelancer_name, email, hourly_rate) VALUES
    ('Vladyslav Hryn', 'vladhryn@mail.com', 25.00),
    ('Ivan Kovalenko', 'ivankovalenko@mail.com', 30.00),
    ('Maria Shevchenko', 'mariashevchenko@mail.com', 20.00),
    ('Andrii Bondar', 'andriibondar@mail.com', 35.00),
    ('Kateryna Lys', 'katerynalys@mail.com', 28.00);
	
	
INSERT INTO categories (category_name) VALUES
    ('Web Development'),
    ('Graphic Design'),
    ('Copywriting'),
    ('Mobile Development'),
    ('SEO');
	
	
INSERT INTO projects
    (client_id, freelancer_id, category_id, title, status, budget, start_date)
VALUES
    (1, 1, 1, 'Company Website', 'Completed', 1000.00, '2026-01-10'),
    (2, 2, 4, 'Mobile App MVP', 'Completed', 2500.00, '2026-02-01'),
    (3, 3, 2, 'Logo Design', 'Completed', 300.00, '2026-02-15'),
    (4, 4, 1, 'Landing Page', 'In Progress', 800.00, '2026-03-01'),
    (5, 5, 3, 'Blog Articles', 'Completed', 400.00, '2026-03-10'),
    (1, 2, 1, 'API Integration', 'Completed', 1200.00, '2026-03-20'),
    (2, 1, 5, 'SEO Audit', 'Completed', 600.00, '2026-04-01'),
    (3, 4, 4, 'iOS App Update', 'In Progress', 1500.00, '2026-04-15'),
    (4, 3, 2, 'Brand Guidelines', 'Completed', 700.00, '2026-04-20'),
    (5, 5, 1, 'Website Redesign', 'Completed', 1800.00, '2026-05-01');
	
	
INSERT INTO payments (project_id, amount, payment_date) VALUES
    (1, 500.00, '2026-01-15'),
    (1, 500.00, '2026-01-25'),
    (2, 1250.00, '2026-02-05'),
    (2, 1250.00, '2026-02-20'),
    (3, 300.00, '2026-02-20'),
    (5, 400.00, '2026-03-15'),
    (6, 600.00, '2026-03-25'),
    (6, 600.00, '2026-04-01'),
    (7, 600.00, '2026-04-05'),
    (9, 700.00, '2026-04-25'),
    (10, 900.00, '2026-05-05'),
    (10, 900.00, '2026-05-15');
	
	
	
	
SELECT
    f.freelancer_name,
    c.category_name,
    SUM(pay.amount) AS total_paid
FROM payments pay
JOIN projects p ON pay.project_id = p.project_id
JOIN freelancers f ON p.freelancer_id = f.freelancer_id
JOIN categories c ON p.category_id = c.category_id
JOIN clients cl ON p.client_id = cl.client_id
WHERE p.status = 'Completed'
GROUP BY f.freelancer_name, c.category_name
HAVING SUM(pay.amount) > 500
ORDER BY total_paid DESC
LIMIT 5;