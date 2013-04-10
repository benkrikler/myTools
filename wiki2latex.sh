#! /bin/bash

for FILE in $@; do
#OUTFILE="body.tex"
OUTFILE="$(echo $FILE|sed -e 's!\..*!.tex!')"
echo $FILE $OUTFILE

IN_LIST=0
#cat $OUTFILE| while read LINE; do
#head -25 "$FILE"| while read LINE; do
cat "$FILE"| while read LINE; do

if [ $IN_LIST == 0 ]; then
    echo "$LINE"| grep -e '^\* '>/dev/null
    [ $? -eq 0 ] && echo \\begin{itemize} && IN_LIST=1
else 
    echo "$LINE"| grep -e '^\* '>/dev/null
    [ $? -eq 1 ] && echo \\end{itemize} && IN_LIST=0
fi
     echo "$LINE"| sed -e "s!\*!\\\\item!g
     s!\[\([^ ]*\)#\([^ ]*\)]!\1/\2!g
     s!\[[^ ]*[#]*[^ ]* \([^ ]*\)\]!\1!g 
     s!\[[^ ]*[#]*[^ ]* \(.*\)\]!\1!g 
     s!\[\./\w*!!g
     s!====\(.*\)====!\\\\subsubsection\\*{\1}!g
     s!==\([^=]*[^=]*\)==!\\\\subsection{\1}!g
     s!=\([^=]*[^=]*\)=!\\\\section{\1}!g
     s!#!\\\\#!g
     s!'''\([^ ]*\)'''!{\\\\bf \1}!g
     s!\"\<\(.*\)\>\"!\`\`\1''!g
     s!''\<\(.*\)\>''!\\\\emph{\1}!g
     s!\]!!g
     "

done |tee $OUTFILE
done
