aws_list() {
  PROFILES=$(grep profile ${HOME}/.aws/config | sed 's/profile //' | tr -d '[]')
  for PROFILE in ${PROFILES}; do
     if [[ ${PROFILE} == ${AWS_DEFAULT_PROFILE} ]]; then
       SEL="=>"
     else
       SEL="  "
     fi
     printf " ${SEL} %s\n" ${PROFILE};
  done
}
