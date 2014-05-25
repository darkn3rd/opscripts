# generate 10 random characters (alphanumeric) using fold & sed
numchars=10; tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w $numchars | sed 1q
