import UIKit

// This is where the puzzle happens
public class PuzzleViewController : UIViewController{
    
    // puzzle view setup
    var puzzleView: PuzzleView! { return self.view as? PuzzleView }
    var board: UICollectionView! { return puzzleView.board }
    var feedbackText: UITextView! { return puzzleView.feedbackText }
    var checkButton: UIButton! { return puzzleView.checkButton }
    var resetButton: UIButton! { return puzzleView.resetButton }

    // collection view reusable cell identifier
    public var reuseIdentifier = "CardCell"
    
    public var cardsArray = [Card]()
    public var cellModel = CardCollectionViewCell()
    public var cardModel = CardModel()
    
    // stores which cell has been touched in collection view
    public var firstSelectedCardIndex:IndexPath?
    public var secondSelectedCardIndex:IndexPath?
    
    // counts how many times cards have been swapped
    public var cardSwapped = 0
    
    public override func viewDidLoad() {
        
        self.view = PuzzleView()
        
        self.checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        self.resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        // cards configuration to be displayed in collection view cells
        cardsArray = cardModel.generateArray()

        setupNavigationBar()
        
        setupCollectionView()
    }
    
    // custom title in navigation bar setup
    public func setupNavigationBar(){
        let imageView = UIImageView(image: UIImage(named: "titlePuzzle"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
            imageView.frame = titleView.bounds
            titleView.addSubview(imageView)

        // sets image view with puzzle title in navigation bar center
        self.navigationItem.titleView = titleView
    }
    
    public func setupCollectionView(){
        board?.delegate = self
        board?.dataSource = self
        
        //register cell
        board?.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        board?.allowsMultipleSelection = true
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
        cellModel.swapCardsPosition(cardsArray: cardsArray, firstIndex: firstSelectedCardIndex, secondIndex: secondSelectedCardIndex)
        
        // update statuses
        board?.reloadItems(at: [firstSelectedCardIndex!, secondSelectedCardIndex!])
        firstSelectedCardIndex = nil
        secondSelectedCardIndex = nil
        
        // score counts
        cardSwapped += 1
    }
    
    // shows feedback when button check is pressed
    public func giveFeedback(row: Bool, col: Bool, quarter: Bool){
        // three possible feedbacks
        let badFeedback = "Hmmm... There must be a device repeating somewhere, keep playing"
        let goodFeeback = "Congratulations!! You grouped all colors with \(cardSwapped) swaps!"
        let beatRecordFeedback = "WOW! You beat my record with \(cardSwapped) swaps!!"
        
        // if there's no device repeating in row and columns and if all colors are in the same quarter
        if row && col && quarter{
            feedbackText.textColor = .systemGreen
            // if score is less than 10, beat record
            if cardSwapped < 10 {
                feedbackText.text = beatRecordFeedback
            } else{
                // if just solved but didn't break record
                feedbackText.text = goodFeeback
            }
        // if puzzle isn't solved yet
        } else{
            feedbackText.textColor = .red
            feedbackText.text = badFeedback
        }
    }
    
        
    // resets the whole game: new board and scores
    @objc func resetButtonPressed(_ sender: UIButton){
        // removes all cards from the array and generate new ones, in different positions
        cardsArray.removeAll()
        cardsArray = cardModel.generateArray()
        
        // updates score and board
        board?.reloadData()
        cardSwapped = 0
        
        // set buttons in initial position and hides feedback text
        feedbackText.alpha = 0
        checkButton.frame = CGRect(x: 140, y: 420, width: 120, height: 50)
        resetButton.frame = CGRect(x: 125, y: 490, width: 150, height: 50)
        
    }
        
    @objc func checkButtonPressed(_ sender: UIButton){
        // check all rows for same color
        let row = cellModel.checkAllRows(cardsArray: cardsArray)
        
        // check all columns for same color
        let col = cellModel.checkAllColumns(cardsArray: cardsArray)

        // check all quarters for different devices
        let quarter = cellModel.checkAllQuarters(cardsArray: cardsArray)
        
        // feedback
        giveFeedback(row: row, col: col, quarter: quarter)
        
        // display feedback and adjust buttons
        checkButton.frame = CGRect(x: 140, y: 450, width: 120, height: 50)
        resetButton.frame = CGRect(x: 125, y: 520, width: 150, height: 50)
        feedbackText.alpha = 1
    }
    
}

// MARK: Delegate protocols for Collection View
extension PuzzleViewController: UICollectionViewDelegate{
     public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = cardsArray[indexPath.row]
        card.isSelected = true
        
        // decides which card is selected, the first or the second.
        selectCard(indexPath: indexPath)
    }
    
     public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // it's only possible to deselect the first card
        let card = cardsArray[indexPath.row]
        card.isSelected = false
        firstSelectedCardIndex = nil
    }
}

extension PuzzleViewController: UICollectionViewDataSource{
     public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // custom cell class
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        
        // sets cards to cell
        let card = cardsArray[indexPath.row]
        cell.setCard(card)
        
        // cell appearance setup
        cell.backgroundColor = .systemBlue
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 5.0
        
        return cell
    }
    
     public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // collection view is going to have the same quantity of cells as cardsArray elements
        return cardsArray.count
    }
}

// layout configuration
extension PuzzleViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // cell size
        return CGSize(width: 67, height: 67)
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // space between rows and columns
        return 5
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // space between cards in rows and columns
        return 5
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // space between collection view and section (there's only one section)
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
