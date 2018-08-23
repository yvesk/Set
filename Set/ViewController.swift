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
    var grid = Grid(layout: .aspectRatio(5.0/8.0))
    @IBOutlet weak var dealThreeCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    
    @IBOutlet weak var cardContainer: UIView!
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
        
        let swipeRecognizer = UISwipeGestureRecognizer (
            target: self, action: #selector(ViewController.swipe(recognizer:))
        )
        swipeRecognizer.direction = .down
        view.addGestureRecognizer(swipeRecognizer)

    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
        }, completion: { _ in
            self.updateUI()
        })
        
        super.willTransition(to: newCollection, with: coordinator)
    }
    @IBAction func newGameTouched(_ sender: Any){
        set = Set()
        updateUI()
    }
    
    @IBAction func dealThreeCardTouched(_ sender: Any) {
        set.drawThreeCards()
        updateUI()
    }
    
    
    fileprivate func configure(_ cardView: CardView, with card: Card) {
        cardView.isOpaque = false
        cardView.rank = card.number
        
        switch card.color {
        case .red:
            cardView.color = UIColor.red
        case .black:
            cardView.color = UIColor.green
        case .blue:
            cardView.color = UIColor.blue
        }
        
        switch card.shading {
        case .open:
            cardView.fill = .empty
        case .solid:
            cardView.fill = .solid
        case .striped:
            cardView.fill = .striped
        }
        
        switch card.symbol {
        case .circle:
            cardView.face = .oval
        case .square:
            cardView.face = .diamond
        case .triangle:
            cardView.face = .squiggle
        }
        
        if set.cardIsSelected(card: card) {
            if set.selectedCardCount == 3 {
                cardView.cardColor = set.isMatch() ? #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) : #colorLiteral(red: 0.9098039269, green: 0.7191671618, blue: 0.7026784244, alpha: 1)
            } else {
                cardView.cardColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        } else {
            cardView.cardColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var cardViewToCardMap = [CardView : Card]()
    private func updateUI() {
        dealThreeCardsButton.isEnabled = set.canDealThree
        scoreLabel.text = "Score: \(set.score)"
        
        grid.cellCount = set.cardsOnTable.count
        grid.frame = cardContainer.bounds;
        
        for cardView in cardContainer.subviews.reversed() {
            cardView.removeFromSuperview()
        }
        cardViewToCardMap.removeAll()
        
        for cardIdx in set.cardsOnTable.indices {
            let card = set.cardsOnTable[cardIdx]
            let cardView = CardView(frame: grid[cardIdx]!.insetBy(dx: 5, dy: 5))
            cardViewToCardMap[cardView] = card
            configure(cardView, with: card)

            let tapRecognizer = UITapGestureRecognizer (
                target: self, action: #selector(ViewController.tap(recognizer:))
            )
            cardView.addGestureRecognizer(tapRecognizer)
            
            cardContainer.addSubview(cardView)
        }
    }

    @IBAction func rotate(_ recognizer: UIRotationGestureRecognizer) {
        if recognizer.state == .ended {
            set.shuffle()
            updateUI()
        }
    }
    
    @objc private func swipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            set.drawThreeCards()
            updateUI()
        }
    }
    
    @objc private func tap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            if let card = cardViewToCardMap[recognizer.view as! CardView] {
                set.chooseCard(card: card)
                updateUI()
            }
        }
    }
}

