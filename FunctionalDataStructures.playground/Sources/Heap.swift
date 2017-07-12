import Foundation


public protocol Heap {
    associatedtype Element
    
    func findMin() -> Element?
    func deleteMin() -> Self?
    func merge(with heap:Self) -> Self
    func insert(x:Element) -> Self
}
