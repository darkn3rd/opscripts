go_nuclear() {
   [[ -z $(docker ps -q) ]] || docker ps -q | xargs docker stop
   [[ -z $(docker ps -aq) ]] || docker ps -aq | xargs docker rm
   [[ -z $(docker images -q) ]] || docker images -q | xargs docker rmi --force
}
