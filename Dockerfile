# ベースイメージの指定
FROM ubuntu:22.04

LABEL maintainer="your-email@example.com"

# タイムゾーンの設定
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    lsb-release \
    vim

# Autowareのリポジトリをクローン
RUN git clone https://github.com/autowarefoundation/autoware.git ~/autoware

# # 依存関係のインストール
WORKDIR /root/autoware
RUN yes | ./setup-dev-env.sh --no-nvidia --no-cuda-drivers

# # ROS2パッケージのインストール
RUN mkdir src
RUN curl -s https://raw.githubusercontent.com/autowarefoundation/autoware/main/autoware.repos -o autoware.repos
RUN vcs import src < autoware.repos
RUN /bin/bash -c "source /opt/ros/humble/setup.bash" \ && rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
RUN colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

# コンテナ実行時のデフォルトのコマンド
CMD ["/bin/bash"]
