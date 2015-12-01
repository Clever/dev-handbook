# Golang at Clever

## Onboarding

It is suggested that you introduce yourself to Golang by first completing [the tour](https://tour.golang.org/welcome/1).
Most topics are covered to help you hit the ground running.

Most Go idioms can then be learned by reading [Effective Go]Effective Go](https://golang.org/doc/effective_go.html).
This is highly suggested before you begin writing Go code for production.

[The Go Blog](http://blog.golang.org/) contains many useful articles going over how to use several essential Go features like go-routines, JSON, constants, etc.


## Golang versions

All golang services written by Clever should be on Go 1.5.
Some 3rd-party tools that we use, such as Heka, are not on Go 1.5.


## Best Practices

### Sets

Sets are typically best represented by a `map[key type]bool` structure where every boolean value is set to `true`.
Since maps return the default value of the value type when a key does not exist, they will return `false` (the default boolean value) when accessed with a nonexistent key.
This allows you to use code like:

```go
crew := map[string]bool{
    "Malcom":   true,
    "Zoe":      true,
    "Wash":     true,
    "Inara":    true,
    "Jayne":    true,
    "Kaylee":   true,
    "Simon":    true,
    "River":    true,
    "Shepherd": true,
}

// now we can use a map access like a boolean condition
if crew["River"] {
    println("member of the crew!")
}

// alternatively the "comma ok" idiom obfuscates what is happening
if _, isCrew := crew["River"]; isCrew {
    println("member of the crew!")
}
```

- **(suggested)** Full example of bool map set: https://play.golang.org/p/0NngCA8e6t
- Full example of comma ok set: https://play.golang.org/p/OCxq0U7olc
- Full example of slice set: https://play.golang.org/p/0NngCA8e6t



## Docker Images

#### drone

Use `clever/drone-go:1.5` as the `image` to ensure that Go1.5 is already installed.

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

See the [Clever godep documentation](./godep.md).

[Essential Godep](https://docs.google.com/a/clever.com/document/d/1YZg2S7v1bir3MG1YvswAD2Y0KrsuDr-NCr6pPG2ycEM/edit?usp=sharing) for extended instruction.

### Glide

See the [Glide documentation](./glide.md)
