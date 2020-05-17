import Foundation

public class CardModel{
    public init() {}
    
    // creates an array of cards initialized with images
    public func getCards() -> [Card] {
        var cardsArray = [Card]()
        
        for i in 0...15{
            let tempCard = Card()
            tempCard.imageName = "card\(i).png"
            // ideal seria colocar isso aqui também
            cardsArray.append(tempCard)
        }
        
        return cardsArray
    }

    //function to set property deviceType to specific cards by its position in the array
    public func setDeviceType(cardsArray: [Card], firstPosition: Int, device: String){
        let secondPosition = firstPosition+2
        let thirdPosition = firstPosition+8
        let forthPosition = secondPosition+8
        let positions = [firstPosition, secondPosition, thirdPosition, forthPosition]
        
        for i in 0...3{
            cardsArray[positions[i]].deviceType = device
        }
    }
    
    // set property deviceType to all cards, determine which card is what deviceType
    public func setAllDevices(cardsArray: [Card]){
        let deviceDictionary = [0:"Watch", 1:"iPhone", 4:"Mac", 5:"iPad"]
        
        for (key, value) in deviceDictionary{
            setDeviceType(cardsArray: cardsArray, firstPosition: key, device: value)
        }
    }
    
    //function to set property color to specific cards by its position in the array
    public func setColor(cardsArray: [Card], firstPosition: Int, color: String){
        let secondPosition = firstPosition+1
        let thirdPosition = firstPosition+4
        let forthPosition = secondPosition+4
        let positions = [firstPosition, secondPosition, thirdPosition, forthPosition]
        
        for i in 0...3{
            cardsArray[positions[i]].color = color
        }
    }
    
    // set property color to all cards, determine which card is what color
    public func setAllColors(cardsArray:[Card]){
        let colorDictionary = [0:"Green", 2:"Red", 8:"Blue", 10:"Lightgreen"]
        
        for(key, value) in colorDictionary{
            setColor(cardsArray: cardsArray, firstPosition: key, color: value)
        }
    }
    
    // create an array of cards with all properties: image, deviceType and cards
    public func generateArray() -> [Card]{
        var cardsArray = getCards()
        setAllDevices(cardsArray: cardsArray)
        setAllColors(cardsArray: cardsArray)
        
        //randomize card array to display randomly during puzzle
        cardsArray.shuffle()
        
        return cardsArray
    }
    
    
    
}
