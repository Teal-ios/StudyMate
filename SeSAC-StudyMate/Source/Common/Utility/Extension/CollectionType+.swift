
import Foundation

//MARK: - Collection Type들에서 배열 개수를 초과했을 때 runtime Error가 아닌 nil값을 반환해주는 Logic
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
