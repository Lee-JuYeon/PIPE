package com.cavss.pipe.ui.screen.main.board.frags

import android.content.ContextWrapper
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import androidx.core.app.ActivityCompat.recreate
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.cavss.pipe.MainActivity
import com.cavss.pipe.R
import com.cavss.pipe.databinding.FragmentBoardSettingBinding
import com.cavss.pipe.db.sharedpreference.CustomSharedPreference
import com.cavss.pipe.model.target.FamilyOption
import com.cavss.pipe.ui.custom.jy_dropdown.JuYeonDropDown
import com.cavss.pipe.vm.PipeVM
import java.util.Locale

class SettingFragment : Fragment() {
    private lateinit var binding : FragmentBoardSettingBinding
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentBoardSettingBinding.inflate(inflater, container, false)
        return binding.root
    }

    private val pipeVM : PipeVM by activityViewModels()
    private fun updateLanguageAtSystemAndDB(lang : String){
        val newLocale = Locale(lang)
        Locale.setDefault(newLocale)

        val configuration = Configuration(resources.configuration)
        configuration.setLocale(newLocale)

        // 변경된 언어 설정을 앱에 적용
        val context = requireContext().createConfigurationContext(configuration)
        val restartIntent = Intent(context, MainActivity::class.java)
        restartIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        context.startActivity(restartIntent)
    }
    private fun setLangaugeDropdown(dropdown : JuYeonDropDown){
        dropdown.apply {
            val list : List<String> = listOf("🇰🇷 한국어","🇬🇧 English","🇯🇵 日本語","🇹🇼 臺灣話","🇪🇸 Español","🇮🇹 Italiano")
            setMenu(list)
            setMenuItemClick { clickedMenu ->
                when(clickedMenu){
                    "🇰🇷 한국어" -> {
                        updateLanguageAtSystemAndDB("kr")
                    }
                    "🇬🇧 English" -> {
                        updateLanguageAtSystemAndDB("en")
                    }
                    "🇯🇵 日本語" -> {
                        updateLanguageAtSystemAndDB("ja")
                    }
                    "🇹🇼 臺灣話" -> {
                        updateLanguageAtSystemAndDB("zh")
                    }
                    "🇪🇸 Español" -> {
                        updateLanguageAtSystemAndDB("es")
                    }
                    "🇮🇹 Italiano" -> {
                        updateLanguageAtSystemAndDB("it")
                    }
                }
            }
        }
    }

    private fun updateInformation(country : String){
        try{
            CustomSharedPreference.updateInformationCountry(country)
            Log.e("mException", "정보받을 국가 : ${country}")
        }catch (e:Exception){
            Log.e("mException", "SettingFragment, updateInformation // Exception : ${e.localizedMessage}")
        }
    }
    private fun setInformationDropdown(dropdown : JuYeonDropDown){
        dropdown.apply {
            val list : List<String> = listOf("🇰🇷 대한민국", "🇪🇸 España", "🇦🇺 Australia", "🇮🇹 Italia", "🇮🇩 Indonesia")
            setMenu(list)
            setMenuItemClick { clickedMenu ->
                when(clickedMenu){
                    "🇰🇷 대한민국" -> {
                        updateInformation("korea")
                    }
                    "🇪🇸 España" -> {
                        updateInformation("spain")
                    }
                    "🇦🇺 Australia" -> {
                        updateInformation("australia")
                    }
                    "🇮🇹 Italia" -> {
                        updateInformation("italy")
                    }
                    "🇮🇩 Indonesia" -> {
                        updateInformation("indonesia")
                    }
                }
            }
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setLangaugeDropdown(binding.languageDropdown)
        setInformationDropdown(binding.informationDropdown)
    }

    override fun onStart() {
        super.onStart()
        pipeVM.let {
//            it.loadJobContestList()
//            it.jobContestList.observe(requireActivity()){ list : List<ContestModel> ->
//                updateAdapterList(list)
//            }
        }
    }
}