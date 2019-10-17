import Foundation
import UIKit

struct Cache {
    
    private static var images = [URL : UIImage]()
    private static let downloadQueue = DispatchQueue(label: "ImageDownloadQueue", attributes: .concurrent)
    private static let updateQueue = DispatchQueue(label: "ImageUpdateQueue")
    
    static func getImage(for url: URL, completed: @escaping (UIImage?) -> Void) {
        Cache.updateQueue.async {
            if let image = images[url] {
                completed(image)
                return
            }
        }
        
        
        Cache.downloadQueue.async {
            if let data = try? Data(contentsOf: url) {
                Cache.updateQueue.async {
                    images[url] = UIImage(data: data)
                    completed(images[url])
                }
            }
        }
    }
    
    
}
