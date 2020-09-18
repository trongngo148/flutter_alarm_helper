import 'package:analog_clock/screens/home_screen/components/bloc/time_event.dart';
import 'package:analog_clock/screens/home_screen/components/bloc/time_state.dart';
import 'package:bloc/bloc.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(InitialStateTime().getInit());

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is NextTime) {
      print("Vao Next Time");
      yield SuggestTime(
        currentTime: event.currentTime,
        timeCustom: event.customTime,
        timeFallInSleep: event.timeFallInSleep,
        result3h: '',
        result4h30: '',
        result6h: '',
        result7h30: '',
      ).getTime();
    }
  }
}
