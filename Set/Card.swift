//
//  Card.swift
//  Set
//
//  Created by Yves Kurz on 15.08.18.
//  Copyright © 2018 Yves Kurz. All rights reserved.
//

import Foundation

struct Card: Equatable
{
    enum Symbol: String, Equatable {
        case square = "■"
        case triangle = "▲"
        case circle = "●"
        static let all = [Symbol.square, .triangle, .circle]
    }
    
    enum Color: Equatable {
        case red
        case blue
        case black
        static let all = [Color.red, .blue, .black]
    }
    
    enum Shading: Equatable {
        case solid
        case striped
        case open
        static let all = [Shading.solid, .striped, .open]
    }
    
    let symbol: Symbol
    let color: Color
    let shading: Shading
    let number: Int
    
    init(symbol:Symbol, color:Color, shading: Shading, number: Int) {
        assert(number > 0 && number < 4, "Invalid card number")
        self.symbol = symbol
        self.color = color
        self.shading = shading
        self.number = number
    }
}
