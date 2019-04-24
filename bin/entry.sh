#!/bin/ash

if [[ "${PLATFORM_FEATURES}" == "generic" ]];then
  echo ">> This container is not optimized for a specific microarchitecture"
else 
  echo ">> This container is optimized for: ${PLATFORM_FEATURES}"
fi
