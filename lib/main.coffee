fs = require 'fs'

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
        self = atom.packages.getLoadedPackage('spacemacs-syntax')

        atom.config.onDidChange 'spacemacs-syntax.theme', ({newValue, oldValue}) ->
            themeData = '@import "themes/' + newValue.toLowerCase() + '";'

            fs.writeFile self.path + '/styles/theme.less', themeData, (err) ->
                if !err
                    atom.themes.activateThemes()
