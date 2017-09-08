//
//  GitHubLanguage.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum GitHubLanguage: String {
    case ActionScript
    case C
    case C_Sharp = "C#"
    case C_PlusPlus = "C++"
    case Clojure
    case CoffeeScript
    case CSS
    case Go
    case Haskell
    case HTML
    case Java
    case JavaScript
    case Lua
    case Matlab
    case Objective_C = "Objective-C"
    case Perl
    case PHP
    case Python
    case R
    case Ruby
    case Scala
    case Shell
    case Swift
    case TeX
    case Vim_script

    static var allValues: [GitHubLanguage] {
        return [
            ActionScript,
            C,
            C_Sharp,
            C_PlusPlus,
            Clojure,
            CoffeeScript,
            CSS,
            Go,
            Haskell,
            HTML,
            Java,
            JavaScript,
            Lua,
            Matlab,
            Objective_C,
            Perl,
            PHP,
            Python,
            R,
            Ruby,
            Scala,
            Shell,
            Swift,
            TeX,
            Vim_script
        ]
    }

}
