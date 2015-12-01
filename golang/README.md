# Golang at Clever

## Golang versions

All golang services (with some exceptions, like Heka) at Clever should be on go-1.5.


## Docker Images

#### drone

`clever/drone-go:1.5`

#### runtime

Drone should build your executable and it should be copied into Docker:

- `gliderlabs/alpine:3.2`
  - smaller image footprint
  - requires additional build configuration
  - see [catapult/Makefile](https://github.com/Clever/catapult/blob/master/Makefile) as an example
- `debian:jessie`
  - larger image
  - no special configuration needed
  - suggested if you have any dependencies you exec
  - see [shorty/Dockerfile](https://github.com/Clever/shorty/blob/master/Dockerfile) as an example

## Dependencies

Both `godep` and `glide` are used to manage golang dependencies.

### Godeps

See the [Godeps documentation in Google docs](https://docs.google.com/a/clever.com/document/d/1YZg2S7v1bir3MG1YvswAD2Y0KrsuDr-NCr6pPG2ycEM/edit?usp=sharing)

### Glide

See the [Glide documentation](./glide.md)
