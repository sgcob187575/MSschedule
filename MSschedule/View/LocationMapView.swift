//
//  LocationMapView.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/9/4.
//

import SwiftUI
import MapKit
struct LocationMapView: View {
    var sql:String
    @ObservedObject var attractionViewModel = AttractionViewModel()
    @State var tagsql=""
    @State var showTagView=false
    var annotations:[MKPointAnnotation]{
        attractionViewModel.result.map{
            let annotation=MKPointAnnotation()
            annotation.coordinate=CLLocationCoordinate2D(latitude: $0.geometry.location.lat, longitude: $0.geometry.location.lng)
            annotation.title=$0.name
            annotation.subtitle=$0.formatted_address
            return annotation
        }
    }
    var body: some View {
        VStack{
            MapView(showTagView:$showTagView ,sql: $tagsql,annotations:annotations)
            

        }.sheet(isPresented: $showTagView, content: {
            TagView(sql: tagsql)
        }).onAppear(){
            self.attractionViewModel.fetchdata(sql: self.sql)
        }
        
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView(sql: "")
    }
}
