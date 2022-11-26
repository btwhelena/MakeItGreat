//
//  ContentView.swift
//  ICloudyPOC
//
//  Created by Ieda Xavier on 22/11/22.
//

import SwiftUI
import CloudKit

class CloudKitUser: ObservableObject {

    @Published var permissionStatus: Bool = false
    @Published var isSignedInToICloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""

    init() {
        getICloudStatus()
        requestPermission()
        fetchiCloudRecordId()
    }

    private func getICloudStatus() {
        CKContainer.default().accountStatus { [weak self] statusCloudKit, errorCloudKit in
            DispatchQueue.main.async {
                switch statusCloudKit {
                    case .available:
                        self?.isSignedInToICloud = true
                    case .couldNotDetermine:
                        self?.error = CloudKitError.ICloudAccountNotDetermined.rawValue
                    case .noAccount:
                        self?.error = CloudKitError.ICloudAccountNotFound.rawValue
                    case .restricted:
                        self?.error = CloudKitError.ICloudAccounRestricted.rawValue
                    case .temporarilyUnavailable:
                        self?.error = CloudKitError.ICloudAccountUnavailable.rawValue
                    default:
                        self?.error = CloudKitError.ICloudAccountUnknown.rawValue
                }
            }
        }
    }

    enum CloudKitError: String, LocalizedError {
        case ICloudAccountNotFound
        case ICloudAccountNotDetermined
        case ICloudAccounRestricted
        case ICloudAccountUnknown
        case ICloudAccountUnavailable
    }

    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }

    func fetchiCloudRecordId() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }

    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedID, returnedError in
            DispatchQueue.main.async {
                if let name = returnedID?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
}

