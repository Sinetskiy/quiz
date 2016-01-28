//
//  StoreManager.swift
//  Quiz
//
//  Created by anatoliy.kant on 21.01.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class StoreManager  {
    func loadQuestionsByTheme(themeName:String) -> [Question]? {

        //найдем путь к файлу с информацией о викторине
        let path = NSBundle.mainBundle().pathForResource("cinema", ofType: "json")
        
        //проверить условие и продолжить дальше, только если оно выполняется
        guard path != nil else {
            
            return nil
        }
        
        //загружаем сюда данные
        let data = NSData(contentsOfFile: path!)
        
        guard data != nil else {
            return nil
        }
        
        do {
            //преобразуем байты в объект
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print(json)
            let questionsInfos = json["questions"] as! [NSDictionary]
            
            //создадим массив Question объектов
            var questionsObjects = [Question]()
            
            for info in questionsInfos {
                let questionObject = Question(json: info)
                questionsObjects.append(questionObject)
            }
            
            return questionsObjects
            
        }
        
        
        catch {
            print("Oopps did not get objects from data:\(error)")
            return nil
        }
        //return [question]
    }
}
