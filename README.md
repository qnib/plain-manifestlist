# plain-manifestlist
ManifestList image

## Manifest-tool

To aggregate a couple of images into a manifest list `docker manifest` can be used. As of today it only supports `<OS>/<ARCH>/<ARCH_VARIANT>` and no platform feature.
Therefore `manifest-tool` must be used.

This manifest description...

```
image: qnib/plain-manifestlist
manifests:
  -
    image: qnib/plain-featuretest:test1
    platform:
      architecture: amd64
      os: linux
      features:
        - test1
  -
    image: qnib/plain-featuretest:test2
    platform:
      architecture: amd64
      os: linux
      features:
        - test2
  -
    image: qnib/plain-featuretest:test34
    platform:
      architecture: amd64
      os: linux
      features:
        - test3
        - test4

```
