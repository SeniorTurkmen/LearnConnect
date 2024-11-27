//
//  Clousers.swift
//  Utilities
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import UIKit

public typealias VoidClosure = (() -> Void)
public typealias StringClosure = ((String) -> Void)
public typealias DataClosure = ((Data) -> Void)
public typealias OptionalStringClosure = ((String?) -> Void)
public typealias IndexPathClosure = ((IndexPath) -> Void)
public typealias IntClosure = ((Int) -> Void)
public typealias DoubleClosure = ((Double) -> Void)
public typealias DateClosure = ((Date) -> Void)
public typealias AnyClosure<T: Any> = ((T) -> Void)
public typealias NullableAnyClosure<T: Any> = ((T?) -> Void)
public typealias ArrayClosure<T: Any> = (([T]) -> Void)
public typealias BoolClosure = ((Bool) -> Void)
