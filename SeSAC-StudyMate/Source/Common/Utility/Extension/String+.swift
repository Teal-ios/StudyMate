
import Foundation

//MARK: - String에서도 배열처럼 String[0]을 사용할 수 있게 만드는 Logic
extension String {
        
    subscript(idx: Int) -> String? {
        
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
    func toPhoneNumberPattern(pattern: String, replacmentCharacter: Character) -> String {
            
            var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            
            pureNumber = pureNumber.count > 11 ? String(pureNumber[...pureNumber.index(startIndex,offsetBy: 10)]) : pureNumber
            
            for index in 0..<pattern.count {
                guard index < pureNumber.count else { return pureNumber }
                
                let stringIndex = String.Index(utf16Offset: index, in: pattern)
                let patternCharacter = pattern[stringIndex]
                
                guard patternCharacter != replacmentCharacter else { continue }
                pureNumber.insert(patternCharacter, at: stringIndex)
            }
            
            return pureNumber
        }
}
