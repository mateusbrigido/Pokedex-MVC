import Foundation

class SessionManager {
    private let session = URLSession(configuration: .ephemeral)
    
    public func getPokemonList(completed: @escaping ([Pokemon]) -> Void) {
        guard let url = URL(string: "https://pokedex-23964.firebaseio.com/pokemon.json") else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let pokemonList = try decoder.decode([Pokemon].self, from: data)
                
                completed(pokemonList)
            } catch {
                print("\(error)")
            }
        }
        task.resume()
    }
    
}
