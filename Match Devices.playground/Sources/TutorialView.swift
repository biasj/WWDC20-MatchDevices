import UIKit

public class TutorialView: UIView{
    
    public let tutorialText = UITextView()
    public let tutorialAnimationView = UIImageView()
    
    public var tutorialAnimation = [UIImage]()
    public var model = AnimationModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupTutorialText()
        setupTutorialAnimationView()
          
        // animates 40 images called tutorialAnimation followed by a number from 0 to 39
        tutorialAnimation = model.createImageArray(imageNames: "tutorialAnimation", imageCount: 40)
        model.animateImages(imageView: tutorialAnimationView, images: tutorialAnimation)
        
        addSubview(tutorialText)
        addSubview(tutorialAnimationView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

