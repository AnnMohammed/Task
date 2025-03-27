//
//  ItemsModel.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Foundation

struct ItemsResponse: Codable {
    let status: Int?
    let errors: [GeneralError]?
    let items: [ItemsModel]?
}

// MARK: - Item Model
struct ItemsModel: Codable {
    let userId, id: Int?
    let title, body: String?
}

// MARK: - General API Error Model
struct GeneralError: Codable {
    let field, message: String?
}

// MARK: - Progress Data
struct ProgressData: Codable {
    var countOffersCompany: Int?
    var countClaimedOffers: Int?
    var maxCountClaimed: Int?
}

// MARK: - Attendance State Enum
enum AttendanceState: String, Codable {
    case deviceNotRegister = "device_not_register"
    case deviceRegister = "device_register"
    case deviceUsedFromAnotherUser = "device_used_from_another_user"
    case deviceHaveRequest = "device_have_request"
    case isWeekend = "is_weekend"
    case userAttendance = "user_attendance"
    case isAbsent = "is_absent"
    case vacationRequest = "vacation_request"
    case isHolidays = "is_holidays"
    case deviceBlocked = "device_blocked"
    
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(String.self)
        self = AttendanceState(rawValue: value ?? "") ?? .unknown
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

