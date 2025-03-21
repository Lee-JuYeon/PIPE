//
//  DummySingleton.swift
//  PIPE
//
//  Created by Jupond on 3/19/25.
//

import Foundation


class DummySingleton {
    
    static let shared = DummySingleton()
    private let dateFormatter: DateFormatter
        
    private init() {
        dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    let dummyOfficeList = [
        OfficeModel(
            buildingAddress: "서울시 종로구 창신동",
            buildingSize: 42,
            buildingPrice: 3421.5,
            buildingPriceType: "임대",
            buildingType: "아파트",
            website: "naver.com",
            target: "신혼부부",
            constructionCompany: "시공사 1",
            company: "건설사 1"
        ),
        OfficeModel(
            buildingAddress: "서울시 종로구 창신동",
            buildingSize: 13,
            buildingPrice: 8000.0,
            buildingPriceType: "임대",
            buildingType: "아파트",
            website: "naver.com",
            target: "신혼부부",
            constructionCompany: "시공사 1",
            company: "건설사 1"
        ),
        OfficeModel(
            buildingAddress: "서울시 종로구 창신동",
            buildingSize: 52,
            buildingPrice: 30.0,
            buildingPriceType: "임대",
            buildingType: "아파트",
            website: "naver.com",
            target: "신혼부부",
            constructionCompany: "시공사 1",
            company: "건설사 1"
        ),
        OfficeModel(
            buildingAddress: "서울시 종로구 창신동",
            buildingSize: 18,
            buildingPrice: 10000.0,
            buildingPriceType: "매매",
            buildingType: "주택",
            website: "google.com",
            target: "대학생",
            constructionCompany: "시공사 1",
            company: "건설사 1"
        ),
        OfficeModel(
            buildingAddress: "인천 서구 백석동",
            buildingSize: 10,
            buildingPrice: 5000.0,
            buildingPriceType: "전세",
            buildingType: "상가",
            website: "naver.com",
            target: "신혼부부",
            constructionCompany: "시공사 1",
            company: "건설사 1"
        )
    ]
    let dummyHomeList = [
        HomeModel(
            homeAddress: "주소 1",
            homeSize: 10.5,
            homePrice: 23.1,
            homePriceType: "전세",
            homeType: "주택",
            website: "www.naver.com",
            target: "신혼부부",
            constructionCompany: "건설사1",
            company: "회사1"
        ),
        HomeModel(
            homeAddress: "주소 2",
            homeSize: 15.5,
            homePrice: 190.1,
            homePriceType: "매매",
            homeType: "아파트",
            website: "www.naver.com",
            target: "대학생",
            constructionCompany: "건설사2",
            company: "회사2"
        ),
        HomeModel(
            homeAddress: "주소 3",
            homeSize: 40.5,
            homePrice: 15.3,
            homePriceType: "월세",
            homeType: "빌라",
            website: "www.naver.com",
            target: "유공자",
            constructionCompany: "건설사2",
            company: "회사1"
        ),
        HomeModel(
            homeAddress: "주소 4",
            homeSize: 32.5,
            homePrice: 40.1,
            homePriceType: "전세",
            homeType: "주택",
            website: "www.naver.com",
            target: "신혼부부",
            constructionCompany: "건설사1",
            company: "회사2"
        ),
        HomeModel(
            homeAddress: "주소 5",
            homeSize: 10.5,
            homePrice: 23.1,
            homePriceType: "월세",
            homeType: "아파트",
            website: "www.naver.com",
            target: "신혼부부",
            constructionCompany: "건설사5",
            company: "회사1"
        ),
        HomeModel(
            homeAddress: "주소 6",
            homeSize: 10.5,
            homePrice: 23.1,
            homePriceType: "월세",
            homeType: "다가구주택",
            website: "www.naver.com",
            target: "신혼부부",
            constructionCompany: "건설사6",
            company: "회사3"
        )
    ]
    
    // 돈 / 지원금
    let dummySupportList: [SupportModel] = [
        // 1
        SupportModel(
            name: "청년 취업 지원",
            reward: "월 50만원",
            description: "청년 구직자를 위한 취업 준비 비용 지원 프로그램"
        ),
        
        // 2
        SupportModel(
            name: "소상공인 대출 지원",
            reward: "최대 5천만원 대출",
            description: "소상공인을 위한 저금리 대출 제공"
        ),
        
        // 3
        SupportModel(
            name: "주거 안정 지원",
            reward: "보증금 1천만원 지원",
            description: "저소득층을 위한 주거비 지원 프로그램"
        ),
        
        // 4
        SupportModel(
            name: "창업 지원 펀드",
            reward: "최대 1억원 투자",
            description: "신규 창업자를 위한 초기 자금 지원"
        ),
        
        // 5
        SupportModel(
            name: "교육비 지원",
            reward: "연 300만원 장학금",
            description: "저소득 가정 학생을 위한 교육비 지원"
        ),
        
        // 6
        SupportModel(
            name: "농업인 지원 프로그램",
            reward: "농기계 구매 50% 할인",
            description: "농업인을 위한 농업 장비 지원"
        ),
        
        // 7
        SupportModel(
            name: "재난 복구 지원",
            reward: "최대 2천만원 보상",
            description: "자연재해 피해자를 위한 복구 자금 지원"
        ),
        
        // 8
        SupportModel(
            name: "문화 예술 지원",
            reward: "프로젝트당 500만원",
            description: "예술가를 위한 창작 활동 지원금"
        ),
        
        // 9
        SupportModel(
            name: "고령자 의료 지원",
            reward: "의료비 70% 감면",
            description: "고령자를 위한 의료비 부담 완화 프로그램"
        ),
        
        // 10
        SupportModel(
            name: "친환경 에너지 지원",
            reward: "설치비 50% 보조",
            description: "태양광 패널 설치 지원 프로그램"
        )
    ]
    
    // 돈 / 은행 더미
    func dummyBankModels() -> [BankModel] {
        return [
            // 1. 한국
            BankModel(
                country: "KR",
                bankAddress: "서울시 강남구 테헤란로 123",
                bankURL: "https://www.shinhan.com",
                bankName: "신한은행",
                monthlySavingAmount: 50000,
                maxProtectionLimit: 50000000.0,
                applicationDeadline: dateFormatter.date(from: "2025-12-31")!,
                maturityDate: dateFormatter.date(from: "2026-12-31")!,
                additionalInfo: ["interestRate": "2.5%", "taxBenefit": "비과세"]
            ),
            
            // 2. 스페인
            BankModel(
                country: "ES",
                bankAddress: "Madrid, Calle de Alcalá 45",
                bankURL: "https://www.santander.es",
                bankName: "Banco Santander",
                monthlySavingAmount: 50, // 유로
                maxProtectionLimit: 100000.0, // 유로
                applicationDeadline: dateFormatter.date(from: "2025-06-30")!,
                maturityDate: dateFormatter.date(from: "2026-06-30")!,
                additionalInfo: ["interestRate": "1.8%", "regulation": "EU Deposit Guarantee"]
            ),
            
            // 3. 포르투갈
            BankModel(
                country: "PT",
                bankAddress: "Lisboa, Rua Augusta 110",
                bankURL: "https://www.bcp.pt",
                bankName: "Banco Comercial Português",
                monthlySavingAmount: 40, // 유로
                maxProtectionLimit: 100000.0, // 유로
                applicationDeadline: dateFormatter.date(from: "2025-09-15")!,
                maturityDate: dateFormatter.date(from: "2027-09-15")!,
                additionalInfo: ["interestRate": "2.0%", "term": "2 years"]
            ),
            
            // 4. 일본
            BankModel(
                country: "JP",
                bankAddress: "Tokyo, Chuo-ku 1-1-1",
                bankURL: "https://www.mufg.jp",
                bankName: "MUFG Bank",
                monthlySavingAmount: 5000, // 엔
                maxProtectionLimit: 10000000.0, // 엔
                applicationDeadline: dateFormatter.date(from: "2025-03-31")!,
                maturityDate: dateFormatter.date(from: "2026-03-31")!,
                additionalInfo: ["interestRate": "0.5%", "bonus": "0.1% 추가"]
            ),
            
            // 5. 인도네시아
            BankModel(
                country: "ID",
                bankAddress: "Jakarta, Jl. Sudirman 54",
                bankURL: "https://www.bri.co.id",
                bankName: "Bank Rakyat Indonesia",
                monthlySavingAmount: 100000, // 루피아
                maxProtectionLimit: 2000000000.0, // 루피아
                applicationDeadline: dateFormatter.date(from: "2025-11-30")!,
                maturityDate: dateFormatter.date(from: "2026-11-30")!,
                additionalInfo: ["interestRate": "4.5%", "promo": "Cashback"]
            ),
            
            // 6. 태국
            BankModel(
                country: "TH",
                bankAddress: "Bangkok, Rama IV Road",
                bankURL: "https://www.scb.co.th",
                bankName: "Siam Commercial Bank",
                monthlySavingAmount: 500, // 바트
                maxProtectionLimit: 1000000.0, // 바트
                applicationDeadline: dateFormatter.date(from: "2025-08-20")!,
                maturityDate: dateFormatter.date(from: "2026-08-20")!,
                additionalInfo: ["interestRate": "3.0%", "minTerm": "12 months"]
            ),
            
            // 7. 베트남
            BankModel(
                country: "VN",
                bankAddress: "Hanoi, 123 Tran Hung Dao",
                bankURL: "https://www.vietcombank.com.vn",
                bankName: "Vietcombank",
                monthlySavingAmount: 200000, // 동
                maxProtectionLimit: 125000000.0, // 동
                applicationDeadline: dateFormatter.date(from: "2025-10-15")!,
                maturityDate: dateFormatter.date(from: "2027-10-15")!,
                additionalInfo: ["interestRate": "5.5%", "promo": "Free insurance"]
            ),
            
            // 8. 한국 (2)
            BankModel(
                country: "KR",
                bankAddress: "부산시 해운대구 456",
                bankURL: "https://www.kbstar.com",
                bankName: "국민은행",
                monthlySavingAmount: 100000,
                maxProtectionLimit: 50000000.0,
                applicationDeadline: dateFormatter.date(from: "2025-07-31")!,
                maturityDate: dateFormatter.date(from: "2026-07-31")!,
                additionalInfo: ["interestRate": "2.8%", "accountType": "정기예금"]
            ),
            
            // 9. 스페인 (2)
            BankModel(
                country: "ES",
                bankAddress: "Barcelona, Plaça de Catalunya 1",
                bankURL: "https://www.caixabank.es",
                bankName: "CaixaBank",
                monthlySavingAmount: 60, // 유로
                maxProtectionLimit: 100000.0, // 유로
                applicationDeadline: dateFormatter.date(from: "2025-05-20")!,
                maturityDate: dateFormatter.date(from: "2026-05-20")!,
                additionalInfo: ["interestRate": "1.5%", "term": "1 year"]
            ),
            
            // 10. 일본 (2)
            BankModel(
                country: "JP",
                bankAddress: "Osaka, Namba 2-3-4",
                bankURL: "https://www.smbc.co.jp",
                bankName: "SMBC",
                monthlySavingAmount: 10000, // 엔
                maxProtectionLimit: 10000000.0, // 엔
                applicationDeadline: dateFormatter.date(from: "2025-04-30")!,
                maturityDate: dateFormatter.date(from: "2027-04-30")!,
                additionalInfo: ["interestRate": "0.7%", "campaign": "Spring Bonus"]
            ),
            
            // 11. 인도네시아 (2)
            BankModel(
                country: "ID",
                bankAddress: "Surabaya, Jl. Pemuda 12",
                bankURL: "https://www.mandiri.co.id",
                bankName: "Bank Mandiri",
                monthlySavingAmount: 150000, // 루피아
                maxProtectionLimit: 2000000000.0, // 루피아
                applicationDeadline: dateFormatter.date(from: "2025-12-15")!,
                maturityDate: dateFormatter.date(from: "2026-12-15")!,
                additionalInfo: ["interestRate": "4.0%", "benefit": "Free transfer"]
            ),
            
            // 12. 태국 (2)
            BankModel(
                country: "TH",
                bankAddress: "Chiang Mai, Nimmanhaemin Rd",
                bankURL: "https://www.krungthai.com",
                bankName: "Krungthai Bank",
                monthlySavingAmount: 1000, // 바트
                maxProtectionLimit: 1500000.0, // 바트
                applicationDeadline: dateFormatter.date(from: "2025-09-30")!,
                maturityDate: dateFormatter.date(from: "2026-09-30")!,
                additionalInfo: ["interestRate": "2.8%", "promo": "Travel voucher"]
            ),
            
            // 13. 베트남 (2)
            BankModel(
                country: "VN",
                bankAddress: "Ho Chi Minh City, 45 Le Duan",
                bankURL: "https://www.techcombank.com.vn",
                bankName: "Techcombank",
                monthlySavingAmount: 300000, // 동
                maxProtectionLimit: 150000000.0, // 동
                applicationDeadline: dateFormatter.date(from: "2025-11-20")!,
                maturityDate: dateFormatter.date(from: "2027-11-20")!,
                additionalInfo: ["interestRate": "6.0%", "term": "24 months"]
            ),
            
            // 14. 포르투갈 (2)
            BankModel(
                country: "PT",
                bankAddress: "Porto, Rua de Santa Catarina 23",
                bankURL: "https://www.novobanco.pt",
                bankName: "Novo Banco",
                monthlySavingAmount: 30, // 유로
                maxProtectionLimit: 100000.0, // 유로
                applicationDeadline: dateFormatter.date(from: "2025-08-31")!,
                maturityDate: dateFormatter.date(from: "2026-08-31")!,
                additionalInfo: ["interestRate": "1.9%", "condition": "Online only"]
            ),
            
            // 15. 한국 (3)
            BankModel(
                country: "KR",
                bankAddress: "인천시 남동구 789",
                bankURL: "https://www.hana.com",
                bankName: "하나은행",
                monthlySavingAmount: 70000,
                maxProtectionLimit: 50000000.0,
                applicationDeadline: dateFormatter.date(from: "2025-10-31")!,
                maturityDate: dateFormatter.date(from: "2026-10-31")!,
                additionalInfo: ["interestRate": "2.6%", "promo": "Gift card"]
            )
        ]
    }
    
    
    // 직장 / 자격증
    func dummyCertificationList() -> [CertificationModel] {
        return [
            CertificationModel(country: "KR", name: "정보처리기사", date: dateFormatter.date(from: "2025-06-15")!),
            CertificationModel(country: "ES", name: "DELE B2", date: dateFormatter.date(from: "2025-04-20")!),
            CertificationModel(country: "PT", name: "CAPLE C1", date: dateFormatter.date(from: "2025-07-10")!),
            CertificationModel(country: "JP", name: "JLPT N2", date: dateFormatter.date(from: "2025-12-01")!),
            CertificationModel(country: "ID", name: "UKBI Level 3", date: dateFormatter.date(from: "2025-09-25")!),
            CertificationModel(country: "TH", name: "Thai Proficiency Test", date: dateFormatter.date(from: "2025-08-15")!),
            CertificationModel(country: "VN", name: "VSTEP B2", date: dateFormatter.date(from: "2025-11-30")!),
            CertificationModel(country: "KR", name: "토익", date: dateFormatter.date(from: "2025-03-22")!),
            CertificationModel(country: "JP", name: "BJT J2", date: dateFormatter.date(from: "2025-05-18")!),
            CertificationModel(country: "ES", name: "SIELE", date: dateFormatter.date(from: "2025-10-05")!)
        ]
    }
    
    // 직장 / 쥐칙박람회
    func dummyJobFair() -> [JobFairModel] {
        return [
            JobFairModel(country: "KR", name: "서울 취업 박람회", address: "서울 코엑스", url: "https://seouljobfair.kr"),
            JobFairModel(country: "ES", name: "Feria de Empleo Madrid", address: "Madrid IFEMA", url: "https://empleomadrid.es"),
            JobFairModel(country: "PT", name: "Feira de Emprego Lisboa", address: "Lisboa Centro de Congressos", url: "https://empregolx.pt"),
            JobFairModel(country: "JP", name: "Tokyo Job Expo", address: "Tokyo Big Sight", url: "https://tokyojobexpo.jp"),
            JobFairModel(country: "ID", name: "Jakarta Career Fair", address: "Jakarta Convention Center", url: "https://careerfair.id"),
            JobFairModel(country: "TH", name: "Bangkok Job Fair", address: "BITEC Bangkok", url: "https://bangkokjobfair.th"),
            JobFairModel(country: "VN", name: "Hanoi Employment Expo", address: "Hanoi Exhibition Center", url: "https://hanoijob.vn"),
            JobFairModel(country: "KR", name: "부산 일자리 박람회", address: "부산 벡스코", url: "https://busanjobs.kr"),
            JobFairModel(country: "JP", name: "Osaka Career Fair", address: "Osaka Intex", url: "https://osakajob.jp"),
            JobFairModel(country: "ES", name: "Barcelona Job Summit", address: "Fira Barcelona", url: "https://jobsummit.es")
        ]
    }
    
    // 직장 / 구인구직
    func dummyEmploymentList() -> [EmploymentModel] {
        return [
            EmploymentModel(country: "KR", name: "삼성전자", address: "수원시 영통구"),
            EmploymentModel(country: "ES", name: "Telefónica", address: "Madrid, Gran Vía"),
            EmploymentModel(country: "PT", name: "EDP Energias", address: "Lisboa, Av. 24 de Julho"),
            EmploymentModel(country: "JP", name: "Toyota", address: "Toyota City, Aichi"),
            EmploymentModel(country: "ID", name: "Pertamina", address: "Jakarta, Jl. Medan Merdeka"),
            EmploymentModel(country: "TH", name: "PTT Group", address: "Bangkok, Vibhavadi Rangsit"),
            EmploymentModel(country: "VN", name: "VinGroup", address: "Hanoi, Vinhomes Riverside"),
            EmploymentModel(country: "KR", name: "현대자동차", address: "울산시 북구"),
            EmploymentModel(country: "JP", name: "Sony", address: "Tokyo, Minato-ku"),
            EmploymentModel(country: "ES", name: "BBVA", address: "Bilbao, Plaza San Nicolás")
        ]
    }
    
    // 직장 / 공모전
    func dummyContestList() -> [ContestModel] {
        return [
            ContestModel(country: "KR", name: "서울 디자인 공모전", address: "서울 DDP"),
            ContestModel(country: "ES", name: "Madrid Innovation Contest", address: "Madrid Palacio de Cibeles"),
            ContestModel(country: "PT", name: "Lisboa Startup Challenge", address: "Lisboa LX Factory"),
            ContestModel(country: "JP", name: "Tokyo Hackathon", address: "Tokyo Shibuya"),
            ContestModel(country: "ID", name: "Jakarta Coding Competition", address: "Jakarta Pantai Indah Kapuk"),
            ContestModel(country: "TH", name: "Bangkok Art Contest", address: "Bangkok MBK Center"),
            ContestModel(country: "VN", name: "Hanoi Entrepreneurship Contest", address: "Hanoi Keangnam Tower"),
            ContestModel(country: "KR", name: "부산 영화 콘테스트", address: "부산 해운대"),
            ContestModel(country: "JP", name: "Osaka Robotics Challenge", address: "Osaka Umeda"),
            ContestModel(country: "ES", name: "Barcelona Photography Contest", address: "Barcelona Parc Güell")
        ]
    }
}
