//
//  WriteQuoteView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 12/05/2023.
//

import SwiftUI

struct WriteQuoteView: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    @Environment(\.dismiss) var dismiss
    
    @State private var quote: String = ""
    @State private var author: String = ""
    @State private var quoteCategory: QuoteCategory = .affirmations
    
    private let quoteService = QuoteService()
    
    private var authorTextField: some View {
        HStack {
            Image(systemName: "minus")
                .font(.footnote)
                .fontWeight(.semibold)
            
            TextField("Author", text: $author)
                .textInputAutocapitalization(.words)
        }
    }
    
    private var quoteTextField: some View {
        HStack {
            QuoteIcon(iconType: .opening)
            
            TextField("Quote", text: $quote, axis: .vertical)
                .textInputAutocapitalization(.sentences)
            
            QuoteIcon(iconType: .closing)
        }
    }
    
    var quoteCategoryPicker: some View {
        Picker("Category", selection: $quoteCategory) {
            ForEach(QuoteCategory.allCases, id: \.self) { category in
                Text(category.icon + " " + category.rawValue.capitalized)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    quoteTextField
                    authorTextField
                }
                .autocorrectionDisabled(true)
                .listRowSeparator(.hidden)
                
                Section {
                    quoteCategoryPicker
                }
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .navigationTitle("Add Quote")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        quoteService.uploadQuote(quote: quote, author: author, category: quoteCategory)
                        dismiss()
                    }
                    .font(.headline)
                }
            }
            .tint(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
        }
    }
}

struct WriteQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteQuoteView()
    }
}
