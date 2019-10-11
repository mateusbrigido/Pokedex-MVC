import UIKit

class PokemonListViewController: UIViewController {

    private let pokedex = Pokedex()
    
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
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pokedex.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon = Pokedex.list[indexPath.row]
        
        cell.nameLabel.text = pokemon.name
        cell.orderLabel.text = "#\(pokemon.order)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try! Data(contentsOf: pokemon.defaultSprite)
            
            DispatchQueue.main.async {
                cell.pokemonImageView.image = UIImage(data: data)
            }
        }
        
        for index in pokemon.types.indices {
            cell.typesImageViews[index].image = UIImage(named: pokemon.types[pokemon.types.count - index - 1].name)
        }
        
        return cell
    }
}
