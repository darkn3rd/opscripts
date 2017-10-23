# pipe each line to while read filter construct
find . -name *.cc | while read FILE; do mv ${FILE} ${FILE%.cc}.cpp; done
