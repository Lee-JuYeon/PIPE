package com.cavss.pipe.ui.screen.main.place

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.viewpager2.widget.ViewPager2
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentPlaceBinding
import com.cavss.pipe.ui.custom.viewpager.BaseFragmentAdapter
import com.cavss.pipe.ui.screen.main.MainBottomNaviVM
import com.cavss.pipe.ui.screen.main.board.BoardFragment
import com.cavss.pipe.ui.screen.main.place.frags.MyHomeFragment
import com.cavss.pipe.ui.screen.main.place.frags.OfficeFragment
import com.cavss.pipe.ui.screen.main.place.frags.TicketFragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayout.*
import com.google.android.material.tabs.TabLayoutMediator

class PlaceFragment : Fragment(){

    private var myHomeFragment : MyHomeFragment? = null
    private var officeFragment : OfficeFragment? = null
    private fun setTabLayoutWithViewPager2(tabLayout: TabLayout, viewPager2: ViewPager2){
        try{
            myHomeFragment = MyHomeFragment()
            officeFragment = OfficeFragment()
            viewPager2.let {
                var viewpagerAdapter =  object : BaseFragmentAdapter.Adapter(requireActivity()){
                    override fun setFragmentList(): List<Fragment> {
                        return listOf<Fragment>(
                            myHomeFragment ?: BoardFragment(),
                            officeFragment ?: OfficeFragment()
                        )
                    }
                }
                it.adapter = viewpagerAdapter
                it.isUserInputEnabled = false // 스크롤로 프래그먼트 이동 억제
            }

            tabLayout.let {
                it.tabMode = MODE_FIXED
                it.tabGravity = GRAVITY_FILL
            }
            TabLayoutMediator(binding.tablayout, binding.viewpager2){ tab, position ->
                val MY_HOME = 0
                val OFFICE = 1
                when(position){
                    MY_HOME -> {
                        tab.text = requireContext().getString(R.string.fragment_place_item_myhome)
                    }
                    OFFICE -> {
                        tab.text = requireContext().getString(R.string.fragment_place_item_office)
                    }
                }
            }.attach()
        }catch (e:Exception){
            Log.e("mException", "PlaceFragment, setTabLayout // Exception : ${e.localizedMessage}")
        }
    }


    private val mainBottomNaviVM : MainBottomNaviVM by activityViewModels()

    private lateinit var binding : FragmentPlaceBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentPlaceBinding.inflate(inflater, container, false)
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
        myHomeFragment = null
        officeFragment = null
    }
}