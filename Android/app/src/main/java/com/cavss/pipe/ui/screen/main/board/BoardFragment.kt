package com.cavss.pipe.ui.screen.main.board

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.viewpager2.widget.ViewPager2
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentBoardBinding
import com.cavss.pipe.ui.custom.viewpager.BaseFragmentAdapter
import com.cavss.pipe.ui.screen.main.board.frags.CalendarMemoFragment
import com.cavss.pipe.ui.screen.main.board.frags.NotificationFragment
import com.cavss.pipe.interfaces.PortfolioFragment
import com.cavss.pipe.ui.screen.main.board.frags.SettingFragment
//import com.cavss.pipe.vm.LocalDBVM
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator


class BoardFragment : Fragment() {
    private var calendarFragment : CalendarMemoFragment? = null
    private var notificationFragment : NotificationFragment? = null
    private var settingFragment : SettingFragment? = null
    private fun setTabLayoutWithViewPager2(tabLayout: TabLayout, viewPager2: ViewPager2) {
        try{
            calendarFragment = CalendarMemoFragment()
            notificationFragment = NotificationFragment()
            settingFragment = SettingFragment()

            viewPager2.let {
                var viewpagerAdapter =  object : BaseFragmentAdapter.Adapter(requireActivity()){
                    override fun setFragmentList(): List<Fragment> {
                        return listOf<Fragment>(
                            calendarFragment ?: CalendarMemoFragment(),
                            notificationFragment ?: NotificationFragment(),
//                            portfolioFragment ?: PortfolioFragment(),
                            settingFragment ?: SettingFragment()
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
                // 달력+메모, 공지사항, 포폴, 로그인, llm 질의응답
                when(position){
                    0 -> {
                        // 달력 + 메모 + llm 질의응답
                        tab.text = requireContext().getString(R.string.fragment_board_item_calendar)
                    }
                    1 -> {
                        // 공지사항
                        tab.text = requireContext().getString(R.string.fragment_board_item_notification)
                    }
//                    2 -> {
//                        // 포폴
//                        tab.text = requireContext().getString(R.string.fragment_board_item_portfolio)
//                    }
                    2 -> {
                        // 설정
                        tab.text = requireContext().getString(R.string.fragment_board_item_setting)
                    }
                }
            }.attach()
        }catch (e:Exception){
            Log.e("mException", "BoardFragment, setTabLayoutWithViewPager2 // Exception : ${e.localizedMessage}")
        }
    }

    private lateinit var binding : FragmentBoardBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentBoardBinding.inflate(inflater, container, false)
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
        calendarFragment = null
        notificationFragment  = null
//        portfolioFragment = null
        settingFragment = null
    }
}

/*
//    private val localDBVM : LocalDBVM by activityViewModels()
    private val pipeVM : PipeVM by activityViewModels()
    private val notificationVM : NotificationVM by activityViewModels()
    private lateinit var binding : FragmentBoardBinding

    // option view
    private var myOptionViewAdapter : BaseAdapters.RecyclerAdapter<MyOptionViewModel, HolderMyoptionviewBinding>? = null
    private fun animateOptionView(viewlist : List<ViewGroup>, setView : View){
        try{
            viewlist.forEach {view : ViewGroup ->
                if (view == setView){
                    if (setView.visibility != View.VISIBLE){
                        val originalHeight = view.height
                        val startHeight = if (view.visibility == View.VISIBLE) 0 else originalHeight
                        val endHeight = if (view.visibility == View.VISIBLE) originalHeight else 0

                        val animation = TranslateAnimation(
                            0F, // fromXDelta
                            0F, // toXDelta
                            startHeight.toFloat(), // fromYDelta
                            endHeight.toFloat() // toYDelta
                        ).apply {
                            duration = 500 // 애니메이션의 지속 시간 (밀리초)
                            setAnimationListener(object : Animation.AnimationListener {
                                override fun onAnimationStart(animation: Animation?) {
                                    // 애니메이션 시작 후 처리
                                }
                                override fun onAnimationEnd(animation: Animation?) {
                                    // 애니메이션이 끝난 후 처리
                                    view.visibility = if (view.visibility == View.VISIBLE) View.GONE else View.VISIBLE
                                }
                                override fun onAnimationRepeat(animation: Animation?) {}
                            })
                        }
                        view.startAnimation(animation)
                    }
                }else if (view != setView){
                    if (view.visibility == View.VISIBLE){
                        val originalHeight = view.height
                        val startHeight = 0
                        val endHeight = originalHeight

                        val animation = TranslateAnimation(
                            0F, // fromXDelta
                            0F, // toXDelta
                            startHeight.toFloat(), // fromYDelta
                            endHeight.toFloat() // toYDelta
                        ).apply {
                            duration = 500 // 애니메이션의 지속 시간 (밀리초)
                            setAnimationListener(object : Animation.AnimationListener {
                                override fun onAnimationStart(animation: Animation?) {
                                    // 애니메이션 시작 후 처리
                                }
                                override fun onAnimationEnd(animation: Animation?) {
                                    // 애니메이션이 끝난 후 처리
                                    view.visibility =  View.GONE
                                }
                                override fun onAnimationRepeat(animation: Animation?) {}
                            })
                        }
                        view.startAnimation(animation)
                    }
                }
            }
        }catch (e:Exception){
            Log.e("mException", "MyFragment, animateOptionView // Exception : ${e.localizedMessage}")
        }
    }
    private fun setMyOptionViewRecycerlview(recyclerview : RecyclerView){
        try{
            val viewlist = listOf(
                binding.myCalendarInclude.myCalender,
                binding.myMemoInclude.myMemoContainer,
                binding.myNotificationInclude.myNotificationContainer,
                binding.myInfofilterInclude.myInfoFilter
            )
            val clickEvent = object : IClickListener<MyOptionViewModel> {
                override fun onItemClick(model: MyOptionViewModel, position: Int) {
                    when(model.optionViewText) {
                        "일정" -> {
                            animateOptionView(viewlist = viewlist, setView = binding.myCalendarInclude.myCalender)
                        }
                        "메모" -> {
                            animateOptionView(viewlist = viewlist, setView = binding.myMemoInclude.myMemoContainer)
                        }
                        "공지사항" -> {
                            animateOptionView(viewlist = viewlist, setView = binding.myNotificationInclude.myNotificationContainer)
                        }
                        "설정" -> {
                            animateOptionView(viewlist = viewlist, setView = binding.myInfofilterInclude.myInfoFilter)
                        }
                    }

                }
            }
            myOptionViewAdapter = object :
                BaseAdapters.RecyclerAdapter<MyOptionViewModel, HolderMyoptionviewBinding>() {
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_myoptionview
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: MyOptionViewModel?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!,
                        BR.position to position,
                        BR.clickCallback to clickEvent
                    )
                }

            }
            recyclerview.apply {
                adapter = myOptionViewAdapter
                setHasFixedSize(true)
                layoutManager = GridLayoutManager(requireContext(), 4).apply {
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }

        }catch (e:Exception){
            Log.e("mException", "MyFragment, setMyOptionViewRecycerlview // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateMyOptionViewAdapter(list : List<MyOptionViewModel>){
        try{
            myOptionViewAdapter?.updateList(list)
        }catch (e:Exception){
            Log.e("mException", "MyFragment, updateMyOptionViewAdapter // Exception : ${e.localizedMessage}")
        }
    }


    // notification view
    private var notificationAdpater : BaseAdapters.RecyclerAdapter<NotificationModel, HolderNotificationBinding>? = null
    private fun setNotificationRecyclerview(recyclerview : RecyclerView){
        try{
            val clickEvent = object : IClickListener<NotificationModel> {
                override fun onItemClick(model: NotificationModel, position: Int) {
//                    Log.e("mException", "해당 아이템 저장 : ${model}")

                }
            }
            notificationAdpater = object :
                BaseAdapters.RecyclerAdapter<NotificationModel, HolderNotificationBinding>() {
                override fun setViewHolderXmlFileName(viewType: Int): Int {
                    return R.layout.holder_notification
                }

                override fun setViewHolderVariable(
                    position: Int,
                    model: NotificationModel?
                ): List<Pair<Int, Any>> {
                    return listOf(
                        BR.model to model!!,
                        BR.position to position,
                        BR.clickCallback to clickEvent
                    )
                }

            }
            recyclerview.apply {
                adapter = notificationAdpater
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(requireActivity()).apply {
                    orientation = LinearLayoutManager.VERTICAL
                    isItemPrefetchEnabled = false
                }
                addItemDecoration(CustomItemGap(10))
                setItemViewCacheSize(0)
            }

        }catch (e:Exception){
            Log.e("mException", "MyFragment, setNotificationRecyclerview // Exception : ${e.localizedMessage}")
        }
    }
    private fun updateNotificationAdpater(list : List<NotificationModel>){
        try{
            notificationAdpater?.updateList(list)
        }catch (e:Exception){
            Log.e("mException", "MyFragment, updateNotificationAdpater // Exception : ${e.localizedMessage}")
        }
    }

    // calendar view
    private fun setCalendarView(calendar : CustomCalendarView){
        try{
//            val events = mapOf(
//                Calendar.getInstance().apply { set(2023, 4, 1) }.time to "Event 1",
//                Calendar.getInstance().apply { set(2023, 4, 2) }.time to "Event 2",
//                Calendar.getInstance().apply { set(2023, 4, 3) }.time to "Event 3"
//            )
//
//            calendar.setEvents(events)
//            calendar.onDateClickListener = { date ->
//                Log.e("mException", "MyFragment, setCalendarView // clicked : ${date}")
//            }
            calendar.setOnClick { day : Date ->
                val date = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(day)
                Log.e("mException", "클릭된 날짜 : ${date}")
                Unit
            }
        }catch (e:Exception){
            Log.e("mException", "MyFragment, setCalendarView // Exception : ${e.localizedMessage}")
        }
    }

    // memo view
    private fun setMemoEditView(editText : EditText){
        try {
            editText.let {
                it.setOnFocusChangeListener { view, hasFocus ->
                    if (!hasFocus){
                        // 포커스를 잃었을 때의 처리 로직
                        // 메모 내용 저장
                        var currentText = it.text.toString()
//                        localDBVM.insertMemo(
//                            MemoModel(memo = currentText)
//                        )
                    }
                }
            }
        }catch (e:Exception){
            Log.e("mException", "MyFragment, setMemoEditView // Exception : ${e.localizedMessage}")
        }
    }

    // filter view
    private fun setFilterView(){
        try{

        }catch (e:Exception){
            Log.e("mException", "MyFragment, setFilterView // Exception : ${e.localizedMessage}")
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentBoardBinding.inflate(inflater, container, false)
        binding.run {
            setCalendarView(binding.myCalendarInclude.myCalender)
            setMemoEditView(binding.myMemoInclude.myMemo)
            setMyOptionViewRecycerlview(binding.myOptionRecyclerview)
            setNotificationRecyclerview(binding.myNotificationInclude.myNotificationRecyclerview)
            setFilterView()
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // 달력+메모, 공지사항, 포폴, 로그인, llm 질의응답
        updateMyOptionViewAdapter(listOf(
            MyOptionViewModel("📅",requireContext().resources.getString(R.string.fragment_board_item_calendar)),
            MyOptionViewModel("\uD83D\uDCE3",requireContext().resources.getString(R.string.fragment_board_item_notification)),
            MyOptionViewModel("📝",requireContext().resources.getString(R.string.fragment_board_item_portfolio)),
            MyOptionViewModel("🙋🏻",requireContext().resources.getString(R.string.fragment_board_item_ask))

        ))

        notificationVM.let {
            lifecycleScope.launch(Dispatchers.IO) {
                it.loadNotificationList()
                it.notificationList.collect { list : List<NotificationModel> ->
                    updateNotificationAdpater(list)
                }
            }
        }
    }
    override fun onStart() {
        super.onStart()
        pipeVM.let {

        }
//        localDBVM.let {
//            lifecycleScope.launch(Dispatchers.IO) {
//                it.getMemos().observe(requireActivity()){ memo ->
//                    try{
//                        Log.e("mException", "MyFragment, 데이터 memo : ${memo}")
//                    }catch (e:Exception){
//                        Log.e("mException", "MyFragment, setInit, localDBVM.getAllMemos().observe  // Exception : ${e.message}")
//                    }
//                }
//            }
//        }

    }



    override fun onStop() {
        super.onStop()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        myOptionViewAdapter = null
    }

 */