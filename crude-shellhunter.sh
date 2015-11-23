#!/bin/bash
logprefixpath="/var/log/crude-shellhunter"
mkdir ${logprefixpath}
cat $1 | xargs -I placeholder sh -c "awk -f ~/audit/crude-shellhunter/deshellswebshellsbytheseashore.awk placeholder 2>> ${logprefixpath}/error.log; echo '======' >> ${logprefixpath}/run.log; diff -U 0 placeholder placeholder.tmp >> ${logprefixpath}/run.log ; echo '======' >> ${logprefixpath}/run.log; ; mv placeholder.tmp placeholder" 2> ${logprefixpath}/error.log

