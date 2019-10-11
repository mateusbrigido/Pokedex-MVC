import Foundation

class Pokedex {
    
    private let sessionManager = SessionManager()
    
    private(set) static var list = [Pokemon]()
    
    func downloadList(completed: @escaping ([Pokemon]) -> Void) {
        if Pokedex.list.count > 0 { completed(Pokedex.list) }
        
        sessionManager.getPokemonList { (pokemonList) in
            Pokedex.list = pokemonList
            completed(pokemonList)
        }
    }
    
}
