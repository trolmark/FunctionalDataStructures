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

public struct QueueBase<Elem> {
    
    public var f : [Elem] = []
    public var r : [Elem] = []
    public var lenF : Int = 0
    public var lenR : Int = 0
    
    public init() {
        self.f = []
        self.r = []
        self.lenR = 0
        self.lenF = 0
    }
    
    public init(f:[Elem], r:[Elem], lenF:Int, lenR:Int) {
        self.f = f
        self.r = r
        self.lenF = lenF
        self.lenR = lenR
    }
}
