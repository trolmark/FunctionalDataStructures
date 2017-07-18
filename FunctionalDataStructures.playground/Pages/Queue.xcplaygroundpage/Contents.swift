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
}

private extension BatchedQueue {
    
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



struct LazyQueue<Elem> : Queue {
    
    var f : [Elem] = []
    var r : [Elem] = []
    var lenF : Int = 0
    var lenR : Int = 0
    
    
    typealias Element = Elem
    
    func isEmpty() -> Bool {
        return (lenF == 0)
    }
    
    func head() -> Elem? {
        return f.first
    }
    
    func tail() -> LazyQueue<Elem> {
        let newF = Array(f.dropFirst())
        return check(lenF: lenF - 1, fStream: newF, lenR: lenR, rStream: r)
    }
    
    func snoc(elem: Elem) -> LazyQueue<Elem> {
        let newR =  [elem] + r
        return check(lenF: lenF, fStream: f, lenR: lenR + 1, rStream: newR)
    }
}

private extension LazyQueue {
    
    func check(lenF:Int, fStream:[Elem],lenR:Int, rStream:[Elem]) -> LazyQueue<Elem> {
        if lenR <= lenF {
            return LazyQueue(f: fStream,
                             r: rStream, lenF: lenF, lenR: lenR)
        } else {
            return LazyQueue(f: fStream + rStream.reversed(),
                             r: [], lenF: lenF + lenR, lenR: 0)
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

//: [Next](@next)
