//
//  CellBankBasic.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/10/10.
//

import Foundation
import CoreData

@objc(Memo)
public class Memo: NSManagedObject {
    
}

extension Memo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
}
