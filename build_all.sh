#!/bin/bash
for i in `ls src | grep \.sh$`;
do
  name=${i%.*}
  shc -f src/$i -o target/$name
  sudo cp target/$name /usr/local/bin/
done
