//
//  Set.swift
//  Set
//
//  Created by Yves Kurz on 15.08.18.
//  Copyright © 2018 Yves Kurz. All rights reserved.
//

import Foundation

struct Set
{
    private var deck = [Card]()
    
    var cardsOnTable = [Card]()
    private var selectedCards = [Card]()
    var score = 0
    
    var selectedCardCount: Int {
        get {
            return selectedCards.count
        }
    }
    
    private mutating func createDeck() {
        for symbol in Card.Symbol.all {
            for color in Card.Color.all {
                for shading in Card.Shading.all {
                    for number in 1...3 {
                        deck.append(Card(symbol: symbol, color: color, shading: shading, number: number))
                    }
                }
            }
        }
    }
    
    func cardIsSelected(card: Card) -> Bool {
        return selectedCards.contains(card)
    }
    
    private mutating func drawInitialTwelveCards(){
        cardsOnTable += deck.removeRandom(numberOfElements: 12)
    }
    
    init() {
        createDeck()
        drawInitialTwelveCards()
    }
    
    var canDealThree: Bool {
        get { return !deck.isEmpty }
    }
    
    func isMatch() -> Bool {
        if selectedCards.count != 3 {
            return false
        }
        
        if ((selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color) ||
            (selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[0].color != selectedCards[2].color)) &&
            ((selectedCards[0].number == selectedCards[1].number && selectedCards[1].number == selectedCards[2].number) ||
                (selectedCards[0].number != selectedCards[1].number && selectedCards[1].number != selectedCards[2].number && selectedCards[0].number != selectedCards[2].number)) &&
            ((selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading) ||
                (selectedCards[0].shading != selectedCards[1].shading && selectedCards[1].shading != selectedCards[2].shading && selectedCards[0].shading != selectedCards[2].shading)) &&
            ((selectedCards[0].symbol == selectedCards[1].symbol && selectedCards[1].symbol == selectedCards[2].symbol) ||
                (selectedCards[0].symbol != selectedCards[1].symbol && selectedCards[1].symbol != selectedCards[2].symbol && selectedCards[0].symbol != selectedCards[2].symbol)){
            return true
        }

        return false;
    }
    
    mutating func replaceSelectedCardsWithCardsFromDeck() {
        for selectedCardIndex in (0..<selectedCards.count).reversed() {
            if let replacementIndex = cardsOnTable.index(of:selectedCards[selectedCardIndex])    {
                if (deck.isEmpty) {
                    cardsOnTable.remove(at: replacementIndex)
                } else {
                    let replacementIndex = cardsOnTable.index(of:selectedCards[selectedCardIndex])!
                    cardsOnTable[replacementIndex] = deck.removeRandom(numberOfElements: 1)[0]
                    selectedCards.remove(at: selectedCardIndex)
                }
            } else {
                print("Something went wrong, selected card is not on table :(")
            }
        }
    }
    
    mutating func shuffle() {
        cardsOnTable.shuffle()
    }
    
    mutating func chooseCard(card: Card) {
        func validateTripplet() {
            if (isMatch()) {
                replaceSelectedCardsWithCardsFromDeck()
                selectedCards.removeAll()
                if (cardsOnTable.contains(card)) {
                    selectedCards.append(card)
                }
            } else {
                selectedCards = [card]
                score -= 2
            }
        }
        
        if let selectedCardIndex = selectedCards.index(of: card) {
            if (selectedCards.count < 3) {
                selectedCards.remove(at: selectedCardIndex)
                score -= 1
            } else {
                validateTripplet()
            }
        } else {
            if (selectedCards.count == 3) {
                validateTripplet()
            } else {
                selectedCards.append(card)
                if isMatch() {
                    score += 3
                }
            }
        }
    }
    
    mutating func drawThreeCards() {
        if isMatch() {
            replaceSelectedCardsWithCardsFromDeck()
        } else {
            if deck.count > 0 {
                cardsOnTable += deck.removeRandom(numberOfElements: min(deck.count, 3))
            }
        }
    }
    
}
