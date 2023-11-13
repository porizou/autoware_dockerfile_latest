# autoware_dockerfile

This Dockerfile is used to set up an Autoware environment based on Ubuntu 22.04 without GPU.

https://github.com/autowarefoundation/autoware


# Usage


## Create Docker Image

```bash
docker build -t autoware-no-cuda .
```

## Creating and launching docker containers

```bash
xhost +local:docker
docker compose up
```

```bash
~/autoware_dockerfile_latest$ docker compose up
[+] Running 1/1
 ✔ Container autoware  Recreated                                                                                                                                                                       0.1s 
Attaching to autoware
```

## Run Planning simulation


- Launch Planning simulation

```bash
docker exec -it autoware bash
ros2 launch autoware_launch planning_simulator.launch.xml map_path:=$HOME/autoware_map/sample-map-planning vehicle_model:=sample_vehicle sensor_model:=sample_sensor_kit
```



- Start the ego vehicle

```bash
ros2 service call /api/operation_mode/change_to_autonomous autoware_adapi_v1_msgs/srv/ChangeOperationMode {}
```

https://autowarefoundation.github.io/autoware-documentation/main/tutorials/ad-hoc-simulation/planning-simulation/

