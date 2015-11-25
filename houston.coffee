fs = require("fs")

process.on("uncaughtException", (err)->
    console.log("Unhandled error: #{err}")
);

module.exports = (commandsList = [], optionsPath = '')->
    options = {}

    if fs.existsSync(optionsPath)
        rawOptions = fs.readFileSync(optionsPath)

        options = JSON.parse(rawOptions)

    commander = require("commander")

    zBoot = require("./src/zBoot.coffee")

    commander.version('0.1')

    zBoot(commander, commandsList, options)

    unless process.argv.length > 2
        commander.outputHelp()

    commander.parse(process.argv)
