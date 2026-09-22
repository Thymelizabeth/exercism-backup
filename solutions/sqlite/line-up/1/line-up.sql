-- Schema:
-- CREATE TABLE "line-up" (
--   name   TEXT    NOT NULL,
--   number INTEGER NOT NULL,
--   result TEXT
-- );
--
-- Task: Update the line-up table and set the result column based on the name and the number.
UPDATE "line-up"
SET result = concat(
    name, 
    ', you are the ',
    number,
    CASE
    WHEN number % 10 == 1 AND number % 100 != 11 THEN 'st'
    WHEN number % 10 == 2 AND number % 100 != 12 THEN 'nd'
    WHEN number % 10 == 3 AND number % 100 != 13 THEN 'rd'
    ELSE 'th' END,
    ' customer we serve today. Thank you!');