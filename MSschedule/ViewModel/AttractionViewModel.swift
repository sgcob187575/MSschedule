//
//  AttractionViewModel.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/8/30.
//

import Foundation
import Combine
class AttractionViewModel: ObservableObject {
    @Published var result:[googleAttractionget.Attraction] = [googleAttractionget.Attraction]()
    var cancellable: AnyCancellable?
    func fetchdata(sql:String) {
        cancellable = DataManager.shared.getAttractionPublisher(sql: sql).sink(receiveCompletion: { (completion) in
                if case .failure = completion {
                    print("errorfetch")
                }
            }) {[weak self] (value) in
                guard let self = self else { return }
            self.result=value
        }
        
    }
}
