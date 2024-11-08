//
//  FakeDataCustomers.swift
//  DeliveryNewspaperHelper
//
//  Created by cmStudent on 2024/11/05.
//

import Foundation

class DummyData {
    static var customers: [Customer] = [
        .init(name: "田中", address: .init(latitude: 35.8078274017569, longitude: 139.4473695507108)),
        .init(name: "鈴木", address: .init(latitude: 35.80892272971942, longitude: 139.44661697315317)),
        .init(name: "阿部", address: .init(latitude: 35.80877617531185, longitude: 139.44534364075062)),
        .init(name: "木村", address: .init(latitude: 35.809197185016856, longitude: 139.4470714897325)),
        .init(name: "山田", address: .init(latitude: 35.808360843976686, longitude: 139.44673712560328))
    ]
}

