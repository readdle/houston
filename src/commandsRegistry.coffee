commands = []

module.exports.registryCommandsArray = (commandsArray)-> commands = commands.concat(commandsArray)

module.exports.getCommands = ()-> commands
