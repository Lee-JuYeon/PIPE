//
//  YeahgumBaseModel.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/06/30.
//

import Foundation
import UIKit

class CustomUserDefaults {
    // UserDefaults 싱글톤 인스턴스 생성
    static let instance = CustomUserDefaults()

    private init() {
        // 생성자를 private로 만들어 외부에서 객체를 생성하는 것을 방지
    }

    func setUserInfo(){
        UserDefaults.standard.set("", forKey: "")
    }
    
    func addCalendarDate(){
        UserDefaults.standard
    }
    
      // 사용자 이름을 저장하고 검색하는 함수
      func setUsername(_ username: String) {
          UserDefaults.standard.set(username, forKey: "username")
      }

      func getUsername() -> String? {
          return UserDefaults.standard.string(forKey: "username")
      }

      // 추가로 설정 및 데이터 저장/검색 함수를 정의할 수 있습니다.
      
      // 사용자 로그아웃 처리
      func logout() {
          UserDefaults.standard.removeObject(forKey: "username")
          // 다른 설정 및 데이터도 여기에서 삭제
      }
}
