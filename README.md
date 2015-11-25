# houston

Houston allows you to create command-line commands for NodeJS. Inspired by Symfony console component

# Installation

```sh
$ npm install --save houston
```

# Your first command

./commands/TestCommand.coffee

```coffee
BaseCommand = require("houston").Command

class TestCommand extends BaseCommand

    name: 'test:command'
    description: 'Test command'

    execute: ()->
        console.log 'executed!'

module.exports = new TestCommand
```

# Run commands

First, create your console executable file:

```sh
$ vim houston
```

Add your commands to the houston:

```coffee
#!/usr/bin/env coffee

console = require("houston").console

commandList = []

commandList.push( require("./commands/TestCommand.coffee") )

console(commandList)
```

Make houston executable

```sh
$ chmod +x houston
```

Run:

```sh
$ ./houston test:command
```

# Add run options to the command

```coffee
BaseCommand = require("houston").Command

class TestCommand extends BaseCommand

    name: 'test:command'
    description: 'Test command'
    options: [
        {
            option: "-f, --force"
            description: "Force execute flag"
        }
    ]

    execute: (param, options)->
        console.log 'force:', options.force
        console.log 'executed!'

module.exports = new TestCommand
```

Run:

```sh
$ ./houston test:command -f
```

Result:

```sh
$ ./houston test:command -f
force: true
executed!
```

# Handle command argument:

```coffee
BaseCommand = require("houston").Command

class TestCommand extends BaseCommand

    name: 'test:command'
    description: 'Test command'
    options: [
        {
            option: "-f, --force"
            description: "Force execute flag"
        }
    ]

    execute: (param, options)->
        console.log 'argument:', param
        console.log 'executed!'

module.exports = new TestCommand
```

```sh
$ ./houston test:command passedArgument
```

Result:

```sh
$ ./houston test:command passedArgument
argument: passedArgument
executed!
```
