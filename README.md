# plain-manifestlist
ManifestList image

## Manifest-tool

To aggregate a couple of images into a manifest list `docker manifest` can be used. As of today it only supports `<OS>/<ARCH>/<ARCH_VARIANT>` and no platform feature.
Therefore `manifest-tool` must be used.

This manifest description...

```
image: docker.io/qnib/plain-manifestlist
manifests:
  -
    image: docker.io/qnib/plain-featuretest:cpu-skylake
    platform:
      architecture: amd64
      os: linux
      features:
        - cpu:skylake
  -
    image: docker.io/qnib/plain-featuretest:cpu-broadwell
    platform:
      architecture: amd64
      os: linux
      features:
        - cpu:broadwell
  -
    image: docker.io/qnib/plain-featuretest:cpu_broadwell-nvcap_52
    platform:
      architecture: amd64
      os: linux
      features:
        - cpu:broadwell
        - nvcap:5.2
```
