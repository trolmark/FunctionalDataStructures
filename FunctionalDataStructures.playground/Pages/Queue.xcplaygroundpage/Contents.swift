//: [Previous](@previous)

import Foundation


struct BatchedQueue<Elem> : Queue {
    typealias Element = Elem
    
    fileprivate var f : [Elem] = []
    fileprivate var r : [Elem] = []
    
    func isEmpty() -> Bool {
        return f.isEmpty
    }
    
    func head() -> Elem? {
        return f.first
    }
    
    func tail() -> BatchedQueue<Elem> {
        let newF = Array(f.dropFirst())
        return checkF(f: newF, r: r)
    }
    
    func snoc(elem: Elem) -> BatchedQueue<Elem> {
        let newR =  [elem] + r
        return checkF(f: f, r: newR)
    }
    
    /* Elements are added to r and removed from f , so they must somehow migrate from 
     one list to the other. This is accomplished by reversing R and installing the result 
     as the new F whenever F would otherwise become empty, simultaneously setting the new R to [ ] */
    
    func checkF(f:[Elem], r:[Elem]) -> BatchedQueue<Elem> {
        if f.isEmpty {
            return BatchedQueue(f: r.reversed(), r: [])
        } else {
            return BatchedQueue(f: f, r: r)
        }
    }
}

let queue = BatchedQueue<Int>()
print(queue
    .snoc(elem: 1)
    .snoc(elem: 2)
    .snoc(elem: 7)
    .tail()
    .head()!)



struct LazyQueue<Elem> : Queue {
    
    fileprivate var f : [Elem] = []
    fileprivate var r : [Elem] = []
    fileprivate var lenF : Int = 0
    fileprivate var lenR : Int = 0
    
    
    typealias Element = Elem
    
    func isEmpty() -> Bool {
        return (lenF == 0)
    }
    
    func head() -> Elem? {
        return nil
    }
    
    func tail() -> LazyQueue<Elem> {
        return self
    }
    
    func snoc(elem: Elem) -> LazyQueue<Elem> {
        return self
    }
    
}

//: [Next](@next)
