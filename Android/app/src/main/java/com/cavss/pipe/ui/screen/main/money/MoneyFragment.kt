package com.cavss.pipe.ui.screen.main.money

import android.os.Bundle
import android.util.Log
import android.view.*
import android.view.View
import android.widget.RelativeLayout
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.viewpager2.widget.ViewPager2
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentMoneyBinding
import com.cavss.pipe.ui.custom.viewpager.BaseFragmentAdapter
import com.cavss.pipe.ui.screen.main.MainBottomNaviVM
import com.cavss.pipe.ui.screen.main.money.frags.BankFragment
import com.cavss.pipe.ui.screen.main.money.frags.SupportFragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class MoneyFragment : Fragment(){

    private var bankFragment : BankFragment? = null
    private var supportFragment : SupportFragment? = null
    private fun setTabLayoutWithViewPager2(tabLayout: TabLayout, viewPager2: ViewPager2){
        try{
            bankFragment = BankFragment()
            supportFragment = SupportFragment()
            viewPager2.let {
                var viewpagerAdapter =  object : BaseFragmentAdapter.Adapter(requireActivity()){
                    override fun setFragmentList(): List<Fragment> {
                        return listOf<Fragment>(
                            supportFragment ?: SupportFragment(),
                            bankFragment ?: BankFragment()
                        )
                    }
                }
                it.adapter = viewpagerAdapter
                it.isUserInputEnabled = false // 스크롤로 프래그먼트 이동 억제
            }

            tabLayout.let {
                it.tabMode = TabLayout.MODE_FIXED
                it.tabGravity = TabLayout.GRAVITY_FILL
            }
            TabLayoutMediator(binding.tablayout, binding.viewpager2){ tab, position ->
                val SUPPORT = 0
                val BANK = 1
                when(position){
                    SUPPORT -> {
                        tab.text = requireContext().getString(R.string.fragment_money_item_support)
                    }
                    BANK -> {
                        tab.text = requireContext().getString(R.string.fragment_money_item_bank)
                    }
                }
            }.attach()
        }catch (e:Exception){
            Log.e("mException", "MoneyFragment, setTabLayout // Exception : ${e.localizedMessage}")
        }
    }


    private val mainBottomNaviVM : MainBottomNaviVM by activityViewModels()

    private lateinit var binding : FragmentMoneyBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMoneyBinding.inflate(inflater, container, false)
        binding.run {
            setTabLayoutWithViewPager2(
                tabLayout = this@run.tablayout,
                viewPager2 = this@run.viewpager2
            )
        }
        return binding.root
    }



    override fun onStart() {
        super.onStart()
        /*
        액티비티가 시작됨 상태에 들어가면 이 메서드를 호출합니다.
        사용자에게 프래그먼트가 보이게 되고, 이 메서드에서 UI를 관리하는 코드를 초기화 합니다.
        이 메서드는 매우 빠르게 완료되고, 완료되면 Resumed(재개)상태로 들어가 onResume() 메서드를 호출합니다.
         */

    }

    override fun onResume() {
        super.onResume()
        /*
        이 상태에 들어갔을 때 사용자와 상호작용 합니다.
        어떤 이벤트가 발생하여 포커스가 떠날 때 까지 이 상태에 머무릅니다.
        프로그램이 일시정지되어 onPause()를 호출하고 다시 재개되면 onResume() 메서드를 다시 호출합니다.
        재개 상태로 전환될때마다 필요한 초기화 작업들을 수행해야 합니다.
         */
    }

    override fun onPause() {
        super.onPause()
        /*
        사용자가 프래그먼트를 떠나면 첫번 째로 이 메서드를 호출합니다.
        사용자가 돌아오지 않을 수도 있으므로 여기에 현재 사용자 세션을 넘어 지속되어야 하는 변경사항을 저장합니다
         */
    }


    override fun onStop() {
        super.onStop()
        /*
        다른 액티비티가 완전히 화면을 가리게 되면 호출합니다. 필요하지 않은 리소스를 해제하거나 조정해야 합니다.

        액티비티가 중단되면 액티비티 객체는 메모리 안에 머무르게 됩니다. 이 객체가 모든 상태 및 멤버 정보를 가지고 관리하지만 연결되 있지는 않습니다. 다시 시작되면 이 객체를 다시 호출합니다. 최상위 상태가 재개되어도 콜백 메서드 중에 생성된 요소는 다시 초기화할 필요가 없습니다. 또한 시스템은 레이아웃에 있는 각 View 객체의 현재 상태도 기록하므로 사용자가 EditText 위젯에 텍스트를 입력했다면 내용이 저장되기 때문에 저장, 복원할 필요가 없습니다.
        프래그먼트는 이를 제거하는 트랜잭션에서 addToBackStack()을 호출하여 인스턴스를 저장하라고 명시적으로 요청할 경우에만 액티비티에서 관리하는 백 스택으로 들어갑니다.
         */
        bankFragment = null
        supportFragment = null
    }


}
/*
private lateinit var binding : FragmentMoneyBinding
    private val pipeVM : PipeVM by activityViewModels()

    private var bankFragment : BankFragment? = null
    private var supportFragment : SupportFragment? = null

    private var moneyAdpater : BaseAdapters.RecyclerAdapter<SupportModel, HolderSupportBinding>? = null
    private var bottomSheet : CustomBottomSheet? = null
    private fun setMoneyRecyclerView(recyclerview : RecyclerView){
        try {
            val clickEvent = object : IClickListener<SupportModel> {
                override fun onItemClick(model: SupportModel, position: Int) {
                    Log.e("mException", "해당 아이템 저장 : ${model}")
                    bottomSheet = CustomBottomSheet(requireActivity())
                    bottomSheet?.apply {
                        setGravity(Gravity.BOTTOM)
                        show()
                    }
                }
            }

            moneyAdpater = object :
                BaseAdapters.RecyclerAdapter<SupportModel, HolderSupportBinding>() {
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_support
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: SupportModel?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!,
                        BR.position to position,
                        BR.clickCallback to clickEvent
                    )
                }

            }
            recyclerview.apply {
                adapter = moneyAdpater
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply {
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }
        } catch (e: Exception) {
            Log.e("mException", "MoneyFragment, setMoneyRecyclerView // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateMoneyAdapterList(newList : List<SupportModel>){
        try {
            moneyAdpater?.updateList(newList)
        }catch (e:Exception){
            Log.e("mException", "MoneyFragment, updateMoneyAdapterList // Exception : ${e.localizedMessage}")
        }
    }
    private fun setFiltering(){
        try{
//            val drawable = ContextCompat.getDrawable(requireContext(), R.drawable.icon_search)
//            drawable?.setBounds(0, 0, 60, 60) // 아이콘 크기 조정
//            binding.moneySearch.setCompoundDrawables(drawable, null, null, null) // 동적으로 아이콘 설정
            binding.moneySearch.addTextChangedListener {

            }
        }catch (e:Exception){
            Log.e("mException","MoneyFragment, setFiltering // Exception : ${e.localizedMessage}")
        }
    }
    private fun setHeaderDesign(){
        try{
            binding.moneyHeader.let {

            }
//            binding.moneyHeaderDragger.let {
//                it.outlineProvider = object : ViewOutlineProvider() {
//                    override fun getOutline(view: View?, outline: Outline?) {
//                        outline?.setRoundRect(
//                            0,
//                            0,
//                            view!!.width,
//                            view.height,
//                            30f // 원하는 radius 값으로 변경 가능
//                        )
//                    }
//                }
//
//                it.background = GradientDrawable(
//                        GradientDrawable.Orientation.LEFT_RIGHT,
//                        intArrayOf(
//                            requireContext().getColor(R.color.claymorphismPositiveBackground),
//                            requireContext().getColor(R.color.claymorphismPositiveInnerShadowLeftTop),
//                            requireContext().getColor(R.color.claymorphismPositiveInnerShadowRightBottom)
//                        )
//                    ).apply {
//                        // 그라데이션 타입을 선형으로 지정합니다.
//                        this.gradientType =  GradientDrawable.LINEAR_GRADIENT
//                    }
//                it.clipToOutline = true
//                it.setOnClickListener {
//                    val scaleY = ObjectAnimator.ofFloat(binding.moneyFilter.viewStub, View.SCALE_Y, 0f, 1f)
//                    val alpha = ObjectAnimator.ofFloat(binding.moneyFilter.viewStub, View.ALPHA, 0f, 1f)
//
//                    val set = AnimatorSet()
//                    set.playTogether(scaleY, alpha)
//                    set.interpolator = AccelerateDecelerateInterpolator()
//                    set.duration = 200
//                    when(binding.moneyFilter.viewStub?.visibility){
//                        View.VISIBLE -> {
//                            binding.moneyFilter.viewStub?.visibility = View.GONE
//                            set.start()
//                        }
//                        else -> {
//                            binding.moneyFilter.viewStub?.visibility = View.VISIBLE
//                            set.start()
//                        }
//                    }
//                }
//            }
        }catch (e:Exception){
            Log.e("mException","MoneyFragment, setHeaderDesign // Exception : ${e.localizedMessage}")
        }
    }
//    private fun setViewStub(){
//        try{
//            binding.moneyFilter.viewStub?.setOnInflateListener { viewStub, view ->
//                val mBinding = ViewstubMoneyFilterBinding.bind(view)
//                mBinding
//            }
//            binding.moneyFilter.viewStub?.inflate()
//        }catch (e:Exception){
//            Log.e("mException", "MoneyFragment, setViewStub // Exception : ${e.localizedMessage}")
//        }
//    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentMoneyBinding.inflate(inflater, container, false)
        setMoneyRecyclerView(binding.moneyRecyclerview)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        setViewStub()
        setHeaderDesign()
        setFiltering()
    }
    override fun onStart() {
        super.onStart()
        pipeVM.let {
            it.loadMoneyList()
            it.moneyList.observe(requireActivity()){ list : List<SupportModel> ->
                updateMoneyAdapterList(list)
            }
        }

    }

    override fun onDestroyView() {
        super.onDestroyView()
    }
 */