//
//  Api.swift
//  WEB
//
//  Created by Александр Алексеев on 15.03.2023.
//

import Foundation
import UIKit
import Alamofire

struct Root : Decodable{
    let Hello : String
}

struct Sign : Decodable{
    let success : String
}

struct UserDate : Decodable{
    let date : String
}




struct products: Decodable {
    let product: [productApi]
}

// MARK: - Product
struct productApi: Decodable {
    let id: Int
    let name: String
    let price, quantity: Int
    let description: String
}

struct LoginUser {
    static var login = String()
}

struct Api {
    static let shared = Api()
    //static let url = "http://127.0.0.1:8000/"
    static let url = "http://alexbobr.ru:7000/"

    
    func signup<T : Decodable>(parameters : [String : Any], path: String, method : String, decodedValue : @escaping  (T) -> Void) {
        
        let headers = [
          "accept": "application/json",
          "Content-Type": "application/json"
        ]
        
        let newUrl = Api.url + path
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        
        guard let url = URL (string: newUrl) else {return}
                
                var request = URLRequest(url: url)
                request.httpMethod = method
                request.allHTTPHeaderFields = headers
                request.httpBody = (postData ?? Data()) as Data

        
                let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                    if (error != nil) {
                        print(error ?? "")
                    } else {
                        let httpResponse = response as? HTTPURLResponse
                       // print(httpResponse?.statusCode ?? "")
                        
                        do{
                            let json : T = try JSONDecoder().decode(T.self, from: data!)
                            decodedValue(json)
                           // print(json)
                        }
                        catch{
                            print("Error")
                        }
                        
                        
                    }
                })
                task.resume()
        }
    
    func date<T : Decodable>( decodedValue : @escaping  (T) -> Void) {
        
        let headers = ["accept": "application/json"]

        let request = NSMutableURLRequest(url: NSURL(string: Api.url + "user/?login=\(LoginUser.login)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
              do{
                  let json : T = try JSONDecoder().decode(T.self, from: data!)
                  decodedValue(json)
                 // print(json)
              }
              catch{
                  print("Error")
              }
          }
        })

        dataTask.resume()
        }
    
    
    
//    func loadimage(imageData : Data){
//        let url = URL(string: "http://127.0.0.1:7000/uploadfile/")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // set the headers
//        request.addValue("application/json", forHTTPHeaderField: "accept")
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
//
//        // create the multipart form data
//        let formData = MultipartFormData()
//        formData.append(imageData, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
//
//        // set the body of the request to the form data
//        request.httpBody = formData.data
//
//        // create and send the URLSessionDataTask
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // handle the response or error here
//
//        }
//        task.resume()
//
//    }
    
    func send(imageData : Data, login : String){
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: login, mimeType: "image/jpeg")
        
        }, to: Api.url + "userimage").responseJSON { response in
            debugPrint(response.response?.statusCode)
        }

    }
    
    func sendProduct(imageData : Data, login : String){
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: login, mimeType: "image/jpeg")
        
        }, to: Api.url + "productimage").responseJSON { response in
            debugPrint(response.response?.statusCode)
        }

    }
    
//
//    func apiimage( completition : @escaping (Data) -> ()) -> (){
//
//        let url = Api.url + "/get"
//        guard let apiURL = URL(string: url) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
//            guard let data = data, error == nil else { return }
//
//            completition(data)
//
//        }.resume()
//    }

    func products<T : Decodable>( decodedValue : @escaping  (T) -> Void) async{
        
        let headers = ["accept": "application/json"]

        let request = NSMutableURLRequest(url: NSURL(string: Api.url + "select/products")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
           // print(httpResponse)
              do{
                  let json : T = try JSONDecoder().decode(T.self, from: data!)
                  decodedValue(json)
                 // print(json)
              }
              catch{
                  print("Error")
              }
          }
        })

        dataTask.resume()
    }

    
}

