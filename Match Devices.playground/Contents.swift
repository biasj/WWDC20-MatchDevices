//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class InitialViewController: UIViewController{
    
    var gameTitle = UIImageView()
    var imageLogo = UIImageView()

    var playButton = UIButton()
    var tutorialButton = UIButton()
    

    override func viewDidLoad() {
        

        view.backgroundColor = .white

        setupGameTitle()
        setupImageLogo()
        setupPlayButton()
        setupTutorialButton()

        view.addSubview(gameTitle)
        view.addSubview(imageLogo)
        view.addSubview(tutorialButton)
        view.addSubview(playButton)
    }
    
    // hide navigationController only on initial view controller
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    // MARK: UIKit components configuration
    func setupGameTitle(){
        gameTitle.frame = CGRect(x: 75, y: 45, width: 250, height: 60)
        gameTitle.image = UIImage(named: "titlePuzzle")
    }

    func setupImageLogo(){
        imageLogo.image = UIImage(named: "logo.png")
        imageLogo.frame = CGRect(x: 90, y: 140, width: 220, height: 220)
    }

    func setupPlayButton(){
        playButton.frame = CGRect(x: 145, y: 400, width: 110, height: 50)
        playButton.setImage(UIImage(named: "buttonPlay"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    }

    func setupTutorialButton(){
        tutorialButton.frame = CGRect(x: 130, y: 470, width: 140, height: 55)
        tutorialButton.setImage(UIImage(named: "buttonTutorial"), for: .normal)
        tutorialButton.addTarget(self, action: #selector(tutorialButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Buttons actions inside first view controller
    @objc func playButtonPressed(_ sender: UIButton){
        // go to puzzle view
        navigationController?.pushViewController(puzzleView, animated: true)
    }
    
    @objc func tutorialButtonPressed(_ sender: UIButton){
        // go to tutorial view
        navigationController?.pushViewController(tutorialView, animated: true)
    }
}


//View Controllers
var root = InitialViewController()
var puzzleView = PuzzleViewController()
var tutorialView = TutorialViewController()

// Present the view controller in the Live View window
root.preferredContentSize = CGSize(width: 400, height:550)
let nav = UINavigationController(rootViewController: root)
PlaygroundPage.current.liveView = nav

