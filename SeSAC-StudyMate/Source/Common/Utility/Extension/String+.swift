
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
}
