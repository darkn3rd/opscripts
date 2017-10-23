aws_set() {
  if [ $# -ne 0 ]; then
    export AWS_DEFAULT_PROFILE=$1
  fi
}

aws_get() {
    echo AWS_DEFAULT_PROFILE=${AWS_DEFAULT_PROFILE}
}
