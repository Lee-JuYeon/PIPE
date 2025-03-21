package com.cavss.pipe.repository

import com.cavss.pipe.model.board.NotificationModel
import kotlinx.coroutines.flow.*

class NotificationRepository {

    private val _notificationList = MutableStateFlow<List<NotificationModel>>(listOf())
    val notificationList : StateFlow<List<NotificationModel>>
        get() = _notificationList

    private val dummyNotificationList = listOf<NotificationModel>(
        NotificationModel(title = "1, PIPE 정보", content = "email : pizzalover114@naver.com \nemail : emila2@naver.com\n문의 등 모든 이메일과 이메일의 내용은 앱을 통해 공개 할 예정이니 주의하시길 바랍니다.", date = "2023-4-29"),
        NotificationModel(title = "3, 광고 관련 문의", content = "모든 계약서의 내용은 오픈됩니다. \nemail : pizzalover114@naver.com", date = "2023-4-15"),
        NotificationModel(title = "2, 후원 관련 문의", content = "모든 후원과 사용처 내용은 오픈됩니다. \nemail : pizzalover114@naver.com", date = "2023-4-20"),
        NotificationModel(title = "4, 후원 관련 문의", content = "모든 후원과 사용처 내용은 오픈됩니다. \nemail : pizzalover114@naver.com", date = "2023-4-9")
    )

    suspend fun getNotificationList() {
        val list = dummyNotificationList
        _notificationList.value = list
    }
}