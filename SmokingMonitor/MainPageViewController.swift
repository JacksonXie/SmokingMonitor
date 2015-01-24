//
//  MainPageViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/22.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit
import QuartzCore

class MainPageViewController:UIViewController,UITextFieldDelegate{
    //Declaration
    var layout = Layout()
    var color = Color()
    var mainViewLayout = MainViewLayout()
    //UI Element
    var healthIndexCircle:HealthIndexCircle!
    var healthIndexLabel:UILabel!
    var healthIndexTitleLabel:UILabel!
    var topUIView:UIView!
    var middleUIView:UIView!
    var bottomUIView:UIView!
    var smokeBtn:UIButton!
    var cancelBtn:UIButton!
    var suggestionTitleLabel:UILabel!
    var suggestionLabel: UILabel!
    var suggestion:NSString!
    var buttonView:UIView!
    //Mask Element
    var maskView:UIView!
    // button
    var buttonName = ["Coffee","Stress","Work Breaks","Drinking","Parties",
        "Smoke Buddies","Traffic","After Meals","After Sex","Spare Time"]
    var button1:UIButton!
    var button2:UIButton!
    var button3:UIButton!
    var button4:UIButton!
    var button5:UIButton!
    var button6:UIButton!
    var button7:UIButton!
    var button8:UIButton!
    var button9:UIButton!
    var button10:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MASK
        maskView = UIView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        maskView.backgroundColor = UIColor.blackColor()
        maskView.alpha = 0
        //buttonView
        buttonView = UIView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        buttonView.hidden = true
        buttonView.alpha = 0
        
        //topUIView
        topUIView = UIView()
        topUIView.backgroundColor = color.ViewBackgroundColor
        
        //middleUIView
        middleUIView = UIView()
        middleUIView.backgroundColor = color.LightGrayColor
        
        //text need be updated
        
        suggestionTitleLabel = UILabel()
        suggestionTitleLabel.text = "Do Exercise"
        suggestionTitleLabel.textColor = UIColor.blackColor()
        suggestionTitleLabel.font = UIFont(name: "Helvetica", size: 20)
        
        suggestionLabel = UILabel()
        suggestion = "Exercising is a great way to deal with stress and is a positive, lifestyle change."
        suggestionLabel.text = suggestion
        suggestionLabel.numberOfLines = 0
        suggestionLabel.textColor = color.TextGrayColor
        suggestionLabel.preferredMaxLayoutWidth = 250.0
        //bottomUIView
        bottomUIView = UIView()
        bottomUIView.backgroundColor = color.LightBlueColor
        
        //healthIndexCircle
        healthIndexCircle = HealthIndexCircle(frame:CGRectMake((view.bounds.width/2)-100.0, 75.0, 200.0, 200.0))
        healthIndexCircle.BackgroundLayerColor = color.DarkBlueColor
        healthIndexCircle.lineWidth = 50.0
        healthIndexCircle.RingColor = color.LightBlueColor
        healthIndexCircle.RingThickness = 15.0
        healthIndexCircle.RingProgress  = 0.0
        
        //Index Label
        healthIndexLabel = UILabel()
        healthIndexLabel.textColor = UIColor.whiteColor()
        healthIndexLabel.font = UIFont(name: "Helvetica", size: 52)
        healthIndexLabel.text = "58%"//TODO: initialize with 100%, and need to refresh after call the index calculation
        healthIndexLabel.sizeToFit()
        healthIndexLabel.center = CGPoint(x:view.bounds.width/2,y:0)
        healthIndexLabel.alpha = 0.0
        
        healthIndexTitleLabel = UILabel()
        healthIndexTitleLabel.textColor = color.LightGrayColor
        healthIndexTitleLabel.font = UIFont(name:"Helvetica-Bold", size: 15)
        healthIndexTitleLabel.text = "HEALTH INDEX"
        healthIndexTitleLabel.sizeToFit()
        healthIndexTitleLabel.center = CGPoint(x:view.bounds.width/2,y:200)
        
        //I smoke Btn
        smokeBtn = UIButton()
        smokeBtn.alpha = 0
        smokeBtn.backgroundColor = color.DarkBlueColor
        smokeBtn.setTitle("I SMOKED", forState: UIControlState.Normal)
        smokeBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        smokeBtn.addTarget(self, action: "ISmoked:", forControlEvents: UIControlEvents.TouchUpInside)
        // Cancel Btn
        cancelBtn = UIButton()
        cancelBtn.alpha = 0
        cancelBtn.backgroundColor = color.LightBlueColor
        cancelBtn.setTitle("CANCEL", forState: UIControlState.Normal)
        cancelBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cancelBtn.addTarget(self, action: "CancelBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Button
        TriggerButtons()
        
        //View
        view.addSubview(topUIView)
        view.addSubview(middleUIView)
        middleUIView.addSubview(suggestionLabel)
        middleUIView.addSubview(suggestionTitleLabel)
        view.addSubview(bottomUIView)
        view.addSubview(maskView)
        view.addSubview(buttonView)
        topUIView.insertSubview(healthIndexCircle, aboveSubview: view)
        topUIView.insertSubview(healthIndexLabel, aboveSubview: healthIndexCircle)
        topUIView.insertSubview(healthIndexTitleLabel, aboveSubview: healthIndexCircle)
        bottomUIView.addSubview(smokeBtn)
        buttonView.addSubview(cancelBtn)
        buttonView.addSubview(button1)
        buttonView.addSubview(button2)
        buttonView.addSubview(button3)
        buttonView.addSubview(button4)
        buttonView.addSubview(button5)
        buttonView.addSubview(button6)
        buttonView.addSubview(button7)
        buttonView.addSubview(button8)
        buttonView.addSubview(button9)
        buttonView.addSubview(button10)
        
        AutoLayoutConstraint()
    }
    override func viewDidAppear(animated: Bool) {
        //HealthIndexLabel need be updated
        healthIndexLabel.text = "70%"
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.healthIndexCircle.RingProgress = 70.0
        })
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: nil, animations: { () -> Void in
            self.healthIndexLabel.center = CGPoint(x:self.view.bounds.width/2,y:0+160)
            self.healthIndexLabel.alpha = 1.0
            self.smokeBtn.alpha = 1.0
            }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func ISmoked(sender: UIButton) {
        self.maskView.alpha = 0.8
        self.buttonView.hidden = false
        self.buttonView.alpha = 1.0
        self.cancelBtn.alpha = 1.0
        var SpringWithDamping:CGFloat! = 0.6
        var Duration:CGFloat! = 0.5
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button1.frame = CGRectMake((self.buttonView.bounds.width/4)-30,100,self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button2.frame = CGRectMake((self.buttonView.bounds.width/4)-30+135,100,self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: SpringWithDamping,initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button3.frame = CGRectMake((self.buttonView.bounds.width/4)-30,160, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button4.frame = CGRectMake((self.buttonView.bounds.width/4)-30+135,160, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: SpringWithDamping,initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button5.frame = CGRectMake((self.buttonView.bounds.width/4)-30,220, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button6.frame = CGRectMake((self.buttonView.bounds.width/4)-30+135,220, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.3, usingSpringWithDamping: SpringWithDamping,initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button7.frame = CGRectMake((self.buttonView.bounds.width/4)-30,280, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.3, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button8.frame = CGRectMake((self.buttonView.bounds.width/4)-30+135,280, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.4, usingSpringWithDamping: SpringWithDamping,initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button9.frame = CGRectMake((self.buttonView.bounds.width/4)-30,340, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.4, usingSpringWithDamping: SpringWithDamping, initialSpringVelocity:1, options: nil, animations: { () -> Void in
            self.button10.frame = CGRectMake((self.buttonView.bounds.width/4)-30+135,340, self.mainViewLayout.triggerBtnWidth, self.mainViewLayout.triggerBtnHeight)
            }, completion: nil)
    }
    func CancelBtn(sender:UIButton){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.maskView.alpha = 0
            self.buttonView.hidden = true
            self.buttonView.alpha = 0
        })
    }
    //Count the Trigger Number
    func button(sender:UIButton){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.maskView.alpha = 0
            self.buttonView.hidden = true
            self.buttonView.alpha = 0
        })
    }
    func TriggerButtons(){
        button1 = UIButton()
        button1.frame = CGRectMake(buttonView.bounds.width/4-30,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button1.backgroundColor = color.LightBlueColor
        button1.setTitle(buttonName[0], forState: UIControlState.Normal)
        button1.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button1.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button2 = UIButton()
        button2.frame = CGRectMake(buttonView.bounds.width/4-30+130,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button2.backgroundColor = color.LightBlueColor
        button2.setTitle(buttonName[1], forState: UIControlState.Normal)
        button2.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button3 = UIButton()
        button3.frame = CGRectMake(buttonView.bounds.width/4-30,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button3.backgroundColor = color.LightBlueColor
        button3.setTitle(buttonName[2], forState: UIControlState.Normal)
        button3.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button3.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button4 = UIButton()
        button4.frame = CGRectMake(buttonView.bounds.width/4-30+130,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button4.backgroundColor = color.LightBlueColor
        button4.setTitle(buttonName[3], forState: UIControlState.Normal)
        button4.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button4.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button5 = UIButton()
        button5.frame = CGRectMake(buttonView.bounds.width/4-30,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button5.backgroundColor = color.LightBlueColor
        button5.setTitle(buttonName[4], forState: UIControlState.Normal)
        button5.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button5.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button6 = UIButton()
        button6.frame = CGRectMake(buttonView.bounds.width/4-30+130,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button6.backgroundColor = color.LightBlueColor
        button6.setTitle(buttonName[5], forState: UIControlState.Normal)
        button6.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button6.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button7 = UIButton()
        button7.frame = CGRectMake(buttonView.bounds.width/4-30,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button7.backgroundColor = color.LightBlueColor
        button7.setTitle(buttonName[6], forState: UIControlState.Normal)
        button7.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button7.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button8 = UIButton()
        button8.frame = CGRectMake(buttonView.bounds.width/4-30+130,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button8.backgroundColor = color.LightBlueColor
        button8.setTitle(buttonName[7], forState: UIControlState.Normal)
        button8.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button8.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button9 = UIButton()
        button9.frame = CGRectMake(buttonView.bounds.width/4-30,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button9.backgroundColor = color.LightBlueColor
        button9.setTitle(buttonName[8], forState: UIControlState.Normal)
        button9.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button9.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        
        button10 = UIButton()
        button10.frame = CGRectMake(buttonView.bounds.width/4-30+130,4*(buttonView.bounds.height/5)+40, mainViewLayout.triggerBtnWidth, mainViewLayout.triggerBtnHeight)
        button10.backgroundColor = color.LightBlueColor
        button10.setTitle(buttonName[9], forState: UIControlState.Normal)
        button10.addTarget(self, action: "button:", forControlEvents: UIControlEvents.TouchUpInside)
        button10.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
    }
    func AutoLayoutConstraint(){
        topUIView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var topUIViewConstraintWidth = NSLayoutConstraint(item: self.topUIView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:1.0, constant:0)
        var topUIViewConstraintHeight = NSLayoutConstraint(item: self.topUIView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0.55, constant:0)
        var topUIViewConstraintX = NSLayoutConstraint(item: self.topUIView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var topUIViewConstraintY = NSLayoutConstraint(item: self.topUIView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier:1, constant:0)
        
        middleUIView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var middleUIViewConstraintWidth = NSLayoutConstraint(item: self.middleUIView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:1.0, constant:0)
        var middleUIViewConstraintHeight = NSLayoutConstraint(item: self.middleUIView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0.25, constant:0)
        var middleUIViewConstraintX = NSLayoutConstraint(item: self.middleUIView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var middleUIViewConstraintY = NSLayoutConstraint(item: self.middleUIView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.topUIView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        suggestionTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var suggestionTitleLabelConstraintX = NSLayoutConstraint(item: self.suggestionTitleLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.middleUIView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var suggestionTitleLabelConstraintY = NSLayoutConstraint(item: self.suggestionTitleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.middleUIView, attribute: NSLayoutAttribute.CenterY, multiplier:0, constant:40.0)
        
        suggestionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        var suggestionLabelConstraintHeight = NSLayoutConstraint(item: self.suggestionLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.middleUIView, attribute: NSLayoutAttribute.Height, multiplier:0.6, constant:0)
        var suggestionLabelConstraintX = NSLayoutConstraint(item: self.suggestionLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.middleUIView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant:layout.marginLeft)
        var suggestionLabelConstraintY = NSLayoutConstraint(item: self.suggestionLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.suggestionTitleLabel, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:40.0)
        
        bottomUIView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var bottomUIViewConstraintWidth = NSLayoutConstraint(item: self.bottomUIView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier:1.0, constant:0)
        var bottomUIViewConstraintHeight = NSLayoutConstraint(item: self.bottomUIView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0.2, constant:0)
        var bottomUIViewConstraintX = NSLayoutConstraint(item: self.bottomUIView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier:1, constant:0)
        var bottomUIViewConstraintY = NSLayoutConstraint(item: self.bottomUIView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.middleUIView, attribute: NSLayoutAttribute.Bottom, multiplier:1, constant:0)
        
        cancelBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var cancelBtnConstraintWidth = NSLayoutConstraint(item: self.cancelBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var cancelBtnConstraintHeight = NSLayoutConstraint(item: self.cancelBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var cancelBtnConstraintX = NSLayoutConstraint(item: self.cancelBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var cancelBtnConstraintY = NSLayoutConstraint(item: self.cancelBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonView, attribute: NSLayoutAttribute.Bottom, multiplier:0.9, constant:0)
        
        smokeBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var smokeBtnConstraintWidth = NSLayoutConstraint(item: self.smokeBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomUIView, attribute: NSLayoutAttribute.Width, multiplier:1, constant:-2*layout.marginLeft)
        var smokeBtnConstraintHeight = NSLayoutConstraint(item: self.smokeBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomUIView, attribute: NSLayoutAttribute.Height, multiplier:0, constant:layout.LongButtonHeight)
        var smokeBtnConstraintX = NSLayoutConstraint(item: self.smokeBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomUIView, attribute: NSLayoutAttribute.Left, multiplier:1, constant:layout.marginLeft)
        var smokeBtnConstraintY = NSLayoutConstraint(item: self.smokeBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.bottomUIView, attribute: NSLayoutAttribute.CenterY, multiplier:1, constant:0)
        
        view.addConstraint(topUIViewConstraintHeight)
        view.addConstraint(topUIViewConstraintWidth)
        view.addConstraint(topUIViewConstraintX)
        view.addConstraint(topUIViewConstraintY)
        view.addConstraint(middleUIViewConstraintHeight)
        view.addConstraint(middleUIViewConstraintWidth)
        view.addConstraint(middleUIViewConstraintX)
        view.addConstraint(middleUIViewConstraintY)
        view.addConstraint(suggestionTitleLabelConstraintX)
        view.addConstraint(suggestionTitleLabelConstraintY)
        view.addConstraint(suggestionLabelConstraintX)
        view.addConstraint(suggestionLabelConstraintY)
        view.addConstraint(bottomUIViewConstraintHeight)
        view.addConstraint(bottomUIViewConstraintWidth)
        view.addConstraint(bottomUIViewConstraintX)
        view.addConstraint(bottomUIViewConstraintY)
        view.addConstraint(cancelBtnConstraintHeight)
        view.addConstraint(cancelBtnConstraintWidth)
        view.addConstraint(cancelBtnConstraintX)
        view.addConstraint(cancelBtnConstraintY)
        view.addConstraint(smokeBtnConstraintHeight)
        view.addConstraint(smokeBtnConstraintWidth)
        view.addConstraint(smokeBtnConstraintX)
        view.addConstraint(smokeBtnConstraintY)
        
    }
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
