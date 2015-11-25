errorHandler = (error)->
    console.log("================= Handled error =================")
    console.log(error.stack)
    console.log("================= Handled error =================")

module.exports = (app, commandsList = [], settings = {})->
    commandsRegistry = require("./commandsRegistry.coffee")

    commandsRegistry.registryCommandsArray(commandsList)

    commands = commandsRegistry.getCommands()

    for command in commands
        commandDetails = command.init.call(command)

        actionErrorHandlerWrapper = (actionDetails)->
            (param, options)->
                actionDetails.action.call(actionDetails.action, [param, options, settings[actionDetails.name]])
                .catch(errorHandler)

        preparedCommand = app
            .command(commandDetails.actionSignature)
            .description(commandDetails.description)
            .action(actionErrorHandlerWrapper(commandDetails))

        for option in commandDetails.options
            preparedCommand.option(option.option, option.description)
