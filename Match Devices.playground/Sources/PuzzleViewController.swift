import UIKit

// This is where the puzzle happens
public class PuzzleViewController : UIViewController{
    
    // board and cells related
    public var board: UICollectionView?
    public var reuseIdentifier = "CardCell"
    public var cardsArray = [Card]()
    public var model = CardModel()
    public var firstSelectedCardIndex:IndexPath?
    public var secondSelectedCardIndex:IndexPath?
    
    // counts how many times cards have been swapped
    public var cardSwapped = 0
     
    public var feedbackText = UITextView()
    public var resetButton = UIButton()
    public var checkButton = UIButton()
    
   
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        
        let layout:UICollectionViewLayout = UICollectionViewFlowLayout()

        board = UICollectionView(frame: CGRect(x: 50, y: 90, width: 300, height: 293), collectionViewLayout: layout)
        
        // cards configuration to be displayed in collection view cells
        cardsArray = model.generateArray()

        setupCollectionView()
        setupCheckButton()
        setupResetButton()
        setupFeedbackText()
        setupNavigationBar()
        
        view.addSubview(board ?? UICollectionView())
        view.addSubview(checkButton)
        view.addSubview(resetButton)
        view.addSubview(feedbackText)
        
    }
    
    // MARK: UIKit components configuration
    public func setupNavigationBar(){
        // center (title)
        let imageView = UIImageView(image: UIImage(named: "titlePuzzle"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
            imageView.frame = titleView.bounds
            titleView.addSubview(imageView)

        self.navigationItem.titleView = titleView
    }
    
    public func setupCollectionView(){
        board?.delegate = self
        board?.dataSource = self
        board?.allowsMultipleSelection = true
        board?.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        board?.backgroundColor = .white
        board?.layer.borderWidth = 2.0
        board?.layer.borderColor = UIColor.white.cgColor
        board?.layer.cornerRadius = 5.0
    }
    
    public func setupFeedbackText(){
        feedbackText.alpha = 0
        feedbackText.font = UIFont.boldSystemFont(ofSize: 16)
        feedbackText.textColor = .black
        feedbackText.textAlignment = .center
        feedbackText.isScrollEnabled = false
        feedbackText.isEditable = false
        feedbackText.frame = CGRect(x: 50, y: 385, width: 300, height: 65)
    }
    
    public func setupCheckButton(){
        checkButton.frame = CGRect(x: 140, y: 420, width: 120, height: 50)
        checkButton.setImage(UIImage(named: "buttonCheck"), for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        
    }
    
    public func setupResetButton(){
        resetButton.frame = CGRect(x: 125, y: 490, width: 150, height: 50)
        resetButton.setImage(UIImage(named: "buttonNewBoard"), for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Puzzle action
    
    // determine which card position the user is touching
    public func selectCard(indexPath: IndexPath){
        // if it's the first card selected, waits for another card to be touched
        if firstSelectedCardIndex == nil{
            firstSelectedCardIndex = indexPath
            
        // if it's the second card selected, swaps cards position
        }else{
            secondSelectedCardIndex = indexPath
            swapPositions()
        }
    }
    
    // if user has selected two cards, swap positions
    public func swapPositions(){
        // method from CardModel Class to swap card properties
        model.swapCardsPosition(cardsArray: cardsArray, firstIndex: firstSelectedCardIndex, secondIndex: secondSelectedCardIndex)
        
        // update statuses
        board?.reloadItems(at: [firstSelectedCardIndex!, secondSelectedCardIndex!])
        firstSelectedCardIndex = nil
        secondSelectedCardIndex = nil
        
        // score counts
        cardSwapped += 1
    }
    
    // resets the whole game: new board and scores
    @objc func resetButtonPressed(_ sender: UIButton){
        cardsArray.removeAll()
        cardsArray = model.generateArray()
        board?.reloadData()
        feedbackText.alpha = 0
        resetButton.setTitle("Reset board", for: .normal)
        checkButton.frame = CGRect(x: 140, y: 420, width: 120, height: 50)
        resetButton.frame = CGRect(x: 125, y: 490, width: 150, height: 50)
        cardSwapped = 0
    }
    
    @objc func checkButtonPressed(_ sender: UIButton){
        // check rows for same color
        let row = model.checkAllRows(cardsArray: cardsArray)
        
        // check columns for same color
        let col = model.checkAllColumns(cardsArray: cardsArray)

        // check corners for different devices
        let group = model.checkAllCorners(cardsArray: cardsArray)
        
        // feedback
        giveFeedback(row: row, col: col, group: group)
        
        // display feedback and ajust buttons
        checkButton.frame = CGRect(x: 140, y: 450, width: 120, height: 50)
        resetButton.frame = CGRect(x: 125, y: 520, width: 150, height: 50)
        feedbackText.alpha = 1
    }
    
    public func giveFeedback(row: Bool, col: Bool, group: Bool){
        let badFeedback = "Hmmm... There must be a device repeating somewhere, keep playing"
        let goodFeeback = "Congratulations!! You grouped all colors with \(cardSwapped) swaps!"
        let beatRecordFeedback = "WOW! You beat my record with \(cardSwapped) swaps!!"
        
        if row && col && group{
            feedbackText.textColor = .systemGreen
            if cardSwapped < 10 {
                feedbackText.text = beatRecordFeedback
            } else{
                feedbackText.text = goodFeeback
            }
        } else{
            feedbackText.textColor = .red
            feedbackText.text = badFeedback
        }
    }
}

// MARK: Delegate protocols for Collection View
extension PuzzleViewController: UICollectionViewDelegate{
     public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = cardsArray[indexPath.row]
        
        card.isSelected = true
        selectCard(indexPath: indexPath)
    }
    
     public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //preciso saber se é o firstSelected -> sempre vai ser o primeiro
        let card = cardsArray[indexPath.row]
        card.isSelected = false
        firstSelectedCardIndex = nil
        
    }
}

extension PuzzleViewController: UICollectionViewDataSource{
     public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        
        let card = cardsArray[indexPath.row]
        cell.setCard(card)
        
        cell.backgroundColor = .systemBlue
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 5.0
        return cell
    }
    
     public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
}

extension PuzzleViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 67, height: 67)
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}