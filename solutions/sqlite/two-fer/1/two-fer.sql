-- Schema: CREATE TABLE "twofer" ("input" TEXT, "response" TEXT);
-- Task: update the twofer table and set the response based on the input.
UPDATE twofer 
SET response = 'One for ' || CASE input WHEN '' THEN 'you' ELSE input END || ', one for me.';