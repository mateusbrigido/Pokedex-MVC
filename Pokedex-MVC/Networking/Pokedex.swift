import Foundation

class Pokedex {
    
    private let sessionManager = SessionManager()
    
    private(set) var list: [Pokemon]?
    
    func downloadList(completed: @escaping ([Pokemon]) -> Void) {
        if let pokemonList = self.list, pokemonList.count > 0 { completed(pokemonList) }
        
        sessionManager.getPokemonList { (pokemonList) in
            self.list = pokemonList
            completed(pokemonList)
        }
    }
    
}
