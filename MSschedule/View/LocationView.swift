//
//  LocationView.swift
//  MSplan
//
//  Created by 陳昱豪 on 2020/8/8.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Location.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Location.create, ascending: false)])var fetchedLocationItems: FetchedResults<Location>
    var body: some View {
        NavigationView{
            List{
                ForEach(fetchedLocationItems,id:\.self){(item:Location) in
                    Text(item.name!)
                    
                }.onDelete(perform: removeLocationItems)
            }            
        }.navigationBarItems(trailing: EditButton())
        
    }
    func removeLocationItems(at offsets: IndexSet) {
        for index in offsets {
            let item = fetchedLocationItems[index]
            managedObjectContext.delete(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveLocationTask() {
        
        let newLocation = Location(context: self.managedObjectContext)
        newLocation.id=UUID()
        newLocation.create=Date()
        newLocation.name="新溪口吊橋"
        newLocation.address="336桃園市復興區中山路8號"
        newLocation.latitude=24.809634
        newLocation.longitude=121.347474
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
