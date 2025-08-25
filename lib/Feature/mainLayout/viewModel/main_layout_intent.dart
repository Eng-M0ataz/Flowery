abstract class NavigationIntent {}

class ChangeTabIntent extends NavigationIntent {
  final int newIndex;
  ChangeTabIntent(this.newIndex);
}