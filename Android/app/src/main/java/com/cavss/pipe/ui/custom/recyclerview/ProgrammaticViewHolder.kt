package com.cavss.pipe.ui.custom.recyclerview

import android.util.Log
import android.view.View
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.RecyclerView

abstract class ProgrammaticViewHolder<MODEL : Any, BIND : View>(
    protected var view : View // 하위 클래스에서 접근 가능하도록 protected 키워드 사용. private 사용시 접근불가.
) : RecyclerView.ViewHolder(view){
    /*
    Viewholder에서 클릭이벤트를 처리하기 위해 코루틴 등을 사용하게 되면,
    새로운 스레드를 만들지 않고 기존 스레드를 재활용하여 효율적으로 처리할 수 있다.
    그치만 ViewHolder 특성상 객체가 많이 생성되고 해체되기 때문에 메모리가 낭비된다.

    따라서 동작 이벤트는 코루틴 대신 CallBack interface를 사용하여
    적은 메모리를 사용하고 메모리 누수를 방지할 수 있다.
     */
//    abstract fun bind(model: MODEL?, position : Int, clickListener: ViewHolderClickListener<MODEL>?)

    fun bind(variableList : List<Pair<Int, Any>>?){
        try{

        }catch (e:Exception){
            Log.e("mException", "BaseViewHolder, bindVariable // Exception : ${e.localizedMessage}")
        }

    }
}