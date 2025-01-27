#!/bin/sh

ptex2pdf -l $1 
ls | grep -e '.aux$' -e '.nav$' -e '.log$' -e '.out$' -e '.snm$' -e '.toc$' | xargs rm
