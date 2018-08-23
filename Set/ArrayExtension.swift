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


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
