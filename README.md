# UIDynamicAnimation
UIDynamic是iOS7的API，主要模拟现实世界的力学系统。

#UIKit Dynamics动力系统入门
###1.什么是动力系统(What is the UIKit Dynamics?)
动力系统的引入，并不是替代CoreAnimation，而是对模拟现实世界物体运动的补充，比如，碰撞，重力，悬挂等等。所以说，UIKit动力系统的引入，大大简化了一些交互动画（不需要自己实现一些模拟现实世界物理动力系统的动画），丰富了UI设计。
###2.动力系统怎么使用(How to use it?)
**UIKit动力系统结构如下：**

![image](http://jashion.b0.upaiyun.com/images/UIDynamics.png)

总的来说，先要注册UI系统体系，也就是类似于二维的坐标系，然后添加所需的行为以及行为的作用物体，然后该物体就能在设定的坐标体系里，根据所添加的行为运动。<br>
光说不练乃是纸上谈兵，没有成效。下面分解动力系统所包含的几类运动。

**UIGravityBehavior**

重力，这个大家应该都很熟悉了。我们每天都能感受到它的存在，所谓脚踏实地就是这种感觉。小时候，大家应该都有过从高处把一些物体扔下来，或者直接让它坐自由落体运动，相似的，这个Gravity也是模拟重力行为，下面直接上代码。

```
myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
myAnimator.delegate = self;
UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[ball]];
[myAnimator addBehavior: gravityBehavior];

```

1.UIDynamicAnimator就是一个播放者，容器。一个容纳动力系统的环境，而referenceView就是该环境的坐标系，物体运动的参照系。<br>
2. gravityBehavior，初始化一个重力行为，行为的受力物体是ball（只要实现UIDynamicItem接口的类都能作为受力物体，如，View和UICollectionViewLayoutAttributes）。<br>
3. 将这个行为添加到UIDynamicAnimator上面就行了。<br>
4. 显示效果的Demo以及代码下载在最后。

**UICollisionBehavior**

碰撞行为，最直接的感受就是，玩弹珠，一颗弹珠可以被另一颗弹珠弹射到很远的地方，原理就是碰撞产生了一个反方向的作用力，远离事故发生地。废话也不多说，直接上代码：

```
myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];

UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: ballsArray2];        collision.translatesReferenceBoundsIntoBoundary = YES;
collision.collisionDelegate = self;
[myAnimator addBehavior: collision];

```

1.和重力行为一样，也要先初始化一个容器myAnimator。<br>
2.添加碰撞行为collision，collision.translatesReferenceBoundsIntoBoundary的属性是否设置以参考View的边界为碰撞边界，我们这里选择YES。<br>
3.除了设置参考View的边界为碰撞边界外，还可以自己设定边界，使用- addBoundaryWithIdentifier: forPath:或者addBoundaryWithIdentifier: fromPoint: toPoint:方法可以自己设定碰撞边界的范围。
4。最后，也需要把collision添加到myAnimator上。

**UIAttachmentBehavior**

描述一个物体和一个锚点或者另一个物体的连接，可以是弹性的，也可以是非弹性的连接。直接上代码：

```
UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem: square offsetFromCenter: UIOffsetMake(0, - 40) attachedToAnchor: anchor];
attachmentBehavior.length = 100;
attachmentBehavior.damping = 0.3;
[myAnimator addBehavior: attachmentBehavior];

```

1.物体默认的锚点在中心，可以设置偏移。<br>
2.步骤也是和其它得行为一样，设置参数，把该行为添加到myAnimator上。<br>
3.更多的方法和属性，请自行参考苹果官方文档。

**UISnapBehavior**

吸附行为，将UIView通过动画吸附到某个点上。API非常简单，看下面代码就懂了。

```
UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem: ballView snapToPoint: centerBall.center];
snapBehavior.damping = 0.4;
[myAnimator addBehavior: snapBehavior];
```

**UIPushBehavior**

推动力，可以理解为向一个物体施加一个作用力，可以是持续的，也可以是瞬间的冲击。

```
UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems: @[square] mode: UIPushBehaviorModeInstantaneous];
pushBehavior.pushDirection = CGVectorMake(velocity.x / 1000, velocity.y / 1000);
[myAnimator addBehavior: pushBehavior];

```

**UIDynamicItemBehavior**

这其实不是一种行为，我的理解是对于将要进行各种行为的物体一些参数上面的设置，比如，弹力，震荡频率，密度等等。

```
UIDynamicItemBehavior *behavior3 = [[UIDynamicItemBehavior alloc] initWithItems: @[ballsArray2[2]]];
behavior3.elasticity = 0.5;
behavior3.friction = 0.3;
behavior3.resistance = 0.3;
[myAnimator addBehavior: behavior3];
```

###3.组合(Group)

所有的行为都可以组合起来，如碰撞和重力，可以类似于物体做自由落体运动，然后和地面碰撞。代码如下：

```
myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
//重力行为
UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[ball]];
[myAnimator addBehavior: gravity];

//碰撞行为
UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: @[ball]];
collision.translatesReferenceBoundsIntoBoundary = YES;
collision.collisionDelegate = self;
[myAnimator addBehavior: collision];

//设置物体的一些相关的参数
UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] init];
behavior.elasticity = 0.8;
behavior.friction = 0.2;
behavior.resistance = 0.3;
behavior.density = 0.5;
behavior.angularResistance = 0.2;
[behavior addItem: ball];
[myAnimator addBehavior: behavior];

```

###4.自定义行为(DIY)
1.将官方的行为打包<br>

* 继承UIDynamicBehavior(一个抽象类)
* 实现添加组合行为的方法，最好和官方的保持一致，比如：initWithItems:，在里面调用addChildBehavior：方法添加需要组合的行为
* 初始化该继承类，然后使用

```
@interface GravityWithCollisionBehavior : UIDynamicBehavior

- (instancetype)initWithItems: (NSArray *)items;

@end

@implementation GravityWithCollisionBehavior

- (instancetype)initWithItems: (NSArray *)items {
    self = [super init];
    if (self) {
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: items];
        [self addChildBehavior: gravityBehavior];
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: items];
        collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [self addChildBehavior: collisionBehavior];
    }
    return self;
}

@end
```

2.完全自定义行为<br>
UIDynamicBehavior里提供了一个`@property(nonatomic, copy) void (^action)(void)`，animator将会在行为发生期间，每一步都调用这个block。也就是说，你想自定义行为就得在这里写自己的一些代码。具体就是在这个block中向所有的item询问它们当前的center和transform状态，然后经过计算，把新的值赋予相应的item，从而该改变它们在屏幕上的位置，大小，角度，方向等等。

###5.终结(Summary)
总的来说，iOS7引进的这套动力系统，大大丰富了我们动画表达，但是，该系统有着一些限制，会消耗一定的CPU资源，并且，当它们被添加到动画系统后，只能通过动画系统改变位置，而外部对于UIDynamicsItem的center,transform等设定是被忽略的，除此之外，该系统也没有现实世界那么精确，当计算迭代无法得到有效解的时候，动画将无法得到正确的呈现，所以，不要将动力系统神化。

###6.Demo展示

![UIDynamicAnimator](http://jashion.b0.upaiyun.com/images/UIDynamics.gif)

[源码下载](https://github.com/jashion/UIDynamicAnimation.git)

