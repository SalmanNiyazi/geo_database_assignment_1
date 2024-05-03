

/*
a) Create a new type named PointType. This type represents a point comprising two coordinates x and y, which are of type NUMERIC.
*/
CREATE TYPE PointType AS(
    x NUMERIC,
    y NUMERIC
);

/*
b) Create a new table Rectangle to store axis-aligned rectangles. An axis-aligned rectangle
is identified by its primary key id, and contains two points of type PointType. Ensure the
following constraints are satisfied:
• The first point is the bottom left corner of the rectangle.
• The second point is the top right corner of the rectangle.
• A rectangle can be created using the two points given
*/

CREATE TABLE Rectangle(
    id SERIAL PRIMARY KEY,
    first_point PointType NOT NULL,
    second_point PointType NOT NULL,
    CONSTRAINT valid_rectangle CHECK (first_point.x < second_point.x AND first_point.y < second_point.y)
);

/*To create a rectangle*/
INSERT INTO Rectangle(first_point, second_point) VALUES ('(1.0, 2.0)', '(4.0, 4.0)');

/*
c) Create a new table named Triangle. A triangle is identified by its primary key id, and
contains three points of type PointType. Ensure a valid triangle can be created using the
three points provided.
*/

CREATE TABLE Triangle(
    id SERIAL PRIMARY KEY,
    first_point PointType NOT NULL,
    second_point PointType NOT NULL,
    third_point PointType NOT NULL,
    CONSTRAINT valid_triangle CHECK ( NOT(first_point.x = second_point.x AND first_point.x = third_point.x) OR NOT(first_point.y = second_point.y AND first_point.y = third_point.y))
);

/*To create a triangle*/
INSERT INTO Triangle(first_point, second_point, third_point) VALUES (ROW(1.0, 1.0), ROW(2.0, 2.0), ROW(3.0, 1.0)); --a valid triangle

INSERT INTO Triangle(first_point, second_point, third_point) VALUES (ROW(1.0, 1.0), ROW(1.0, 2.0), ROW(1.0, 3.0)) -- an invalid triangle because of collinearity