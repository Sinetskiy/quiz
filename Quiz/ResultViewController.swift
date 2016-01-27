//
//  ResultViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 27/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit



class ResultViewController: UIViewController {

    @IBOutlet weak var ratingText: UILabel!
    var rating:Double = 0 {
        didSet {
            if rating > 1 {
                rating = 1
            }
            if rating < 0 {
                rating = 0
            }
        }
    }//значение от 0 до 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText()
    }

    func updateText() {
        switch rating {
        
        //когда диапазон значений находится внутри 0, 0.1 не включая  0.1
        case 0..<0.1:
            ratingText.text = "Повезет в другой раз, хотя вряд ли."

        //когда диапазон значений находится внутри (0.1, 0.4) не включая  0.4
        case 0.1..<0.4:
            ratingText.text = "Бывало и получше"
            
        //когда диапазон значений находится внутри (0.4, 0.8) включая  0.8
        case 0.4...0.8:
            ratingText.text = "Бывало и похуже"
            
        //Для всех других ситуаций
        default:
            ratingText.text = "Сразу видно чемпиона!"
        }
    }
}
