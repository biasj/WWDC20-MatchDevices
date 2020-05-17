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
    
}
