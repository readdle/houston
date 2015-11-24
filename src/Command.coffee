class Command

    commandName: null
    commandDescription: null
    commandOptions: []

    throwError: (message)->
        throw new Error(message)

    init: ->
        unless @commandName?
            throw new Error('Command name is not specified. Please, override it on your command')

        unless @commandDescription?
            throw new Error('Command description is not specified. Please, override ir on your command')

        action: @execute, description: @commandDescription, options: @commandOptions, actionSignature: @commandName, name: @commandName

    execute: ->
        console.log('override it!')

module.exports = Command
