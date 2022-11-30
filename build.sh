#2022-11-23 只是适用于linux
#!/bin/bash
#!/bin/bash
echo '构造诗词语料库-begin'
# ipath=$1  # 无默认值
ipath=${1:-Poetry}  # 设置默认值为/default_arg1
opath=${2:-poetry.csv}  # 设置默认值为/default_arg2
opath_cut=${3:-poetry.csv_cut}  # 设置默认值为/default_arg3
# arg4=${4:-default_arg4}  # 设置默认值为/default_arg4
# echo $ipath $$opath $arg3 $arg4

# cat $ipath/*.csv > $opath
cat *.csv > $opath
# 清理冗余标题，修改第二行到最后一行
sed -i '' '/"题目","朝代","作者","内容"/{2,$d}' $opath

echo '构造诗词语料库-done'
# 
# 修正正文中的[,]to[，] [\r","]to[","];整理错误的分行数据格式
sed -i ' ' -e 's/"\n","/","/g;s/","/"|"/g;s/,/，/g;s/"|"/","/g' $opath
# python huggingface/tokenizer/jieba_cut_file.py $opath
# 修正[" ][ "]to["][""]
# sed -i -e 's/" /"/g;s/ "/"/g' $opath_cut

# more poetry.csv_cut
python -c "
from datasets import load_dataset, DatasetDict
datasets = load_dataset('csv', data_files='poetry.csv_cut')
#拆分测试数据集
dataset=datasets["train"].train_test_split(test_size=0.1)
dataset['train']
dataset['test']
dataset['train'][0]['内容']
dataset['train'][1]['内容']
"
# import jieba
# jieba.lcut(dataset['train'][0]['内容'])

# cat *.csv >poetry.txt
# awk '{if (length(max)<length()) max=$0}END{print length(max)}'  poetry.txt
# rm poetry.txt