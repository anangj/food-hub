abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOuputs {}

abstract class BaseViewModelInputs {
  void start(); //will be called while init of viewmodel
  void dispose(); //will be calles while viewmodel dies.
}

abstract class BaseViewModelOuputs {}
