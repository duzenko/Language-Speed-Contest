import SwiftUI

var timer: Timer?

struct ContentView: View {
    @State var result: String = "Not run yet"
    
    var body: some View {
          //Text("Hello World")
          VStack {
            Button(action: {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                    print("Done!")
                    timer = nil
                })
                DispatchQueue.global(qos: .background).async {
                    calcPrimes()
                    self.result = "\(lastPrime) and \(totalPrimes) more"
                }
            }) {Text("Click here")}
            Text(result)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var lastPrime = 0, totalPrimes = 0

func calcPrimes() {
    lastPrime = 1
    totalPrimes = 0
    while timer != nil {
        if isPrime(n:lastPrime) {
            print(lastPrime)
            totalPrimes+=1
        }
        lastPrime+=1
    }
}

func isPrime(n:Int)->Bool {
    if n<4 {
        return n>1
    }
    for i in 2...Int(Double(n).squareRoot()) {
        if n % i == 0 {
            return false
        }
    }
    return true
}
