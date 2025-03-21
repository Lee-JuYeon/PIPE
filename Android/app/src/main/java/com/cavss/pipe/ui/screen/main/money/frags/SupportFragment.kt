package com.cavss.pipe.ui.screen.main.money.frags

import android.graphics.Color
import android.graphics.drawable.Drawable
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.text.method.LinkMovementMethod
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.view.setPadding
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.pipe.BR
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentMoneySupportBinding
import com.cavss.pipe.databinding.HolderMoneySupportBinding
import com.cavss.pipe.model.money.support.SupportModel
import com.cavss.pipe.ui.custom.jy_bottomsheet.JuYeonBottomSheet
import com.cavss.pipe.ui.custom.recyclerview.CustomItemGap
import com.cavss.pipe.ui.custom.recyclerview.IClickEventListener
import com.cavss.pipe.abstracts.AdsAdapter
import com.cavss.pipe.databinding.IncludeFilteringBinding
import com.cavss.pipe.model.target.FamilyOption
import com.cavss.pipe.ui.custom.jy_address.JuYeonAddress
import com.cavss.pipe.ui.custom.jy_switch.JuYeonSwitch
import com.cavss.pipe.vm.PipeVM

class SupportFragment : Fragment() {

    private fun showBottomSheet(model: SupportModel) {
        JuYeonBottomSheet(requireContext()).apply {
            fetchContentView(
                TextView(requireContext()).apply {
                    text = model.toBottomSheetMapping(requireContext())
                    // TextView에 LinkMovementMethod 설정
                    movementMethod = LinkMovementMethod.getInstance()
                    // TextView에 클릭 가능하도록 설정
                    isClickable = true
                    // TextView에 포커스를 받을 수 있도록 설정
                    isFocusableInTouchMode = true
                    setLineSpacing(16f,1f)
                    setPadding(20)
                }
            )
            show()
        }
    }

    private var supportList : List<SupportModel> = listOf()
    private var adsAdapter : AdsAdapter<SupportModel, HolderMoneySupportBinding>? = null

    private fun setRecyclerview(recyclerview : RecyclerView){
        try {
            val clickEvent = object : IClickEventListener {
                override fun onItemClick(model: Any, position: Int) {
                    when(model){
                        is SupportModel -> {
                            showBottomSheet(model)
                            Log.e("mException", "SupportFragment, setRecyclerview, clickEvent // ${position}th model : ${model.serviceTitle}")
                        }
                        else -> {
                            Log.e("mException", "SupportFragment, setRecyclerview, clickEvent // 알 수 없는 모델")
                        }
                    }
                }
            }

            adsAdapter = object : AdsAdapter<SupportModel, HolderMoneySupportBinding>(R.layout.holder_money_support){
                inner class SupportViewHolder(private val binding : HolderMoneySupportBinding) : RecyclerView.ViewHolder(binding.root){
                    fun binding(model : SupportModel?, position : Int, clickevent : IClickEventListener?){
                        try{
                            binding.setVariable(BR.model, model)
                            binding.setVariable(BR.position, position)
                            binding.setVariable(BR.clickCallback, clickevent)
                            binding.executePendingBindings()
                        }catch (e:Exception){
                            Log.e("mException", "SupportFragment, setRecyclerview, adsAdapter // Exception : ${e.localizedMessage}")
                        }
                    }
                }
                override fun createContentViewHolder(binding: HolderMoneySupportBinding): RecyclerView.ViewHolder {
                    return SupportViewHolder(binding)
                }

                override fun bindContentViewHolder(holder: RecyclerView.ViewHolder, model : SupportModel, position: Int) {
                    val mHolder = holder as SupportViewHolder
                    mHolder.binding(model, position, clickEvent)
                }
            }

            recyclerview.apply {
                adapter = adsAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply{
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        }catch (e:Exception){
            Log.e("mException", "SupportFragment, setRecyclerview // Exception : ${e.localizedMessage}")
        }
    }

    private lateinit var binding : FragmentMoneySupportBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMoneySupportBinding.inflate(inflater, container, false)
        return binding.root
    }

    private fun setFilteringContainer(container : RelativeLayout){
        try{
            var themeColour : Int = Color.WHITE
            val nightModeFlags = requireContext().resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
            if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
                // 나이트 모드일 때 텍스트 색상
                themeColour = Color.DKGRAY
            } else {
                // 라이트 모드일 때 텍스트 색상
                themeColour = requireContext().getColor(R.color.claymorphismThemeColour)
            }
            val gradientDrawable = GradientDrawable(
                GradientDrawable.Orientation.TOP_BOTTOM, // 그라데이션 방향 (위에서 아래로)
                intArrayOf(
                    ContextCompat.getColor(requireContext(), R.color.lightWhitenightBlack),
                    themeColour
                ) // 시작 색상과 종료 색상 배열
            ).apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadii = floatArrayOf(0f, 0f, 0f, 0f, 20f, 20f, 20f, 20f)
                setStroke(5, requireContext().getColor(R.color.lightWhitenightBlack)) // 흰색 테두리 설정
            }

            container.apply {
                background = gradientDrawable
                layoutParams = RelativeLayout.LayoutParams(
                    RelativeLayout.LayoutParams.MATCH_PARENT,
                    RelativeLayout.LayoutParams.WRAP_CONTENT
                ).apply {
                    setMargins(10,0,10,0)
                }
                setPadding(25)
            }
        }catch (e:Exception){
            Log.e("mException", "SupportFragment, setFilteringContainer // Exception : ${e.localizedMessage}")
        }
    }
    private fun setFilteringInclude(include : IncludeFilteringBinding){
        try {
            include.root.visibility = View.VISIBLE // ViewStub이 화면에 나타나도록 visibility 변경

            val filteringTitle = binding.filteringTitle
            filteringTitle.text = "${requireContext().getText(R.string.viewstub_detail_title)} 🔼"
            filteringTitle.setOnClickListener {
                if (include.root.visibility == View.VISIBLE) {
                    include.root.visibility = View.GONE
                    filteringTitle.text = "${requireContext().getText(R.string.viewstub_detail_title)} 🔽"
                } else {
                    include.root.visibility = View.VISIBLE
                    filteringTitle.text = "${requireContext().getText(R.string.viewstub_detail_title)} 🔼"
                }
            }

            include.apply {
                address.apply {
                    setOnTextChangedListener(object : JuYeonAddress.OnTextChangedListener {
                        override fun onTextChanged(country: String, city: String, district: String, neighborhood: String) {
                            // 텍스트 변경에 대한 처리 코드를 여기에 작성
                            // country, city, district, neighborhood 매개변수를 사용하여 필요한 작업을 수행
                            Log.e("mException", "address : ${country}-${city}-${district}-${neighborhood}")
                        }
                    })
                }
                familyTypeDropdown.apply {
                    val familyOptionList : List<String> = FamilyOption.values().map {
                        it.rawValue
                    }.toList()
                    setMenu(familyOptionList)
                    setMenuItemClick { clickedMenu ->

                        Log.e("mException", "Clicked Menu: $clickedMenu")
                    }
                }
                genderSwitch.apply {
                    setOnSwitchChangedListener(object : JuYeonSwitch.JuYeonSwitchListener {
                        override fun onSwitchChanged(value: Drawable?) {
                            Log.e("mException", "Clicked: $value")
                        }
                    })
                }
                agePicker.apply {
                    maxValue = 2024
                    minValue = 1900
                    value = 1990
                    setOnValueChangedListener { numberPicker, oldValue, newValue ->
                        Log.e("mException", "지금 벨류 : ${newValue}")
                    }
                }
            }
        }catch (e:Exception){
            Log.e("mException", "SupportFragment, setFilteringInclude // Exception : ${e.localizedMessage}")
        }
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setRecyclerview(recyclerview = binding.recyclerview)
        setFilteringInclude(include = binding.filterInclude)
        setFilteringContainer(container = binding.filteringContainer)
    }

    private val pipeVM : PipeVM by activityViewModels()
    override fun onStart() {
        super.onStart()
        pipeVM.let {
            it.loadSupportList()
            it.supportList.observe(requireActivity()){ list : List<SupportModel> ->
                adsAdapter?.updateList(list)
                supportList = list
            }
        }
    }
}