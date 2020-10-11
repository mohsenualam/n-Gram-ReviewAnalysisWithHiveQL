CREATE EXTERNAL TABLE IF NOT EXISTS ratings (posted TIMESTAMP, cust_id INT, prod_id INT , rating TINYINT, message STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' LOCATION '/user/malam/ratings';
describe ratings;
select count(*) from ratings;


LOAD DATA INPATH '/user/malam/dualcore/ratings_2013.txt' INTO TABLE ratings;
select count(*) from ratings;


CREATE EXTERNAL TABLE products (prod_id INT, brand STRING, name STRING, price INT, cost INT, shipping_wt INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' LOCATION '/user/malam/products';

SELECT prod_id, FORMAT_NUMBER(avg_rating, 2) AS avg_rating FROM (SELECT prod_id, AVG(rating) AS avg_rating, COUNT(*) AS num FROM ratings GROUP BY prod_id) rated WHERE num >= 50 ORDER BY avg_rating DESC LIMIT 1;

SELECT prod_id, FORMAT_NUMBER(avg_rating, 2) AS avg_rating FROM (SELECT prod_id, AVG(rating) AS avg_rating, COUNT(*) AS num FROM ratings GROUP BY prod_id) rated WHERE num >= 50 ORDER BY avg_rating ASC LIMIT 1;


SELECT SENTENCES(LOWER(message)) AS bigrams FROM ratings WHERE prod_id = 1274673;
SELECT NGRAMS(SENTENCES(LOWER(message)), 2, 5) AS bigrams FROM ratings WHERE prod_id = 1274673;
SELECT EXPLODE(NGRAMS(SENTENCES(LOWER(message)), 2, 5)) AS bigrams FROM ratings WHERE prod_id = 1274673;
SELECT EXPLODE(NGRAMS(SENTENCES(LOWER(message)), 3, 5)) AS trigrams FROM ratings WHERE prod_id = 1274673;


SELECT message FROM ratings WHERE prod_id = 1274673 AND message LIKE '%ten times more%' LIMIT 3;

SELECT distinct(message) FROM ratings  WHERE prod_id = 1274673 AND message LIKE '%red%';

select * from products where prod_id = 1274673;

SELECT * FROM products WHERE name LIKE '%16 GB USB Flash Drive%' AND brand='"Orion"';

SELECT context_ngrams(sentences(LOWER(message)), array(null, null), 10) AS onegram FROM ratings;
SELECT EXPLODE(context_ngrams(sentences(LOWER(message)), array(null, null), 10)) AS onegram FROM ratings;
SELECT EXPLODE(context_ngrams(sentences(LOWER(message)), array(null, null), 10)) AS bigram FROM ratings;
SELECT EXPLODE(context_ngrams(sentences(lower(message)), array("red", "one", null, null), 4, 10)) AS snippet FROM ratings;

--"Twitter Sentiment Analysis and n-gram with Hadoop and Hive SQL”, https://gist.github.com/umbertogriffo/a512baaf63ce0797e175