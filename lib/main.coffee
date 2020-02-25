fs = require 'fs'
{CompositeDisposable} = require 'atom'

module.exports =
    config:
        theme:
            type: 'string',
            description: "Set your default syntax theme.",
            enum: [
                'Dark',
                'Light'
                ],
            default: 'Dark'

    activate: (state) ->
        @disposables = new CompositeDisposable
        self = atom.packages.getLoadedPackage(require('../package.json').name)

        @disposables.add atom.config.onDidChange "#{self.name}.theme", ({newValue, oldValue}) ->
            themeData = '@import "themes/' + newValue.toLowerCase() + '";'

            fs.writeFile "#{self.path}/styles/theme.less", themeData, (err) ->
                if !err
                    atom.themes.activateThemes()

    deactivate: ->
        @disposables.dispose()
