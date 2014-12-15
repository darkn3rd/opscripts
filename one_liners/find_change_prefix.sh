find . -name *.ts | while read FILE; do mv ${FILE} ${FILE%.ts}.dart; done
