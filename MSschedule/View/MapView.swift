//
//  MapView.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/9/4.
//

import Foundation
import MapKit
import SwiftUI
struct MapView:UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator($showTagView,$sql)
    }
    @Binding var showTagView:Bool
    @Binding var sql:String

    var annotations=[MKPointAnnotation]()
    func makeUIView(context: Context) -> MKMapView {
        let mapview=MKMapView()
        mapview.delegate=context.coordinator
        mapview.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotation")
        return mapview
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(annotations, animated: true)
    }
    
    
    class Coordinator: NSObject,MKMapViewDelegate {
        @Binding var showTagView:Bool
        @Binding var sql:String


        init(_ showTagView: Binding<Bool>,_ sql:Binding<String>) {
            self._showTagView = showTagView
            self._sql=sql
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView=mapView.dequeueReusableAnnotationView(withIdentifier: "annotation", for: annotation)
            annotationView.canShowCallout=true
            annotationView.rightCalloutAccessoryView=UIButton(type: .detailDisclosure)
            return annotationView
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            let annotation=view.annotation as? MKPointAnnotation
            showTagView=true
            sql=annotation!.title!

        }
    }
    typealias UIViewType = MKMapView
    
}
