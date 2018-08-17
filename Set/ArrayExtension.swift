//
//  ArrayExtension.swift
//  Set
//
//  Created by Yves Kurz on 15.08.18.
//  Copyright © 2018 Yves Kurz. All rights reserved.
//

import Foundation

extension Array
{
    mutating func removeRandom(numberOfElements:Int) ->  [Element] {
        assert(numberOfElements > 0, "'numberOfCards must be bigger than 0")
        assert(numberOfElements <= self.count, "Cannot remove more elements than array contains")
        var removedElements = [Element]()
        for _ in 1...numberOfElements {
            removedElements.append(self.remove(at: Int(arc4random_uniform(UInt32(self.count)))))
        }
        return removedElements
    }
}
