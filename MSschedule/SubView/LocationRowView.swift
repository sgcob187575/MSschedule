//
//  LocationRowView.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/9/4.
//

import SwiftUI

struct LocationRowView: View {
    var title:String
    var subtitle:String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle").resizable().frame(width: 20, height: 20)
            VStack{
                Text(title)
                    .font(.title)
                Text(subtitle).font(.subheadline).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView(title: "耕壽司 羅東店", subtitle: "羅東鎮公園路58號 ,宜蘭市")
    }
}
