//
//  UploadData.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import Foundation

struct UploadDataModel {
    var fileName: String
    var mimeType: String
    var data: Data
    var name: String = "file"
}

struct UploadDataRequest: Codable {
    var fileName: String?
    var mimeType: String?
    var data: Data?
    var name: String? = "file"
}
