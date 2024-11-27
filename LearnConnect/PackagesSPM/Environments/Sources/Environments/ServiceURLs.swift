//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public enum ServiceURLs {
#if (APPSTORE || PROD)
    public static let serviceURL = (BaseURLChanger.shared.config?.environment(
        for: .kdServices,
        environmentType: .prod)?.value) ?? ""
#elseif PREPROD
    public static let serviceURL = (BaseURLChanger.shared.config?.environment(
        for: .kdServices,
        environmentType: .preprod)?.value) ?? ""
#elseif TEST
    public static let serviceURL = (BaseURLChanger.shared.config?.environment(
        for: .kdServices,
        environmentType: .test)?.value) ?? ""
#elseif GADGET
    public static let serviceURL = UserDefaults.standard.serviceURLValue
#else
    public static let serviceURL = (BaseURLChanger.shared.config?.environment(
        for: .kdServices,
        environmentType: .test)?.value) ?? ""
#endif
}
