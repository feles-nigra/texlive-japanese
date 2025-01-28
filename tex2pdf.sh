#!/bin/sh

file=$1

yes "quit()" | ptex2pdf -l $file > temp.log 2> error.log

if grep -q "Error" "temp.log"; then
  cat temp.log > latex_error
  awk '/Error/{flag=1} flag' temp.log | head
fi

ls | grep -e 'dvi$' -e '.aux$' -e '.nav$' -e '.log$' -e '.out$' -e '.snm$' -e '.toc$' | xargs rm
