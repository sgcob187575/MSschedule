//
//  MotherView.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack {
            if viewRouter.currentPage=="Travel"{
                TravelView()
            }
            else if viewRouter.currentPage=="Location"{
                LocationView()
            }
            else if viewRouter.currentPage=="Tag"{
                TagView(sql:"新溪口吊橋")
            }
            else if viewRouter.currentPage=="Search"{
                SearchLocationView(sql:"桃園景點")
            }
            
        }.onAppear{
                self.viewRouter.currentPage="Tag"

        }
        
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
