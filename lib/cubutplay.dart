import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
// Future<void> main() async {
//   final cubit = CounterCubit();
//   final subscription = cubit.stream.listen(print); // 1
//   cubit.increment();
//   await Future.delayed(Duration.zero);
//   await subscription.cancel();
//   await cubit.close();
// }

void main() {
  Bloc.observer = SimpleBlocObserver();
  CounterCubit()
    ..increment()
    ..close();
}


// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//
//   void increment() => emit(state + 1);
// }
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}



class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType}, $change');
  }
}