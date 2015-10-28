//
//  AccessTwitterAccount.swift
//  TwitterCF
//
//  Created by Heidi Yee on 10/27/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation
import Accounts

class AccessTwitterAccount {
    
    class func loginTwitter(completionHandler: (String?, ACAccount?) -> ()) {
        
        let accountStore = ACAccountStore()
    
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error {
                completionHandler("ERROR: Request access to accounts returned an error.", nil); return
            }
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completionHandler(nil, account); return
                }
                
            completionHandler("ERROR: No twitter accounts were found on this device.", nil); return
                
            }
        })
        
        completionHandler("No access to Twittter Accounts", nil); return
        
    }

}

