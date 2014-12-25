#!/bin/sh
for FILE in *.py; do sed -i '1c #!/usr/bin/env python' ${FILE}; done
