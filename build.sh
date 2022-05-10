#!/bin/bash

: "${REGISTRY:=docker.io}"
echo "image: ${REGISTRY}/qnib/bench" |tee manifest.yml
echo "manifests:" |tee -a manifest.yml

## Image without optimizations
docker build -t ${REGISTRY}/qnib/plain-featuretest:generic .
docker push ${REGISTRY}/qnib/plain-featuretest:generic
echo "  -" |tee -a manifest.yml
echo "    image: ${REGISTRY}/qnib/plain-featuretest:generic" |tee -a manifest.yml
echo "    platform:" |tee -a manifest.yml
echo "      architecture: amd64" |tee -a manifest.yml
echo "      os: linux" |tee -a manifest.yml

for x in cpu:skylake cpu:broadwell arch:skylake_avx512 arch:zen arch:zen2 arch:zen3 arch:cascadelake;do
  docker build -t ${REGISTRY}/qnib/plain-featuretest:$(echo ${x}|sed -e 's/:/-/') --build-arg=PLATFORM_FEATURES=${x} .
  docker push ${REGISTRY}/qnib/plain-featuretest:$(echo ${x}|sed -e 's/:/-/')
  echo "  -" |tee -a manifest.yml
  echo "    image: ${REGISTRY}/qnib/plain-featuretest:$(echo ${x}|sed -e 's/:/-/')" |tee -a manifest.yml
  echo "    platform:" |tee -a manifest.yml
  echo "      architecture: amd64" |tee -a manifest.yml
  echo "      os: linux" |tee -a manifest.yml
  echo "      features:" |tee -a manifest.yml
  echo "        - ${x}" |tee -a manifest.yml
done

## Image with two features [broadwell,nvcap52]
docker build -t ${REGISTRY}/qnib/plain-featuretest:cpu_broadwell-nvcap_52 --build-arg=PLATFORM_FEATURES="cpu:broadwell,nvcap:5.2" .
docker push ${REGISTRY}/qnib/plain-featuretest:cpu_broadwell-nvcap_52
echo "  -" |tee -a manifest.yml
echo "    image: ${REGISTRY}/qnib/plain-featuretest:cpu_broadwell-nvcap_52" |tee -a manifest.yml
echo "    platform:" |tee -a manifest.yml
echo "      architecture: amd64" |tee -a manifest.yml
echo "      os: linux" |tee -a manifest.yml
echo "      features:" |tee -a manifest.yml
echo "        - cpu:broadwell" |tee -a manifest.yml
echo "        - nvcap:5.2" |tee -a manifest.yml

if [[ ${REGISTRY} == "docker.io" ]];then
  if [[ "X${DOCKER_USER}" == "X" ]];then
    echo -ne "Please provide your DOCKERHUB user: "
    read DOCKER_USER
  fi
  if [[ "X${DOCKER_PASSWD}" == "X" ]];then
    echo -ne "Please provide your DOCKERHUB password for ${DOCKER_USER}: "
    read -s DOCKER_PASSWD
  fi
  echo ">> manifest-tool --username ${DOCKER_USER} --password <hidden> push from-spec manifest.yml"
  manifest-tool --username ${DOCKER_USER} --password ${DOCKER_PASSWD} push from-spec manifest.yml
fi
echo ">> manifest-tool --insecure push from-spec manifest.yml"
manifest-tool --insecure push from-spec manifest.yml

