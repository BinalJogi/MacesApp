//
//  PeopleResponce.swift
//  MacesApp
//
// Created by Binal Jogi on 06/05/2022.

import Foundation

struct PeopleData: Decodable {
    var createdAt: String?
    var firstName: String
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobTitle: String?
    var favouriteColor: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey{
        case createdAt,firstName,avatar,email,lastName,favouriteColor,id
        case jobTitle = "jobtitle"
    }
}
