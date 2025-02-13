//
//  KeyChainManager.swift
//  MangasApp
//
//  Created by María Pérez  on 15/1/25.
//

import Foundation

final class KeyChainManager: Sendable {
    static let shared = KeyChainManager()
    
    func storeKey(key: Data, label: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
            kSecValueData: key
        ] as [String: Any]
        
        if readKey(label: label) == nil {
            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("Error grabando clave \(label): Error \(status)")
            }
        } else {
            let attributes = [
                kSecValueData: key
            ] as [String: Any]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if status != errSecSuccess {
                print("Error actualizando clave \(label): Error \(status)")
            }
        }
    }
    
    func readKey(label: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String: Any]
        
        var item: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess {
            return nil
        } else {
            return item as? Data
        }
    }
    
    func deleteKey(label: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label]
        as [CFString: Any]
        
        let result = SecItemDelete(query as CFDictionary)
        if result == noErr {
            print("Item \(label) borrado.")
        }
    }
}
