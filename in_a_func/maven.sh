# Prereq: Maven should be installed `brew install maven` (2016-01)
mvn_environment() {
  export M2_HOME=/usr/local/Cellar/maven/3.3.9
  export MAVEN_OPTS="-Xms256m -Xmx512m"
  export M2=$M2_HOME/bin
  export PATH=$M2:$PATH
}
