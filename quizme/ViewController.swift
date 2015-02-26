//
//  ViewController.swift
//  quizme
//
//  Created by Ricky Yim on 26/02/2015.
//  Copyright (c) 2015 dius. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import SwiftSpinner

class ViewController: UIViewController {

    var language: String!
    var cardView: UIView!
    var front: UIImageView!
    var back: UIView!
    var showingBack = false
    var next: UIButton!
    var label: UILabel!
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Waiting for Richard to type the data in...")
        
        HttpQuiz().download(self, language: language)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let rect = CGRectMake(0, 0, screenSize.width, screenSize.height)
        
        let frontImage = UIImage(named: "horse.gif")
        front = UIImageView(image: frontImage)
        front.contentMode = UIViewContentMode.Center
        
        back = UIView(frame: CGRectMake(0, 0, 0, 0))
        back.contentMode = UIViewContentMode.Center
        label = UILabel()
        label.text = "cheval"
        label.font = UIFont.systemFontOfSize(20)
        label.contentMode = UIViewContentMode.Center
        label.center = CGPointMake(screenSize.width/2, screenSize.height/2)
        label.frame = CGRectMake(screenSize.width/2 - 50, 10, screenSize.width, screenSize.height)
        back.addSubview(label)
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("tapped"))
        singleTap.numberOfTapsRequired = 1
        
        cardView = UIView(frame: rect)
        cardView.addSubview(front)
        cardView.addGestureRecognizer(singleTap)
        cardView.userInteractionEnabled = true
        view.addSubview(cardView)
        
        front.frame = cardView.bounds
        back.frame = cardView.bounds
        

        let button : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, 320, 44)
        let center = self.view.center
        button.center = CGPoint(x: center.x + 100, y: center.y + 200)
        button.addTarget(self, action: Selector("buttonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("Next", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.systemFontOfSize(40)
        view.addSubview(button)
        
        let backButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        backButton.frame = CGRectMake(0, 0, 320, 44)
        backButton.center = CGPoint(x: center.x - 100, y: center.y + 200)
        backButton.addTarget(self, action: Selector("backButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Prev", forState: UIControlState.Normal)
        backButton.titleLabel!.font = UIFont.systemFontOfSize(40)
        view.addSubview(backButton)
        
    //    self.selectImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tapped() {
        if (showingBack) {
            UIView.transitionFromView(back, toView: front, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            showingBack = false
        } else {
            UIView.transitionFromView(front, toView: back, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            showingBack = true
        }
    }
    
    func buttonClicked() {
        dispatch_async(dispatch_get_main_queue()) {
            self.quiz.next()
            self.selectImage()
        }
    }
    
    func backButtonClicked() {
        dispatch_async(dispatch_get_main_queue()) {
            self.quiz.prev()
            self.selectImage()
        }
    }
    
    func selectImage() {
        let flashCard = quiz.currentFlashCard()
        let url = NSURL(string: flashCard.image)!
        let data = NSData(contentsOfURL: url)!
        self.front.image = UIImage(data: data)
        self.label.text = flashCard.name
        UIView.transitionFromView(back, toView: front, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        showingBack = false
    }
    
    func quizDownloaded(quiz: Quiz) {
        self.quiz = quiz
        
        dispatch_async(dispatch_get_main_queue()) {
            self.selectImage()
            SwiftSpinner.hide()
        }
    }
    
    
    

}

