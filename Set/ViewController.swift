//
//  ViewController.swift
//  Set
//
//  Created by Yves Kurz on 15.08.18.
//  Copyright © 2018 Yves Kurz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var set = Set()
    
    @IBOutlet weak var dealThreeCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
    }
    
    @IBAction func newGameTouched(_ sender: Any){
        set = Set()
        updateUI()
    }
    
    @IBAction func dealThreeCardTouched(_ sender: Any) {
        set.drawThreeCards()
        updateUI()
    }
    
    @IBAction func cardTouched(_ sender: UIButton) {
        if let selectedButtonIndex = cardButtons.index(of: sender) {
            set.chooseCard(card: set.cardsOnTable[selectedButtonIndex])
            updateUI()
        }
    }
    
    private func attributedString(for card:Card) -> NSAttributedString {
        var symbols = ""
        for _ in 1...card.number {
            symbols += card.symbol.rawValue
        }

        var attribs = [NSAttributedStringKey : Any]()
        let color: UIColor
        switch card.color {
            case .red:
                color = #colorLiteral(red: 0.9626258264, green: 0.05161305742, blue: 0.1408702286, alpha: 1)
            case .black:
                color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .blue:
                color = #colorLiteral(red: 0, green: 0.4359109956, blue: 1, alpha: 1)
        }
        switch card.shading {
            case .solid:
                attribs[NSAttributedStringKey.foregroundColor] = color
                attribs[NSAttributedStringKey.strokeWidth] = -1
            case .open:
                attribs[NSAttributedStringKey.foregroundColor] = color
                attribs[NSAttributedStringKey.strokeWidth] = 20
            case .striped:
                attribs[NSAttributedStringKey.foregroundColor] = color.withAlphaComponent(0.15)
                attribs[NSAttributedStringKey.strokeWidth] = -1
        }
        
        let attrString = NSAttributedString(string: symbols, attributes: attribs)
        return attrString
    }
    
    private func updateUI() {
        let isMatch = set.isMatch()
        for cardIndex in set.cardsOnTable.indices {
            let cardButton = cardButtons[cardIndex]
            let card = set.cardsOnTable[cardIndex]
            cardButton.isHidden = false
            
            cardButton.setAttributedTitle(attributedString(for: card), for: .normal)
            
            let selected = set.cardIsSelected(card: card)
            cardButton.layer.borderColor = selected ? (isMatch ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1): #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)) : #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            cardButton.layer.borderWidth = selected ? 3 : 1
            cardButton.layer.cornerRadius = 8.0
        }
        
        for indexToHide in set.cardsOnTable.count..<cardButtons.count  {
            cardButtons[indexToHide].isHidden = true
        }
        
        dealThreeCardsButton.isEnabled = set.canDealThree
        
        scoreLabel.text = "Score: \(set.score)"
    }
}

