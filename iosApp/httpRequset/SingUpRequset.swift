//
//  SingUpRequset.swift
//  iosApp
//
//  Created by Osama Halabi on 9/10/1399 AP.
//  Copyright © 1399 orgName. All rights reserved.
//

import Foundation
import Combine


class SingUpRequset: ObservableObject {
    
    let link : String = "http://84.82.7.96:1997/register"
    
    func postAuth(email : String, username :String, password : String)
   {
       guard let url = URL(string: link) else {
           return
       }
       
       var requset = URLRequest(url: url)
       requset.httpMethod = "POST"
       requset.setValue("application/Json", forHTTPHeaderField: "Content-Type")
    
       let body : [String: String] = ["email" : email,"user" : username, "password"  :password ]
        
        do{
            requset.httpBody = try!
                JSONSerialization.data(withJSONObject: body)
            
        }
        
        URLSession.shared.dataTask(with: requset){
            (data, response, error) in
            
        }.resume()

   }
}

