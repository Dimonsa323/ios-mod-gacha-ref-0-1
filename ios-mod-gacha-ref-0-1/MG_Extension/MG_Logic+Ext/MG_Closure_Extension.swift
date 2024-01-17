//
//  MG_Closure_Extension.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 17.01.2024.
//
import Foundation

typealias MG_EmptyClosure = () -> Void
typealias MG_ValueClosure<T> = (T) -> Void
typealias MG_ValueReturnClosure<T, V> = (T) -> V
typealias MG_AsyncValueClosure<T> = (T) async -> Void
typealias MG_AsyncEmptyClosure = () async -> Void
typealias MG_AsyncThrowEmptyClosure = () async throws -> Void
typealias MG_BuilderClosure<T> = () -> T
typealias MG_BuilderClosureValue<V, T> = (V) -> T
