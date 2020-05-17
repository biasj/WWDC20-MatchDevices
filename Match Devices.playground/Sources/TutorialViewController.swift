import UIKit

public class TutorialViewController: UIViewController{
    
    public override func viewDidLoad() {
        
        self.view = TutorialView()
        setupNavigationBar()
    
    }
    
    // custom title for navigation bar
    public func setupNavigationBar(){
        let imageView = UIImageView(image: UIImage(named: "titleTutorial"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 40))
            imageView.frame = titleView.bounds
            titleView.addSubview(imageView)

        self.navigationItem.titleView = titleView
    }
    
}

