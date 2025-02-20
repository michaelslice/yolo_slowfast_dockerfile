FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

# Set the working directory
WORKDIR /app

# Update package lists and install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3.8 \
    python3.8-venv \
    python3-pip \
    python3-dev \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment
RUN python3.8 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Clone the repository
RUN git clone https://github.com/wufan-tb/yolo_slowfast.git . && \
    pip3 install --upgrade pip && \
    pip3 install torch==1.12.1+cu113 torchvision==0.13.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113 && \
    pip3 install \
        pytorchvideo \
        scipy \
        pandas \
        numpy \
        requests \
        ultralytics \
        gitpython>=3.1.30 \
        setuptools>=70.0.0 \
        matplotlib>=3.3 \
        opencv-python>=4.1.1 \
        pillow>=10.3.0 \
        psutil \
        PyYAML>=5.3.1 \
        thop>=0.1.1 \
        tqdm>=4.66.3

# Create directory for DeepSort checkpoint
RUN mkdir -p deep_sort/deep_sort/deep/checkpoint/
RUN mkdir -p /files

# Copy deep sort parameters
COPY ./deepsort_parameters deep_sort/deep_sort/deep/checkpoint/
COPY ./data /files

# Set environment variables for CUDA
ENV CUDA_HOME=/usr/local/cuda
ENV PATH=${CUDA_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}