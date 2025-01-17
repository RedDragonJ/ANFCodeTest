//
//  ANFExploreTableViewCell.swift
//  ANF Code Test
//
//  Created by James Layton on 1/16/25.
//

import UIKit

class ANFExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promoMessageLabel: UILabel!
    @IBOutlet weak var bottomDescriptionTextView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentStack: UIStackView!

    var exploreItem: ExploreItem!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFullWidthCell()
        resetCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }

    private func resetCell() {
        backgroundImage.image = nil
        topDescriptionLabel.text = nil
        titleLabel.text = nil
        promoMessageLabel.text = nil
        bottomDescriptionTextView.text = nil
        bottomDescriptionTextView.isHidden = true
        textViewHeightConstraint.constant = 0
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func setupFullWidthCell() {
        preservesSuperviewLayoutMargins = false
        contentView.preservesSuperviewLayoutMargins = false
        contentView.layoutMargins = .zero
        layoutMargins = .zero
    }

    func configure(with exploreItem: ExploreItem) {
        self.exploreItem = exploreItem

        if let backgroundImageURL = exploreItem.backgroundImage {
            downloadImage(from: backgroundImageURL) { [weak self] image in
                DispatchQueue.main.async {
                    if let image {
                        self?.backgroundImage.isHidden = false
                        self?.backgroundImage.image = image
                    }
                }
            }
        }

        if let topDescription = exploreItem.topDescription {
            topDescriptionLabel.isHidden = false
            topDescriptionLabel.text = topDescription
        }

        if let title = exploreItem.title {
            titleLabel.isHidden = false
            titleLabel.text = title
        }

        if let promoMessage = exploreItem.promoMessage {
            promoMessageLabel.isHidden = false
            promoMessageLabel.text = promoMessage
        }

        if let bottomDescription = exploreItem.bottomDescription {
            bottomDescriptionTextView.isHidden = false
            textViewHeightConstraint.constant = 50
            bottomDescriptionTextView.configureWithHTML(bottomDescription)
        }

        // Configure content buttons
        if let content = exploreItem.content {
            contentStack.isHidden = false
            contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() } // Clear existing buttons if any

            for item in content {
                let button = UIButton(type: .system)
                button.setTitle(item.title, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.layer.cornerRadius = 5
                button.addTarget(self, action: #selector(contentButtonTapped(_:)), for: .touchUpInside)
                button.tag = contentStack.arrangedSubviews.count // Set tag for button identification

                let containerView = UIView()
                containerView.addSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                    button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                    button.topAnchor.constraint(equalTo: containerView.topAnchor),
                    button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                    button.heightAnchor.constraint(equalToConstant: 50)
                ])

                contentStack.addArrangedSubview(containerView)
            }
        }
    }

    // MARK: - Button Action
    @objc private func contentButtonTapped(_ sender: UIButton) {
        guard let content = exploreItem.content else { return }

        // Get the URL target from the button's tag
        let selectedContent = content[sender.tag]

        // Open URL
        if let targetURL = selectedContent.target {
            UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL or no target set.")
        }
    }

    // MARK: - Download Image
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                let image = UIImage(data: data)
                completion(image)
            } else {
                print("Failed to download image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
        task.resume()
    }
}
