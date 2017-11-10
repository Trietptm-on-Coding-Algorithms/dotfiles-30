

-- lsof -nPi | awk 'NR>1 { print $1 ":" $2 "\t" $9 "\t"$10 }'
