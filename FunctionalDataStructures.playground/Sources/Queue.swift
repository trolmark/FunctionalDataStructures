import Foundation

public protocol Queue {
    associatedtype Element
    
    func isEmpty() -> Bool
    func snoc(elem:Element) -> Self
    func head() -> Element?
    func tail() -> Self
}
