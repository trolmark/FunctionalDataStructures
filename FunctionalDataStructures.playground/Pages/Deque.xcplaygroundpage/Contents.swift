//: [Previous](@previous)

import Foundation


struct BankersDeque<Elem> {
    
    fileprivate var queue = QueueBase<Elem>()
    let c : Int
}

extension BankersDeque : Deque {
    
    typealias Element = Elem
    
    func isEmpty() -> Bool {
        return (queue.lenF + queue.lenR == 0)
    }
    
    func head() -> Elem? {
        if isEmpty() { return nil }
        else if queue.lenF == 0 && queue.lenR != 0 {
            return queue.r.first
        } else {
            return queue.f.first
        }
    }
    
    func tail() -> BankersDeque<Elem> {
        if isEmpty() { return self }
        else if queue.lenF == 0 && queue.lenR != 0 {
            return BankersDeque(queue: self.queue, c: c)
        } else {
            let newF = Array(queue.f.dropFirst())
            let newQueue = QueueBase(f: newF, r: queue.r, lenF: queue.lenF - 1, lenR: queue.lenR)
            return check(queue: newQueue, c: c)
        }
    }
    
    func snoc(elem: Elem) -> BankersDeque<Elem> {
        let newR =  [elem] + queue.r
        let newQueue = QueueBase(f: queue.f, r: newR, lenF: queue.lenF, lenR: queue.lenR + 1)
        return check(queue: newQueue, c: c)
    }
    
    func cons(elem:Element) -> BankersDeque<Elem> {
        let newF =  [elem] + queue.f
        let newQueue = QueueBase(f: newF, r: queue.r, lenF: queue.lenF + 1, lenR: queue.lenR)
        return check(queue: newQueue, c: c)
    }
    
    func last() -> Element? {
        if isEmpty() { return nil }
        else if queue.lenR == 0 && queue.lenF != 0 {
            return queue.f.first
        } else {
            return queue.r.first
        }
    }
    
    func dropLast() -> BankersDeque<Elem> {
        if isEmpty() { return self }
        else if queue.lenR == 0 && queue.lenF != 0 {
            return BankersDeque(queue: self.queue, c: c)
        } else {
            let newR = Array(queue.r.dropFirst())
            let newQueue = QueueBase(f: queue.f, r: newR, lenF: queue.lenF, lenR: queue.lenR - 1)
            return check(queue: newQueue, c: c)
        }
    }
}

private extension BankersDeque {
    
    func check(queue:QueueBase<Elem>, c:Int) -> BankersDeque<Elem> {
        
        let i : Int = (queue.lenF + queue.lenR)/2
        let j : Int = queue.lenF + queue.lenR - i
        
        if queue.lenF > c*queue.lenR + 1 {
            let newF = Array(queue.f.prefix(upTo: i))
            let newR = queue.r + Array(queue.f.dropFirst(i)).reversed()
            let newQueue = QueueBase(f: newF, r: newR, lenF: i, lenR: j)
            
            return BankersDeque(queue: newQueue, c: c)
            
        } else if queue.lenR > c*queue.lenF + 1 {

            let newR = Array(queue.r.prefix(upTo: i))
            let newF = queue.f + Array(queue.r.dropFirst(i)).reversed()
            let newQueue = QueueBase(f: newF, r: newR, lenF: i, lenR: j)
            
            return BankersDeque(queue: newQueue, c: c)
        } else {
            return BankersDeque(queue: queue, c: c)
        }
    }
}




//: [Next](@next)
