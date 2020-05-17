import UIKit

public class InitialView: UIView{
    
    // initial view components
    public var gameTitle = UIImageView()
    public var imageLogo = UIImageView()
    public var playButton = UIButton()
    public var tutorialButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupGameTitle()
        setupImageLogo()
        setupPlayButton()
        setupTutorialButton()
        
        addSubview(gameTitle)
        addSubview(imageLogo)
        addSubview(playButton)
        addSubview(tutorialButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // image view for Game Title
    public func setupGameTitle(){
        gameTitle.frame = CGRect(x: 75, y: 45, width: 250, height: 60)
        gameTitle.image = UIImage(named: "titlePuzzle")
    }

    // image view for game logo
    public func setupImageLogo(){
        imageLogo.image = UIImage(named: "logo.png")
        imageLogo.frame = CGRect(x: 90, y: 140, width: 220, height: 220)
    }
    
    // button setup for play button
    public func setupPlayButton(){
        playButton.frame = CGRect(x: 145, y: 400, width: 110, height: 50)
        playButton.setImage(UIImage(named: "buttonPlay"), for: .normal)
    }

    // button setup for tutorial button
    public func setupTutorialButton(){
        tutorialButton.frame = CGRect(x: 130, y: 470, width: 140, height: 55)
        tutorialButton.setImage(UIImage(named: "buttonTutorial"), for: .normal)
    }
    
}

