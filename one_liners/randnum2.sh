# generate 10 random alphanumeric chars (using dd)
numchars=10; tr -dc 'a-zA-Z0-9' < /dev/urandom | dd bs=$numchars count=1 2> /dev/null
