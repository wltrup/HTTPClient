import Foundation
import Dispatch

// Shamelessly appropriated from https://github.com/basememara/SynchronizedGeneric

public struct SynchronizedBarrier <Value> {

    public init(_ value: Value) {
        self._value = value
    }

    public var value: Value { mutex.sync { _value } }

    public mutating func value <T> (execute task: (inout Value) throws -> T) rethrows -> T {
        try mutex.sync(flags: .barrier) { try task(&_value) }
    }

    private let mutex = DispatchQueue(label: "SynchronizedBarrier", attributes: .concurrent)
    private var _value: Value

}
