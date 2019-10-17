import Foundation
import UIKit

struct Cache {
    
    private static var images = [URL : UIImage]()
    
    static func getImage(for url: URL, completed: @escaping (UIImage?) -> Void) {
        if let image = images[url] {
            completed(image)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                images[url] = image
                
                completed(image)
            }
        }
    }
    
    
}
