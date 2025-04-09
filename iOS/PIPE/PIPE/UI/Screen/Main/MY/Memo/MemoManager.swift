//
//  SavingController.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/28.
//

import Foundation

class MemoManager {
    static let shared = MemoManager()
    
    // NotificationCenter 관련 상수 정의
    struct NotificationNames {
        static let memosUpdated = Notification.Name("MemoCoreManagerMemosUpdated")
        static let memoSaved = Notification.Name("MemoCoreManagerMemoSaved")
        static let memoDeleted = Notification.Name("MemoCoreManagerMemoDeleted")
        static let memoUpdated = Notification.Name("MemoCoreManagerMemoUpdated")
    }
    
    // 메모리 캐싱
    private var memosCache: [MemoModel] = []
    
    private init() {
        // 초기화 시 캐시 로드
        loadFromStorage()
    }
    
    private func loadFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "memos") {
            do {
                let memos = try JSONDecoder().decode([MemoModel].self, from: data)
                self.memosCache = memos
                // 초기 로딩 후 알림 전송
                notifyMemosUpdated()
            } catch {
                print("메모 로드 에러: \(error)")
                self.memosCache = []
            }
        } else {
            self.memosCache = []
        }
    }
    
    private func saveToStorage() -> Bool {
        do {
            let data = try JSONEncoder().encode(self.memosCache)
            UserDefaults.standard.set(data, forKey: "memos")
            return true
        } catch {
            print("메모 저장 에러: \(error)")
            return false
        }
    }
    
    // 현재 메모 목록을 직접 반환
    func getMemos() -> [MemoModel] {
        return memosCache
    }
    
    // 메모 목록 업데이트 알림 발송
    private func notifyMemosUpdated() {
        NotificationCenter.default.post(
            name: NotificationNames.memosUpdated,
            object: self,
            userInfo: ["memos": memosCache]
        )
    }
    
    // 메모 저장
    func saveMemo(_ memo: MemoModel, completion: ((Bool) -> Void)? = nil) {
        if let index = self.memosCache.firstIndex(where: { $0.id == memo.id }) {
            self.memosCache[index] = memo
        } else {
            self.memosCache.append(memo)
        }
        
        let success = saveToStorage()
        
        // 저장 결과 알림 발송
        NotificationCenter.default.post(
            name: NotificationNames.memoSaved,
            object: self,
            userInfo: ["memo": memo, "success": success]
        )
        
        // 목록 업데이트 알림 발송
        notifyMemosUpdated()
        
        // 완료 콜백 호출
        completion?(success)
    }
    
    // 메모 삭제
    func deleteMemo(id: UUID, completion: ((Bool) -> Void)? = nil) {
        let originalCount = memosCache.count
        memosCache.removeAll { $0.id == id }
        
        // 실제로 항목이 삭제되었는지 확인
        let wasDeleted = originalCount > memosCache.count
        let success = wasDeleted ? saveToStorage() : false
        
        // 삭제 결과 알림 발송
        NotificationCenter.default.post(
            name: NotificationNames.memoDeleted,
            object: self,
            userInfo: ["memoID": id, "success": success]
        )
        
        // 목록 업데이트 알림 발송
        notifyMemosUpdated()
        
        // 완료 콜백 호출
        completion?(success)
    }
    
    // 메모 업데이트
    func updateMemo(_ memo: MemoModel, completion: ((Bool) -> Void)? = nil) {
        guard let index = self.memosCache.firstIndex(where: { $0.id == memo.id }) else {
            completion?(false)
            return
        }
        
        self.memosCache[index] = memo
        let success = saveToStorage()
        
        // 업데이트 결과 알림 발송
        NotificationCenter.default.post(
            name: NotificationNames.memoUpdated,
            object: self,
            userInfo: ["memo": memo, "success": success]
        )
        
        // 목록 업데이트 알림 발송
        notifyMemosUpdated()
        
        // 완료 콜백 호출
        completion?(success)
    }
}
