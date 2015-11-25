fs = require("fs")

process.on("uncaughtException", (err)->
    console.log("Unhandled error: #{err}")
);

module.exports = (optionsPath)->
    rawOptions = fs.readFileSync(optionsPath)

    options = JSON.parse(rawOptions)

    commander = require("commander")

    zBoot = require("./commands/zBoot.coffee")

    commander.version('0.1')

    zBoot(commander, options)

    unless process.argv.length > 2
        commander.outputHelp()

    commander.parse(process.argv)
