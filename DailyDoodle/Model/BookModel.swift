import SwiftUI
import CloudKit

struct BookModel: Hashable, Identifiable {
    var id = UUID().uuidString
    var nameTheme: String
    let nameDetail: String
    let imageURL: URL?
    let record: CKRecord
}
