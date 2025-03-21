package com.cavss.pipe

import InsuranceFragment
import android.graphics.*
import android.graphics.drawable.Drawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import android.widget.RelativeLayout
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.ViewModelProvider
import com.cavss.pipe.databinding.ActivityMainBinding
import com.cavss.pipe.db.sharedpreference.CustomSharedPreference
//import com.cavss.pipe.vm.LocalDBVM
import com.cavss.pipe.ui.screen.main.MainBottomEnum
import com.cavss.pipe.ui.screen.main.MainBottomNaviVM
import com.cavss.pipe.ui.screen.main.place.PlaceFragment
import com.cavss.pipe.ui.screen.main.job.JobFragment
import com.cavss.pipe.ui.screen.main.money.MoneyFragment
import com.cavss.pipe.ui.screen.main.board.BoardFragment
import com.cavss.pipe.ui.screen.main.money.frags.SupportFragment
import com.cavss.pipe.util.typeconverter.dpToPx
import com.cavss.pipe.vm.NotificationVM
import com.cavss.pipe.vm.PipeVM
import com.google.android.gms.ads.MobileAds
import com.google.android.material.bottomnavigation.BottomNavigationView


class MainActivity : AppCompatActivity() {

    private var mainBottomVM : MainBottomNaviVM? = null
    private var pipeVM : PipeVM? = null
    private var notificationVM : NotificationVM? = null

    private var boardFragment : BoardFragment? = null
//    private var moneyFragment : MoneyFragment? = null
    private var supportFragment : SupportFragment? = null
//    private var insuranceFragment : InsuranceFragment? = null
    private var placeFragment : PlaceFragment? = null
    private var jobFragment : JobFragment? = null


    private fun setInit(){
        try{
            MobileAds.initialize(this)

            boardFragment = BoardFragment()
//            moneyFragment = MoneyFragment()
            supportFragment = SupportFragment()
//            insuranceFragment = InsuranceFragment()
            placeFragment = PlaceFragment()
            jobFragment = JobFragment()

            pipeVM = ViewModelProvider(this@MainActivity)[PipeVM::class.java]
            mainBottomVM = ViewModelProvider(this@MainActivity)[MainBottomNaviVM::class.java]
            notificationVM = ViewModelProvider(this@MainActivity)[NotificationVM::class.java]
//            localDBVM = ViewModelProvider(this, ViewModelProvider.AndroidViewModelFactory.getInstance(application))[LocalDBVM::class.java]

            CustomSharedPreference.init(context = this)

        }catch (e:Exception){
            Log.e("mException", "MainActivity, setInit  // Exception : ${e.message}")
        }
    }
    private fun chageFragment(frag : MainBottomEnum){
        try{
            val manager = (this as FragmentActivity).supportFragmentManager.beginTransaction()
            when(frag){
                MainBottomEnum.BOARD -> manager.replace(binding.mainFrame.id, boardFragment ?: BoardFragment()).commit()
                MainBottomEnum.MONEY -> manager.replace(binding.mainFrame.id, supportFragment ?: SupportFragment()).commit()
                MainBottomEnum.PLACE -> manager.replace(binding.mainFrame.id, placeFragment ?: PlaceFragment()).commit()
                MainBottomEnum.JOB -> manager.replace(binding.mainFrame.id, jobFragment ?: JobFragment()).commit()
//                MainBottomEnum.INSURANCE -> manager.replace(binding.mainFrame.id, insuranceFragment ?: InsuranceFragment()).commit()
            }
        }catch (e:Exception){
            Log.e("mException", "MainActivity, changeFragment  // Exception : ${e.message}")
        }
    }
    private fun setBottomNavigation(bottomNavi : BottomNavigationView, main : RelativeLayout){
        try{
            main.apply {
                if (context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
                    // 나이트 모드일 때 텍스트 색상
                    setBackgroundColor(Color.BLACK)
                } else {
                    // 라이트 모드일 때 텍스트 색상
                    setBackgroundColor(getColor(R.color.claymorphismThemeColour))
                }
            }
            bottomNavi.apply {
                setOnItemSelectedListener { menuItem ->
                    when (menuItem.title) {
                        getString(R.string.bottom_navi_item_board) -> {
                            mainBottomVM?.setFragmentType(MainBottomEnum.BOARD)
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
//                        getString(R.string.bottom_navi_item_insurance) -> {
//                            mainBottomVM?.setFragmentType(MainBottomEnum.INSURANCE)
//                            true
//                        }
                        else -> {
                            mainBottomVM?.setFragmentType(MainBottomEnum.BOARD)
                            false
                        }
                    }
                }
                itemIconTintList = null
                itemTextColor = getColorStateList(R.color.textColour)
                background = object : Drawable() {
                    private val nightModeFlags = this@MainActivity.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
                    private val backgroundColour = if (nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES) {
                        // 나이트 모드일 때 텍스트 색상
                        Color.LTGRAY
                    } else {
                        // 라이트 모드일 때 텍스트 색상
                        Color.WHITE
                    }
                    private val marginHorizontal = 5.dpToPx(this@MainActivity).toFloat() // 좌우 마진 값을 픽셀로 변환
                    override fun draw(canvas: Canvas) {
                        // 하얀색 테두리 그리기
                        val height = bounds.height().toFloat()
                        val radius = 16.dpToPx(this@MainActivity).toFloat() // 테두리의 둥근 정도를 설정 (여기서는 16dp로 설정)
                        val bottomMargin = height - 3.dpToPx(this@MainActivity).toFloat()
                        val bottomSheetStrokeWidth = 2.dpToPx(this@MainActivity).toFloat() // 테두리 선의 굵기를 설정 (여기서는 2dp로 설정)
                        val bottomSheetStrokePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
                            color = backgroundColour // 테두리 색상을 원하는 색상으로 설정
                            style = Paint.Style.STROKE
                            maskFilter = null
                            strokeWidth = bottomSheetStrokeWidth
                        }
                        canvas.drawRoundRect(
                            marginHorizontal,
                            0f,
                            width - marginHorizontal,
                            bottomMargin,
                            radius, radius, bottomSheetStrokePaint
                        )
                    }

                    override fun setAlpha(alpha: Int) {

                    }

                    override fun setColorFilter(colorFilter: ColorFilter?) {

                    }

                    override fun getOpacity(): Int = PixelFormat.TRANSLUCENT

                }
            }
            mainBottomVM?.apply {
                getFragmentType.observe(this@MainActivity){ type : MainBottomEnum ->
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
                main = this@run.main
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

            boardFragment = null
//            moneyFragment = null
            supportFragment = null
//            insuranceFragment = null
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