#!/bin/bash
rm list_tmp*
pages=`wget "http://www.cyklistesobe.cz/api/issues/?page=1&amp" -S -O list_tmp_1.json 2>&1 | grep "X-Total-Pages" | sed "s/.*: //"`
for page in `seq 2 $pages`; do
     wget http://www.cyklistesobe.cz/api/issues/?page=$page -O list_tmp_$page.json
done
jq -s 'reduce .[] as $dot ({"type":"FeatureCollection"}; .features += $dot.features)' list_tmp_*.json > list.json
