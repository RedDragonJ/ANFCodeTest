//
//  UITextView+ConfigureWithHTML.swift
//  ANF Code Test
//
//  Created by James Layton on 1/16/25.
//

import UIKit

extension UITextView {
    /// Configures the UITextView to display HTML content, center-align text, and enable tappable links.
    /// - Parameter html: A html string contains hyperlink.
    func configureWithHTML(_ html: String) {
        guard let data = html.data(using: .utf8) else {
            self.text = html // Fallback to plain text
            return
        }

        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            self.attributedText = attributedString
            self.textAlignment = .center
            self.isScrollEnabled = true
            self.isEditable = false
            self.isSelectable = true
            self.dataDetectorTypes = [.link]
        } catch {
            print("Failed to parse HTML: \(error)")
            self.text = html // Fallback to plain text
        }
    }
}
