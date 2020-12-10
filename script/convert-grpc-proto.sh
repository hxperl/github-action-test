# Type a script or drag a script file from your workspace to insert its path.
PROTO_SOURCE_PATH="./protobuf"
DESTINATION_ROOT="./gRPC"

# 1. Remove old files.
rm -rf $DESTINATION_ROOT/*

# 2. Find *.proto files recursively.
find $PROTO_SOURCE_PATH -name '*.proto' -print0 | 
    while IFS= read -r -d '' proto_path; do
        # 3. Make destination path.
        TEMP_PATH=`echo "${DESTINATION_ROOT}${proto_path#$PROTO_SOURCE_PATH}"`
        DESTINATION="${TEMP_PATH%/*}/"
        
        # 4. Make folders.
        mkdir -p $DESTINATION
        
        # 5. Generate swift files.
        protoc --proto_path=$PROTO_SOURCE_PATH --grpc-swift_opt=FileNaming=PathToUnderscores,Visibility=Public --grpc-swift_out=$DESTINATION --swift_opt=FileNaming=PathToUnderscores,Visibility=Public --swift_out=$DESTINATION $proto_path

        # Options
        # --proto_path: Root path for proto files for `import`.
        # --grpc-swift_opt: gRPC converting option.
        # --grpc-swift_out: gRPC output destination.
        # --swift_opt: pb converting option.
        # --swift_out: pb output destination.
    done

