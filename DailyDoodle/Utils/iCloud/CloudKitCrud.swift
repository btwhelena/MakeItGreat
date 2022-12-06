//
//  CloudKitcRUD.swift
//  ICloudyPOC
//
//  Created by Ieda Xavier on 23/11/22.
//

import SwiftUI
import CloudKit


class CloudKitCrudVM: ObservableObject {

    @Published var draws: [BookModel] = []
    @Published var selectedDraw: BookModel? = nil
    var nameTheme : String = ""
    var nameDetail : String = ""

    init() {
        fetchItems()
    }


     func addItem(nameTheme: String, nameDetail: String, image: UIImage?){
        let newDraw = CKRecord(recordType: "Books")
        newDraw["nameTheme"] = nameTheme
        newDraw["nameDetail"] = nameDetail
        guard
            let imageURL = image,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(imageURL.description),
            let data = imageURL.pngData() else { return }


        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newDraw["imageDraw"] = asset
            print(newDraw)
            saveItem(record: newDraw)

        } catch let error {
            print(error)
        }

    }

    private func saveItem(record: CKRecord){
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                self?.fetchItems()
            }
        }
    }

    func fetchItems() {
        //let predicate = NSPredicate(format: "nameTheme = %@", argumentArray: ["Natal"])
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Books", predicate: predicate)
        //query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)

        var returnedItems: [BookModel] = []

        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { returnedRecordID, returnedResult in
                switch returnedResult {
                    case .success(let record):
                        guard let nameTheme = record["nameTheme"] as? String else {return}
                        guard let nameDetail = record["nameDetail"] as? String else {return}
                        let imageAsset = record["imageDraw"] as? CKAsset
                        let imageURL = imageAsset?.fileURL
                        returnedItems.append(BookModel(nameTheme: nameTheme, nameDetail: nameDetail, imageURL: imageURL, record: record))

                        break
                    case .failure(let error):
                        print(error)
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { returnedRecord in
                guard let nameTheme = returnedRecord["nameTheme"] as? String else {
                    return
                }
                guard let nameDetail = returnedRecord["nameDetail"] as? String else {
                    return
                }
                let imageAsset = returnedRecord["imageDraw"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                returnedItems.append(BookModel(nameTheme: nameTheme, nameDetail: nameDetail, imageURL: imageURL, record: returnedRecord))
            }
        }


        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async {
                    self?.draws = returnedItems
                    self?.selectedDraw = returnedItems.first
                }

            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
                DispatchQueue.main.async {
                    self?.draws = returnedItems
                }
            }
        }

        addOperation(operation: queryOperation)
    }

    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
