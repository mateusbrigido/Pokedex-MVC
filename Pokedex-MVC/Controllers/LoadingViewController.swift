import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var pokeballView: UIView!
    
    @IBOutlet weak var bigCircle: UIView! {
        didSet {
            bigCircle.layer.cornerRadius = bigCircle.frame.height / 2
            bigCircle.clipsToBounds = true
            
            let color1 =  UIColor(red: 111.0/255.0, green: 222.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            let color2 = UIColor(red: 141.0/255.0, green: 224.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [color1, color2]
            gradientLayer.transform = CATransform3DMakeRotation(3 * CGFloat.pi / 2, 0, 0, 1)
            gradientLayer.frame = bigCircle.bounds

            bigCircle.layer.insertSublayer(gradientLayer, at:0)
        }
    }
    
    
    @IBOutlet weak var mediumCircle: UIView! {
        didSet {
            mediumCircle.backgroundColor = .clear
            mediumCircle.layer.cornerRadius = mediumCircle.frame.height / 2
            mediumCircle.clipsToBounds = true
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.frame = mediumCircle.bounds
            mediumCircle.addSubview(blurEffectView)
        }
    }
    
    @IBOutlet weak var smallCircle: UIView! {
        didSet {
            smallCircle.layer.cornerRadius = smallCircle.frame.height / 2
            smallCircle.clipsToBounds = true
            
            let color1 =  UIColor(red: 111.0/255.0, green: 222.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            let color2 = UIColor(red: 141.0/255.0, green: 224.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [color1, color2]
            gradientLayer.transform = CATransform3DMakeRotation(3 * CGFloat.pi / 2, 0, 0, 1)
            gradientLayer.frame = smallCircle.bounds

            smallCircle.layer.insertSublayer(gradientLayer, at:0)
        }
    }
    @IBOutlet weak var rectangle: UIView! {
        didSet {
            rectangle.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.frame = rectangle.bounds
            rectangle.addSubview(blurEffectView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setGradientBackground()
        setBlur()
        
        let pokedex = Pokedex()
        pokedex.downloadList() { (pokemonList) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "pokemonListSegue", sender: self)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pokeballView.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi / -4))
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat] , animations: {
            self.pokeballView.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi / 4))
        })
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
