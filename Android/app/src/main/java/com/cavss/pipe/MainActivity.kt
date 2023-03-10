package com.cavss.pipe

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.ViewModelProvider
import com.cavss.pipe.databinding.ActivityMainBinding
import com.cavss.pipe.ui.screen.main.MainBottomEnum
import com.cavss.pipe.ui.screen.main.MainBottomNaviVM
import com.cavss.pipe.ui.screen.main.place.PlaceFragment
import com.cavss.pipe.ui.screen.main.job.JobFragment
import com.cavss.pipe.ui.screen.main.money.MoneyFragment
import com.cavss.pipe.ui.screen.main.my.MyFragment
import com.google.android.material.bottomnavigation.BottomNavigationView

class MainActivity : AppCompatActivity() {

    private var mainBottomVM : MainBottomNaviVM? = null
    private var myFragment : MyFragment? = null
    private var moneyFragment : MoneyFragment? = null
    private var placeFragment : PlaceFragment? = null
    private var jobFragment : JobFragment? = null
    private fun setInit(){
        try{
            App.INSTANCE
            mainBottomVM = ViewModelProvider(this@MainActivity).get(MainBottomNaviVM::class.java)

            myFragment = MyFragment()
            moneyFragment = MoneyFragment()
            placeFragment = PlaceFragment()
            jobFragment = JobFragment()

        }catch (e:Exception){
            Log.e("mException", "MainActivity, setInit  // Exception : ${e.message}")
        }
    }
    private fun chageFragment(frag : MainBottomEnum){
        try{
            val manager = (this as FragmentActivity).supportFragmentManager.beginTransaction()
            when(frag){
                MainBottomEnum.MY -> manager.replace(binding.mainFrame.id, myFragment ?: MyFragment()).commit()
                MainBottomEnum.MONEY -> manager.replace(binding.mainFrame.id, moneyFragment ?: MoneyFragment()).commit()
                MainBottomEnum.PLACE -> manager.replace(binding.mainFrame.id, placeFragment ?: PlaceFragment()).commit()
                MainBottomEnum.JOB -> manager.replace(binding.mainFrame.id, jobFragment ?: JobFragment()).commit()
            }
        }catch (e:Exception){
            Log.e("mException", "MainActivity, changeFragment  // Exception : ${e.message}")
        }
    }
    private fun setBottomNavigation(bottomNavi : BottomNavigationView, frame : FrameLayout){
        try{
            bottomNavi.setOnItemSelectedListener { menuItem ->
                when (menuItem.title) {
                    getString(R.string.bottom_navi_item_my) -> {
                        mainBottomVM?.setFragmentType(MainBottomEnum.MY)
                        true
                    }
                    getString(R.string.bottom_navi_item_money) -> {
                        mainBottomVM?.setFragmentType(MainBottomEnum.MONEY)
                        true
                    }
                    getString(R.string.bottom_navi_item_place) -> {
                        mainBottomVM?.setFragmentType(MainBottomEnum.PLACE)
                        true
                    }
                    getString(R.string.bottom_navi_item_job) -> {
                        mainBottomVM?.setFragmentType(MainBottomEnum.JOB)
                        true
                    }
                    else -> {
                        mainBottomVM?.setFragmentType(MainBottomEnum.MY)
                        false
                    }
                }
            }
            binding.mainBottomNavi.itemIconTintList = null
            binding.mainBottomNavi.itemTextColor = getColorStateList(R.color.black)
            mainBottomVM?.getFragmentType?.observe(this@MainActivity){ type : MainBottomEnum ->
                try {
                    chageFragment(type)
                } catch (e: Exception) {
                    chageFragment(type)
                    Log.e("mException", "MainActivity, setBottomNavigation, mainBottomVM.getFragmentType.observe // Exception : ${e.message}")
                } catch (e: NoSuchElementException) {
                    chageFragment(type)
                    Log.e("mException","MainActivity, setBottomNavigation, mainBottomVM.getFragmentType.observe  // NoSuchElementException : ${e.message}")
                }
            }
        }catch (e:Exception){
            Log.e("mException", "MainActivity, setBottomNavigation // Exception : ${e.localizedMessage}")
        }
    }


    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        binding.run{
            setInit()
            setBottomNavigation(
                bottomNavi = this@run.mainBottomNavi,
                frame = this@run.mainFrame
            )
        }
        setContentView(binding.root)
    }

    override fun onStart() {
        super.onStart()

    }

    private fun setNull(){
        try {
            mainBottomVM = null

            myFragment = null
            moneyFragment = null
            placeFragment = null
            jobFragment = null
        } catch (e: Exception) {
            Log.e("mException", "MainActivity, setNull // Exception : ${e.message}")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        setNull()
    }
}