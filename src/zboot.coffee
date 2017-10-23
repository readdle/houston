errorOutput = (message) ->
    console.log("\x1b[41m%s\x1b[0m", message)

errorHandler = (error)->
    errorOutput("================= Handled error =================")
    errorOutput(error.stack)
    errorOutput("================= Handled error =================")

module.exports = (app, commandsList = [])->
    commandsRegistry = require("./commandsRegistry.coffee")

    commandsRegistry.registryCommandsArray(commandsList)

    commands = commandsRegistry.getCommands()

    for command in commands
        commandDetails = command.init.call(command)

        actionErrorHandlerClosure = (actionDetails)->
            (param, options)->
                callResult = actionDetails.action.call(actionDetails.action, param, options)
                callResult.catch(errorHandler) if callResult? and callResult.catch?

        preparedCommand = app
            .command(commandDetails.actionSignature)
            .description(commandDetails.description)
            .action(actionErrorHandlerClosure(commandDetails))

        for option in commandDetails.options
            preparedCommand.option(option.option, option.description)
