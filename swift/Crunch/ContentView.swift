import SwiftUI

struct ContentView: View {
    @State var status: String = "Not run yet"
    @State var threads = 1
    @State var timer: Timer?
    @State var calculator: PrimeCalculator?
    
    var body: some View {
        VStack {
            Text("Threads:")
            HStack {
                Button(action: { self.threads -= 1 }) {
                    Image(systemName: "chevron.left")
                    .padding()
                }.disabled(self.threads < 2)
                Text("\(threads)")
                Button(action: { self.threads += 1 }) {
                    Image(systemName: "chevron.right")
                    .padding()
                }
            }
            Button(action:btnClicked) {
                Text("Click here")
                    .padding()
            }.disabled(timer != nil)
            Text(status)
        }
    }
    
    func btnClicked() -> Void {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            print("Done!")
            self.timer = nil
        })
        status = "Running..."
        let calculator = PrimeCalculator()
        calculator.threads = threads
        calculator.onCanContinue={()in return self.timer != nil}
        calculator.onComplete={()in
            self.status = "\(calculator.lastPrime) and \(calculator.totalPrimes) more"
        }
        calculator.calcPrimes()
        self.calculator = calculator
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
