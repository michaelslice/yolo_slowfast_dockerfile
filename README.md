# YOLO SlowFast Dockerfile

<img src="./output.gif"/>

## Prerequisites  
- Install [Docker](https://www.docker.com/).
- Ensure you have an NVIDIA GPU.

## Usage  

### Pull the Image  
```sh
docker pull ghcr.io/michaelslice/yolo_slowfast_dockerfile:latest
```

### Run the Image  
Run the container in interactive mode with GPU support:
```sh
docker run -it --gpus all ghcr.io/michaelslice/yolo_slowfast_dockerfile:latest
```

### Process a Video File  
Inside the running container, execute the Python script:
```sh
python3 yolo_slowfast.py --input /files/4.mp4
```
Alternatively, process another video file by specifying a different path:
```sh
python3 yolo_slowfast.py --input <path_to_video>
```

### Copy Output File from Container to Local Machine  
1. List running containers:
```sh
docker ps
```
2. Copy the output file from the container to your current directory:
```sh
docker cp <container-id>:/app/output.mp4 $(pwd)
```

#### Example (Windows)  
```sh
docker cp 0ccf26625a6a:/app/output.mp4 $(pwd)
```

---

## Alternatively, Build from Source  
To build the image manually from the source code:
```sh
git clone https://github.com/michaelslice/yolo_slowfast_dockerfile.git
cd yolo_slowfast_dockerfile
docker build -t yolo_slowfast .
```
Then, run the container with GPU support:
```sh
docker run -it --gpus all yolo_slowfast
```

### Process a Video File  
Inside the running container, execute:
```sh
python3 yolo_slowfast.py --input /files/4.mp4
```
Or specify another video path:
```sh
python3 yolo_slowfast.py --input <video-path-in-docker>
```

### Copy Output File from Container to Local Machine  
1. List running containers:
```sh
docker ps
```
2. Copy the output file from the container to your current directory:
```sh
docker cp <container-id>:/app/output.mp4 $(pwd)
```
### Notes  
- Replace `<container-id>` with the actual ID obtained from `docker ps`.
- Ensure the input file is correctly placed inside `/files` before running the script.

## Resources
- [YoloV5](https://github.com/ultralytics/yolov5)
- [DeepSort](https://github.com/ZQPei/deep_sort_pytorch)
- [Yolo SlowFast](https://github.com/wufan-tb/yolo_slowfast)

