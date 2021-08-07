#!/bin/bash
#批量创建01.sh、02.sh...99.sh
for i in {10..99}
do
	touch $i.sh
	chmod u+x $i.sh
done
for i in {1..9}
do
	touch 0$i.sh
	chmod u+x 0$i.sh
done
