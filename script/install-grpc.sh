GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[0m'

if which protoc >/dev/null; then
  echo "${RED}swift-protobuf가 이미 설치되어 있습니다.${WHITE}"
else
  echo "${GREEN}swift-protobuf를 설치합니다.${WHITE}"
  brew install swift-protobuf
fi

if which protoc-gen-grpc-swift >/dev/null; then
  echo "${RED}grpc-swift가 이미 설치되어 있습니다.${WHITE}"
else
  echo "${GREEN}grpc-swift를 설치합니다.${WHITE}"
  git clone -b 1.0.0-alpha.11 https://github.com/grpc/grpc-swift.git
  cd grpc-swift && make plugins
  sudo cp protoc-gen-grpc-swift /usr/local/bin
  cd .. && rm -rf grpc-swift
fi

echo "${GREEN}swift-protobuf & grpc-swift 설정이 완료되었습니다.${WHITE}"