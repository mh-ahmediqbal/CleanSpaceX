//
//  Rocket.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/19/21.
//

import Foundation

struct Rocket: Codable {
    var id: Int?
    var active: Bool?
    var stages, boosters, cost_per_launch, success_rate_pct: Int?
    var first_flight, country, company: String?
    var height, diameter: Diameter?
    var mass: Mass?
    var payloadWeights: [PayloadWeight]?
    var firstStage: FirstStage?
    var secondStage: SecondStage?
    var engines: Engines?
    var landingLegs: LandingLegs?
    var flickr_images: [String]?
    var wikipedia: String?
    var description, rocketID, rocket_name, rocketType: String?
}

// MARK: - Diameter
struct Diameter: Codable {
    var meters, feet: Double?
}

// MARK: - Engines
struct Engines: Codable {
    var number: Int?
    var type, version: String?
    var layout: String?
    var isp: ISP?
    var engineLossMax: Int?
    var propellant1, propellant2: String?
    var thrustSeaLevel, thrustVacuum: Thrust?
    var thrustToWeight: Double?
}

// MARK: - ISP
struct ISP: Codable {
    var seaLevel, vacuum: Int?
}

// MARK: - Thrust
struct Thrust: Codable {
    var kN, lbf: Int?
}

// MARK: - FirstStage
struct FirstStage: Codable {
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSEC: Int?
    var thrustSeaLevel, thrustVacuum: Thrust?
    var cores: Int?
}

// MARK: - LandingLegs
struct LandingLegs: Codable {
    var number: Int?
    var material: String?
}

// MARK: - Mass
struct Mass: Codable {
    var kg, lb: Int?
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    var id, name: String?
    var kg, lb: Int?
}

// MARK: - SecondStage
struct SecondStage: Codable {
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSEC: Int?
    var thrust: Thrust?
    var payloads: Payloads?
}

// MARK: - Payloads
struct Payloads: Codable {
    var option1: String?
    var compositeFairing: CompositeFairing?
    var option2: String?
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable {
    var height, diameter: Diameter?
}
