# Dockerize A Software Build System
Please refer to the [tutorial here](https://ravi-chandran.github.io/blog/posts/docker/dockerizing-a-build-system/)

## One-Time Setup
```bash
cd dockerize-tutorial/swbuilder/ 
./build_docker_image.sh
docker image ls  # resulting image will be swbuilder:v1
```

##  Invoking `swbuilder:v1` On The Trivial Project
```bash
cd dockerize-tutorial
./build.sh ~/repos/dockerize-tutorial/example_workdir
```

## Getting To A Shell Inside The Container
```bash
cd dockerize-tutorial
./shell.sh ~/repos/dockerize-tutorial/example_workdir
```
