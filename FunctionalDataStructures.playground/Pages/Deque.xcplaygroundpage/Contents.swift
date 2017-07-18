//: [Previous](@previous)

import Foundation


struct BankersDeque<Elem> {
    
    fileprivate var f : [Elem] = []
    fileprivate var r : [Elem] = []
    fileprivate var lenF : Int = 0
    fileprivate var lenR : Int = 0
    
    let c : Int
}

extension BankersDeque : Deque {
    
    typealias Element = Elem
    
    func isEmpty() -> Bool {
        return (lenF + lenR == 0)
    }
    
    func head() -> Elem? {
        if isEmpty() { return nil }
        else if lenF == 0 && lenR != 0 { return r.first }
        else { return f.first }
    }
    
    func tail() -> BankersDeque<Elem> {
        if isEmpty() { return self }
        else if lenF == 0 && lenR != 0 {
            return BankersDeque.init(f: [], r: [],
                                     lenF: 0, lenR: 0, c: c)
        } else {
            let newF = Array(f.dropFirst())
            return check(lenF: lenF - 1, fStream: newF, lenR: lenR, rStream: r)
        }
    }
    
    func snoc(elem: Elem) -> BankersDeque<Elem> {
        let newR =  [elem] + r
        return check(lenF: lenF, fStream: f, lenR: lenR + 1, rStream: newR)
    }
    
    func cons(elem:Element) -> BankersDeque<Elem> {
        return self
    }
    
    func last() -> Element? {
        return r.last
    }
    
    func dropLast() -> BankersDeque<Elem> {
        return self
    }
}

private extension BankersDeque {
    
    func check(lenF:Int, fStream:[Elem],lenR:Int, rStream:[Elem]) -> BankersDeque<Elem> {
        return self
    }
}




//: [Next](@next)
