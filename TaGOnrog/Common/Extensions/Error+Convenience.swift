//
//  Error+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Moya

extension Error {
    
    func isCancelled() -> Bool {
        let nsError = self as NSError
        let afErrorCancelled = asAFError?.isExplicitlyCancelledError ?? false
        return afErrorCancelled || (nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorCancelled)
    }
    
}
