
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
            
            // 0부터 9까지의 숫자만 입력되게 해줌
            var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            
            // 입력된 숫자가 11자리 넘는경우 실제 데이터엔 들어가지만 짤라서 보여줌
            // ...이 붙으면 인덱스 0부터 offsetBy: 10 이면 인덱스 0부터 10까지의 값을 나타냄
            // ...이 없으면 offsetBy: 10이면 인덱스 10의 값만 나옴
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
