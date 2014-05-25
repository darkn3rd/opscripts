# move files w/ suffix ending in .cc to have suffix ending in .cpp
for f in *.cc; do mv $f ${f%.cc}.cpp; done
