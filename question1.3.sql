-- What is the area of the rectangle with id 3

SELECT doc ->> 'area' AS Area
FROM GeometryJSON
WHERE type = 'Rectangle' AND id = 3

-- What is the average cicumference of all triangles

SELECT AVG((doc ->> 'cicumference') ::NUMERIC) AS Average
FROM GeometryJSON
WHERE type = 'Triangle';

-- Which triangles and rectangles have the same area

WITH TraingleAreas AS (
    SELECT id, 'Triangle' AS type, (doc ->> 'area')::NUMERIC AS area
    FROM GeometryJSON
    WHERE type = 'Triangle'
)

RectangleAreas AS (
    SELECT id, 'Rectangle' AS type, (doc ->> 'area')::NUMERIC AS area
    FROM GeometryJSON
    WHERE type = 'Rectangle'
)

SELECT id, type
FROM TraingleAreas
WHERE area IN (SELECT area FROM RectangleAreas)
UNION
SELECT id, type
FROM RectangleAreas
WHERE area IN (SELECT area FROM TraingleAreas)