import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SlideViewObject? slideViewObject) {
    if (slideViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManagar.white,
        appBar: AppBar(
          backgroundColor: ColorManagar.white,
          elevation: AppSize.s1_5,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManagar.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: slideViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(slideViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManagar.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: const Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              // add layout indicator an arrows
              _getBottomSheetWidget(slideViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SlideViewObject slideViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //nav left
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: const SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: Icon(Icons.navigate_before),
            ),
            onTap: () {
              //go to previous slide
              _pageController.animateToPage(_viewModel.goPrevious(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        ),

        //circles indicator
        Row(
          children: [
            for (int i = 0; i < slideViewObject.numOfSlides; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i, slideViewObject.currentIndex),
              )
          ],
        ),

        //nav right
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: const SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: Icon(Icons.navigate_next),
            ),
            onTap: () {
              _pageController.animateToPage(_viewModel.goNext(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        ),
      ],
    );
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return Icon(Icons.circle_outlined);
    } else {
      return Icon(Icons.circle_rounded);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(this._sliderObject);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        //image widget
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
