import Foundation

struct Stat {
    var name: String
    var value: Int
}

extension Stat: Decodable {
    
    enum StatKeys: String, CodingKey {
        case name
        case value
    }
    
}
