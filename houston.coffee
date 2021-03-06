fs = require("fs")

process.on("uncaughtException", (err)->
    console.log("Unhandled error: #{err}")
);

module.exports.Command = require("./src/command.coffee")

module.exports.console = (commandsList = [])->
    commander = require("commander")

    zBoot = require("./src/zboot.coffee")

    commander.version('0.1')

    zBoot(commander, commandsList)

    unless process.argv.length > 2
        commander.outputHelp()

    commander.parse(process.argv)
