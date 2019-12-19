import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var pokemonList = Pokedex.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setGradientBackground()
        setBlur()
    }

    private func setGradientBackground() {
        let color1 =  UIColor(red: 110.0/255.0, green: 149.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
        let color2 =  UIColor(red: 111.0/255.0, green: 222.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
        let color3 = UIColor(red: 141.0/255.0, green: 224.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor
        let color4 = UIColor(red: 81.0/255.0, green: 232.0/255.0, blue: 94.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.transform = CATransform3DMakeRotation(3 * CGFloat.pi / 2, 0, 0, 1)
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = self.view.bounds
        self.view.insertSubview(blurEffectView, at: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "pokemonDetailsSegue":
                let detailsVC = segue.destination as! PokemonDetailsViewController
                detailsVC.pokemon = self.pokemonList[tableView.indexPathForSelectedRow!.row]
            default:
                break;
        }
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon = self.pokemonList[indexPath.row]
        
        cell.nameLabel.text = pokemon.name
        cell.orderLabel.text = String(format: "#%03d",  pokemon.order)
        
        Cache.getImage(for: pokemon.defaultSprite) { (image) in
            DispatchQueue.main.async { [weak self] in
                let cellToUpdate = self?.tableView.cellForRow(at: indexPath) as? PokemonTableViewCell
                cellToUpdate?.pokemonImageView.image = image
            }   
        }
        
        for index in pokemon.types.indices {
            cell.typesImageViews[index].image = UIImage(named: "\(pokemon.types[pokemon.types.count - index - 1].name)-badge")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pokemonDetailsSegue", sender: nil)
    }
}

//MARK: - UISearchBarDelegate
extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.pokemonList = Pokedex.list
        } else {
            self.pokemonList = Pokedex.list.filter { $0.name.contains(searchText) }
        }
        
        tableView.reloadData()
    }
}
