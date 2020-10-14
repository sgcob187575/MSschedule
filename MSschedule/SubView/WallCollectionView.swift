//
//  WallCollectionView.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import SwiftUI
struct WallCollectionView:UIViewControllerRepresentable {
    var sql:String
    @ObservedObject var wallViewModel = IGViewModel()
    func makeUIViewController(context: Context) -> WallCollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let demo = storyboard.instantiateViewController(identifier: "WallCollectionViewController") as? WallCollectionViewController
        wallViewModel.fetchdata(sql:sql)
        return demo!

        
    }
    
    func updateUIViewController(_ uiViewController: WallCollectionViewController, context: Context) {
        let imageURL=wallViewModel.postdata.map { (eachpost)  in
            
            return eachpost.node.display_url
        }
        uiViewController.setupData(images:
            imageURL)


    }
    
    typealias UIViewControllerType = WallCollectionViewController
    
    
}

