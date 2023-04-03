//
//  Playground.swift
//  deeplink_curs7
//
//  Created by Orlando Neacsu on 01.04.2023.
//

// SWIFTYJSON

import Foundation

/*
 
 {
    "value": "5"
 }
 
 */

struct User2: Codable {
    let value: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Int.self, forKey: .value)
    }
}

struct User: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "NAME"
    }
}



func test () {
    let usersData = Data()
    do {
        let users = try JSONDecoder().decode([User].self, from: usersData)
    } catch {
        print(error)
    }
}

let endpoint = "https://google.ro"

func test2() {
    
    // query ???
    
    let user = User(name: "orlando")
    let encodedUser = try! JSONEncoder().encode(user)
    
    let url = URL(string: endpoint)!
    var urlRequest = URLRequest(url: url)
    
    urlRequest.allHTTPHeaderFields = [:]
    urlRequest.httpMethod = "GET" // POST, etc
//    urlRequest.httpBody = encodedUser
    
    let task = URLSession.shared.dataTask(with: urlRequest) { _, _, _ in
        
    }
    task.resume()
}

import UIKit

class MyCell: UITableViewCell {
    
    private var task: URLSessionDataTask?
    
    override func prepareForReuse() {
        task?.cancel()
    }
    
    private func loadCarDetails(id: Int) {
        
        let url = URL(string: "https://sadasdad.ro/details/\(id)")!
        let urlRequest = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: urlRequest) { _, _, _ in
            
        }
        task?.resume()
    }
    
    func configure(id: Int) {
        loadCarDetails(id: id)
    }
}
