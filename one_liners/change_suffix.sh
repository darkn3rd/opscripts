# move files w/ suffix ending in .cc to have suffix ending in .cpp
for FILE in *.cc; do mv ${FILE} ${FILE%.cc}.cpp; done
