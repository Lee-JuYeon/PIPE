package com.cavss.pipe.ui.screen.main.board.frags

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentBoardCalendarBinding
import com.cavss.pipe.databinding.HolderNotificationBinding
import com.cavss.pipe.databinding.HolderScheduleMemoBinding
import com.cavss.pipe.db.sharedpreference.CustomSharedPreference
import com.cavss.pipe.model.board.NotificationModel
import com.cavss.pipe.model.board.ScheduleMemoModel
import com.cavss.pipe.ui.custom.jy_calendar.JuYeonCalendar
import com.cavss.pipe.ui.custom.recyclerview.BaseAdapters
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickListener
import com.cavss.pipe.vm.PipeVM
import java.text.SimpleDateFormat
import java.util.Date

class CalendarMemoFragment : Fragment(){
    private lateinit var binding : FragmentBoardCalendarBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentBoardCalendarBinding.inflate(inflater, container, false)
        return binding.root
    }

    private fun setCalendarView(calendar : JuYeonCalendar){
        try {

        }catch (e:Exception){
            Log.e("mException", "CalendarMemoFragnemt, setCalendarView // Exception : ${e.localizedMessage}")
        }
    }
    private fun setMemoView(editText : EditText){
        try {
            val savedMemo = CustomSharedPreference.readMemo()
            editText.setText(savedMemo)
            editText.addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                    // 입력 전에 호출되는 메서드
                }
                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    // 텍스트가 변경될 때 호출되는 메서드
                }
                override fun afterTextChanged(s: Editable?) {
                    // 입력 후에 호출되는 메서드
                    CustomSharedPreference.writeMemo(s.toString())
                }
            })
        }catch (e:Exception){
            Log.e("mException", "CalendarMemoFragment, setMemoView // Exception : ${e.localizedMessage}")
        }
    }
    private fun settingSearchButton(button : TextView, answerTextView: TextView, search : EditText){
        try {
            button.text = "🔎"
            button.setOnClickListener {
                val chatbotAnswer = "삐리삐리삐리ㅃ리"

                // return answer of pipe chatbot at 'answer' textview
                answerTextView.text = "💁🏻 : ${chatbotAnswer}"
            }

            // remove txt underline of edittext
            search.setBackgroundResource(R.drawable.background_null)
        }catch (e:Exception){
            Log.e("mException", "ChatbotAskFragment, settingSearchButton // Exception : ${e.localizedMessage}/")
        }
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        setCalendarView(binding.myCalender)
        setMemoView(binding.myMemo)
        settingSearchButton(binding.searchButton, binding.answer, binding.search)
    }
}
