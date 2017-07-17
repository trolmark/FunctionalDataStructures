import Foundation

public protocol Queue {
    associatedtype Element
    
    func isEmpty() -> Bool
    func snoc(elem:Element) -> Self
    func head() -> Element?
    func tail() -> Self
}

public protocol Deque : Queue {
    func cons(elem:Element) -> Self
    func last() -> Element?
    func dropLast() -> Self
}
