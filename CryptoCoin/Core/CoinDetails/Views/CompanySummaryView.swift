//
//  CompanySummaryView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import SwiftUI
// MARK: მოსაშთობია

struct CompanySummaryView: View {
    
    //MARK: VIEWs  არის მოსაშთობი
    
    @State private var isExpanded: Bool = false
    private let lineLimit: Int = 3
    let coinSummary: CoinSummaryModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About The Coin")
                .foregroundColor(Color.theme.text)
            
            Text(coinSummary.description ?? "Description is not available. Please visit the Crypto website.")
                .lineLimit(isExpanded ? nil : lineLimit)
                .animation(.linear, value: isExpanded)
                .foregroundColor(Color.theme.subtext)
                .font(.system(size: 15))
            
            ExpandButton(isExpanded: $isExpanded)

            CoinInfoRow(title: "Web-Site", value: "Link", link: coinSummary.link)
            CoinInfoRow(title: "Market Cap.", value: coinSummary.marketCap ?? "")
            CoinInfoRow(title: "Rank", value: "\(coinSummary.rank ?? 0)")
        }
        .padding()
        .background(Color.theme.subview)
        .cornerRadius(15)
    }
}

// MARK: - Subviews

struct ExpandButton: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack(spacing: 5) {
                    Text(isExpanded ? "Show Less" : "Show More")
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
        }
        .padding(.bottom, 10)
    }
}

struct CoinInfoRow: View {
    let title: String
    let value: String
    let link: String?
    
    init(title: String, value: String, link: String? = nil) {
        self.title = title
        self.value = value
        self.link = link
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.theme.subtext)
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let link = link, let url = URL(string: link) {
                Link("Link", destination: url)
                    .foregroundColor(.blue)
                    .font(.system(size: 13))
            } else {
                Text(value)
                    .foregroundColor(Color.theme.text)
                    .font(.system(size: 13))
            }
        }
    }
}




#Preview {
    CompanySummaryView(coinSummary: CoinSummaryModel(
        description: "რამდენიმე ხნის შემდეგ ექვთიმე თაყაიშვილს თვითონ მოუხდა ყირიმში ყოფნა, როცა სევასტოპოლის გზით ბრუნდებოდა ჩერნიგოვის გუბერნიიდან, სადაც მისი ძმა გენერალი ვარლამ თაყაიშვილი ცხოვრობდა. ექვთიმეს გზად იალტაზე გამოუვლია და თარხნიშვილის ქვრივისგან „ვეფხისტყაოსნის“ ხელნაწერის მიღებას ეცადა. თუ ხელნაწერის მუზეუმისათვის საჩუქრად მიღებას ვერ მოვახერხებ, აღვწერ მაინცაო, – ფიქრობდა მეცნიერი. ელენე თარხნიშვილი ექვთიმე თაყაიშვილს მანამდე პირადად არ იცნობდა და საჭირო იყო ვინმეს რეკომენდაცია. ექვთიმემ ამ საქმეში ისევ გუბერნატორ დუმბაძის ავტორიტეტის გამოყენება სცადა, მაგრამ ამჯერად მკვლევარს ბედი არ სწყალობდა. გუბერნატორი იალტაში არ დახვდა. მის სახლში იყო მხოლოდ მისი ცოლისდა, რომელმაც, ექვთიმეს თხოვნით, დაურეკა თარხნიშვილის ქვრივს და უთხრა, ამა და ამ კაცს სურს თქვენი ნახვაო. მან სიამოვნებით მიიღო მეცნიერი და რამდენიმე დღეს დაიტოვა სტუმრად. ელენე ამ დროს უკვე სამოც წელს იყო მიღწეული, მაგრამ თავისი სილამაზე ჯერ კიდევ შერჩენოდა. ქართულად შესანიშნავად ლაპარაკობდა, მაგრამ, მაშინდელი არისტოკრატიის ჩვეულებისამებრ, საუბარში ხშირად რუსულს ურევდა.",
        link: "slkdfnlkdsmclsdmc",
        marketCap: "40 0000",
        rank: 7))
}
