//
//  AboutQuoteClub.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import Foundation

struct AboutQuoteClub: Hashable {
    let question: String
    let answer: String
}

extension AboutQuoteClub {
    static var about: [AboutQuoteClub] {
        [
            AboutQuoteClub(
                question: "What is QuoteClub?",
                answer: "QuoteClub is a social media app for sharing quotes with others."
            ),
            
            AboutQuoteClub(
                question: "Who developed QuoteClub?",
                answer: "QuoteClub was developed by a developer named Baher Tamer"
            ),
            
            AboutQuoteClub(
                question: "What is the license of QuoteClub?",
                answer: "QuoteClub is licensed under the MIT license"
            ),
            
            AboutQuoteClub(
                question: "What features does QuoteClub offer?",
                answer: """
- You can like quotes
- You can save quotes
- You can see others' profile
- You can search for users
- You can filter quotes by category
- You can customize the app color
- You can edit your profile

and much more...
"""
            ),
            
            AboutQuoteClub(
                question: "What tools did the developer use for QuoteClub?",
                answer: """
- Swift
- SwiftUI
- Firebase Authentication
- Firebase Firestore Database
- Firebase Storage
- PhotosUI
- KingFisher
- StoreKit
"""
            )
        ]
    }
}

extension AboutQuoteClub {
    static var lorem: String {
        """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse commodo nibh quis lobortis pellentesque. Donec at ligula nec justo varius dignissim. Sed tincidunt nibh nec tortor aliquam, eget iaculis orci pellentesque. Nullam luctus odio et ligula venenatis, in semper erat lobortis. Nulla a arcu ultrices, imperdiet urna nec, efficitur dolor. Donec tempor tempor nibh, rutrum scelerisque tellus condimentum non. Ut blandit arcu ut magna fermentum, vel accumsan turpis facilisis. Suspendisse vel dapibus risus, ut pharetra elit. Vestibulum tempus massa tellus, et sagittis mauris posuere eu. Sed tellus elit, interdum imperdiet fringilla nec, vehicula vehicula velit. Sed finibus vulputate volutpat.

Vivamus ac egestas urna. Phasellus volutpat sed enim nec dictum. In hac habitasse platea dictumst. Vivamus id euismod dolor. Mauris condimentum erat id feugiat aliquet. Morbi ullamcorper euismod pulvinar. Nam risus mauris, imperdiet eu neque a, imperdiet mattis massa. Cras sagittis posuere velit quis interdum. Aliquam fringilla ante at nisi ultrices dapibus. Mauris rutrum lorem nec neque dignissim, eu dapibus lectus molestie. Aenean porta ullamcorper orci ac fringilla. Vestibulum in semper odio. Donec fermentum pharetra libero, in pulvinar sapien sagittis nec.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lacinia nibh quis felis tristique, et facilisis est dapibus. Ut rutrum dui at dignissim scelerisque. Nullam eu varius magna. Vestibulum a quam faucibus dolor accumsan porttitor. Suspendisse dictum sodales orci sit amet faucibus. Cras dictum pellentesque lacus non posuere. Pellentesque non suscipit orci. Nam fermentum nunc dui. Cras in ligula vehicula, lobortis metus at, facilisis dolor. Aliquam erat volutpat.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer eget justo eu justo rhoncus tincidunt quis et dui. In pharetra dui interdum massa luctus laoreet. Donec volutpat in eros a laoreet. Vestibulum pellentesque laoreet est, eget vestibulum nisi rhoncus vel. Nullam a mi porta turpis interdum commodo. Aenean vestibulum leo in feugiat tempus. Ut efficitur accumsan justo, vitae egestas sapien. Maecenas dui neque, feugiat a efficitur sed, condimentum ac nunc. Ut lobortis fringilla lectus et mollis. Nulla rutrum convallis massa, nec vulputate mi pretium ac. Aliquam interdum odio vel nulla fermentum, congue gravida urna accumsan. Nullam bibendum sodales suscipit.

Mauris suscipit nisi vel laoreet volutpat. Integer in euismod lacus. Nulla facilisi. Etiam mattis nulla sit amet tempor gravida. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum sagittis blandit turpis, sit amet dignissim purus vehicula ut. Phasellus et laoreet ipsum. Etiam posuere justo est, eu viverra nibh cursus non. Sed interdum at quam quis cursus. Vestibulum suscipit, dui id accumsan tristique, est ligula eleifend ligula, rutrum rutrum nibh neque sit amet purus. Vivamus non nibh bibendum, venenatis turpis vestibulum, placerat odio.

Duis sed ante eu arcu blandit ullamcorper. Quisque sed orci ex. Donec metus ex, consectetur ac diam sit amet, consequat gravida quam. Morbi pretium diam a odio dapibus, et aliquam dolor dictum. Nulla orci mi, condimentum eget iaculis eget, ultrices non lacus. Donec bibendum aliquet semper. Pellentesque eget finibus nisi, sit amet volutpat ex. Aenean volutpat, ante ac dignissim lobortis, mi neque ullamcorper elit, vitae blandit elit risus at massa. Aliquam posuere, purus quis condimentum blandit, turpis eros interdum urna, id ullamcorper felis libero et velit. Suspendisse imperdiet ligula in est pharetra, non auctor diam suscipit. Nullam imperdiet, erat nec tincidunt pulvinar, elit elit suscipit lectus, sit amet faucibus ipsum nunc ut neque. Pellentesque placerat leo eu arcu sodales, eget feugiat velit vulputate.
"""
    }
}
