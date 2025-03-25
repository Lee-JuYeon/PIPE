//
//  SavingController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/28.
//

import CoreData
import RxSwift

class MemoCoreDataManager {
    static let shared = MemoCoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemoModel") // xcdatamodeld 파일 이름
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data 저장소 로딩 실패: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
