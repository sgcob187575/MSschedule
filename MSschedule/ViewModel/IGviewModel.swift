//
//  IGviewModel.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import Combine
class IGViewModel: ObservableObject {
    @Published var postdata = [IGapiget.Graphql.Hashtag.Topposts.Edge]()
    @Published var hashtag = IGHashtag(id: "", name: "", profile_pic_url: "", edge_hashtag_to_top_posts: IGapiget.Graphql.Hashtag.Topposts(edges: [IGapiget.Graphql.Hashtag.Topposts.Edge]()))
    var cancellable: AnyCancellable?
    func fetchdata(sql:String) {
        cancellable = DataManager.shared.getIGtagPublisher(sql: sql).sink(receiveCompletion: { (completion) in
                if case .failure = completion {
                    print("errorfetch")
                }
            }) {[weak self] (value) in
                guard let self = self else { return }
                self.postdata = value.edge_hashtag_to_top_posts.edges
                self.hashtag=value
        }
        
    }
}
