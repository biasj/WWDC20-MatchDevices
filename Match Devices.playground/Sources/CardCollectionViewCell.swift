import UIKit

public class CardCollectionViewCell: UICollectionViewCell {
    
    public var cardImage = UIImageView()
    public var highlightedView = UIImageView()
     //instância da classe Card, que tem como propriedade o nome da imagem e uma propriedade que indica se está selecionada
    public var card:Card?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupCardImage()
        setupHighlightedImage()
        addSubview(cardImage)
        addSubview(highlightedView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // highlight cells by showing an hidden imageView if cell if touched
    public override var isHighlighted: Bool{
        didSet{
            highlightedView.isHidden = !isHighlighted
            highlightedView.layer.borderWidth = 3.0
        }
    }

    public override var isSelected: Bool{
        didSet{
            highlightedView.isHidden = !isSelected
        }
    }
        
    // sets card images
    public func setCard(_ card:Card) {
        self.card = card
        cardImage.image = UIImage(named: card.imageName)
    }
    
   
    public func setupCardImage(){
        cardImage.clipsToBounds = true
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.heightAnchor.constraint(equalToConstant: 67).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 67).isActive = true
        cardImage.layer.cornerRadius = 5
    }
    
    public func setupHighlightedImage(){
        highlightedView.isHidden = true
        highlightedView.alpha = 0.5
        highlightedView.backgroundColor = .opaqueSeparator
        highlightedView.clipsToBounds = true
        highlightedView.translatesAutoresizingMaskIntoConstraints = false
        highlightedView.heightAnchor.constraint(equalToConstant: 67).isActive = true
        highlightedView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        highlightedView.layer.cornerRadius = 5
    }
    
    // swap card properties in cell touched
    public func swapCardsPosition(cardsArray: [Card], firstIndex: IndexPath?, secondIndex: IndexPath?){
        // conteúdo do card a ser trocado
        let tempCardImageName = cardsArray[firstIndex!.row].imageName
        let tempCardDeviceType = cardsArray[firstIndex!.row].deviceType
        let tempCardColor = cardsArray[firstIndex!.row].color
        
        cardsArray[firstIndex!.row].imageName = cardsArray[secondIndex!.row].imageName
        cardsArray[firstIndex!.row].deviceType = cardsArray[secondIndex!.row].deviceType
        cardsArray[firstIndex!.row].color = cardsArray[secondIndex!.row].color
        
        cardsArray[secondIndex!.row].imageName = tempCardImageName
        cardsArray[secondIndex!.row].deviceType = tempCardDeviceType
        cardsArray[secondIndex!.row].color = tempCardColor
        
        cardsArray[firstIndex!.row].isSelected = false
        cardsArray[secondIndex!.row].isSelected = false
    }
    
    // check if there's a repeating device in a row
    public func checkRow(cardsArray: [Card], line: Int) -> Bool{
        var clear = true
        let endLine = line+3
        
        for j in line...endLine-1{
            let i = j+1
            for i in i...endLine{
                if cardsArray[j].deviceType == cardsArray[i].deviceType{
                    clear = false
                }
            }
        }
        
        return clear
    }
    
    // check all rows for same devices
    public func checkAllRows(cardsArray: [Card]) -> Bool{
        var count = 0
        var clear = true
        while count <= 12{
            clear = checkRow(cardsArray: cardsArray, line: count)
            count += 4
            if !clear {
                break
            }
        }
        return clear
    }
    
    // check a column for a repeating device
    public func checkColumn(cardsArray: [Card], column: Int) -> Bool {
        var clear = true
        var i = column
        var j = column + 4
        while i <= 8{
            j=i+4
            while j<=12{
                if cardsArray[i].deviceType == cardsArray[j].deviceType{
                    clear = false
                    break
                }
                j+=4
            }
            if !clear{
                break
            }
            i+=4
        }
        return clear
    }
    
    // check all columns for same device
    public func checkAllColumns(cardsArray: [Card]) -> Bool{
        var clear = true
        for j in 0...3{
            clear = checkColumn(cardsArray: cardsArray, column: j)
            if !clear{
                break
            }
        }
        return clear
    }
    
    // check a corner of the board for different colors
    public func checkCorner(cardsArray: [Card], firstPosition: Int) -> Bool{
        var clear = true
        // a corner is composed by 4 cells, two on top of another two, in a corner of the board
        let secondPosition = firstPosition+1
        let thirdPosition = firstPosition+4
        let forthPosition = secondPosition+4
        
        let positions = [firstPosition, secondPosition, thirdPosition, forthPosition]
        
        for i in 0...2{
            let j = i+1
            for j in j...3{
                if cardsArray[positions[i]].color != cardsArray[positions[j]].color{
                    clear = false
                    break
                }
            }
            if !clear{
                break
            }
        }
        return clear
    }
    
    // check all corner of the board for different colors
    public func checkAllCorners(cardsArray: [Card]) -> Bool{
        var clear = true
        let firstPositions = [0,2,8,10]
        
        for i in 0...3{
            clear = checkCorner(cardsArray: cardsArray, firstPosition: firstPositions[i])
            if !clear{
                break
            }
        }
        return clear
    }
    
}
