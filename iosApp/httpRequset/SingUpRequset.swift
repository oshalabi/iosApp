//
//  SingUpRequset.swift
//  iosApp
//
//  Created by Osama Halabi on 9/10/1399 AP.
//  Copyright © 1399 orgName. All rights reserved.
//

import Foundation
import Combine

struct ServerMessageSingUp : Decodable {
    let token, user : String
    
}

class SingUpRequset: ObservableObject {
    
    @Published var authenticated = false
     var link : String = "http://84.82.7.96:1997/register"
    
    
    func postAuth(email : String, username :String, password : String)
    {
        guard let url = URL(string: link) else {
            return
        }
        
        let body : [String: String] = ["email" :email,   "user" : username, "password"  :password ]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        
        var requset = URLRequest(url: url)
        requset.httpMethod = "POST"
        requset.httpBody = finalBody
        requset.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: requset){
            (data, response, error) in
            
            guard let data = data else {return}
            let resData = try! JSONDecoder().decode(ServerMessageSingUp.self, from: data)
            
            print(resData.token)
            
            if resData.token == "correct" {
                DispatchQueue.main.async{
                    self.authenticated = true
                }
            }
        }.resume()
    }
}
