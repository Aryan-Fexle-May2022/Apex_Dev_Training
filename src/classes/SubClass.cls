public class SubClass extends SuperKeywordClass {
    public override void printName() {
          super.printName();
          System.debug('But you can call me ' + super.getFirstName());
      }
  }