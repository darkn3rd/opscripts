# subshell find for file listing
for FILE in $(find . -name *.cc); do echo mv ${FILE} ${FILE%.cc}.cpp; done
