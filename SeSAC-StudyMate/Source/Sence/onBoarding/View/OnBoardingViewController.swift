
import UIKit
import RxSwift

class OnBoardingViewController: BaseViewController, UIScrollViewDelegate {
    
    // Define the number of pages.
    let pageSize = 3
    
    lazy var pageControl: UIPageControl = {
        // Create a UIPageControl.
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 200, width: self.view.frame.maxX, height:50))
        pageControl.backgroundColor = .white
        
        // Set the number of pages to page control.
        pageControl.numberOfPages = pageSize
        
        // Set the current page.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .grayScale5
        
        return pageControl
    }()
    
    lazy var startButton: fillButton = {
        let button = fillButton(frame: CGRect(x: self.view.frame.width*0.05, y: self.view.frame.maxY - 120, width: self.view.frame.width*0.9, height:48))
        button.setTitle("시작하기", for: .normal)
        DispatchQueue.main.async {
            button.layer.cornerRadius = 8
        }
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        // Create a UIScrollView.
        let scrollView = UIScrollView(frame: self.view.frame)
        
        // Hide the vertical and horizontal indicators.
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        
        // Allow paging.
        scrollView.isPagingEnabled = true
        
        // Set delegate of ScrollView.
        scrollView.delegate = self
        
        // Specify the screen size of the scroll.
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * self.view.frame.maxX, height: 0)
        
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the background color to Cyan.
        self.view.backgroundColor = .white
        
        // Get the vertical and horizontal sizes of the view.
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        // Generate buttons for the number of pages.
        for i in 0 ..< pageSize {
            // Generate different labels for each page.
            let view: UIImageView = UIImageView(frame: CGRect(x: CGFloat(i) * width, y: height - height * 0.75 , width: self.view.frame.width, height:self.view.frame.width * 0.85))
            view.clipsToBounds = true
            view.layer.masksToBounds = true
            view.contentMode = .scaleAspectFit
            view.image = UIImage(named: "onboarding_img\(i)")

//
            let label: UIImageView = UIImageView(frame: CGRect(x: CGFloat(i) * width + width/2 - 120, y: height - height * 0.95 , width: 240, height: self.view.frame.width * 0.35))
            label.clipsToBounds = true
            label.contentMode = .scaleAspectFit
            label.layer.masksToBounds = true
            label.image = UIImage(named: "onboardingtxt\(i)")

            scrollView.addSubview(label)
            scrollView.addSubview(view)
            
            startButton.rx.tap
                .withUnretained(self)
                .bind { (vc, _) in
                    UserDefaults.standard.set(true, forKey: "OnBoarding")
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate

                    let vc = PhoneViewController()
                    UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
                    let navi = UINavigationController(rootViewController: vc)
                    sceneDelegate?.window?.rootViewController = navi
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
        }
        
        // Add UIScrollView, UIPageControl on view
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.startButton)
        self.view.addSubview(self.pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // When the number of scrolls is one page worth.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // Switch the location of the page.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}
