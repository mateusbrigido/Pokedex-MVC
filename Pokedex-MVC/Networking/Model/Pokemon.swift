import Foundation

struct Pokemon {
    var order: Int
    var name: String
    var weight: Int
    var height: Int
    var description: String
    
    var defaultSprite: URL
    var shinySprite: URL
    
    var stats: [Stat]
    var types: [Type]
}

extension Pokemon: Decodable {
    init(from decoder: Decoder) throws {
        let pokemon = try decoder.container(keyedBy: PokemonKeys.self)
        
        self.order = try pokemon.decode(Int.self, forKey: .order)
        self.name = try pokemon.decode(String.self, forKey: .name)
        self.weight = try pokemon.decode(Int.self, forKey: .weight)
        self.height = try pokemon.decode(Int.self, forKey: .height)
        self.description = try pokemon.decode(String.self, forKey: .description)
        
        self.stats = try pokemon.decode([Stat].self, forKey: .stats)
        self.types = try pokemon.decode([Type].self, forKey: .types)
        
        let sprites = try pokemon.nestedContainer(keyedBy: PokemonKeys.SpritesKeys.self, forKey: .sprites)
        self.defaultSprite = try sprites.decode(URL.self, forKey: .normal)
        self.shinySprite = try sprites.decode(URL.self, forKey: .shiny)
    }
    
    
    enum PokemonKeys: String, CodingKey {
        case order
        case name
        case weight
        case height
        case description
        
        case sprites
        
        case stats
        case types
        
        enum SpritesKeys: String, CodingKey {
            case normal
            case shiny
        }
    }
}
