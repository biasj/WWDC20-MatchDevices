import UIKit

public class TutorialViewController: UIViewController{
    
    public let tutorialText = UITextView()
    public let tutorialAnimationView = UIImageView()
    
    public var tutorialAnimation = [UIImage]()
    public var model = AnimationModel()
    
    public override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupTutorialText()
        setupTutorialAnimationView()
        
        setupNavigationBar()
        
        // animates 40 images called tutorialAnimation followed by a number from 0 to 39
        tutorialAnimation = model.createImageArray(imageNames: "tutorialAnimation", imageCount: 40)
        model.animateImages(imageView: tutorialAnimationView, images: tutorialAnimation)
        
        view.addSubview(tutorialText)
        view.addSubview(tutorialAnimationView)
    }
    
    public func setupNavigationBar(){
        let imageView = UIImageView(image: UIImage(named: "titleTutorial"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 40))
            imageView.frame = titleView.bounds
            titleView.addSubview(imageView)

        self.navigationItem.titleView = titleView
    
    }
    
    public func setupTutorialText(){
        tutorialText.text = "  This is an inspired sudoku puzzle, one of my greatest passions!\n   To solve this puzzle, you must group the cards by colors in a corner of the board.\n     It doesn't matter in which corner you're going to group a color, but you can't repeat any devices in any rows or columns.\n   To swap cards all you need to do is select the two you want to swap! Do you think you can beat my 10 swaps record?"
        tutorialText.textAlignment = .justified
        tutorialText.font = UIFont.systemFont(ofSize: 16)
        tutorialText.frame = CGRect(x: 10, y: 350, width: 380, height: 300)
        tutorialText.isEditable = false
        tutorialText.isScrollEnabled = false
    }
    
    public func setupTutorialAnimationView(){
        tutorialAnimationView.frame = CGRect(x: 75, y: 75, width: 250, height: 250)
        tutorialAnimationView.backgroundColor = .red
    }
    
}

