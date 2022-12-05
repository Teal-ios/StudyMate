//
//  DateFormatterHelper.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/06.
//

import Foundation

final class DateFormatterHelper {
    private init() { }
    static let standard = DateFormatterHelper()
    
    func dateChangeForChat(dateString: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.string(from: dateString)
    }
}
