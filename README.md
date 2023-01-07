# BQN Koans

These koans guide you to learning the basics of BQN.  They are inspired by the [lisp koans](https://github.com/google/lisp-koans) and
the [Elm decoder koans](https://github.com/dillonkearns/elm-decoder-koans).

## Getting Started

Install a [BQN interpreter](https://mlochbaum.github.io/BQN/running.html), such as [cbqn](https://github.com/dzaima/CBQN).

Once installed, you can run the koans a single time by running the `contemplate.bqn` file:

```bash
cbqn contemplate.bqn
```

If you would like to watch the koans for changes, you can make use of [inotify-tools](https://github.com/inotify-tools/inotify-tools):

```bash
inotifywait -mre modify koans/ |
while read file directory action; do
  cbqn contemplate.bqn
done
```

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for details.

## License

Apache 2.0; see [`LICENSE`](LICENSE) for details.

## Disclaimer

This project is not an official Google project. It is not supported by
Google and Google specifically disclaims all warranties as to its quality,
merchantability, or fitness for a particular purpose.
