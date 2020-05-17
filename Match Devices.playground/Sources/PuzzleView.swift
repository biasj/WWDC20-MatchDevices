import UIKit

public class PuzzleView: UIView{
    
    // puzzle view components
    public var board: UICollectionView?    
    public var feedbackText = UITextView()
    public var checkButton = UIButton()
    public var resetButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let layout:UICollectionViewLayout = UICollectionViewFlowLayout()

        board = UICollectionView(frame: CGRect(x: 50, y: 90, width: 300, height: 293), collectionViewLayout: layout)
        
        setupFeedbackText()
        setupCheckButton()
        setupResetButton()
        
        addSubview(board ?? UICollectionView())
        setupBoardAppearance(board: board!)
        
        addSubview(feedbackText)
        addSubview(checkButton)
        addSubview(resetButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupBoardAppearance(board: UICollectionView){
        board.backgroundColor = .white
        board.layer.borderWidth = 2.0
        board.layer.borderColor = UIColor.white.cgColor
        board.layer.cornerRadius = 5.0
    }
    
    public func setupFeedbackText(){
        // text appearance
        feedbackText.frame = CGRect(x: 50, y: 385, width: 300, height: 65)
        feedbackText.alpha = 0
        
        // text
        feedbackText.font = UIFont.boldSystemFont(ofSize: 16)
        feedbackText.textColor = .black
        feedbackText.textAlignment = .center
        
        feedbackText.isScrollEnabled = false
        feedbackText.isEditable = false
    }
            
    public func setupCheckButton(){
        checkButton.frame = CGRect(x: 140, y: 420, width: 120, height: 50)
        checkButton.setImage(UIImage(named: "buttonCheck"), for: .normal)
    }
    
    public func setupResetButton(){
        resetButton.frame = CGRect(x: 125, y: 490, width: 150, height: 50)
        resetButton.setImage(UIImage(named: "buttonNewBoard"), for: .normal)
    }
    
}

