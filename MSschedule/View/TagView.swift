//
//  TagView.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
struct TagView: View {
    var sql:String
    @ObservedObject var IGDataViewModel = IGViewModel()
    @State var showWall=false
    @State var showtestWall=false
    var body: some View {
        VStack{
            HStack{
                KFImage(URL(string:IGDataViewModel.hashtag.profile_pic_url) ).onSuccess(perform: { (result) in
                    self.showWall=true
                }).resizable().scaledToFit().frame(width:100).clipShape(Circle()).overlay(Circle().stroke(Color.gray, lineWidth: 3))
                Text(IGDataViewModel.hashtag.name)
            }
            if(showWall){
                WallCollectionView(sql:sql)
            }
        }.onAppear(){
            self.IGDataViewModel.fetchdata(sql: self.sql)
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(sql:"日月潭")
    }
}
