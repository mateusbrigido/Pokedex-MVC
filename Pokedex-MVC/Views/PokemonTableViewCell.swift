import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    
    @IBOutlet var typesImageViews: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        pokemonImageView.image = nil
        nameLabel.text = nil
        orderLabel.text = nil
        
        for imageView in typesImageViews {
            imageView.image = nil
        }
    }
    
}
