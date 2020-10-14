//
//  NetWorkClass.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import SwiftUI
import SafariServices
import Combine
import AVFoundation
import CoreLocation
typealias IGHashtag = IGapiget.Graphql.Hashtag
enum NetworkError: Error {
    case errorPassword
    case invalidUrl
    case requestFailed
    case invalidData
    case datatypeError
    case imageDownloadFailed
    case responseFailed
    case duplicateUser
}
struct SafariViewController: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

class Validfield{
    static let shared = Validfield()
    func validateEmail(email: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*@)[A-Za-z\\d@._]{8,}$"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    func isVideo(url: String) -> Bool {
        let passRegEx = ".*mp4"
        let trimmedString = url.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }

    
    
}
struct UploadVideoResult:Codable {
    let success:Bool
}
class DataManager {
    static let shared=DataManager()
    let googleApiKey="AIzaSyCSWiVBrZtonDveBgZ4Q0q7sDZftgQV_a8"

    func getIGtagPublisher(sql:String)->AnyPublisher<IGHashtag,Error>{

            guard  let urlString = "https://www.instagram.com/explore/tags/\(sql)/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ,let url=URL(string: urlString) else {
                return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
            }
            let decorder=JSONDecoder()
            URLSession.shared.dataTask(with: url){data,_,_ in
                print(String(data: data!, encoding: .utf8))

            }.resume()
            return URLSession.shared.dataTaskPublisher(for: url)
                .map{$0.data}.decode(type: IGapiget.self, decoder: decorder).map{$0.graphql.hashtag}.receive(on: DispatchQueue.main).eraseToAnyPublisher()
        }
    func getAttractionPublisher(sql:String)->AnyPublisher<[googleAttractionget.Attraction],Error>{

            guard  let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(sql)&key=\(googleApiKey)&language=zh-TW".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ,let url=URL(string: urlString) else {
                return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
            }
            let decorder=JSONDecoder()
//            URLSession.shared.dataTask(with: url){data,_,_ in
//                print(String(data: data!, encoding: .utf8))
//                dump(data!)
//
//            }.resume()
            return URLSession.shared.dataTaskPublisher(for: url)
                .map{$0.data}.decode(type: googleAttractionget.self, decoder: decorder).map{
                    $0.results}.receive(on: DispatchQueue.main).eraseToAnyPublisher()
        }
    


}
