#!/usr/bin/env bash
set -x
if [ -z ${1+x} ]; then 
  echo "Usage: child-image.sh parent-image-tag"; 
  exit 1;
else
  echo "Testing child of '$1'"; 
fi

cat > Dockerfile << EOF
FROM $1
CMD ["/bin/bash"]

EOF

docker build -t $1-test .
docker run --rm -it $1-test cat /opt/oracle/config/sqlnet.ora


rm Dockerfile