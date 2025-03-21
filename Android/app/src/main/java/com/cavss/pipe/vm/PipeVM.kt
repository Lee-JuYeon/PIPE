package com.cavss.pipe.vm

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.cavss.pipe.model.job.certification.CertificationModel
import com.cavss.pipe.model.job.contest.ContestModel
import com.cavss.pipe.model.job.employment.EmploymentModel
import com.cavss.pipe.model.money.support.SupportModel
import com.cavss.pipe.model.job.jobfair.JobfairModel
import com.cavss.pipe.repository.PipeRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class PipeVM : ViewModel() {

    private val pipeRepository: PipeRepository = PipeRepository()
    private val _supportList = MutableLiveData<List<SupportModel>>()
    val supportList: LiveData<List<SupportModel>>
        get() = _supportList
    fun loadSupportList() {
        viewModelScope.launch(Dispatchers.IO) {
            val list = pipeRepository.getSupportModelList()
            _supportList.postValue(list)
        }
    }

    private val _jobfairList = MutableLiveData<List<JobfairModel>>()
    val jobFairList: LiveData<List<JobfairModel>>
        get() = _jobfairList

    fun loadJobFairList() {
        viewModelScope.launch(Dispatchers.IO) {
            val list = pipeRepository.getJobFairModelList()
            _jobfairList.postValue(list)
        }
    }

    private val _jobEmploymentList = MutableLiveData<List<EmploymentModel>>()
    val jobEmploymentList: LiveData<List<EmploymentModel>>
        get() = _jobEmploymentList

    fun loadJobEmploymentList() {
        viewModelScope.launch(Dispatchers.IO) {
            val list = pipeRepository.getJobEmploymentModelList()
            _jobEmploymentList.postValue(list)
        }
    }

    private val _jobContestList = MutableLiveData<List<ContestModel>>()
    val jobContestList: MutableLiveData<List<ContestModel>>
        get() = _jobContestList

    fun loadJobContestList() {
        viewModelScope.launch(Dispatchers.IO) {
            val list = pipeRepository.getJobContestModelList()
            _jobContestList.postValue(list)
        }
    }

    private val _jobCertificationList = MutableLiveData<List<CertificationModel>>()
    val jobCertificationList: MutableLiveData<List<CertificationModel>>
        get() = _jobCertificationList

    fun loadJobCertificationList() {
        viewModelScope.launch(Dispatchers.IO) {
            val list = pipeRepository.getJobCertificationModelList()
            _jobCertificationList.postValue(list)
        }
    }

//    private val _bankFixedDepositList = MutableLiveData<List<FixedDepositDTO>>()
//    val bankFixedDepositList : MutableLiveData<List<FixedDepositDTO>>
//        get() = _bankFixedDepositList
//    fun loadBankFixedDepositList(){
//        viewModelScope.launch(Dispatchers.IO) {
//            val list = pipeRepository.getSavingFixedDepositLst()
//            _bankFixedDepositList.postValue(list)
//        }
//    }

//    private val _bankSavingList = MutableLiveData<List<SavingsDTO>>()
//    val bankSavingList : MutableLiveData<List<SavingsDTO>>
//        get() = _bankSavingList
//    fun loadBankSavingsList(){
//        viewModelScope.launch(Dispatchers.IO) {
//            val list = pipeRepository.getSavingDepositList()
//            bankSavingList.postValue(list)
//        }
//    }
//
//    private val _bankPensionSavingList = MutableLiveData<List<PensionSavingsDTO>>()
//    val bankPensionSavingList : MutableLiveData<List<PensionSavingsDTO>>
//        get() = _bankPensionSavingList
//    fun loadBankPensionSavingList(){
//        viewModelScope.launch(Dispatchers.IO) {
//            val list = pipeRepository.getSavingPensionList()
//            bankPensionSavingList.postValue(list)
//        }
//    }
//
//    private val _loanMortgageList = MutableLiveData<List<MortgageLoanDTO>>()
//    val loanMortgageList : MutableLiveData<List<MortgageLoanDTO>>
//        get() = _loanMortgageList
//    fun loadLoanMortgageList(){
//        viewModelScope.launch(Dispatchers.IO) {
//            val list = pipeRepository.getLoanMortgageList()
//            loanMortgageList.postValue(list)
//        }
//    }
//
//    private val _loanRentHouseList = MutableLiveData<List<RentHouseLoanDTO>>()
//    val loanRentHouseList : MutableLiveData<List<RentHouseLoanDTO>>
//        get() = _loanRentHouseList
//    fun loadLoanRentHouseList(){
//        viewModelScope.launch(Dispatchers.IO) {
//            val list = pipeRepository.getLoanRentHouselist()
//            loanRentHouseList.postValue(list)
//        }
//    }
//
//    private val _loanList = MutableLiveData<List<Any>>()
//    val loanList: LiveData<List<Any>>
//        get() = _loanList
//
//    fun loadLoanList() {
//        viewModelScope.launch(Dispatchers.IO) {
//            val mortgageList = pipeRepository.getLoanMortgageList()
//            val rentHouseList = pipeRepository.getLoanRentHouselist()
//
//            val mergedList = mutableListOf<Any>()
//            mergedList.addAll(mortgageList)
//            mergedList.addAll(rentHouseList)
//
//            _loanList.postValue(mergedList)
//        }
//    }
}
