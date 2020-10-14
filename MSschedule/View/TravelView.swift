//
//  ContentView.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/8/29.
//

import SwiftUI
import CoreData
import KingfisherSwiftUI
import GoogleMaps
struct TravelView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Travel.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Travel.startdate, ascending: false)])var fetchedTravelItems: FetchedResults<Travel>
    var locationManager=LocationManager.shared
    
    var body: some View {
        NavigationView{
            List {
                Text("add").onTapGesture {
                    self.locationManager.getLocation()
                }

                ForEach(fetchedTravelItems,id:\.self){(item:Travel) in
                    HStack{
                        ForEach(item.memo!,id: \.self){(memo:String) in
                            Text(memo)
                        }
                    }
                    
                }.onDelete(perform: removeTravelItems)
                
            }.navigationBarItems(trailing: EditButton()).onAppear(){

            }
        }
    }
    func removeTravelItems(at offsets: IndexSet) {
        for index in offsets {
            let item = fetchedTravelItems[index]
            viewContext.delete(item)
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveTravelTask() {
        
        let newTravel = Travel(context: self.viewContext)
        newTravel.id=[UUID()]
        newTravel.enddate=Date()
        newTravel.memo=["鑰匙","手機"]
        newTravel.name="涵寶貝"
        newTravel.startdate=Date()
        newTravel.state=[true]
        newTravel.text="哼"
        do {
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    struct TravelView_Previews: PreviewProvider {
        static var previews: some View {
            TravelView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
