
import UIKit

//: Model
public struct Person: Codable {
    struct Name: Codable {
        let first: String
        let last: String
    }
    let isActive: Bool
    let age: Int
    let name: Name
    let email: String
}

//: Utilities
extension String: Error {}

func getJSONData() throws -> Data {
    guard let file = Bundle.main.url(forResource: "File", withExtension: "json") else {
        throw("no file")
    }
    return try Data(contentsOf: file)
}


//: Decodable Extension

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

//: Encodable Extension

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

//: ### Encode/Decode in single JSON Array
print("JSON Array")

let data = try getJSONData()

let people = try [Person].decode(data: data)
print(people)

let jsonData = try people.encode()
print(String(data: jsonData, encoding: .utf8)!)


//: ### Encode/Decode in single JSON Pbject

let json = """
        {
          "_id": "593adfba2756b802b5d88b59",
          "index": 0,
          "guid": "0c233507-b862-4211-980a-a1f55f1e9845",
          "isActive": true,
          "balance": "$1,645.18",
          "picture": "http://placehold.it/32x32",
          "age": 39,
          "eyeColor": "blue",
          "name": {
              "first": "Jan",
              "last": "Monroe"
          },
        "email": "Jan.Monroe@gmail.com"
      }
    """.data(using: .utf8)!

print("Single JSON Object")
let person = try Person.decode(data: json)
print(person)

let singleJsonData = try person.encode()
print(String(data: singleJsonData, encoding: .utf8)!)
