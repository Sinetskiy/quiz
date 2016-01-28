//
//  QuizViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 20/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizView: ViewWilthButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    var question:Question?
    var victorine:[Question]?
    
    var earnedPoints = 0 {
        //каждый раз, когда значение заработанных очков изменилось, 
        //будем обновлять текст с заработанными очками
        didSet {
            if oldValue == earnedPoints {
                print("Значение не изменилось")
                return
            }
            if (earnedPoints < 0){
                earnedPoints = 0
            }
            setupPointsLabel()
        }
    }
    
    //MARK: - View LifeCycle
    

    //В этот момент лучше всего занятся загрузкой требовательных операций
    //чего-то, что потребует большого количества времени
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareToAnimate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        quizView.show(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        quizView.show(false, animated: true)
    }
    
    func prepareToAnimate(){
        quizView.show(false, animated:false)
    }
    
    
    
    //MARK: - Setup
    func setup() {
        title = "Кино"
        self.view.backgroundColor = UIColor.orangeColor()

        setupModel()
        setupViewWithQuestion(question!)
        setupPointsLabel()
    }
    
    func setupModel() {
        if victorine != nil {
            question = victorine?.first
            return
        }
        let storeManager = StoreManager()
        
        victorine = storeManager.loadQuestionsByTheme("theme")
        question = victorine?.first
    }
    
    func setupViewWithQuestion(aQuestion:Question) {
        
        quizView.updateTopText(aQuestion.text)
        quizView.updateImage(aQuestion.image)
        quizView.updateButtonsTitles(aQuestion.answers)
        
        quizView.delegate = self
    }
    
    func setupPointsLabel() {
        let totalQuestionsCount = victorine!.count
        let result = "Очков набрано \(earnedPoints) из \(totalQuestionsCount)"
        pointsLabel.text = result
    }
}

extension QuizViewController: ViewWilthButtonDelegate {
    func buttonWithTitlePressed(title: String) {
        
        if question!.isCorrectAnswer(title) {
            print("You winner")
            earnedPoints++
        }
        else {
            print("Sorry. Go back to school")
        }
        
        let nextQuestion: Question
        
        var index = victorine?.indexOf({ $0 === question! })
        index!++
        
        //Пока не дошли до последнего вопроса, будем отображать следующий
        if index < victorine?.count  {
            nextQuestion = victorine![index!]
            question = nextQuestion
            setupViewWithQuestion(question!)
            return
        }
        
        let result =  Double(earnedPoints) / Double(victorine!.count)
        //запустим переход к новому вьюконтроллеру
        performSegueWithIdentifier("Show Rating", sender: result)
        
    }
    
    //перед переходом на новый экрна вызывается этот метод, где мы можем
    // получить информациб о следующем вью контроллере
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.destinationViewController is ResultViewController {
            let nextViewController = segue.destinationViewController as! ResultViewController
            nextViewController.rating = sender as! Double
        }
    }
}
























