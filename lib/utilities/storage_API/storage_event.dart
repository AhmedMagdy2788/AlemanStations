enum EventState { done, inProgress, error }

class Event {
  EventState state;
  String message;
  Event({required this.state, required this.message});
  @override
  String toString() {
    return 'event state: $state, mess: $message';
  }
}
