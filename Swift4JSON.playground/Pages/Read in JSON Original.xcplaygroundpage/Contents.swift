
import UIKit

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

extension String: Error {}

func getJSONData() throws -> Data {
    guard let file = Bundle.main.url(forResource: "File", withExtension: "json") else {
        throw("no file")
    }
    return try Data(contentsOf: file)
}

let data = try getJSONData()

let decoder = JSONDecoder()
let people = try decoder.decode([Person].self, from: data)
print(people)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let encodedPeople = try encoder.encode(people)
print(String(data: encodedPeople, encoding: .utf8)!)


