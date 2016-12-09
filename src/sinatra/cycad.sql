CREATE TABLE transactions (
  id TEXT NOT NULL PRIMARY KEY,
  date INTEGER NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  category_id INTEGER NOT NULL,
  description TEXT );

CREATE TABLE categories (
  id INTEGER NOT NULL PRIMARY KEY,
  name TEXT NOT NULL );


