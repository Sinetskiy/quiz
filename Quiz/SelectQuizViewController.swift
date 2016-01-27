//
//  SelectQuizViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 27/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class SelectQuizViewController: UIViewController {
    
    var currentYear = 235
    //коллекция из объектов типа Ключ:Значение
    var allQuizes:[ [String:AnyObject] ]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        allQuizes = loadAllQuizes()
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    func loadAllQuizes() -> [ [String:AnyObject] ] {
        let allJSONfilesPaths = NSBundle.mainBundle().pathsForResourcesOfType("json",
            inDirectory: nil)
        
        var loadedJSONs = [ [String:AnyObject] ]()
        
        //перебрать все пути к файлам формата JSON
        for aPath in allJSONfilesPaths {
            let dataAtPath = NSData(contentsOfFile: aPath)
            //попытаемся считать данные из некой директории
            do {//преобразуем их в объект
                let json = try NSJSONSerialization.JSONObjectWithData(dataAtPath!, options: [])
                loadedJSONs.append(json as! [String : AnyObject])
            }
            catch {
                print("Can not get object from file \(aPath)")
            }
        }
        
        print("found jsons \(loadedJSONs)")
        return loadedJSONs
    }
    
}


extension SelectQuizViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizes!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuizeCell", forIndexPath: indexPath)
        let quize = quizAtIndexPath(indexPath)
        let name = quize["name"] as! String
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    func quizAtIndexPath(index:NSIndexPath) -> [String : AnyObject] {
        return allQuizes![index.row]
    }
}

extension SelectQuizViewController: UITableViewDelegate {
    
}















