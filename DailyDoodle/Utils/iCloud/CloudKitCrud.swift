//
//  CloudKitcRUD.swift
//  ICloudyPOC
//
//  Created by Ieda Xavier on 23/11/22.
//

import SwiftUI
import CloudKit


class CloudKitCrudVM: ObservableObject {

    @Published var text: String = ""
    @Published var draw: [DrawModel] = []

    init () {
        fetchItems()
    }

    func addItem(image: UIImage?) {
        let newDraw = CKRecord(recordType: "Draw")
        newDraw["name"] = newDraw.description

        guard
            let imageURL = image,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(imageURL.description),
            let data = imageURL.pngData() else { return }

        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newDraw["image"] = asset
            saveItem(record: newDraw)
        } catch let error {
            print(error)
        }

    }

    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.draw = []
                self?.fetchItems()
            }
        }
    }

    func fetchItems() {

        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Draw", predicate: predicate)
        //query.sortDescriptors = [NSSortDescriptor(key: "createdTimestamp", ascending: false)]

        let queryOperation = CKQueryOperation(query: query)

        var returnedItens : [DrawModel] = []

        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in

                switch returnedResult {
                    case .success(let record):
                        guard let name = record["name"] as? String else { return }
                        let image = record["image"] as? CKAsset
                        let imageURL = image?.fileURL
                        returnedItens.append(DrawModel(name: name, imageURL: imageURL, record: record))
                    case .failure(let error):
                        print(error)
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let name = returnedRecord["name"] as? String else { return }
                let image = returnedRecord["image"] as? CKAsset
                let imageURL = image?.fileURL
                returnedItens.append(DrawModel(name: name, imageURL: imageURL, record: returnedRecord))
            }
        }

        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print(returnedResult)
                DispatchQueue.main.async {
                    self?.draw = returnedItens
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("returned queryCompletionBlock")
                DispatchQueue.main.async {
                    self?.draw = returnedItens
                }
            }
        }

        operationAdd(operation: queryOperation)
    }

    func operationAdd(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }

    func updateItem(item: DrawModel) {
        let record = item.record
        record["name"] = "name"
        saveItem(record: record)
    }

    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let drawDelete = draw[index]
        let record = drawDelete.record

        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.draw.remove(at: index)
            }
        }
    }
}
