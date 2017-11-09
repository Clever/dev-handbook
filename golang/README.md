# Golang at Clever

## Onboarding

It is suggested that you introduce yourself to Golang by first completing [the tour](https://tour.golang.org/welcome/1).
Most topics are covered to help you hit the ground running.

Most Go idioms can then be learned by reading [Effective Go](https://golang.org/doc/effective_go.html).
This is highly suggested before you begin writing Go code for production.

[The Go Blog](http://blog.golang.org/) contains many useful articles going over how to use several essential Go features like go-routines, JSON, constants, etc.


## Golang versions

All golang services written by Clever should be on Go 1.8.

## Style

The style guides used for Go are [Effective Go](http://golang.org/doc/effective_go.html) and the community [Go style guide](https://code.google.com/p/go-wiki/wiki/CodeReviewComments). There are two tools that can be used to detect common mistakes.

* `go fmt` should be run in any directory that contains go files. It will automatically format the code.
* `golint file.go` should be run for every go file. It will lint the code and return any issues it finds.

Optionally you can have Vim run the linters for you:

```vim
" highlight Go errors
let g:syntastic_go_checkers = ['golint', 'govet']
```


#### Recommended setup

* Makefiles: A Go package should have a Makefile that runs "golint" on all files. See the [sfncli Makefile](https://github.com/Clever/sfncli/blob/master/Makefile) as an example.

- toolchain version check
- dep
- testing
  - gofmt
  - golint
  - go vet
  - go test

* emacs: Go has an official [emacs mode](http://golang.org/misc/emacs/go-mode.el) that ships with a `gofmt` command. To get it to run on save, you can add this to your `.emacs`:

    ```
    (add-hook 'before-save-hook 'gofmt-before-save)
    ```

* sublime: Add [GoSublime](https://github.com/DisposaBoy/GoSublime) for code highlighting and `go fmt` on save.

* vim:
    * The [vim-go](https://github.com/fatih/vim-go) plugin adds a lot of functionality, including `gofmt` on save as well as much more.
    * Alternatively, if `vim-go` is too heavy for you, see the directions [here](https://github.com/golang/go/wiki/IDEsAndTextEditorPlugins). It's strongly advised to set up `gofmt` on save.


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

If you need more than addition and presence methods, please consider using a more full featured set implementation (https://github.com/fatih/set).




## Docker Images

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

We use `dep` to manage golang dependencies. See our [`dep` documentation](./glide.md).


### Deprecated tooling

### Glide

See our [`glide` documentation](./glide.md)

### Godeps

See our [`godeps` documentation](./godep.md).

[Essential Godeps](https://docs.google.com/a/clever.com/document/d/1YZg2S7v1bir3MG1YvswAD2Y0KrsuDr-NCr6pPG2ycEM/edit?usp=sharing) for extended instruction.

