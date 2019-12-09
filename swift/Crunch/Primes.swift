import Foundation

class PrimeCalculator {
    var threads = 1
    var onCanContinue: ()->Bool = {() in return false}
    var onComplete: ()->Void = {() in }
    var lastPrime: Int32 = 0, totalPrimes: Int32 = 0
    
    func calcWorker() {
        while onCanContinue() {
            if isPrime(n:lastPrime) {
                print(lastPrime)
                OSAtomicIncrement32(&totalPrimes)
            }
            OSAtomicIncrement32(&lastPrime)
        }
    }
    
    func calcPrimes() {
        lastPrime = 1
        totalPrimes = 0
        let group = DispatchGroup()
        repeat {
            group.enter()
            DispatchQueue.global(qos: .background).async {
                self.calcWorker()
                group.leave()
            }
            threads -= 1
        } while threads > 0
        group.notify(queue: .main, execute: {
            self.onComplete()
        })
    }
    
    func isPrime(n:Int32)->Bool {
        if n<4 {
            return n>1
        }
        for i in 2...Int32(Double(n).squareRoot()) {
            if n % i == 0 {
                return false
            }
        }
        return true
    }
}

