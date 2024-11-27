//
//  DataProvider.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider

public final class DataProvider {
    public static let shared = DataProvider()
#if !APPSTORE
    public let apiDataProvider = APIDataProvider(
    interceptor: DataProviderInterceptor.shared,
    eventMonitors: [APILogger.shared]
)
#else
    public let apiDataProvider = APIDataProvider(
    interceptor: DataProviderInterceptor.shared,
    eventMonitors: [APILogger.shared]
)
#endif
}
