# Rabble-Wabble

An app to learn design patterns in Swift "comprehensively"!

Credits: Design Patterns by Tutorials by Joshua Greene & Jay Strawn
RayWenderlich.com

## Fundamental Design Patterns


## Behavioral Patterns: 
Classified on how objects **communicate** with each other

### Delegation Pattern
In short, the delegation pattern enables an object to use a "helper" to provide data or perform tasks rather than do the task itself. examples of Delegation protocols in UIKit: `UITableViewDataSource`, `UITableViewDelegate`.

<details open>
<summary>Learn More</summary>
<br>

```mermaid
graph BT;
    A[Object Needing a Delegate]--delegates to-->B[protocol Delegate Protocol];
    C[Object Acting as a Delegate]-.conforms to.->B;
```

**Steps**

 Inside the class (say `OwnerClass`) that owns the protocol.
 1. Define a `protocol` over the class/object that needs to hand off control. `OwnerClassDelegate`
 2. Declare the `delegate` inside the class as optional. eg: `public weak var delegate: OwnerClassDelegate?`
 3. Call the protocol methods from within the class appropriately.
 
 Inside the class (say `SuperClass`) that confirms to the protocol.
 1. Assign the `delegate` variable of `OwnerClass` to self.
 2. Confirm the `SuperClass` to the `OwnerClassDelegate` .
 3. Define the protocol methods inside.

**Notes**: 

 - The delegates should be weak properties mostly.
 - Delegation Pattern helps in creating modular reusable components.
</details>

### Strategy Pattern
In short, the strategy pattern defines a family of interchangeable objects that can be interchanged at run time. e.g.: consider an app that uses several food rating services like yelp or google. Instead of writing if-else statements inside the controller after a user has picked what service they want to use for viewing the food review. We can define a common API (a `Strategy` essentially a `Protocol` for all different services)

Three parts: object using the strategy, the strategy protocol, and a family of strategy objects (that conform to the strategy protocol).

<details open>
<summary>Learn More</summary>
<br>

```mermaid
graph BT;
    A[Object using a Strategy]--has a-->B[protocol Strategy Protocol];
    C[Concrete Strategy 1]-.conforms to.->B;
    D[Concrete Strategy 2]-.conforms to.->B;
    E[Concrete Strategy 3]-.conforms to.->B;
```

**Steps**

 1. Define a Strategy `protocol` that defines all the items a Strategy must conform to. say `FoodReviewStrategy`
 2. Conform to this strategy using the different objects (strategies) in your mind. In the case of food reviews, this may be a `GoogleReviewStrategy` or `YelpReviewStrategy`
 3. Use these strategies interchangeably in your main class (VC) depending on user selection or for A/B testing.


**Notes**: 

 - Similar to the delegation pattern, both use protocol. However, strategies are meant to be switched at runtime, whereas delegates are usually fixed.
 - Try not to overuse this pattern. The trick to the pattern is to realize when to pull behaviors out from the mainVC into a strategy protocol. 
</details>

## Creational Patterns: 
Classified on how objects are **created**

### Singleton Pattern
In short, the singleton pattern restricts the class to only one instance. Extremely common. 
Singleton Plus pattern is also common, that allows creation of other instances of the Singleton (simply make the init public instead of private like in the Singleton). 

**Important** Singletons are problematic for testing for two reasons 
- if there is state being stored in a global object like a singleton then the order of the tests starts to matter 
- and, they are very painful to mock. 

<details open>
<summary>Learn More</summary>
<br>

```mermaid
graph BT;
    A[Singleton - shared: Singleton static]-->A;
```

**Steps**

 Inside the class (say `OwnerClass`) that owns the protocol.
 1. Create a class and then create an instance of the same class inside itself.
 2. Create a `private init` inside this class for a true singleton and a `public init` for a SingletonPlus.
 3. Use throughout the app.

**Notes**: 

 - Very easy to overuse and misuse. Make sure there is no other way of doing what you are trying to do before using a Singleton. 
 - Saving UserSettings is one use-case.

