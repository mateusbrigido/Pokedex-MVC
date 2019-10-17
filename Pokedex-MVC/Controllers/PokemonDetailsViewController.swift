import UIKit

class PokemonDetailsViewController: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var statsNames: [UILabel]!
    @IBOutlet var statsValues: [UILabel]!
    @IBOutlet var statsFillBarWidths: [NSLayoutConstraint]!
    
    @IBOutlet var typesImageViews: [UIImageView]!
    
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.round(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], with: 50)
        }
    }
    
    @IBOutlet var statsBackgroundBars: [UIView]! {
        didSet {
            let _ = statsBackgroundBars.map({ $0.round(with: 4) })
        }
    }
    
    @IBOutlet var statsFillBars: [UIView]! {
        didSet {
            for bar in statsFillBars {
                bar.round(with: 4)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setTypeBackgroundColor(for: pokemon!.types[0].name)
        
        nameLabel.text = pokemon.name
        descriptionLabel.text = pokemon.description
        
        for stat in pokemon!.stats {
            switch stat.name {
            case "hp":
                statsValues[0].text = "\(stat.value)"
                statsNames[0].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            case "attack":
                statsValues[1].text = "\(stat.value)"
                statsNames[1].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            case "defense":
                statsValues[2].text = "\(stat.value)"
                statsNames[2].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            case "special-attack":
                statsValues[3].text = "\(stat.value)"
                statsNames[3].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            case "special-defense":
                statsValues[4].text = "\(stat.value)"
                statsNames[4].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            case "speed":
                statsValues[5].text = "\(stat.value)"
                statsNames[5].textColor = UIColor(named: "\(pokemon.types[0].name)-1")
            default: break
            }
        }
        
        for index in pokemon!.types.indices {
            typesImageViews[index].image = UIImage(named: "\(pokemon.types[index].name)-tag")
            typesImageViews[index].isHidden = false
        }
        
        Cache.getImage(for: self.pokemon.defaultSprite) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.pokemonImageView.image = image
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for stat in pokemon.stats {
            switch stat.name {
            case "hp":
                statsFillBarWidths[0].constant = CGFloat((Double(stat.value)/255.0) * 240)
            case "attack":
                statsFillBarWidths[1].constant = CGFloat((Double(stat.value)/255.0) * 240)
            case "defense":
                statsFillBarWidths[2].constant = CGFloat((Double(stat.value)/255.0) * 240)
            case "special-attack":
                statsFillBarWidths[3].constant = CGFloat((Double(stat.value)/255.0) * 240)
            case "special-defense":
                statsFillBarWidths[4].constant = CGFloat((Double(stat.value)/255.0) * 240)
            case "speed":
                statsFillBarWidths[5].constant = CGFloat((Double(stat.value)/255.0) * 240)
            default: break
            }
        }
        
        UIView.animate(withDuration: 0.3, animations:{
            self.view.layoutIfNeeded()
            
            for bar in self.statsFillBars {
                bar.setTypeBackgroundColor(for: self.pokemon.types[0].name)
            }
        })
    }
        
    
}
