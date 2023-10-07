# Usage

```bash
docker build -t autoware-no-cuda .
```


```bash
xhost +local:docker
docker run -it --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name autoware autoware-no-cuda:latest
```


