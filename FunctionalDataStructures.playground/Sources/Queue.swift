import Foundation

public protocol Queue {
    associatedtype Element
    
    func isEmpty() -> Bool
    
    // Add element to the end
    func snoc(elem:Element) -> Self
    func head() -> Element?
    func tail() -> Self
}

public protocol Deque : Queue {
    
    // Add element to start
    func cons(elem:Element) -> Self
    
    // Get element from end
    func last() -> Element?
    
    // Get and remove last element
    func dropLast() -> Self
}
