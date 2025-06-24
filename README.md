# OBF - A brainf\*ck interpreter in Odin

This is a small Brainf\*ck interpreter made to try out [odin-lang](github.com/odin-lang/Odin)

## How to build

You need the Odin compiler to build this.
When that is installed, clone this repo:

```sh
$ git clone https://github.com/AtleSkaanes/obf
```

Then build it like this:

```sh
$ cd obf
$ odin build ./src -out:obf
```

## Usage

Create a file with the brainf\*ck code you want to run.
An example could be this Hello World code:

```bf
>++++++++[<+++++++++>-]<.>++++[<+++++++>-]<+.+++++++..+++.>>++++++[<+++++++>-]<+
+.------------.>++++++[<+++++++++>-]<+.<.+++.------.--------.>>>++++[<++++++++>-
]<+.
```

Then to run it, just give the path to the program, as its first argument

```sh
$ obf [FILE]
```
