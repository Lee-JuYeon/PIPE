package com.cavss.pipe.vm

import androidx.lifecycle.ViewModel
import com.cavss.pipe.model.board.NotificationModel
import com.cavss.pipe.repository.NotificationRepository
import kotlinx.coroutines.flow.StateFlow


class NotificationVM : ViewModel() {
    private val repository : NotificationRepository = NotificationRepository()

    val notificationList: StateFlow<List<NotificationModel>>
        get() = repository.notificationList

    suspend fun loadNotificationList(){
        repository.getNotificationList()

    }


//    private var _notifications = MutableLiveData<List<NotificationModel>>()
//    val notification : LiveData<List<NotificationModel>>
//        get() = _notifications


    init {
//        _notifications.postValue(
//            listOf<NotificationModel>(
//                NotificationModel(title = "PIPE 정보", content = "email : pizzalover114@naver.com \nemail : emila2@naver.com\n문의 등 모든 이메일과 이메일의 내용은 앱을 통해 공개 할 예정이니 주의하시길 바랍니다.", date = "2023-4-29"),
//                NotificationModel(title = "광고 관련 문의", content = "모든 계약서의 내용은 오픈됩니다. \nemail : pizzalover114@naver.com", date = "2023-4-29"),
//                NotificationModel(title = "후원 관련 문의", content = "모든 후원과 사용처 내용은 오픈됩니다. \nemail : pizzalover114@naver.com", date = "2023-4-29")
//            )
//        )
    }
}

