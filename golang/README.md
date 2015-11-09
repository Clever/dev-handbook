# Golang at Clever

## Golang versions

All golang services (with some exceptions) at Clever should be on go-1.5.


## Docker Images

#### drone

`clever/drone-go:1.5`

#### runtime

  - `gliderlabs/alpine:3.2`
    - smaller image footprint
    - requires additional build configuration
    - see [catapult/Makefile](https://github.com/Clever/catapult/blob/master/Makefile) as an example
  - `google/debian:wheezy`
    - larger image
    - no special configuration needed


## Dependencies

Both `godeps` and `glide` are used to manage golang dependencies.

### Godeps

See the [Godeps documentation in Google docs](https://docs.google.com/a/clever.com/document/d/1YZg2S7v1bir3MG1YvswAD2Y0KrsuDr-NCr6pPG2ycEM/edit?usp=sharing)

### Glide

See the [Glide documentation](./glide.md)
