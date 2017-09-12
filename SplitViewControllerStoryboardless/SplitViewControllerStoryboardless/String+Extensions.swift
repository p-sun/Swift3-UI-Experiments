//
//  String+Extensions.swift
//  SplitViewControllerStoryboardlessSimple
//
//  Created by Pei Sun on 2017-09-09.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation

extension String {
    // Returns the String between two characters, excluding the delimiters.
    func substring(between start: Character, until end: Character) -> String? {
        guard contains(end.description) else { return nil }
        
        if let match = range(of: "(?<=\(start))[^\(end)]+", options: .regularExpression) {
            return substring(with: match)
        }
        return nil
    }
}
