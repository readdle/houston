commands = []

module.exports.registryCommandsArray = (commandsArrayPath)->
    commandsArray = require(commandsArrayPath)
    commands = commands.concat(commandsArray)

module.exports.getCommands = ()-> commands
