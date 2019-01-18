import Foundation

struct Play: Codable {
    var name: String
    var type: String
}

struct Invoice: Codable {
    var customer: String
    var performances: [Performance]
}

struct Performance: Codable {
    var playID: String
    var audience: Int
}

func statement(invoice: Invoice, plays: [String: Play]) -> String {
    var totalAmount = 0
    var volumeCredits: Int = 0
    var result = "Statement for \(invoice.customer)\n"
    let format: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    for perf in invoice.performances {
        guard let play = plays[perf.playID] else { return "" }

        var thisAmount = 0

        switch play.type {
            case "tragedy":
                thisAmount = 40000
                if perf.audience > 30 {
                    thisAmount += 1000 * (perf.audience - 30)
                }
            case "comedy":
                thisAmount = 30000;
                if (perf.audience > 20) {
                    thisAmount += 10000 + 500 * (perf.audience - 20);
                }
                thisAmount += 300 * perf.audience
            default: print("Unknown type \(play.type)")
        }

        // add volume credits
        volumeCredits += max(perf.audience - 30, 0)
        // add extra credit for every ten comedy attendees
        if play.type == "comedy" {
            var everyTenAttendees = Double(perf.audience / 5)
            everyTenAttendees.round(.down)
            volumeCredits += Int(everyTenAttendees)
        }

        // print line for this order
        result += "  \(play.name): \(format.string(from: thisAmount / 100 as NSNumber) ?? "") (\(perf.audience) seats)\n"
        totalAmount += thisAmount
    }
    result += "Amount owed is \(format.string(from: totalAmount / 100 as NSNumber) ?? "")\n"
    result += "You earned \(volumeCredits) credits"
    return result
}

