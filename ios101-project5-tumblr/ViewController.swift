//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import NukeExtensions

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view
        view.backgroundColor = .systemBackground
        title = "Tumblr Feed"
        
        setupTableView()
        fetchPosts()
    }
    
    private func setupTableView() {
        // Create table view programmatically
        tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.rowHeight = 150 // Fixed height for consistency
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = true
        tableView.bounces = true
        
        // Register custom cell
        tableView.register(CustomPostCell.self, forCellReuseIdentifier: "PostCell")
        
        // Add to view first
        view.addSubview(tableView)
        
        // Set up Auto Layout constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        print("✅ Table view setup with Auto Layout constraints")
    }

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)
                let posts = blog.response.posts

                DispatchQueue.main.async { [weak self] in
                    self?.posts = posts
                    self?.tableView.reloadData()
                    print("✅ We got \(posts.count) posts!")
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}

// MARK: - Custom Cell Class
class CustomPostCell: UITableViewCell {
    
    private let postImageView = UIImageView()
    private let summaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure image view
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = .systemGray5
        postImageView.layer.cornerRadius = 8
        
        // Configure summary label
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.textColor = .label
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        
        // Add to content view
        contentView.addSubview(postImageView)
        contentView.addSubview(summaryLabel)
        
        // Set up constraints
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Image view constraints (left side, square)
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor),
            
            // Summary label constraints (right side)
            summaryLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with post: Post) {
        // Set summary text
        summaryLabel.text = post.summary.isEmpty ? "No summary available" : post.summary
        
        // Load image
        if let photo = post.photos.first {
            let imageUrl = photo.originalSize.url
            NukeExtensions.loadImage(with: imageUrl, into: postImageView)
        } else {
            postImageView.image = nil
            postImageView.backgroundColor = .systemGray5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        summaryLabel.text = nil
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomPostCell
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
}
