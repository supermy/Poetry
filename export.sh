echo '构造诗词语料库-begin'
cat *.csv > poetry.txt
sed -i '/"题目","朝代","作者","内容"/d' poetry.txt
sed -i 's/ /./g' poetry.txt
sed -i 's/","/ /g' poetry.txt
sed -i 's/"//g' poetry.txt
echo '构造诗词语料库-done'
