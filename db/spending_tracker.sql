DROP TABLE transactions;
DROP TABLE companies;
DROP TABLE types;
DROP TABLE budgets;



CREATE TABLE budgets(
  id SERIAL PRIMARY KEY,
  budget FLOAT
);

CREATE TABLE companies(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  status BOOLEAN NOT NULL

);
CREATE TABLE types(
  id SERIAL PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  type_id INT REFERENCES types(id),
  amount FLOAT,
  time TIMESTAMP
);
