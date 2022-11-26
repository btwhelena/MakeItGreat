import SwiftUI
import CloudKit

struct DrawModel: Hashable, Identifiable {
    var id = UUID().uuidString
    let name: String
    let imageURL: URL?
    let record: CKRecord
}
