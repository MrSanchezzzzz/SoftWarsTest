import 'package:flutter_bloc/flutter_bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0); // Initial tab index is 0.
  final int tabCount = 3;
  void selectTab(int index) {
    if(index<0) index=0;
    if(index>tabCount-1) index=tabCount-1;
    emit(index);
  } // Changes the selected tab.
}