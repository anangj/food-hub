import 'dart:async';

import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controller
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  //konten for slide
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();

    //send this slider to view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++; //-1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //infinite loop to go to first item slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int prevIndex = _currentIndex--; //-1
    if (prevIndex == -1) {
      _currentIndex =
          _list.length - 1; //infinite loop to go the lenght of slider
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SlideViewObject) => SlideViewObject);

  //private function
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//the orders view model will receive from view
abstract class OnBoardingViewModelInputs {
  void goNext(); //when user clicks on nav next or swipe left
  void goPrevious(); //when user clicks on nav before or swipe right
  void onPageChanged(int index);

  //this is the way to add data to the stream input
  Sink get inputSliderViewObject;
}

//result will be sent from viewmodel to view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
