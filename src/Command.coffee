class Command

    name: null
    description: null
    options: []

    throwError: (message)->
        throw new Error(message)

    init: ->
        unless @name?
            throw new Error('Command name is not specified. Please, override it on your command')

        unless @description?
            throw new Error('Command description is not specified. Please, override it on your command')

        action: @execute, description: @description, options: @options, actionSignature: @name, name: @name

    execute: ->
        console.log('override it!')

module.exports = Command
