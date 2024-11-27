//
//  CoreDataManager.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import CoreData
import Foundation
import Logger

open class PersistentContainer: NSPersistentContainer {}

public final class CoreDataManager {
    // MARK: - Init
    private init() {}

    public static var context: NSManagedObjectContext {
        persistentContainer?.viewContext ?? .init(concurrencyType: .mainQueueConcurrencyType)
    }

    public static var persistentContainer: PersistentContainer? = {
        guard let modelURL = Bundle.module.url(
            forResource: "Container",
            withExtension: "momd"
        ) else { return nil }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        let container = PersistentContainer(
            name: "BaseContainer",
            managedObjectModel: model
        )
        container.loadPersistentStores { _, _ in }
        return container
    }()

    public static func saveContext () {
        guard let context = persistentContainer?.viewContext else { return }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

   public static func create<T: NSManagedObject>(_ objectType: T.Type) -> T? {
        var newObject: T?
        context.performAndWait {
            newObject = NSEntityDescription.insertNewObject(
                forEntityName: String(describing: objectType),
                into: context
            ) as? T
        }
        return newObject
    }

    public static func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        var result: [T] = []
        context.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
            request.returnsObjectsAsFaults = false
            do {
                result = try self.context.fetch(request) as? [T] ?? []
            } catch {
                Logger().error(message: error.localizedDescription)
            }
        }
        return result
    }

    public static func removeAll<T: NSManagedObject>(_ objectType: T.Type) {
        var result: [T] = []
        context.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
            request.returnsObjectsAsFaults = false
            do {
                result = try self.context.fetch(request) as? [T] ?? []
                for index in result {
                    context.delete(index)
                }
            } catch let error {
                Logger().error(message: error.localizedDescription)
            }
        }
    }

    public static func update(_ object: NSManagedObject) {
        context.performAndWait {
            do {
                try self.context.save()
            } catch {
                Logger().error(message: error.localizedDescription)
            }
        }
    }

    public static func delete(_ object: NSManagedObject) {
        context.performAndWait {
            self.context.delete(object)
            do {
                try self.context.save()
            } catch {
                Logger().error(message: error.localizedDescription)
            }
        }
    }

    public static func deleteItemWithCode<T: NSManagedObject>(
        _ objectType: T.Type,
        value: String?
    ) {
        guard let value else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
        request.predicate = NSPredicate(format: "id == %@", value)
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as? [T]
            if let objectToDelete = result?.first {
                context.delete(objectToDelete)
                try context.save()
            }
        } catch {
            Logger().error(message: error.localizedDescription)
        }
    }

    public static func hasObject<T: NSManagedObject>(
        _ objectType: T.Type,
        id: Int
    ) -> Bool {
        var result = false
        context.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
            request.predicate = NSPredicate(format: "id == %@", id)
            request.fetchLimit = 1
            do {
                result = try self.context.count(for: request) > 0
            } catch {
                Logger().error(message: error.localizedDescription)
            }
        }
        return result
    }

    public static func get<T: NSManagedObject>(
        _ objectType: T.Type,
        key: Int?
    ) -> T? {
        guard let key else { return nil }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
        request.predicate = NSPredicate(format: "id == %d", key)
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as? [T]
            return result?.first
        } catch {
            Logger().error(message: error.localizedDescription)
            return nil
        }
    }
}
