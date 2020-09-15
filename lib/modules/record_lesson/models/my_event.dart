class MyEvent {
  final Events event;
  final int index;
  final int time;

  MyEvent({
    this.event,
    this.index,
    this.time,
  });
}

enum Events {
  changeImage,
}

extension EventsX on Events {
  String getName() {
    if (this == Events.changeImage)
      return 'changeImage';
    else
      return 'NA';
  }
}
