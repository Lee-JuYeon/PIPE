package com.cavss.pipe.ui.screen.main.job

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.viewpager2.widget.ViewPager2
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentJobBinding
import com.cavss.pipe.ui.custom.viewpager.BaseFragmentAdapter
import com.cavss.pipe.ui.screen.main.job.frags.CertificationFragment
import com.cavss.pipe.ui.screen.main.job.frags.BootcampFragment
import com.cavss.pipe.ui.screen.main.job.frags.EmploymentFragment
import com.cavss.pipe.ui.screen.main.job.frags.EventFragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class JobFragment: Fragment(){

    private var certificationFragment : CertificationFragment? = null
    private var bootcampFragment : BootcampFragment? = null
    private var employmentFragment : EmploymentFragment? = null
    private var eventFragment : EventFragment? = null
//    private var onlineLectureFragment : OnlineLectureFragment? = null
    private fun setTabLayoutWithViewPager2(tabLayout: TabLayout, viewPager2: ViewPager2){
        try{
            certificationFragment = CertificationFragment()
            bootcampFragment = BootcampFragment()
            employmentFragment = EmploymentFragment()
            eventFragment = EventFragment()
//            onlineLectureFragment = OnlineLectureFragment()
            viewPager2.let {
                var viewpagerAdapter =  object : BaseFragmentAdapter.Adapter(requireActivity()){
                    override fun setFragmentList(): List<Fragment> {
                        return listOf<Fragment>(
                            employmentFragment ?: EmploymentFragment(),
                            bootcampFragment ?: BootcampFragment(),
                            eventFragment ?: EventFragment(),
                            certificationFragment ?: CertificationFragment(),
//                            onlineLectureFragment ?: OnlineLectureFragment()
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
                val EMPLOYMENT = 0
                val BOOT_CAMP = 1
                val EVENT = 2
                val CERTIFICATION = 3
//                val LECTURE = 4
                when(position){
                    EMPLOYMENT -> {
                        tab.text = requireContext().getString(R.string.fragment_job_item_employment)
                    }
                    BOOT_CAMP -> {
                        tab.text = requireContext().getString(R.string.fragment_job_item_bootcamp)
                    }
                    EVENT -> {
                        tab.text = requireContext().getString(R.string.fragment_job_item_event)
                    }
                    CERTIFICATION -> {
                        tab.text = requireContext().getString(R.string.fragment_job_item_certification)
                    }
//                    LECTURE -> {
//                        tab.text = requireContext().getString(R.string.fragment_job_item_lecture)
//                    }
                }
            }.attach()
        }catch (e:Exception){
            Log.e("mException", "JobFragment, setTabLayoutWithViewPager2 // Exception : ${e.localizedMessage}")
        }
    }


    private lateinit var binding : FragmentJobBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentJobBinding.inflate(inflater, container, false)
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

    override fun onStop() {
        super.onStop()
        /*
        다른 액티비티가 완전히 화면을 가리게 되면 호출합니다. 필요하지 않은 리소스를 해제하거나 조정해야 합니다.

        액티비티가 중단되면 액티비티 객체는 메모리 안에 머무르게 됩니다. 이 객체가 모든 상태 및 멤버 정보를 가지고 관리하지만 연결되 있지는 않습니다. 다시 시작되면 이 객체를 다시 호출합니다. 최상위 상태가 재개되어도 콜백 메서드 중에 생성된 요소는 다시 초기화할 필요가 없습니다. 또한 시스템은 레이아웃에 있는 각 View 객체의 현재 상태도 기록하므로 사용자가 EditText 위젯에 텍스트를 입력했다면 내용이 저장되기 때문에 저장, 복원할 필요가 없습니다.
        프래그먼트는 이를 제거하는 트랜잭션에서 addToBackStack()을 호출하여 인스턴스를 저장하라고 명시적으로 요청할 경우에만 액티비티에서 관리하는 백 스택으로 들어갑니다.
         */

        certificationFragment = null
        bootcampFragment = null
        employmentFragment = null
        eventFragment = null
//        onlineLectureFragment = null
    }
}