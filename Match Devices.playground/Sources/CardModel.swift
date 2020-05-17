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
