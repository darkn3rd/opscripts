docker_space() {
   docker images | grep -v SIZE | grep -o '[^ ]*$' \
     | awk '/MB/ { sum += $1/1024 }
            /GB/ { sum += $1*1 }
            END { printf "Docker Images Space Usage: %0.2f GB\n", sum}'

}
