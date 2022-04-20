//
//  ReservationModel.swift
//  AboSleim
//
//  Created by MAC on 12/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation

struct ReservationModelJSON: Codable {
    let value: Bool?
    let data: ReservationModel?
    let msg: String?
}

struct ReservationModel: Codable {
    
    let tableReservations: TableReservations?
    
    enum CodingKeys: String, CodingKey {
        case tableReservations = "table_reservations"
    }
}

struct TableReservations: Codable {
    let tableReservations: [Reservations]?
    let paginate: Paginate?

    enum CodingKeys: String, CodingKey {
        case tableReservations = "table_reservations"
        case paginate
    }
}

struct Reservations: Codable {
    let id: Int?
    let table: Table?
    let reservationDate, dateFrom: String?
    let notes: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id, table
        case reservationDate = "reservation_date"
        case dateFrom = "date_from"
        case notes, status
    }
}
struct Table: Codable {
    let id: Int?
    let tableNumber, type, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tableNumber = "table_number"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
