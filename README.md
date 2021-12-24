# nox

Nox is a process manager for Procfiles written in Crystal.
The reason for its existence is so that [Lucky](https://luckyframework.org/) can ship with a built-in process runner instead of requiring one to be installed.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     nox:
       github: matthewmcgarvey/nox
   ```

2. Run `shards install`

## Command Line Installation

- Clone the repo
- Run `shards build nox`
- Run `mv bin/nox /usr/local/bin` or to a different location that is on your `$PATH`

## Command Line Usage

```
nox --help # print help info

nox start # run Procfile in current directory

nox start -f Procfile.dev # run Procfile.dev in current directory
```

## Usage

```crystal
require "nox"

Nox.run("Procfile") # runs the Procfile and exits when the processes are all done or the program is interrupted (ctrl-c)
```

## Contributing

1. Fork it (<https://github.com/matthewmcgarvey/nox/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Matthew McGarvey](https://github.com/matthewmcgarvey) - creator and maintainer
