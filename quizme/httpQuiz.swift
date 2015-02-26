//
//  httpQuiz.swift
//  quizme
//
//  Created by Ricky Yim on 26/02/2015.
//  Copyright (c) 2015 dius. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

class HttpQuiz {
    init() {
        
    }
    
    func download(controller: ViewController, language: String) {
        let url = "https://quizmeapi.herokuapp.com/api/v1/learning/categories/\(language)"
        println(url)
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        
        request.GET(url, parameters: nil, success: { (response: HTTPResponse) -> Void in
            if (response.responseObject != nil) {
                let d = JSONDecoder(response.responseObject!)
                let quiz = Quiz(jsonDecoder: d)
                controller.quizDownloaded(quiz)
                println("quiz downloaded")
            }
            },{(error: NSError, response: HTTPResponse?) -> Void in
                println("got an error: \(error)")
        })
    }
    
}