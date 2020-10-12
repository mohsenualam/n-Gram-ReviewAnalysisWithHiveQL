wget https://s3.amazonaws.com/hipicdatasets/ratings_2012.txt
wget https://s3.amazonaws.com/hipicdatasets/ratings_2013.txt
wget https://s3.amazonaws.com/hipicdatasets/products.tsv

hdfs dfs -mkdir ratings
hdfs dfs -put ratings_2012.txt /user/malam/ratings/

hdfs dfs -mkdir dualcore
hdfs dfs -put ratings_2013.txt dualcore

hdfs dfs -mkdir products
hdfs dfs -put products.tsv /user/malam/products/

hdfs dfs -ls -h products dualcore ratings

hdfs dfs -chmod -R o+w .
