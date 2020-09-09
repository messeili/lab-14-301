-- This will create a second table in the new database named author
CREATE TABLE AUTHORS
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- This will retrieve unique author values from books table and insert each one into the author table in the name column
INSERT INTO authors
    (name)
SELECT DISTINCT author
FROM books;

-- This will add a column to the books table named author_id. This will connect each book to a specific author in the other table.
ALTER TABLE books ADD COLUMN author_id INT;

-- This will prepare a connection between the two tables. It works by running a subquery for every row in the books table
UPDATE books SET author_id=author.id FROM (SELECT *
    FROM authors) AS author WHERE books.author = author.name;

--This will modify the books table by removing the column named author.
ALTER TABLE books DROP COLUMN author;

-- This modify the data type of the author_id in the books table, setting it as a foreign key which references the primary key in the authors table
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);

