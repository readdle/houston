errorHandler = (error)->
    console.log("================= Handled error =================")
    console.log(error.stack)
    console.log("================= Handled error =================")

module.exports = (app, options)->
    commandsRegistry = require("./commandsRegistry.coffee")

    commandsRegistry.registryCommandsArray(options.commandsListPath) if options.commandsListPath?

    commands = commandsRegistry.getCommands()

    for command in commands
        commandDetails = command.init.call(command)

        actionErrorHandlerWrapper = (actionDetails)->
            (param, options)->
                actionDetails.action.call(actionDetails.action, [param, options])
                .catch(errorHandler)

        preparedCommand = app
            .command(commandDetails.actionSignature)
            .description(commandDetails.description)
            .action(actionErrorHandlerWrapper(commandDetails))

        for option in commandDetails.options
            preparedCommand.option(option.option, option.description)
