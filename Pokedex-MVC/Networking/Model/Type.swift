import Foundation

struct Type {
    var name: String
    var slot: Int
}

extension Type: Decodable {
    
    enum TypeKeys: String, CodingKey {
        case name
        case slot
    }
}
