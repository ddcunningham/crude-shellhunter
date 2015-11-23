#!/bin/awk

BEGIN { FS = "\\?><"; bound = 3}
{
  #If line matches shell pattern, and is on the first line, and contains only webshell fields (as seen in every example), clear the line..
  if($0 ~ /<\?php if\(!isset\(\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]\)\).*\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]=1\; \} \?><\?php.*?>/ && NR == 1 && NF < 3) 
    {print "======\n""Removed line 1, as it was all shellcode:",FILENAME,". See diff for changes.\n======" >> "/root/audit/run.log"}
# print "bliggablau" > FILENAME".tmp"}
  #If line matches shell pattern, and is on the first line, modify the file in place, and log what was changed.
  else if($0 ~ /<\?php if\(!isset\(\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]\)\).*\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]=1\; \} \?><\?php.*?>/ && NR == 1 && NF >= 3) 
    {print "======\n""Removed shellcode from line 1:",FILENAME,". See diff for changes.\n======" >> "/root/audit/run.log"; 
      for(i=bound; i<=NF; i++) printf("%s%s%s","<", $(i), i<NF ? OFS : "\n") > FILENAME".tmp" }
  #If line matches shell pattern, but is not on the first line, just log it.
  else if($0 ~ /<\?php if\(!isset\(\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]\)\).*\$GLOBALS\[\"\\x61\\156\\x75\\156\\x61\"\]=1\; \} \?><\?php.*?>/) 
    { print "======\n""Found additional shellcode, logging only:",FILENAME,", line",NR".\n\nShellcode is:", $0"\n======" >> "/root/audit/run.log"; print $0> FILENAME".tmp"}
  else 
    print $0 > FILENAME".tmp"
}

