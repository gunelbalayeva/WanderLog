//
//  CoreDataManagers.swift
//  WanderLog
//
//  Created by User on 04.04.25.
//

import UIKit
import CoreData


class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    
    
   private init() {
        persistentContainer = NSPersistentContainer(name: "TravelDataModel")
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load persistent store: \(error.localizedDescription)")
            } else {
                print("Persistent store successfully loaded.")
            }
        }
    }
    
    var context :NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges {
            do {
                try  context.save()
            } catch {
                 print("Failed to saved context:\(error)")
            }
        }
    }
    
    func addTravel(countryName:String, cityName:String,id: UUID ,image:Data ,year:Int ){
        let newTravel = TravelData(context: context)
               newTravel.countryName = countryName
               newTravel.cityName = cityName
               newTravel.id = id
               newTravel.image = image
               newTravel.year = Int32(year)
               
               saveContext()
    }
    
    func fetchTravelData() -> [TravelData] {
        let request: NSFetchRequest<TravelData> = TravelData.fetchRequest()
        
        do {
          return try context.fetch(request)

        } catch {
            print("Failed to fetch travel data: \(error)")
            return []
        }
    }
    
    func deleteTravel(travel: TravelData) {
        context.delete(travel)
        do {
            try context.save()
            print("Travel data deleted successfully.")
        } catch {
            print("Failed to delete travel data: \(error)")
        }
    }

}

