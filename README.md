# 개발 일기


|           | Explain                                                      |
| --------- | ------------------------------------------------------------ |
| 진행 기간 | 22.11.07 ~ 22.12.07                                          |
| Skill     | **RxSwift** **MVVM** **CodeBaseUI** **Moya** **Firebase**    |
| Library   | Toast Tabman IQKeyboard Pageboy Multislider RxKeyboard Snapkit Then |

## 앱 내 주요 기능

- 회원 가입 : 전화번호 인증을 통해 회원가입을 진행합니다.
- 채팅 : 스터디가 매칭된 사람들끼리 채팅을 할 수 있습니다.
- 홈 화면 : 채팅 / 등록 / 매칭 상태로 구분되며, 설정한 위치를 기반으로 스터디를 등록할 수 있습니다.
- 검색 : 직접 원하는 스터디를 등록할 수 있으며, 주변에 등록된 스터디들을 알려줍니다.
- 내정보 : 원하는 스터디 / 성별 / 매칭 연령대 / 리뷰 등을 확인 / 수정할 수 있습니다.

## 🛠 기술 스택

- Firebase를 통한 **전화번호 인증 프로세스**를 개발하였습니다.
- FCM Token 만료 시 **RefreshToken Logic**을 구현하였습니다.
- **Web Socket** 방식을 통한 1대1 채팅 기능을 구현하였습니다.
- **MVVM** 패턴을 적용해 **business Logic을**  분리하였습니다.
- **RxSwift / RxCocoa / RxKeyboard**를 통한 전반적 서비스를 구성하였습니다.
- **Moya** 도입으로 Network 레이어 설계를 통한 네트워킹 작업을 단순화하였습니다.
- **Figma / SwaggerUI / Confluence**를 통한 개발을 진행하였습니다.
- **Compositional Layout**을 적용하여 Label 길이에 따른 cell의 크기를 자동으로 조절해주었습니다.
- StackView에 Hidden처리를 통한 **동적 View 설계**를 하였습니다.
- **Mapkit / CoreLocation**을 적용하여 설정 위치에 따라 Annotation이 보이도록 설계하였습니다.
- 정규식을 활용하여 전화번호 입력 시 하이픈이 추가되도록 해주었습니다.

## 💣 TroubleShooting

### Cell Item Size 자동화

Lable 길이에 따라 FlowLayout의 분기처리를 통해 Collection View의 Cell 크기를 조정하고자 하였으나, 수많은 분기처리 / 예외처리가 필요하였습니다. 이를 Compositional Layout을 통해 자동으로 Cell 크기를 지정하도록 변경해주었습니다.

~~~swift
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        //item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(200),
            heightDimension: .absolute(32)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(32)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(8)
        //sections
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        //return
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
    }
~~~

---

### 동적 View 구성

Figma에 구성된 Design 요구사항을 Expandable TableView로 구성하였고, Cell끼리 연결되어있는 화면을 구성할 수 없는 이슈가 발생하였습니다. 이를 해결하고자 StackView 및 Hidden처리 방식으로 화면을 재구성하였습니다. 이를 통해 개발 전 Design에 따른 설계의 중요성에 대해 깨닫게 되었습니다.

~~~swift
    private lazy var stackView = UIStackView(
        arrangedSubviews: [nameView, titleView, studyView, reviewView]).then {
            $0.makeCornerStyle(width: 1, color: UIColor.grayScale2.cgColor, radius: 8)
            $0.axis = .vertical
            $0.spacing = 24
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.isLayoutMarginsRelativeArrangement = true
        }
~~~

---

### Keyboard에 따른 화면 높이 조정

Keyboard 활성화에 따른 높이 조정을 **Notification** 및 **CGAffineTransform**를 통해 구성하였습니다. 하지만 이러한 방식을 사용 시 ViewWillAppear / ViewWillDisappear / Keyboard 설정 함수 등 Controller에서의 코드가 증가하는 문제가 발생하였습니다. 이를 **RxKeyboard** / **remakeConstraints**를 통해 간결 및 Rx의 코드 일관성을 가질 수 있도록 개선하였습니다.

~~~swift
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                self?.setUpConstraints(height: height)
                UIView.animate(withDuration: 0.5) {
                    self?.mainview.messageView.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
~~~

~~~swift
    private func setUpConstraints(height: CGFloat) {
        switch height {
        case 0:
            //다시 돌아가기
            mainview.messageView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(mainview.safeAreaLayoutGuide).offset(-16)
                make.height.greaterThanOrEqualTo(52)
            }
            mainview.tableView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(mainview.messageView.snp.top).offset(-12)
                make.top.equalTo(mainview.safeAreaLayoutGuide)
            }
        default:
            //올리기
            mainview.messageView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().offset(-height-16)
                make.height.greaterThanOrEqualTo(52)
            }
            mainview.tableView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(mainview.messageView.snp.top).offset(-12)
                make.top.equalTo(mainview.safeAreaLayoutGuide)
            }
        }
    }
~~~



## 회고

- UserDefualts를 Singleton Pattern 및 계산속성을 활용하여 구성하다 보니 Logic이 중복사용되는 문제점을 발견하였습니다. 이를 **Property Wrapper**을 활용하여 코드 재사용성을 높히는 방식으로 개선해보고 싶습니다.
- API 응답값에 따른 화면 전환을 하는 경우, ViewModel에서 처리하지 못해 Controller에서 처리해주었습니다. 이를 **Coordinator**를 통해 Controller에서 화면 전환에 대한 Logic을 구분하는 방식으로 개선해보고 싶습니다.
- 코드 가독성을 높히기 위해 **Coding Convention**이 필요함을 느꼈습니다. 이를 통해 다음 프로젝트에는 함수는 주어 + 동사 + 목적의 형태 / CamelCase / MARK:를 활용하여 연관성에 따른 코드를 구분하도록 구성할 것입니다.
- 프로젝트 구성 시 Utill / Common 등의 파일들을 가져오는 형태로 구성하였습니다. 이를 **Framework**를 구성하여 **모듈화**를 통해 결합성을 낮추고, 빌드 속도 및 코드 안정성을 도입하고 싶습니다.

---



| 날짜         | 기능                                                         | etc.                                                         |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 22.11.07(월) | SLP Figma 톺아보기 / PageVC 구성                             | PageControl...  왜 너 안되는거니...                          |
| 22.11.08(화) | Login화면 구성 / Rx로 작성                                   | 하이픈... 너 쉽지않아                                        |
| 22.11.09(수) | onBoarding 구성 및 Login UI 완성                             | Rx로 Logic 구현 더 연습하기!!                                |
| 22.11.10(목) | 전화번호 인증 요청 및 LoginView 연결 / 하이픈 처리 완료      | 번호 인증.. 지옥이야...                                      |
| 22.11.11(금) | Gender화면 구성 - collectionView 활용                        |                                                              |
| 22.11.12(토) | firebase 인증 완료 / Login Logic 구현 완료 및 저장           | 드디어..인증 지옥에서 벗어났다!!                             |
| 22.11.13(일) | Network 통신 완료 및 Firebase 회사 측으로 변경 완료          | 그래도...그래도... 메인 기능은 성공...!!                     |
| 22.11.14(월) | TabbarVC 구성 / 내정보 VC 구성 완료                          | 내정보 관리 VC 구성 실패...                                  |
| 22.11.15(화) | UserDefaults 싱글톤으로 한부분에서 관리                      | 내정보 관리 VC 구성을 다시해봤는데... 아직도 감이 잡히지 않는다... |
| 22.11.16(수) | 내정보 관리 VC 구성 완료                                     | 팀원분들의 중요성... 감사함당....                            |
| 22.11.17(목) | Firebase 재인증 완료 / Login GET 통신 완료                   |                                                              |
| 22.11.18(금) | Mapkit 설정 완료                                             |                                                              |
| 22.11.19(토) | SearchView 구성 - 기능 구현 실패 / 내 친구 찾기 UI 구성      | 검색뷰 도전 1일차...                                         |
| 22.11.20(일) | MyPage PUT 통신/Network MyQueueState Setting                 |                                                              |
| 22.11.21(월) | SearchView CollectionView 1개로 재구성 - 구현 실패           | 검색뷰 도전 2일차...                                         |
| 22.11.22(화) | SearchView Cell 하나로 섹션 분리 도전 - 구현 실패            | 검색뷰 도전 3일차....                                        |
| 22.11.23(수) | SearchView Section 3개 / Cell 3개 - 구현 실패 / cell Protocol로 값전달 | 검색뷰 도전 4일차...                                         |
| 22.11.24(목) | 검색뷰 구성 완료 - CollectionView                            | Diffable로 후에 다시 개선해보기                              |
| 22.11.25(금) | HomeVC 통신해서 다른 새싹 위치 반영 완료                     | 값 전달의 필요성을 깨달음                                    |
| 22.11.26(토) | Home 로직 개선 및 Protocol 값 전달해 네트워크 값 넣어주기    | HomeVC 고려해야할게 완전 많다...                             |
| 22.11.27(일) | Home 마커 이동 시 데이터 전환 완료                           | Protocol 값전달 진짜 마스터!!                                |
| 22.11.28(월) | Image / String Enum 처리 / HomeVC State 따라 분기 처리 완료  | 코드 정리는 미리미리... 리팩도 꾸준히 하기!!                 |
| 22.11.29(화) | CustomAlertView 구성                                         | 상속받아서 재사용뷰로 만드는거 성공!                         |
| 22.11.30(수) | 회원탈퇴 기능 구성                                           |                                                              |
| 22.12.01(목) | Tabman 사용해 요청 / 수락하기 화면 구성                      |                                                              |
| 22.12.02(금) | 요청하기 화면 데이터 받아와서 개수 및 이름 Label 설정 완료   |                                                              |
| 22.12.03(토) | 요청 / 수락하기 기능 구현                                    |                                                              |
| 22.12.04(일) | Custom Alert 구성해 확인 눌렀을 때 요청 / 수락 기능 구현     |                                                              |
| 22.12.05(월) | Chat tableView UI 구성 완료                                  |                                                              |
| 22.12.06(화) | Chat Network 구성 완료                                       |                                                              |
| 22.12.07(수) | DateFormatter 설정 및 Chat Logic 수정 완료                   | 채팅 보내지고 받는 것도 확인. 취업 준비를 해보자!            |

---

### 22.11.07(월)

- SLP Figma 톺아보기
- BaseSetting 만들어놓기
- Onboarding 화면 PageViewController으로 만들기(fail...?)

#### SLPFigma 톺아보기

SLP Service Flow를 한번 훑어보고자 제일 먼저 FIgma를 한번 다 훑어보았다. 어떤 화면은 어떻게 구현할 지, 먼저 구조화 시킬 수 있는 부분은 만들어 놓으면서 기본 Setting 및 PageViewController을 만들었다. 처음 Figma를 보고 적용해보는것이라 신기한 기능들이 많았다... 특히 Layout을 이미 다 볼수있다는 점이 가장 신기했던 것 같음!!

#### BaseSetting 만들기

이번에 프로젝트를 진행하면서, 처음으로 미리 BaseSetting 파일인 Utility 파일을 만든 뒤 안에 폴더링을 구성했다. 이렇게 하니 새로운 프로젝트를 만들때마다 바로 이 폴더만 넣어주면 기본 세팅 및 폴더링도 적용되니 매우 편리했다.. 진작에 이렇게 할걸 ;ㅅ;

그리고 이 프로젝트에 필요한 버튼이나 폰트, 에셋 등 기본적으로 재사용될만한 것들을 커스텀해 만들어 두었음!! 

#### OnBoarding화면 구성 - PageViewController

PageViewController로 OnBoarding화면을 구성했다. 각각 VC들에 맞는 화면을 구성해주고, 마지막으로 PageVC안에 들어있는 각각의 FirstVC, SecondVC, ThirdVC에 pageControl을 넣어주었는데, index가 인식이 안되는 문제가 발생했다... 찾아보니 ScrollerView에 PageControl 방식으로 많이 구현하는 것 같아 후에 재구현할 생각이다.

---



### 22.11.08(화)

- Login 구성 중 맨 처음의 화면인 PhoneNumberVC 구성
- 정규식 이용해서 010-1234-5678 이형태로 구현하고 싶었음 -> 적용 X
- 재사용 View를 만들고, 이를 상속받아 추가로 구현하도록 만들어 줌 -> View를 상속받아 구현해보니... 이전 상속 View에 있던 것들이 보여지지 않는 issue 발생

#### Login 구성 중 맨 처음의 화면인 PhoneNumberVC 구성

Login 관련 화면이 정말 많은데, 먼저 회원가입 로직의 시작인 핸드폰 인증 화면부터 차근차근 해보자!! 생각했고, View를 다 그려주었음!!

그리고 주어진 조건에 맞추어 버튼의 색이 변경되도록 Rx로 구현해주었음!!

#### 정규식 이용해서 010-1234-5678 이형태로 구현하고 싶었음 -> 적용 X

이부분이 정말 시간을 많이 썼는데, 하이픈이 들어간 번호형태로 구현하는 것이 주어진 조건이여서 이 부분을  정규식을 사용해서 구현해보자! 생각함.

그래서 정규식도 찾아보면서 구현하는 로직까진 생각했지만, 문제가 내가 Rx로 구현한 것... 이것을 어떻게 적용하나... 정말 이것 저것 많이 해봤는데 해결책을 못찾음... 너무 여기에만 하루를 날리는 것 같아 우선 차후에 구현하도록 하고, 마감 기한까지 진도를 나가는게 우선이라 생각해 다음 걸로 넘어갔음.

#### 재사용 View를 만들고, 이를 상속받아 추가로 구현하도록 만들어 줌 -> View를 상속받아 구현해보니... 이전 상속 View에 있던 것들이 보여지지 않는 issue 발생

이번에는 정말 이슈들이 많이 발생했는데, 기존에 했던 방식이 아니라 새로 적용해보려는 Rx나 구조화를 하려다 보니, 계속 예상치 못한 곳에서 이슈가 나타남 흑흑... 이번엔 형태가 비슷한 것들을 한번 뷰로 묶어서 상속받는 뷰 형태로 구현해보자! 했는데, 레이아웃 문제인지, 상속의 문제인지 정확하게 모르겠지만 상속을 받은 뷰에 추가적으로 레이블이나 버튼을 놓고 뷰의 레이아웃을 잡아주면, 기존에 잡아줬던 상속뷰에 넣어줬던 버튼이나 레이블들이 사라지는 이슈가 발생했음.

마감일만 아니였어도... 다 파보고 싶은데 못다한 기능들이 많아.. 나중에 제대로 파보겠어!!



### 22.11.09(수)

- OnBoarding 화면 구성 완료
- UI Login 화면 기본 구성 완료(Gender 부분 구현 X)
- Firebase 연결 및 gitignore 처리 다시 완료

#### OnBoarding 화면 구성 완료

오늘 UI를 전부 완성시키자 생각해서 미뤄두었던 OnBoarding 화면을 다시 ScrollerView + PageControl로 구성 완료했음!

진작에 이케할걸... 머리에서 깡깡 소리나겠다...

#### UI Login 화면 기본 구성 완료(Gender 부분 구현 X)

Login 기능 화면 중 Gender 부분 제외하고 기본 화면 구성을 완료했음!! 아직 생년월일 부분 Layout이 맘에 안들긴 하지만... datepicker로 지정한 날짜를 넣으면 표현되게까지도 구현해 놓았고... 이제 로직들만 붙이면 될 것 같음!! Gender부분은 CollectionView로 구성할 지 아직 조금 더 생각해보기로 해서 구현을 안했음!! OnBoarding처럼 고생하지 않도록...

#### Firebase 연결 및 gitignore 처리 다시 완료

우선 기본적으로 Firebase를 연결해주었고, 이에 따라 GoogleInfo.plist도 .gitignore처리를 해주어야 해서 새로 터미널로 처리를 해주었음! 이제 firebase를 통해 전화번호 인증을 할 것!

---



### 22.11.10(목)

- Firebase 인증 요청 완료 - idToken발급 실패
- Login View 연결 완료
- 하이픈 설정 완료

#### Firebase 인증 요청 완료 - idToken발급 실패

Firebase 연결을 해놓았으니 이제 Auth를 통해 인증을 받기 위해 ViewModel에서 처리를 해주었다.
        

```swift
func verifyNum(num: String?) {    
	guard let num = num else { return }
    
    PhoneAuthProvider.provider().verifyPhoneNumber(Country.kr.CountryCode + num, uiDelegate: nil) { (varification, error) in
        if error == nil {
            if let id = varification {
                UserDefaults.standard.set("\(id)", forKey: "FCMToken")
            }
            print(varification)
            self.verificationID = varification
            print("성공")
        } else {
            print("Phone Varification Error:\(error.debugDescription)")
        }
    }
}

func verifyID(code: String?) {
    
    guard let code = code else { return }
    
    let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: code)
    
    Auth.auth().signIn(with: credential) { (success, error) in
        if error == nil {
            print(success ?? "")
            print("User Signed in...")
        } else {
            print(error.debugDescription)
        }
    }
}
```

이렇게 ViewModel에서 처리 후 실행하니 문자 인증은 잘 왔는데, 이상하게 인증코드를 입력하는 창에 넣으면 다음 화면으로 넘어가지 않는 문제가 발생했다. 후에 다시 인증 설정이 필요할 것 같다.



#### Login View 연결 완료

Rx형태로 화면 연결을 성공했을 때 화면이 연결되어 전환되도록 설정해주었다. 이때 모든 로직이 성공했을때 처리를 해주고 화면전환을 해주어야 하니, VC에서 함수를 하나 더 만들고 여기에 ViewModel에서 처리하는 함수 + 화면 전환하는 코드를 심어주는 식으로 구현했다.



```swift
//vc
    private func seccess() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.successNickname(nickname: text)
        self.transition(BirthdayViewController(), transitionStyle: .presentFullScreen)
    }



        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? vc.seccess() : vc.mainview.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요")

            }
```



#### 하이픈 설정 완료

드디어.. 번호를 하이픈 넣어서 구현하고 싶었는데... 구현을 해따!!

```swift
    func isPhone(phoneNumber: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    func addHypen(num: String) -> String {
        let numTen = num.toPhoneNumberPattern(pattern: "###-###-####", replacmentCharacter: "#")
        let numEleven = num.toPhoneNumberPattern(pattern: "###-####-####", replacmentCharacter: "#")
        
        if num.count < 13 {
            return numTen
        } else {
            return numEleven
        }
    }

```

사실 구글링과... 같이 공부하는 팀원들에게 배웠다... 왤케 머리가 안돌아가지 ;ㅅ;

그래도 구현하고 보니 배우길 잘했다는 생각을.. 굳굳

---



### 22.11.11(금)

- GenderVC CollectionView로 화면 구성 완료

- GenderVC 클릭 시 하나만 선택되도록 설정 완료



#### GenderVC CollectionView로 화면 구성 완료

전체가 collectionView가 아니라 특정 부분만 collectionview로 구성하는건 처음이여서 약간 헷갈렸지만, View에서

```swift
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 60, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenderCollectionViewCell.self, forCellWithReuseIdentifier: GenderCollectionViewCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
```

이렇게 레이아웃과 셀크기를 지정해주니 구현이 가능했었다.



#### GenderVC 클릭 시 하나만 선택되도록 설정 완료

처음에 로직 구현이 제대로 되지 않아 정말 고민거리였는데, isSelect라는 속성을 이용하니 해결이 가능했다.

collectionViewCell에서 이렇게 계산속성을 활용해 구현하니 중복이 되지도 않고 하나만 선택하도록 설정할 수 있었다.

~~~
    override var isSelected: Bool {
        didSet {
            isSelectedCell()
        }
    }
    
    func isSelectedCell() {
        if isSelected {
            self.backgroundColor = .brandYellowGreen
        } else {
            self.backgroundColor = .white
        }
    }
~~~

---

### 22.11.12(토)

- 번호 인증 부분 구현 완료
- Login Logic 모든 부분 Validation Check 완료 및 UserDefault 저장 완료



#### 번호 인증 부분 구현 완료

드디어... 애먹던 번호 인증 부분을 구현했다.

~~~
    func requestIDToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                return
            }
            
            guard let idToken = idToken else { return }
            UserDefaults.standard.set(idToken, forKey: "idToken")
            print("idToken",idToken)
        }
    }
~~~

내가 이부분을 구현하지 않아서 계속 토큰이 날라오지는 않고 성공했다고만 뜨고 그 이후의 token을 받아오지 못하는거였다. 공식문서를 더 자세히, 이해하면서 읽는 습관을 들여야겠다...



#### Login Logic 모든 부분 Validation Check 완료 및 UserDefault 저장 완료

서버 통신에 들어가기 전, 마지막으로 Validation 로직을 설정해주고, 성공했을 때 UserDefault에 저장되도록 로직을 설정해주었다. Date 부분이 Date형식으로 UserDefault에 저장해주어야지! 라고 생각했는데, UserDefault엔 Date로 저장할 수 없어 String으로 저장 후 후에 Date로 변환시켜주어야 한다는 것도 처음 알게 되었다.

---

### 22.11.13(일)

- 회사 측 Firebase로 변경 완료
- NavigationBar Custom 완료
- Moya를 이용한 Network 통신 완료

#### 회사 측 Firebase로 변경 완료

정말... 많은 이슈가 있었다. 먼저 회사측 Firebase로 변경하기 위해 Google.info 변경 및 Schema 변경, info에서 http 설정 허용을 해주었어야 했는데, 둘 다 안하고 plist만 바꾸고 실기기 테스트를 위해 notification / background만 지우고 왜 안될까.. 하면서 끙끙 앓았던 것.

그래도 다행히 수정 후 인증까지 문제 없이 변경이 되었다.

#### NavigationBar Custom 완료

Navigation을 Custom해서 설정해주었다.

항상 느끼는 거지만, Navi Custom은 간단한것들은 간단하다가도, 정말 어려운 부분이 있다. 이번에도 이미지만 변경해주었더니, pop이 되지 않는 issue가 발생해 addtarget을 통해 뒤로 가는 코드를 심어주었다.



#### Moya를 이용한 Network 통신 완료

제일 뿌듯한 점. Moya를 써보자, 써보자 했는데 이번 프로젝트에서 시간에 쫒기다 보니 그냥 Alamofire로 변경할 까 하다가 그래도 이럴 때 써보면서 익히는 것이라 생각하고 도전했다. 처음엔 이해도, 어떻게 사용하는 지 감도 잡히지 않아 어려웠지만, 소깡느님의 쏙쏙 강의와 팀원들의 도움 덕에 Moya로 네트워크 통신을 성공했다.

모야를 쓰니 확실히 추상화를 통해 직접 쓸 때의 번거로움과 한 곳에서 관리를 할 수 있는 객체지향의 느낌이 강했다. 또한 플러그인을 통해 더욱 세세하게 Network통신을 직관적으로 볼 수 있다는 장점까지 있으니, 이번에 모야로 통신을 하면서 좀 더 습득해 나가야겠다.

---

### 22.11.14(월)

- MainTabbarVC 구성 
- 내정보 VC 구성
- 내정보 관리 VC 구성 - 처참히 실패



#### MainTabbarVC 구성 

이제 회원가입 로직을 마무리하고, MainView 구현쪽으로 넘어갔다. Tabbar와 Navibar를 같이 사용할 때에 고려할 점이 필요하다는 것을 느낀 경험이었다.



#### 내정보 VC 구성

펼쳤다 닫는 UI를 구현 - 처음에 expandable table View로 구조를 잡았음 - 각 뷰가 펼쳤다 닫아져야하는데, 그 때 UI가 요구사항을 구현하지 못하는 이슈 발생 - 실패

---

### 22.11.15(화)

- 코드 구조화 - UserDefaults 싱글턴 관리
- Network 분기 처리
- 내정보 관리 VC 설계 - 두번째 처참히 실패...



#### 코드 구조화 - UserDefaults 싱글턴 관리

계속 UI만 그리다보니, 잘 그려지지도 않고 머리가 복잡해져서 기존에 작성했지만 보기 싫었던 코드들을 구조화 시켜보았음. UserDefaults를 싱글톤으로 하나에서 관리하도록 구조 변경

~~~swift
import Foundation

final class UserDefaultsHelper {
    private init() { }
    static let standard = UserDefaultsHelper()
    let userDefaults = UserDefaults.standard
    
    enum Key {
        static let idToken = "idToken"
        static let FCMtoken = "FCMtoken"
        static let verificationID = "verificationID"
        static let phone = "phoneNumber"
        static let nickname = "nick"
        static let birthday = "birth"
        static let email = "email"
        static let gender = "gender"
        static let currentUser = "currentUser"
    }
    
    var idToken: String? {
        get { return userDefaults.string(forKey: Key.idToken) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.idToken) }
    }
    
    var FCMtoken: String? {
        get { return userDefaults.string(forKey: Key.FCMtoken) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.FCMtoken) }
    }
    
    var verificationID: String? {
        get { return userDefaults.string(forKey: Key.verificationID) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.verificationID) }
    }
    
    var phone: String? {
        get { return userDefaults.string(forKey: Key.phone) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.phone) }
    }
    
    var nickname: String? {
        get { return userDefaults.string(forKey: Key.nickname) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.nickname) }
    }
    
    var birthday: String? {
        get { return userDefaults.string(forKey: Key.birthday) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.birthday) }
    }
    
    var email: String? {
        get { return userDefaults.string(forKey: Key.email) ?? "" }
        set { userDefaults.set(newValue, forKey: Key.email) }
    }
    
    var gender: Int {
        get { return userDefaults.integer(forKey: Key.gender) }
        set { userDefaults.set(newValue, forKey: Key.gender) }
    }
    
    var currentUser: Bool {
        get { return userDefaults.bool(forKey: Key.currentUser) }
        set { userDefaults.set(newValue, forKey: Key.currentUser) }
    }
    
    func removeObject() {
        userDefaults.removeObject(forKey: Key.idToken)
        userDefaults.removeObject(forKey: Key.FCMtoken)
        userDefaults.removeObject(forKey: Key.verificationID)
        userDefaults.removeObject(forKey: Key.phone)
        userDefaults.removeObject(forKey: Key.nickname)
        userDefaults.removeObject(forKey: Key.birthday)
        userDefaults.removeObject(forKey: Key.email)
        userDefaults.removeObject(forKey: Key.gender)
    }
    
    func removeAccessToken() {
        userDefaults.removeObject(forKey: Key.idToken)
    }
}

~~~



#### Network 분기 처리

네트워크도 Error를 재사용해보려고 했지만, 각 에러들마다 처리하는 예외처리가 다 달라 아에 각자의 Error들로 분리하고, 통신도 이에 맞춰서 다 분리해주었음.

~~~swift
import Foundation

enum LoginError: Int, Error {
    case FirebaseTokenError = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .FirebaseTokenError:
            return "id토큰이 만료되었습니다. 갱신해주세요"
        case .notSignUp:
            return "미가입 유저입니다."
        case .serverError:
            return "Server Error"
        case .clientError:
            return "Client Error"
        }
    }
}

~~~



#### 내정보 관리 VC 설계 - 두번째 처참히 실패...

다른 코드들을 구조화시키게 만들었던 이친구... 어떻게 해볼까 하다가 새로 Layout을 잡아주는 형태로 생각 - 구현해보니 이후 재사용 부분에서는 이런 방식으로 구현을 할 수 없는 UI임을 늦게 깨달아버렸고... 이렇게.... 2트 실패...

---

### 22.11.16(수)

- 정보관리 VC 구현 성공 - 중요한건... 꺾이지 않는 마음



#### 정보관리 VC 구현 성공 - 중요한건... 꺾이지 않는 마음

팀원이 테이블 뷰 + 스택 뷰 방식으로 구현해서 구조에 대해 설명듣고 팁도 들었고... 드디어... 팀원의 구조를 참고해 구성 완료!!

팀원들의 개발 연륜과 소중함을 느꼈다...

---

### 22.11.17(목)

- Login GET 통신 완료
- Login Error 처리 완료
- Firebase 토큰 갱신 처리 완료



#### Login GET 통신 완료/ Error처리 완료 / Firebase 토큰 갱신 처리 완료

이제 내정보 UI를 끝냈으니 MainView에 들어가기 전, 마지막으로 전 주에 다듬지 못했던 나머지 예외 처리와 토큰 갱신을 마무리했다. 생각보다  어려운 줄 알고 구현안하고 있었는데, 막상 해결하려고 해보니 금방 구현했었던 토큰 갱신이었다.

---

### 22.11.18(금)

- SearchView 구성 - 각 셀 클릭시 나타나는 기능 구현 실패
- Mapkit 설정 완료

#### SearchView 구성 - 각 셀 클릭시 나타나는 기능 구현 실패

서치 뷰를 구성할 때, 테이블 뷰 안에 두개의 디퍼블 컬렉션 뷰를 넣고, 컴포지셔널 레이아웃으로 잡아줬는데 다른 셀끼리 데이터 전달을 실패.

#### Mapkit 설정 완료

기본적으로 해야하는 권한 설정 및 Pin에대한 설정을 해주었음. Mapkit을 많이 사용해본 것이 아니라 메서드들에 대해 알아가면서 공부하기!

---

### 22.11.19(토)

- 내 친구 찾기 UI 구성
- SearchView 구성 - 기능 구현 실패

#### 내 친구 찾기 UI 구성

카드뷰 재사용으로 UI먼저 구성 - 중복 데이터 처리를 하지 못하는 Issue 발생.

#### SearchView 구성 - 기능 구현 실패

SearchView에 대한 부분에서 Snapshot에서 데이터를 뿌리는 도중, 어떻게 Hashable하게 만들어 줄 지에 대한 설정 및 셀 클릭에 대한 이벤트를 처리할 지에 대해 해결을 하지 못함. 디퍼블을 그리는 방법 이외에도 스냅샷에 대해 조금 더 이해하고 적용해볼 것.

---

### 22.11.20(일)

- 내 주변 친구 찾기 기능 구성 - 실패
- 내정보 관리 PUT Network 통신 완료
- SearchView CollectionView 화면 구성 - 구현 실패

#### 내 주변 친구 찾기 기능 구성 - 실패

#### 내정보 관리 PUT Network 통신 완료

내 정보 관리 뷰에서 PUT 통신을 통한 내 정보 수정 기능을 구현하였다. CRUD 중 Update를 처음 경험해본 부분이었고, PUT과 PATCH에 대한 차이에 대해서도 찾아보았다.이를 통해 이때 PUT은 전체를 새로 갱신하는 것이고, PATCH는 여러 항목들 중 수정된 부분만 갱신하는 것이라는 차이점에 대해서도 알게되었다.

#### SearchView CollectionView 화면 구성 - 구현 실패

---

### 22.11.21(월)

- SearchView CollectionView 1개로 재구성 - 구현 실패

#### SearchView CollectionView 1개로 재구성 - 구현 실패

---

### 22.11.22(화)

- SearchView Cell 하나로 섹션 분리 도전 - 구현 실패

#### SearchView Cell 하나로 섹션 분리 도전 - 구현 실패

---

### 22.11.23(수)

- SearchView Section 3개 / Cell 3개 - 구현 실패

#### SearchView Section 3개 / Cell 3개 - 구현 실패

---

### 22.11.24(목)

- 검색뷰 구성 완료

#### 검색뷰 구성 완료

---

### 22.11.25(금)

- HomeVC 통신해서 다른 새싹 위치 반영 완료

#### HomeVC 통신해서 다른 새싹 위치 반영 완료

---

### 22.11.26(토)

- Home Logic 추가 및 Protocol 값전달 완료

#### Home Logic 추가 및 Protocol 값전달 완료

---

### 22.11.27(일)

- Home 마커 이동 시 데이터 전환 완료

#### Home 마커 이동 시 데이터 전환 완료

Home VC에서 regionDidChange 메서드를 사용해서 어노테이션을 지워주고, 뷰 모델에서 재통신을 해주는 로직을 구현하였다.

~~~swift
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print(mapView.centerCoordinate)
        mapView.removeAnnotations(mapView.annotations)
        viewModel.requestSearchData(lat: mapView.centerCoordinate.latitude, long: mapView.centerCoordinate.longitude)
    }
~~~

이러니 과호출 문제도 해결되었다.

---

### 22.11.28(월)

- Image / String Enum으로 묶기
- Home VC State에 따라 분기 처리 완료

#### Image / String Enum으로 묶기

Enum과 Switch를 활용해서 다 row한 값들을 묶어주었다. 근데 다 작성하고 보니, 피드백으로 Image 같은 부분을 static let으로 묶는게 더 좋을 것 같다고 받아서, 후에 리팩토링 할 예정.

#### Home VC State에 따라 분기 처리 완료

HomeVC에서 MyStateQueue에 따른 이미지 및 화면 전환을 어떻게 해줄 지에 대한 예외처리를 진행하였다. 이미지에 대한 부분은 ViewModel에서 처리하였고 화면 전환은 ViewController에서 처리하였다.

### 22.11.29(화)

- 재사용 Custom AlertView 구성

#### 재사용 Custom AlertView 구성

CustomAlert을 만들어 비슷하게 CustomAlert이 사용되는 곳에서 상속받아 Title과 Subtitle만 작성하면 알아서 구성되도록 형태를 만들었다.

### 22.11.30(수)

- Tabman 구성

#### Tabman 구성 (요청 / 수락 화면)

Tabman을 사용하여 요청 / 수락화면UI를 구성했다. 

### 22.12.01(목)

- 요청하기 화면 데이터 구성
- 요청 데이터 개수 및 nameLabel 구성 완료

#### 요청하기 화면 데이터 구성

#### 요청 데이터 개수 및 nameLabel 구성 완료

### 22.12.02(금)

- 요청하기 화면 데이터 받아와서 개수 및 이름 Label 설정 완료

#### 요청하기 화면 데이터 받아와서 개수 및 이름 Label 설정 완료

### 22.12.03(토)

- 요청 / 수락하기 기능 완료

#### 요청 / 수락 기능 구현 완료

### 22.12.04(일)

- Custom Alert 구성해 확인 눌렀을 때 요청 / 수락 기능 구현 완료

#### Custom Alert 구성하여 확인 눌렀을 때 요청 / 수락 기능을 구현하도록 Refactor

### 22.12.05(월)

- Chat tableView UI 구성 완료

### 22.12.06(화)

- Chat Network 구성 완료

#### Chat Network 구성

### 22.12.07(수)

- DateFormatter 설정 및 Chat Logic 수정 완료

#### DateFormatter 설정 및 Chat Logic 수정 완료

