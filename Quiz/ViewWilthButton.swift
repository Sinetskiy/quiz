//
//  ViewWilthButton.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 20/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

protocol ViewWilthButtonDelegate:class {
    func buttonWithTitlePressed(title:String)
}

class ViewWilthButton: UIView {

    var delegate:ViewWilthButtonDelegate?
    
    //текст
    @IBOutlet var topText:UILabel!
    
    //картинка
    @IBOutlet var imageView:UIImageView!
    
    @IBOutlet var button1:UIButton!
    @IBOutlet var button2:UIButton!
    @IBOutlet var button3:UIButton!
    @IBOutlet var button4:UIButton!
    
    @IBAction func buttonPressed(button:UIButton){
        
        delegate?.buttonWithTitlePressed(button.titleForState(UIControlState.Normal)!)
    }
    
    func show(show:Bool, animated:Bool){
        
        let duration:NSTimeInterval = animated ? 1 : 0
        UIView.animateWithDuration(duration) { () -> Void in
            let alpha = show ? 1 : 0
            self.alpha = CGFloat(alpha)
        }
    }
    
    func updateTopText(text:String){
        topText.text = text
    }
    
    //передается optional переменная
    //т.е. может быть либо UIImage либо
    //в качестве параметра придет пустота
    func updateImage(picture:UIImage?){
        
        if picture == nil {
            imageView.alpha = 0
            return
        }
        
        imageView.image = picture
        imageView.alpha = 1
    }
    
    func updateButtonsTitles(titles:[String]) {
        
        //перебрать все элементы внутри titles
        //aTitle - это название элемента когда мы будем их все перебирать на каждом шаге
        for aTitle in titles {
            //распечатаем значение каждой строки
            print("one of titles is: \(aTitle)")
        }
        
        let allButtons = [button1,button2,button3,button4]
        
        //index = 0,1,2,...,  до titles.count
        for index in 0..<titles.count {
            //обратимся к элементу массива под номером 
            //от 0 до последнего
            let stringToAdd = titles[index]
            let aButton = allButtons[index]
            
            //задать текст кнопки для самого общего случая
            aButton.setTitle(stringToAdd,
                forState: UIControlState.Normal)
        }
    }
}












