//
//  DataStructure.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "Location" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
struct IGapiget : Codable,Identifiable{
    var id:String{
        graphql.hashtag.id
    }
    var graphql:Graphql
    init(graphql:Graphql) {
        self.graphql=graphql
    }
    struct Graphql:Codable {
        var hashtag:Hashtag
        init(hashtag:Hashtag) {
            self.hashtag=hashtag
        }
        struct Hashtag:Codable {
            let id:String
            let name:String
            let profile_pic_url:String
            let edge_hashtag_to_top_posts:Topposts
            init(id:String,name:String,profile_pic_url:String,edge_hashtag_to_top_posts:Topposts) {
                self.id=id
                self.profile_pic_url=profile_pic_url
                self.name=name
                self.edge_hashtag_to_top_posts=edge_hashtag_to_top_posts
            }
            struct Topposts:Codable{
                
                let edges:[Edge]
                init(edges:[Edge]) {
                    self.edges=edges
                }
                struct Edge:Codable,Identifiable {
                    var id :String{
                        node.id
                    }
                    let node:Node
                    init(node:Node) {
                        self.node=node
                    }
                    struct Node:Codable {
                        let id:String
                        let display_url:String
                        init(id:String,display_url:String) {
                            self.id=id
                            self.display_url=display_url
                        }
                    }
                }
            }
        }
    }
}
struct googleAttractionget : Codable{
    var status:String
    var results:[Attraction]
    struct Attraction:Codable{
        var formatted_address:String
        var geometry:Geometry
        struct Geometry:Codable {
            var location:Location
            struct Location:Codable {
                var lat:Double
                var lng:Double
            }
        }
        var name:String

    }
    var next_page_token:String?
}
