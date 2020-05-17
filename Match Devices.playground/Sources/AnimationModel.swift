import Foundation
import UIKit

public class AnimationModel{
    public init(){}
    
    // creates an array of UIImages to be used in the animation
    public func createImageArray(imageNames: String, imageCount: Int) -> [UIImage]{
        var imagesArray = [UIImage]()
        
        for i in 0..<imageCount{
            let tempImageName = "\(imageNames)\(i).png"
            let image = UIImage(named: tempImageName)!
            
            imagesArray.append(image)
        }
        return imagesArray
    }
    
    // animates an array of images inside an image view
    public func animateImages(imageView: UIImageView, images: [UIImage]){
        imageView.animationImages = images
        imageView.animationDuration = 10.0
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
    
    
}
