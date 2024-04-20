//
//  String+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

extension String {
    
    func toDate(_ format: String = "yyyy-MM-dd HH:mm:ss VV") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func range(of string: String, backwards: Bool) -> NSRange? {
        let options = backwards ? NSString.CompareOptions.backwards : []
        let range = (self as NSString).range(of: string, options: options)
        return validateRange(range)
    }
    
    func validateRange(_ range: NSRange?) -> NSRange? {
        guard let range else { return nil }
        if range.location == NSNotFound || range.location + range.length > count {
            return nil
        }
        return range
    }
    
}

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
    
}
