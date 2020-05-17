//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class InitialViewController: UIViewController{
    
    // initial view setup
    var initialView: InitialView! { return self.view as? InitialView }
    var playButton: UIButton! { return initialView.playButton }
    var tutorialButton: UIButton! { return initialView.tutorialButton }
    
    override func loadView(){
        self.view = InitialView()
    }
    
    override func viewDidLoad() {
    
        view.backgroundColor = .white
        
        self.playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        self.tutorialButton.addTarget(self, action: #selector(tutorialButtonPressed), for: .touchUpInside)
    }
    
    // hide navigationController only on initial view controller
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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

